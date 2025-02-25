-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "f2ad80e8f35f4d75fea4081eeef1ad6f28f8eedc", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";
