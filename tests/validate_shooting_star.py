#!/usr/bin/env python3
"""Validate both locale migrations using pristine databases and the Go loader order.

Only in-memory databases are mutated. The source DBs are opened read-only.
Run from any directory:
  python3 path/to/harasho/tests/validate_shooting_star.py
Optionally save a JSON report and check a clone of the observation repository:
  python3 tests/validate_shooting_star.py --output /tmp/report-harasho.json \
    --observations /path/to/SIFAS-Lesson-Data
"""

import argparse
import collections
import csv
import hashlib
import itertools
import json
import sqlite3
import subprocess
from pathlib import Path


def git(repo, *args):
    return subprocess.check_output(["git", *args], cwd=repo)


def migrations(repo, locale, ref):
    if ref:
        files = git(repo, "ls-tree", "-r", "--name-only", ref, "sql/").decode().splitlines()
    else:
        files = [str(p.relative_to(repo)) for p in (repo / "sql").rglob("*.sql")]
    valid = [p for p in files if len(Path(p).name) > 8 and p.endswith(".sql")]
    # os.ReadDir in Go returns filename-sorted entries; regional files precede common.
    paths = sorted(p for p in valid if p.startswith(f"sql/{locale}/")) + sorted(
        p for p in valid if p.count("/") == 1
    )
    # Targeted upgrades run after the full migrations on a fresh installation.
    # Historic refs can still contain this table in the shared full migration.
    upgrade = "sql/upgrades/001.lesson_shooting_star.sql"
    if upgrade in valid:
        paths.append(upgrade)
    return paths


def dictionary_plans(repo, locale, ref):
    directory = f"upgrades/{locale}/"
    if ref:
        files = git(repo, "ls-tree", "-r", "--name-only", ref, directory).decode().splitlines()
    else:
        files = [str(p.relative_to(repo)) for p in (repo / directory).glob("dictionary_*_k.json")]
    return sorted(p for p in files if p.startswith(directory)
                  and Path(p).name.startswith("dictionary_") and p.endswith("_k.json"))


def apply(repo, locale, ref):
    databases = {}
    lines = 0
    migration_sha256 = {}
    paths = migrations(repo, locale, ref)
    for path in paths:
        database_name = "masterdata.db" if path == "sql/upgrades/001.lesson_shooting_star.sql" else Path(path).name[4:-4]
        if database_name not in databases:
            src = sqlite3.connect(
                f"file:{repo}/db/{locale}/{database_name}?mode=ro", uri=True
            )
            dst = sqlite3.connect(":memory:")
            src.backup(dst)
            src.close()
            databases[database_name] = dst
        contents = git(repo, "show", f"{ref}:{path}").decode() if ref else (repo / path).read_text(encoding="utf-8")
        migration_sha256[path] = hashlib.sha256(contents.encode()).hexdigest()
        for number, line in enumerate(contents.splitlines(), 1):
            # bufio.Scanner's default limit is 64 KiB, including the delimiter.
            assert len(line.encode()) + 1 < 65536, f"Scanner limit: {path}:{number}"
            try:
                databases[database_name].execute(line)
            except sqlite3.Error as error:
                raise AssertionError(f"{locale}/{path}:{number}: {error}") from error
            lines += 1
    # Parameterized text-only plans follow all full SQL and shared lesson metadata.
    # Historical refs without plans retain exactly their original behavior.
    plans = dictionary_plans(repo, locale, ref)
    plan_sha256 = {}
    plan_changes = {}
    for path in plans:
        name = Path(path).stem + ".db"
        if name not in databases:
            src = sqlite3.connect(f"file:{repo}/db/{locale}/{name}?mode=ro", uri=True)
            dst = sqlite3.connect(":memory:")
            src.backup(dst)
            src.close()
            databases[name] = dst
        contents = git(repo, "show", f"{ref}:{path}").decode() if ref else (repo / path).read_text(encoding="utf-8")
        plan_sha256[path] = hashlib.sha256(contents.encode()).hexdigest()
        plan = json.loads(contents)
        assert isinstance(plan.get("changes"), list), path
        applied = 0
        for change in plan["changes"]:
            assert isinstance(change["id"], str) and isinstance(change["to"], str), path
            assert isinstance(change["from"], list) and all(isinstance(v, str) for v in change["from"]), path
            database = databases[name]
            current = database.execute("SELECT message FROM m_dictionary WHERE id=?", (change["id"],)).fetchone()
            if current is None:
                database.execute("INSERT INTO m_dictionary(id,message) VALUES(?,?)", (change["id"], change["to"]))
                applied += 1
            elif current[0] != change["to"] and current[0] in change["from"]:
                database.execute("UPDATE m_dictionary SET message=? WHERE id=? AND message=?", (change["to"], change["id"], current[0]))
                applied += 1
        plan_changes[path] = applied
    for database in databases.values():
        database.commit()
        assert database.execute("PRAGMA integrity_check").fetchall() == [("ok",)]
    return databases, {"files": len(paths), "lines": lines, "paths": paths, "sha256": migration_sha256,
                       "dictionary_plans": plans, "plan_sha256": plan_sha256, "plan_changes": plan_changes}


def fingerprints(database):
    tables = {}
    for (table,) in database.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    ):
        schema = database.execute("SELECT sql FROM sqlite_master WHERE name=?", (table,)).fetchone()[0]
        rows = sorted(database.execute(f'SELECT * FROM "{table}"').fetchall(), key=repr)
        tables[table] = {
            "rows": len(rows),
            "schema_sha256": hashlib.sha256(schema.encode()).hexdigest(),
            "rows_sha256": hashlib.sha256(repr(rows).encode()).hexdigest(),
        }
    return tables


def eligible(skill, combination):
    _, drop_type, _, first, second = skill
    if drop_type == 1:
        return combination.count(first) == 3
    if drop_type == 2:
        return first in combination
    if drop_type == 3:
        return True
    if drop_type == 4:
        return combination.count(first) == 2 and combination.count(second) == 1
    raise AssertionError(f"Unknown drop type {drop_type}")


def validate_mapping(database):
    rows = database.execute("SELECT skill_master_id,lesson_menu_id FROM m_lesson_skill_shooting_star").fetchall()
    assert len(rows) == len(set(rows)) == 29
    assert (30000057, 3) in rows and (30000057, 7) not in rows
    skills = {s[0]: s for s in database.execute("SELECT * FROM m_lesson_skill_content")}
    real_skills = {s[0]: s for s in database.execute("SELECT id,rarity FROM m_passive_skill")}
    menus = {m[0] for m in database.execute("SELECT id FROM m_lesson_menu")}
    combinations = list(itertools.product(range(1, 9), repeat=3))
    for skill_id, menu in rows:
        assert skill_id in skills and skill_id in real_skills and menu in menus
        assert skills[skill_id][2] == real_skills[skill_id][1]
        assert any(menu in c and eligible(skills[skill_id], c) for c in combinations), (
            "Unreachable skill/menu animation", skill_id, menu
        )
    return {"rows": len(rows), "all_skill_ids_and_menu_ids_valid": True, "all_rows_reachable": True}


def observation_evidence(path):
    files = sorted((path / "as-stats-csv/insight_skills").glob("*.csv"))
    assert len(files) == 512
    sightings = []
    for file in files:
        with file.open(encoding="utf-8") as csv_file:
            for row in csv.DictReader(csv_file):
                if int(row["skill_id"]) == 30000057:
                    sightings.append({"combination": file.stem, "count": int(row["count"]), "name": row["name"]})
    assert sightings == [{"combination": "333", "count": 1060, "name": "Critical UP [L]: on AC"}]
    return {
        "repository": "https://github.com/eman1can/SIFAS-Lesson-Data",
        "commit": git(path, "rev-parse", "HEAD").decode().strip(),
        "combinations_scanned": len(files),
        "30000057_sightings": sightings,
        "limitation": "Skill-drop evidence verifies reachability, not the actual animation of every remaining row.",
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, default=Path(__file__).resolve().parent.parent)
    parser.add_argument("--base", default="1d24cef1d2e697a98d9785fc26bf825b36b44978")
    parser.add_argument("--observations", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    repo = args.repo.resolve()
    gl_sp = git(repo, "show", f"{args.base}:sql/gl/017.masterdata.db.sql")
    jp_sp = git(repo, "show", f"{args.base}:sql/jp/006.masterdata.db.sql")
    common_sp = (repo / "sql/002.masterdata.db.sql").read_bytes()
    assert gl_sp == jp_sp == common_sp
    report = {
        "base_commit": git(repo, "rev-parse", args.base).decode().strip(),
        "candidate_commit": git(repo, "rev-parse", "HEAD").decode().strip(),
        "candidate_working_tree_changes": git(repo, "diff", "--stat").decode(),
        "single_player_sql_byte_identical": True,
        "single_player_sql_sha256": hashlib.sha256(common_sp).hexdigest(),
        "locales": {},
    }
    for locale in ("gl", "jp"):
        before, before_run = apply(repo, locale, args.base)
        after, after_run = apply(repo, locale, None)
        base_master, candidate_master = before["masterdata.db"], after["masterdata.db"]
        baseline_tables = fingerprints(base_master)
        candidate_tables = fingerprints(candidate_master)
        changed = [t for t in sorted(set(baseline_tables) | set(candidate_tables)) if baseline_tables.get(t) != candidate_tables.get(t)]
        assert changed == ["m_lesson_skill_shooting_star"], changed
        base_fk = sorted(base_master.execute("PRAGMA foreign_key_check").fetchall(), key=repr)
        candidate_fk = sorted(candidate_master.execute("PRAGMA foreign_key_check").fetchall(), key=repr)
        assert base_fk == candidate_fk, "New foreign-key violations"
        dictionary_changes = {}
        for database_name in after:
            if not database_name.startswith("dictionary_"):
                continue
            if not after[database_name].execute("SELECT 1 FROM sqlite_master WHERE name='m_dictionary'").fetchone():
                assert fingerprints(before[database_name]) == fingerprints(after[database_name])
                dictionary_changes[database_name] = {}
                continue
            previous = dict(before[database_name].execute("SELECT id,message FROM m_dictionary"))
            current = dict(after[database_name].execute("SELECT id,message FROM m_dictionary"))
            dictionary_changes[database_name] = {
                k: {"before": previous.get(k), "after": current.get(k)}
                for k in sorted(set(previous) | set(current)) if previous.get(k) != current.get(k)
            }
        report["locales"][locale] = {
            "baseline_migrations": before_run,
            "candidate_migrations": after_run,
            "all_integrity_checks_ok": True,
            "changed_masterdata_tables": changed,
            "baseline_foreign_key_violation_count": len(base_fk),
            "new_foreign_key_violations": 0,
            "baseline_foreign_key_tables": dict(collections.Counter(r[0] for r in base_fk)),
            "shooting_star_mapping": validate_mapping(candidate_master),
            "dictionary_changes": dictionary_changes,
            "table_fingerprints": candidate_tables,
        }
        for database in [*before.values(), *after.values()]:
            database.close()
    if args.observations:
        report["observations"] = observation_evidence(args.observations)
    if args.output:
        args.output.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": "PASS",
        "report": str(args.output.resolve()) if args.output else None,
        "locales": {
            locale: {
                "baseline_files": result["baseline_migrations"]["files"],
                "candidate_files": result["candidate_migrations"]["files"],
                "candidate_lines": result["candidate_migrations"]["lines"],
                "integrity_checks_ok": result["all_integrity_checks_ok"],
                "masterdata_changes": result["changed_masterdata_tables"],
                "new_foreign_key_violations": result["new_foreign_key_violations"],
                "shooting_star_mapping": result["shooting_star_mapping"],
            }
            for locale, result in report["locales"].items()
        },
    }, indent=2))


if __name__ == "__main__":
    main()
