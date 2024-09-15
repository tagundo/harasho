-- ix Aishiteru Banzai! position, why is dev make sense of this

-- reset to other member to avoid error
UPDATE m_live_member_mapping SET member_master_id = 201 WHERE mapping_id = 10022 AND position = 9; -- umi  to kotori
UPDATE m_live_member_mapping SET member_master_id = 202 WHERE mapping_id = 10022 AND position = 4; -- kotori to rin
UPDATE m_live_member_mapping SET member_master_id = 203 WHERE mapping_id = 10022 AND position = 8; -- rin to umi
UPDATE m_live_member_mapping SET card_position = 201 WHERE mapping_id = 10022 AND position = 9; -- umi  to kotori
UPDATE m_live_member_mapping SET card_position = 202 WHERE mapping_id = 10022 AND position = 4; -- kotori to rin
UPDATE m_live_member_mapping SET card_position = 203 WHERE mapping_id = 10022 AND position = 8; -- rin to umi

UPDATE m_live_member_mapping SET member_master_id = 3 WHERE mapping_id = 10022 AND position = 9; -- umi  to kotori
UPDATE m_live_member_mapping SET member_master_id = 5 WHERE mapping_id = 10022 AND position = 4; -- kotori to rin
UPDATE m_live_member_mapping SET member_master_id = 4 WHERE mapping_id = 10022 AND position = 8; -- rin to umi
UPDATE m_live_member_mapping SET card_position = 3 WHERE mapping_id = 10022 AND position = 9; -- umi  to kotori
UPDATE m_live_member_mapping SET card_position = 5 WHERE mapping_id = 10022 AND position = 4; -- kotori to rin
UPDATE m_live_member_mapping SET card_position = 4 WHERE mapping_id = 10022 AND position = 8; -- rin to umi