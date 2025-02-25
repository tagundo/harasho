-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "767a6f5ec352b7b42a6d3741dbf0701ea2daa46c", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";