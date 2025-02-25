-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "004af20e4c81b136ae6b4f5a3c62f766c6a20dc1", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";
