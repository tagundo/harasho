-- ix Aishiteru Banzai! position, why is dev make sense of this

-- reset to other member to avoid error
UPDATE m_live_member_mapping SET position = 204 WHERE mapping_id = 10022 AND position = 9; -- umi  to kotori
UPDATE m_live_member_mapping SET position = 208 WHERE mapping_id = 10022 AND position = 4; -- kotori to rin
UPDATE m_live_member_mapping SET position = 209 WHERE mapping_id = 10022 AND position = 8; -- rin to umi

UPDATE m_live_member_mapping SET position = 4 WHERE mapping_id = 10022 AND position = 204; -- umi  to kotori
UPDATE m_live_member_mapping SET position = 8 WHERE mapping_id = 10022 AND position = 208; -- kotori to rin
UPDATE m_live_member_mapping SET position = 9 WHERE mapping_id = 10022 AND position = 209; -- rin to umi