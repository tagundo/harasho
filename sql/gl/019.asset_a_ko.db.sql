-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "71c632b4517247da6ec7ed636c305a1ea215f4af", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";