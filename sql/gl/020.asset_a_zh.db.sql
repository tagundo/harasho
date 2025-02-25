-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "0e8cd6e5e66816f0146f3572c76daf2a01433ea1", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";