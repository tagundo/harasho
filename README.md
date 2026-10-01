# Harasho

This is the repository that handles versions of the game that [elichika](https://gitlab.com/tatara_hisoka/elichika) can load. This include:

- `masterdata.db` and other client databases.
- Beatmaps.

This repository is kept up-to-date with `elichika`'s feature updates, with the root being the state of the database at the game's EOS.

For each version, sql files to modify the EOS database to the desired database will be provided instead of the modified database itself. This is both to reduce the necessary network load and make it easier to check what actually changed. These sql files will assume the relevant elichika version would be used to load them. Howerver, you can assume the process would generally follow the following:

- Elichika checks each database file against its Git version before running the historical full SQL migrations.
- If a database file already has local changes, those full migrations are skipped for that file.
- Otherwise elichika applies the full SQL migrations using its migration loader.

Targeted upgrades still run for modified or restored databases. Missing Shooting Star metadata is added while existing metadata tables are preserved. Dictionary plans insert missing keys or replace exact known historical messages; other wording, including owner translations, is preserved. See [Dictionary text upgrades](upgrades/README.md) for the plan format and maintenance rules.

If you want to make your own game version (with modified database and such), it's recommended to create a fork or a new repository with the same structure and point to it from elichika (or your fork / version of it).

Note that server-sided contents like gachas or exchanges is not included here.

PLEASE DO NOT MAKE ANY CHANGES ON SUBMODULE PATH (package/key_name/author_name)
