-- Skills observed as shooting stars for each lesson menu id on 2022-03-22.
-- source: https://web.archive.org/web/20250516115624/https://lovelive-as.boom-app.wiki/entry/trainingcamp-skill
-- 30000057 is Critical Up (L):AC Start, a pure meditation (menu 3) drop.
-- The wiki also lists it for stretches (menu 7), but the observed skill data only
-- contains it for 333 (1060 drops across all 512 combinations). Omit that unsupported
-- menu 7 animation mapping; do not change the verified skill drop pool to match it.
-- observed data: https://github.com/eman1can/SIFAS-Lesson-Data/tree/c737d93c7280d93de1d4b4f02e6d14a3ab65fa3f/as-stats-csv/insight_skills
CREATE TABLE m_lesson_skill_shooting_star (skill_master_id INTEGER, lesson_menu_id INTEGER, PRIMARY KEY (skill_master_id, lesson_menu_id));
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 1);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000055, 1);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000427, 1);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000076, 1);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000522, 1);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000525, 2);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000522, 2);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 2);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000057, 3);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000108, 3);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000078, 3);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 3);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000054, 4);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000105, 4);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000071, 4);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 4);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000525, 5);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000522, 5);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000047, 5);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000079, 5);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 5);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000059, 6);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000523, 6);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 6);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000051, 7);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000072, 7);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 7);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000046, 8);
INSERT INTO m_lesson_skill_shooting_star (skill_master_id, lesson_menu_id) VALUES (30000526, 8);
