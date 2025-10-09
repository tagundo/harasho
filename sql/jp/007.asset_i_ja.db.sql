-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "66574fd0c9d88be5385ca884320f8f189e531d26", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";