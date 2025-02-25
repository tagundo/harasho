-- package verify
-- rename prefix number to last order if any files added
UPDATE m_asset_package SET version = "594408aa8e35aac07384baa399cfd0232e729b23", pack_num = (SELECT COUNT(*) FROM m_asset_package_mapping WHERE package_key="main") WHERE package_key = "main";