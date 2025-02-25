-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "fe7282fe39b0df7222aea4cf8962d66690bc19e5", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";