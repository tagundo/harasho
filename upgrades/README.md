# Dictionary text upgrades

`gl/dictionary_{en,ko,zh}_k.json` defines the current text for selected GL
dictionary keys. Elichika applies these plans after historical SQL, before
building the manifests and server dictionaries. This covers both fresh builds
and restored installations whose already-modified DBs skip historical SQL.

Each change contains `id`, `from` (exact known official or historical wording),
and `to` (the current translation). Keep real line breaks in the JSON string
values. A missing key is inserted; an existing message changes only if it
matches a `from` value. Other messages, including owner translations and NULL,
are preserved. A custom message identical to historical text cannot be
distinguished from that historical text. Each dictionary is updated in one
transaction; a failed update rolls back that dictionary and the server warns.

When revising a translation, retain the known historical values and add the
previous `to` value to `from`. Set `to` to the new wording. Do not add arbitrary
owner text or broad match rules. Leave the original SQL migrations unchanged;
they remain the reproducible baseline for existing installations. Proper names,
URLs and placeholders must remain intact. The ZH dictionary uses Traditional
Chinese; these community translations are not claimed to be official.

Run the source checks from a pristine checkout with full Git history:

```sh
python3 tests/validate_shooting_star.py
python3 tests/validate_localization.py
```

The localization check compares every dictionary row and schema with the
pre-localization baseline, exercises every known old value, missing keys,
repeated application and custom translations, and checks the descriptions
against actual skill ranks, charm weights and graphics settings. Elichika's
regression suite separately exercises the production Go updater, transaction
rollback and concurrent startup. To check an initialized disposable payload:

```sh
python3 tests/validate_localization.py --runtime /path/to/server
```

The runtime check expects canonical text for a fresh build. A customized user
installation may deliberately differ. This repository ignores new dotted
filenames by default, so add new plans, validators and this README explicitly
with `git add -f`.
