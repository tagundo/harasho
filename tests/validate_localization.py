#!/usr/bin/env python3
"""Validate locale plans, real dictionary migrations and prepared runtime text.

Source DBs are opened read-only; default validation uses in-memory copies.
Use --runtime /path/to/a/fresh/prepared/server to check its bundled dictionaries.
"""

import argparse
from contextlib import closing
from fractions import Fraction
import hashlib
import json
from pathlib import Path
import re
import sqlite3

from validate_shooting_star import apply, fingerprints


BASE = "1d28dd11461e1ac7c10dbabd7a56e3be768caa12"
LANGUAGES = ("en", "ko", "zh")


def read_plans(repo):
    plans = {}
    for language in LANGUAGES:
        path = repo / "upgrades/gl" / f"dictionary_{language}_k.json"
        plan = json.loads(path.read_text(encoding="utf-8"))
        assert set(plan) == {"changes"} and plan["changes"], path
        seen = set()
        for change in plan["changes"]:
            assert set(change) == {"id", "from", "to"}, path
            key, old, new = change["id"], change["from"], change["to"]
            assert isinstance(key, str) and key and key not in seen, (path, key)
            assert isinstance(old, list) and all(isinstance(v, str) for v in old)
            assert len(old) == len(set(old)) and new not in old
            assert isinstance(new, str) and new and "\\n" not in new
            assert not key.startswith("elichika_link_") and "_url" not in key
            assert not key.startswith("elichika_title_")
            assert all(re.findall(r"\{[^{}]*\}", new) == re.findall(r"\{[^{}]*\}", v) for v in old), key
            if language == "ko":
                assert re.search(r"[가-힣]", new), (key, new)
            if language == "zh":
                assert re.search(r"[\u4e00-\u9fff]", new), (key, new)
            assert not re.search(r"[\u3040-\u30ff]", new), (key, new)
            seen.add(key)
        plans[language] = plan["changes"]
    return plans


def messages(database):
    return dict(database.execute("SELECT id,message FROM m_dictionary"))


def apply_plan(database, plan):
    changed = 0
    for change in plan:
        current = database.execute("SELECT message FROM m_dictionary WHERE id=?", (change["id"],)).fetchone()
        if current is None:
            database.execute("INSERT INTO m_dictionary(id,message) VALUES(?,?)", (change["id"], change["to"]))
            changed += 1
        elif current[0] in change["from"]:
            database.execute("UPDATE m_dictionary SET message=? WHERE id=?", (change["to"], change["id"]))
            changed += 1
    database.commit()
    return changed


def semantic_checks(master, dictionaries):
    pin = master.execute("SELECT target_skill_rarity FROM m_lesson_enhancing_item_effect_skill_drop WHERE lesson_enhancing_item_id=1402").fetchone()
    assert pin == (4,), pin
    ranks = dict(master.execute("SELECT id,rarity FROM m_passive_skill"))
    skill_rows = master.execute("SELECT skill_master_id,rarity FROM m_lesson_skill_content WHERE rarity >= 4").fetchall()
    assert skill_rows and all(ranks[skill] == rank for skill, rank in skill_rows)
    for language, dictionary in dictionaries.items():
        text = messages(dictionary)
        assert text["m_passive_skill_rarity_setting_skill_rank_a"] == "A"
        assert text["m_passive_skill_rarity_setting_skill_rank_s"] == "S"
        assert "A" in text["item_desc_1402"] and "S" in text["item_desc_1402"]
        assert text["item_desc_1501"] == text["item_desc_1502"]
        assert not re.search(r"Goals|과제|課題", text["item_desc_1501"])
        for item, label in ((1800, "R"), (1801, "SR"), (1802, "UR")):
            assert text[f"item_name_{item}"].endswith(f"({label})")
    for charm in (1501, 1502):
        rates = dict(master.execute("SELECT target_rarity,magnification_weight FROM m_lesson_enhancing_item_effect_drop_rate WHERE lesson_enhancing_item_id=?", (charm,)))
        assert rates[1] == rates[2] == 10000 and rates[3] > 10000 and rates[4] > 10000
        for menu in range(1, 9):
            drops = master.execute("SELECT weight,rarity FROM m_lesson_drop_content WHERE lesson_menu_master_id=?", (menu,)).fetchall()
            total = sum(weight for weight, _ in drops)
            high = sum(weight for weight, rarity in drops if rarity >= 3)
            boosted = [(weight * rates[rarity] // 10000, rarity) for weight, rarity in drops]
            total_after = sum(weight for weight, _ in boosted)
            high_after = sum(weight for weight, rarity in boosted if rarity >= 3)
            assert Fraction(high_after, total_after) >= Fraction(high, total)
    # The community patch makes these modes equal except MV split-screen.
    names = [row[1] for row in master.execute("PRAGMA table_info(m_live_quality_setting)")]
    rows = [dict(zip(names, row)) for row in master.execute("SELECT * FROM m_live_quality_setting WHERE quality_mode IN (10,20)")]
    for setting in {row["set_id"] for row in rows}:
        a = next(row for row in rows if row["set_id"] == setting and row["quality_mode"] == 10)
        b = next(row for row in rows if row["set_id"] == setting and row["quality_mode"] == 20)
        assert {k: v for k, v in a.items() if k not in ("quality_mode", "split_screen")} == {k: v for k, v in b.items() if k not in ("quality_mode", "split_screen")}
        if setting == 3:
            assert (a["split_screen"], b["split_screen"]) == (1, 0)
    return {"pin_minimum_rank": "A", "pin_eligible_rarities_match_client": True,
            "charms_boost_higher_rarity_group": True, "quality_modes_differ_only_in_mv_split_screen": True,
            "quality_limit": "Database settings verified; client enum handling and on-device rendering were not inspected."}


def validate_source(repo, plans, base):
    before, _ = apply(repo, "gl", base)
    after, _ = apply(repo, "gl", None)
    report = {}
    try:
        assert set(before) == set(after)
        for name, current in after.items():
            if name not in {f"dictionary_{lang}_k.db" for lang in LANGUAGES}:
                assert fingerprints(before[name]) == fingerprints(current), name
                continue
            language = name[len("dictionary_"):-len("_k.db")]
            plan = plans[language]
            original, actual = messages(before[name]), messages(current)
            expected = dict(original)
            expected.update({change["id"]: change["to"] for change in plan})
            assert actual == expected, (language, "Unplanned or missing dictionary edits")
            baseline_schema = before[name].execute("SELECT type,name,sql FROM sqlite_master ORDER BY type,name").fetchall()
            assert baseline_schema == current.execute("SELECT type,name,sql FROM sqlite_master ORDER BY type,name").fetchall()
            # Restored installs receive the same text, while owner translations win.
            assert apply_plan(before[name], plan) == len(plan)
            assert messages(before[name]) == actual
            assert apply_plan(before[name], plan) == 0
            key = plan[0]["id"]
            custom = "Owner's translation\n" + language
            before[name].execute("UPDATE m_dictionary SET message=? WHERE id=?", (custom, key))
            missing = plan[1]["id"]
            before[name].execute("DELETE FROM m_dictionary WHERE id=?", (missing,))
            before[name].commit()
            assert apply_plan(before[name], plan) == 1
            assert messages(before[name])[key] == custom
            assert messages(before[name])[missing] == plan[1]["to"]
            # Check every exact official/historical variant, including real LF.
            variants = 0
            for change in plan:
                for old in change["from"]:
                    current.execute("UPDATE m_dictionary SET message=? WHERE id=?", (old, change["id"]))
                    current.commit()
                    assert apply_plan(current, plan) == 1
                    assert messages(current)[change["id"]] == change["to"]
                    variants += 1
            report[language] = {"planned_messages": len(plan), "known_old_variants_verified": variants,
                                "schema_preserved": True, "custom_and_missing_keys_verified": True}
        report["semantics"] = semantic_checks(after["masterdata.db"], {lang: after[f"dictionary_{lang}_k.db"] for lang in LANGUAGES})
        return report
    finally:
        for database in [*before.values(), *after.values()]:
            database.close()


def validate_prepared_runtime(runtime, plans):
    result = {}
    for language in LANGUAGES:
        path = runtime / "assets/db/gl" / f"dictionary_{language}_k.db"
        with closing(sqlite3.connect(path.resolve().as_uri() + "?mode=ro", uri=True)) as database:
            assert database.execute("PRAGMA integrity_check").fetchall() == [("ok",)]
            actual = messages(database)
            for change in plans[language]:
                assert actual.get(change["id"]) == change["to"], (language, change["id"], "Runtime locale upgrade missing")
        result[language] = {"verified_messages": len(plans[language])}
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, default=Path(__file__).resolve().parent.parent)
    parser.add_argument("--base", default=BASE)
    parser.add_argument("--runtime", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    repo = args.repo.resolve()
    plans = read_plans(repo)
    verification = validate_prepared_runtime(args.runtime.resolve(), plans) if args.runtime else validate_source(repo, plans, args.base)
    report = {"status": "PASS", "scope": "prepared_runtime" if args.runtime else "fresh_and_existing_source",
              "verification": verification, "plan_sha256": {lang: hashlib.sha256((repo / "upgrades/gl" / f"dictionary_{lang}_k.json").read_bytes()).hexdigest() for lang in LANGUAGES}}
    if args.output:
        args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
