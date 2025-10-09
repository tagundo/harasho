-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "8f4c572c98dc573db1dbe3a74452bd9c06d28187", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";
