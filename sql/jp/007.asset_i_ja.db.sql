-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "1cba05e866750e52911a4cceeddd0a1ffb600c30", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";