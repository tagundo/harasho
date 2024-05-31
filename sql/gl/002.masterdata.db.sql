-- SIFAS Plus (GL JP Client)
-- todo list

-- RESTORE UNUSED CONTENT
-- lvl 500 bond
UPDATE m_member_init SET love_point_limit = 13181880;
-- lvl 100 card
-- R
UPDATE m_member_love_panel_bonus SET bonus_value = 9 WHERE bonus_type = 13 AND member_love_panel_master_id >= 10001 AND member_love_panel_master_id <= 10212;
UPDATE m_member_love_panel_bonus SET bonus_value = 9 WHERE bonus_type = 13 AND member_love_panel_master_id >= 20001 AND member_love_panel_master_id <= 20212;
UPDATE m_member_love_panel_bonus SET bonus_value = 9 WHERE bonus_type = 13 AND member_love_panel_master_id >= 30001 AND member_love_panel_master_id <= 30212;
UPDATE m_member_love_panel_cell SET bonus_value = 8 WHERE bonus_type = 13 AND id >= 15001 AND id <= 15212;
UPDATE m_member_love_panel_cell SET bonus_value = 8 WHERE bonus_type = 13 AND id >= 115001 AND id <= 115212;
UPDATE m_member_love_panel_cell SET bonus_value = 8 WHERE bonus_type = 13 AND id >= 215001 AND id <= 215212;
UPDATE m_member_love_panel_cell SET bonus_value = 9 WHERE bonus_type = 13 AND id >= 315001 AND id <= 315212;
-- SR
UPDATE m_member_love_panel_bonus SET bonus_value = 6 WHERE bonus_type = 14 AND member_love_panel_master_id >= 10001 AND member_love_panel_master_id <= 10212;
UPDATE m_member_love_panel_bonus SET bonus_value = 6 WHERE bonus_type = 14 AND member_love_panel_master_id >= 20001 AND member_love_panel_master_id <= 20212;
UPDATE m_member_love_panel_bonus SET bonus_value = 8 WHERE bonus_type = 14 AND member_love_panel_master_id >= 30001 AND member_love_panel_master_id <= 30212;
UPDATE m_member_love_panel_cell SET bonus_value = 6 WHERE bonus_type = 14 AND id >= 35001 AND id <= 35212;
UPDATE m_member_love_panel_cell SET bonus_value = 6 WHERE bonus_type = 14 AND id >= 135001 AND id <= 135212;
UPDATE m_member_love_panel_cell SET bonus_value = 8 WHERE bonus_type = 14 AND id >= 235001 AND id <= 235212;
-- UR
UPDATE m_member_love_panel_bonus SET bonus_value = 3 WHERE bonus_type = 15 AND member_love_panel_master_id >= 10001 AND member_love_panel_master_id <= 10212;
UPDATE m_member_love_panel_bonus SET bonus_value = 3 WHERE bonus_type = 15 AND member_love_panel_master_id >= 20001 AND member_love_panel_master_id <= 20212;
UPDATE m_member_love_panel_bonus SET bonus_value = 4 WHERE bonus_type = 15 AND member_love_panel_master_id >= 30001 AND member_love_panel_master_id <= 30212;
UPDATE m_member_love_panel_cell SET bonus_value = 3 WHERE bonus_type = 15 AND id >= 65001 AND id <= 65212;
UPDATE m_member_love_panel_cell SET bonus_value = 3 WHERE bonus_type = 15 AND id >= 165001 AND id <= 165212;
UPDATE m_member_love_panel_cell SET bonus_value = 4 WHERE bonus_type = 15 AND id >= 265001 AND id <= 265212;
-- SP Cut In Lanzhu & Mia
UPDATE m_card SET sp_point = 4 WHERE id = 402113001;
UPDATE m_card SET sp_point = 4 WHERE id = 402123001;
-- Appeal Chance
INSERT INTO m_live_note_wave_setting VALUES (10, "k.live_appeal_time_mission_got_heal");
INSERT INTO m_live_note_wave_setting VALUES (11, "k.live_appeal_time_mission_got_shield");
INSERT INTO m_live_note_wave_setting VALUES (12, "k.live_appeal_time_mission_got_voltage_by_vo");
INSERT INTO m_live_note_wave_setting VALUES (13, "k.live_appeal_time_mission_got_voltage_by_sp");
INSERT INTO m_live_note_wave_setting VALUES (14, "k.live_appeal_time_mission_got_voltage_by_gd");
INSERT INTO m_live_note_wave_setting VALUES (15, "k.live_appeal_time_mission_got_voltage_by_sk");
-- Song
UPDATE m_live_difficulty SET unlock_pattern = 1 WHERE unlock_pattern = 7;
-- item
INSERT INTO m_lesson_enhancing_item VALUES ('1402', '1', '3', 'k.item_thumb_title_1402', 'D|', 'k.item_name_1402', 'k.item_desc_1402', '14', NULL, '1');
INSERT INTO m_lesson_enhancing_item VALUES ('1501', '1', '4', 'k.item_thumb_title_1501', 'P,', 'k.item_name_1501', 'k.item_desc_1501', '14', NULL, '1');
INSERT INTO m_lesson_enhancing_item VALUES ('1502', '1', '4', 'k.item_thumb_title_1502', '?-', 'k.item_name_1502', 'k.item_desc_1502', '14', NULL, '1');
INSERT INTO m_lesson_enhancing_item_effect_skill_drop VALUES ('1402', '4');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1501', '1', '10000');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1501', '3', '15000');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1501', '4', '12000');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1501', '2', '10000');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1502', '1', '10000');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1502', '4', '15000');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1502', '5', '12000');
INSERT INTO m_lesson_enhancing_item_effect_drop_rate VALUES ('1502', '2', '10000');
INSERT INTO m_grade_upper VALUES ('1801', 'k.item_name_1801', 'k.item_desc_1800', '2', 'bc', 'bc', '15', '32', NULL, '1');
INSERT INTO m_grade_upper VALUES ('1802', 'k.item_name_1802', 'k.item_desc_1800', '3', '(g', '(g', '15', '32', NULL, '1');

-- OTHER CHANGES
-- replace pre-render MV with realtime (save hundred megabyte drive)
UPDATE m_story_main_cell SET live_difficulty_id = 12036301 WHERE id = 20002;
UPDATE m_story_main_cell SET live_difficulty_id = 12035301 WHERE id = 22021;
UPDATE m_story_main_cell SET live_difficulty_id = 12056301 WHERE id = 28021;
UPDATE m_live_member_mapping SET suit_master_id = 102102001 WHERE member_master_id = 210 AND mapping_id = 12056;
UPDATE m_live_member_mapping SET suit_master_id = 102112001 WHERE member_master_id = 211 AND mapping_id = 12056;
UPDATE m_live_member_mapping SET suit_master_id = 102122001 WHERE member_master_id = 212 AND mapping_id = 12056;
DELETE FROM m_live_movie;
DELETE FROM m_live WHERE display_order >= 90000000 AND display_order <= 90000010;
DELETE FROM m_live_difficulty WHERE live_id >= 92990 AND live_id <= 93000;
-- disabled useless setting
UPDATE m_home_menu_button_setting SET visible = 0;
-- fixed some songs not unlocked (mynet didn't properly to bond story song)
UPDATE m_live_difficulty SET unlock_pattern = 1 WHERE unlock_pattern = 4;
UPDATE m_story_member SET unlock_live_id = NULL;
-- correct m_user_rank same as official
UPDATE m_user_rank SET max_lp = 160 WHERE rank >= 60 AND rank <= 69;
UPDATE m_user_rank SET max_lp = 170 WHERE rank >= 70 AND rank <= 79;
UPDATE m_user_rank SET max_lp = 180 WHERE rank >= 80 AND rank <= 89;
UPDATE m_user_rank SET max_lp = 190 WHERE rank >= 90 AND rank <= 99;
UPDATE m_user_rank SET max_lp = 200 WHERE rank >= 100 AND rank <= 109;
UPDATE m_user_rank SET max_lp = 210 WHERE rank >= 110 AND rank <= 119;
UPDATE m_user_rank SET max_lp = 220 WHERE rank >= 120 AND rank <= 129;
UPDATE m_user_rank SET max_lp = 230 WHERE rank >= 130 AND rank <= 139;
UPDATE m_user_rank SET max_lp = 240 WHERE rank >= 140 AND rank <= 149;
UPDATE m_user_rank SET max_lp = 250 WHERE rank >= 150 AND rank <= 159;
UPDATE m_user_rank SET max_lp = 260 WHERE rank >= 160 AND rank <= 169;
UPDATE m_user_rank SET max_lp = 270 WHERE rank >= 170 AND rank <= 179;
UPDATE m_user_rank SET max_lp = 280 WHERE rank >= 180 AND rank <= 189;
UPDATE m_user_rank SET max_lp = 290 WHERE rank >= 190 AND rank <= 199;
UPDATE m_user_rank SET max_lp = 300 WHERE rank >= 200 AND rank <= 209;
UPDATE m_user_rank SET max_lp = 310 WHERE rank >= 210 AND rank <= 219;
UPDATE m_user_rank SET max_lp = 320 WHERE rank >= 220 AND rank <= 229;
UPDATE m_user_rank SET max_lp = 330 WHERE rank >= 230 AND rank <= 239;
UPDATE m_user_rank SET max_lp = 340 WHERE rank >= 240 AND rank <= 249;
UPDATE m_user_rank SET max_lp = 350 WHERE rank >= 250 AND rank <= 259;
UPDATE m_user_rank SET max_lp = 360 WHERE rank >= 260 AND rank <= 269;
UPDATE m_user_rank SET max_lp = 370 WHERE rank >= 270 AND rank <= 279;
UPDATE m_user_rank SET max_lp = 380 WHERE rank >= 280 AND rank <= 289;
UPDATE m_user_rank SET max_lp = 390 WHERE rank >= 290 AND rank <= 299;
UPDATE m_user_rank SET max_lp = 400 WHERE rank >= 300 AND rank <= 309;
UPDATE m_user_rank SET max_lp = 410 WHERE rank >= 310 AND rank <= 319;
UPDATE m_user_rank SET max_lp = 420 WHERE rank = 320;
-- UPDATE m_user_rank SET additional_accessory_limit = 10 WHERE rank >= 2 AND rank <= 320;
-- UPDATE m_constant_int SET value = 1000 WHERE constant_int = 154;
-- increase limit name (doesn't not work)
-- UPDATE m_constant_int SET value = 255 WHERE constant_int = 36;
-- UPDATE m_constant_int SET value = 255 WHERE constant_int >= 78 AND constant_int <= 81;
-- (dev) start sbl only 1 person
-- UPDATE m_constant_int SET value = 4 WHERE constant_int = 142;
-- (dev) disable timer start sbl
-- UPDATE m_constant_int SET value = 0 WHERE constant_int = 138;
-- increase limit skip ticket
UPDATE m_constant_int SET value = 100 WHERE constant_int = 173;
-- make all member use swimsuit in tutorial
-- ALTER TABLE m_live_difficulty_override_member_mapping DROP CONSTRAINT suit_non_playable_master_id;
-- ALTER TABLE m_live_difficulty_override_member_mapping DROP CONSTRAINT member_non_playable_master_id;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300104 WHERE member_master_id = 1;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300204 WHERE member_master_id = 2;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300304 WHERE member_master_id = 3;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300404 WHERE member_master_id = 4;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300504 WHERE member_master_id = 5;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300604 WHERE member_master_id = 6;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300711 WHERE member_master_id = 7;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300804 WHERE member_master_id = 8;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 300915 WHERE member_master_id = 9;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310105 WHERE member_master_id = 101;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310205 WHERE member_master_id = 102;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310305 WHERE member_master_id = 103;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310415 WHERE member_master_id = 104;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310505 WHERE member_master_id = 105;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310605 WHERE member_master_id = 106;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310705 WHERE member_master_id = 107;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310805 WHERE member_master_id = 108;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 310905 WHERE member_master_id = 109;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320103 WHERE member_master_id = 201;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320203 WHERE member_master_id = 202;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320313 WHERE member_master_id = 203;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320403 WHERE member_master_id = 204;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320503 WHERE member_master_id = 205;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320613 WHERE member_master_id = 206;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320703 WHERE member_master_id = 207;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320803 WHERE member_master_id = 208;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 320913 WHERE member_master_id = 209;
-- UPDATE m_live_difficulty_override_member_mapping SET suit_non_playable_master_id = 321013 WHERE member_non_playable_master_id = 210;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 321113 WHERE member_master_id = 211;
UPDATE m_live_difficulty_override_member_mapping SET suit_master_id = 321213 WHERE member_master_id = 212;
-- updated quality settings
UPDATE m_live_quality_setting SET frame_rate_60fps = 0;
-- unlock bond story
UPDATE m_story_member SET love_level = 1;