-- SIFAS Single Player (GL JP Client)

INSERT INTO m_dictionary VALUES ('live_appeal_time_mission_got_heal','Gain {0} Stamina!');
INSERT INTO m_dictionary VALUES ('live_appeal_time_mission_got_shield','Gain {0} Shield!');
INSERT INTO m_dictionary VALUES ('live_appeal_time_mission_got_voltage_by_vo','Gain {0} Voltage with an VO Type!');
INSERT INTO m_dictionary VALUES ('live_appeal_time_mission_got_voltage_by_sp','Gain {0} Voltage with an SP Type!');
INSERT INTO m_dictionary VALUES ('live_appeal_time_mission_got_voltage_by_gd','Gain {0} Voltage with an GD Type!');
INSERT INTO m_dictionary VALUES ('live_appeal_time_mission_got_voltage_by_sk','Gain {0} Voltage with an SK Type!');
INSERT INTO m_dictionary VALUES ('item_desc_1402','A Training item that guarantees your leader will discover a super rare Insight Skill.');
INSERT INTO m_dictionary VALUES ('item_name_1402','Insight Pin ★3');
INSERT INTO m_dictionary VALUES ('item_thumb_title_1402','★3');
INSERT INTO m_dictionary VALUES ('item_desc_1501','A Training item that increases the drop rate of super rare items. You can obtain these when you complete Goals.');
INSERT INTO m_dictionary VALUES ('item_name_1501','Lucky Charm ★2');
INSERT INTO m_dictionary VALUES ('item_thumb_title_1501','★2');
INSERT INTO m_dictionary VALUES ('item_desc_1502','A Training item that increases the drop rate of ultra rare items. You can obtain these when you complete Goals.');
INSERT INTO m_dictionary VALUES ('item_name_1502','Lucky Charm ★3');
INSERT INTO m_dictionary VALUES ('item_thumb_title_1502','★3');
UPDATE m_dictionary SET message = 'School Idol Radiance (R)' WHERE id = 'item_name_1800';
INSERT INTO m_dictionary VALUES ('item_name_1801', 'School Idol Radiance (SR)');
INSERT INTO m_dictionary VALUES ('item_name_1802', 'School Idol Radiance (UR)');
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'dic_external_movie_url_1';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'dic_external_movie_url_2';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'dic_external_movie_url_6';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'reference_book_movie_url_16';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_first_awakening_home';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_first_awakening_training_tree';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_gacha_gacha_top';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_gacha_home';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_story_clear_home';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_story_clear_story_chapter_select';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_story_clear_story_main';
UPDATE m_dictionary SET message = 'https://youtu.be/dQw4w9WgXcQ' WHERE id = 'review_request_url_story_clear_story_part_select';

-- Consistent fix dictionary
UPDATE m_dictionary SET message = 'Definition Mode' WHERE id = 'system_option_701';
UPDATE m_dictionary SET message = 'Definition Mode' WHERE id = 'system_option_703';
UPDATE m_dictionary SET message = 'Max 3D (No Split Screen)' WHERE id = 'm_live_quality_mode_name_high3d';
UPDATE m_dictionary SET message = 'Same as Max 3D but without split screen' WHERE id = 'm_live_quality_mode_text_high3d_desc';
UPDATE m_dictionary SET message = 'Shooting Star of Memories' WHERE id = 'replacement_skill_name_30000527';
UPDATE m_dictionary SET message = 'Tropical Smile' WHERE id = 'replacement_skill_name_30000528';
UPDATE m_dictionary SET message = 'Beach Survivor' WHERE id = 'replacement_skill_name_30000529';
UPDATE m_dictionary SET message = 'Bon Dance' WHERE id = 'replacement_skill_name_30000530';
UPDATE m_dictionary SET message = 'Watermelon Smasher' WHERE id = 'replacement_skill_name_30000531';
UPDATE m_dictionary SET message = 'Summer Lover' WHERE id = 'replacement_skill_name_30000532';
UPDATE m_dictionary SET message = 'Beach Dash' WHERE id = 'replacement_skill_name_30000533';

-- Reference Book
UPDATE m_dictionary SET message = 'This external site will open a browser app.' WHERE id = 'reference_book_l_105';
INSERT INTO m_dictionary VALUES ('elichika_title_1','Youtube');
INSERT INTO m_dictionary VALUES ('elichika_description_1','Subscribe to Hisoka Tatara');
INSERT INTO m_dictionary VALUES ('elichika_link_1','https://www.youtube.com/@hisoka_tatara');
INSERT INTO m_dictionary VALUES ('elichika_title_2','Gamebanana');
INSERT INTO m_dictionary VALUES ('elichika_description_2','Subscribe to SIFAS Mods Page');
INSERT INTO m_dictionary VALUES ('elichika_link_2','https://gamebanana.com/games/20519');
INSERT INTO m_dictionary VALUES ('elichika_title_3','Gitlab');
INSERT INTO m_dictionary VALUES ('elichika_description_3','Give us Star');
INSERT INTO m_dictionary VALUES ('elichika_link_3','https://gitlab.com/tatara_hisoka/elichika');
INSERT INTO m_dictionary VALUES ('elichika_title_4','Discord');
INSERT INTO m_dictionary VALUES ('elichika_description_4','Join LL Hax Server');
INSERT INTO m_dictionary VALUES ('elichika_link_4','https://discord.gg/VnhnvdW8CG');
INSERT INTO m_dictionary VALUES ('elichika_title_5','Discord');
INSERT INTO m_dictionary VALUES ('elichika_description_5','Join r/Otonokizaka Server');
INSERT INTO m_dictionary VALUES ('elichika_link_5','https://discord.gg/haha98');
INSERT INTO m_dictionary VALUES ('elichika_title_6','WebUI');
INSERT INTO m_dictionary VALUES ('elichika_description_6','Admin');
INSERT INTO m_dictionary VALUES ('elichika_link_6','http://127.0.0.1:8080/webui/admin');
INSERT INTO m_dictionary VALUES ('elichika_title_7','WebUI');
INSERT INTO m_dictionary VALUES ('elichika_description_7','User');
INSERT INTO m_dictionary VALUES ('elichika_link_7','http://127.0.0.1:8080/webui/user');
