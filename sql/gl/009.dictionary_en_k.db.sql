-- SIFAS Plus
-- Consistent fix dictionary

UPDATE m_dictionary SET message = 'Definition Mode' WHERE id = 'system_option_701';
UPDATE m_dictionary SET message = 'Definition Mode' WHERE id = 'system_option_703';
UPDATE m_dictionary SET message = 'Max 3D (No Split Screen)' WHERE id = 'm_live_quality_mode_name_high3d';
UPDATE m_dictionary SET message = 'This is the highest quality setting, with fluid 3D animation (THEY LIED, THERE IS NOT FLUID HERE) and a high resolution.' WHERE id = 'm_live_quality_mode_text_max3d_desc';
UPDATE m_dictionary SET message = 'Same as Max 3D but without split screen' WHERE id = 'm_live_quality_mode_text_high3d_desc';