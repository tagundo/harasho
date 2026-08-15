-- Lesson (training) drop rates.
--
-- The real server never sent these rates to the client, so masterdata has no table for
-- them. They were recovered from roughly 5.6 million lesson results observed in 2021 by
-- as-stats.loveliv.es, parsed in https://github.com/eman1can/SIFAS-Lesson-Data.
-- Every weight column below is out of a total of 10000.
--
-- elichika applies this file one line at a time and stops on the first error, so every
-- statement has to stay on a single line. Comments and blank lines are fine.

-- How many items a lesson menu run drops (item_id 1) and how many rally megaphones each
-- lesson drops (item_id 2).
--
-- The item counts average 18 per run and are deliberately NOT the 2021 observed figure,
-- which averages 13.2. Item drops were buffed before the game ended: the same 2021 data
-- shows gold dropping in 3k-7k steps where masterdata now has 5k-10k. Only the average is
-- recoverable from that data anyway, not the distribution, so the existing counts are kept.
CREATE TABLE m_lesson_drop_amount (item_id INTEGER, count INTEGER, weight INTEGER);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 15, 25);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 16, 8);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 17, 8);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 18, 25);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 19, 8);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 20, 8);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 21, 11);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 22, 1);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 23, 1);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 24, 3);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 25, 1);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (1, 26, 1);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (2, 0, 810);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (2, 1, 100);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (2, 2, 75);
INSERT INTO m_lesson_drop_amount (item_id, count, weight) VALUES (2, 3, 15);

-- Which of the 9 deck positions receives the skill.
--
-- Observed shares were 23.78% for position 1 and between 9.47% and 9.58% for each of the
-- other 8. The round 2400 / 950 below is that same distribution with the sampling noise
-- taken out, and it sums to exactly 10000.
CREATE TABLE m_lesson_skill_member_chance (position_id INTEGER PRIMARY KEY, weight INTEGER);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (1, 2400);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (2, 950);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (3, 950);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (4, 950);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (5, 950);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (6, 950);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (7, 950);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (8, 950);
INSERT INTO m_lesson_skill_member_chance (position_id, weight) VALUES (9, 950);

-- Weight of each insight skill rarity. Rarity 0 is the weight of dropping no skill at all,
-- so a run gives some skill 71.31% of the time.
--
-- These are the observed rates. eman1can/elichika instead ships a deliberately harder
-- tuning (0 = 4000, 1 = 3000, 2 = 2000, 3 = 750, 4 = 250, 5 = 100), which drops a skill
-- only 60.4% of the time, to make passive skills scarcer. Put those numbers back if that
-- is wanted: nothing in elichika depends on which of the two is used.
--
-- Caveat: this model produces one flat rate for every lesson combination, because all 5
-- rarities are always represented. The real rates were not flat, they were 84.1% for the
-- 8 pure combinations and 69.3% across the 504 mixed ones, ranging from 57.5% to 91.0%.
-- The weights below match the overall average, not that spread.
CREATE TABLE m_lesson_skill_rarity (rarity INTEGER PRIMARY KEY, weight INTEGER);
INSERT INTO m_lesson_skill_rarity (rarity, weight) VALUES (0, 2869);
INSERT INTO m_lesson_skill_rarity (rarity, weight) VALUES (1, 3830);
INSERT INTO m_lesson_skill_rarity (rarity, weight) VALUES (2, 1842);
INSERT INTO m_lesson_skill_rarity (rarity, weight) VALUES (3, 810);
INSERT INTO m_lesson_skill_rarity (rarity, weight) VALUES (4, 485);
INSERT INTO m_lesson_skill_rarity (rarity, weight) VALUES (5, 164);

-- Which insight skill can drop from which combination of the 3 lessons.
--
-- drop_type decides how lesson_menu_id1 and lesson_menu_id2 are read:
--   1 pure     all 3 lessons are lesson_menu_id1
--   2 mixed    at least one lesson is lesson_menu_id1
--   3 any      drops from every combination
--   4 majority lesson_menu_id1 twice and lesson_menu_id2 once, in any order
--
-- Replaying these rules against all 512 observed combinations reproduces the observed
-- skill sets, with two kinds of leftover. Skills 30000524, 30000525 and 30000526 are
-- predicted everywhere but barely observed: they were added to the game after this data
-- was collected, so they could not show up in it. The only real error was 30000304, fixed
-- below.
CREATE TABLE m_lesson_skill_content (skill_master_id  INTEGER PRIMARY KEY, drop_type INTEGER, rarity INTEGER, lesson_menu_id1 INTEGER, lesson_menu_id2 INTEGER);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000046, 1, 3, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000047, 1, 3, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000048, 1, 3, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000049, 1, 3, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000050, 1, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000051, 1, 3, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000054, 1, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000055, 1, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000057, 1, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000058, 1, 3, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000059, 1, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000060, 1, 4, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000061, 1, 4, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000062, 1, 4, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000065, 1, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000066, 1, 3, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000068, 1, 3, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000069, 1, 4, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000071, 1, 5, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000072, 1, 5, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000075, 1, 4, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000076, 1, 4, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000078, 1, 4, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000079, 1, 5, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000081, 1, 4, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000082, 1, 4, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000085, 1, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000086, 1, 3, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000088, 1, 3, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000089, 1, 4, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000101, 1, 4, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000102, 1, 4, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000105, 1, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000106, 1, 3, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000108, 1, 3, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000109, 1, 4, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000111, 1, 4, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000112, 1, 4, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000115, 1, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000116, 1, 3, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000118, 1, 3, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000119, 1, 4, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000121, 1, 4, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000122, 1, 4, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000125, 1, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000126, 1, 3, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000128, 1, 3, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000129, 1, 4, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000131, 1, 4, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000132, 1, 4, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000135, 1, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000136, 1, 3, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000138, 1, 3, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000139, 1, 4, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000001, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000002, 2, 1, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000004, 2, 1, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000006, 2, 1, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000007, 2, 1, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000009, 2, 1, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000011, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000012, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000014, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000021, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000022, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000024, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000026, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000027, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000029, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000031, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000032, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000034, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000036, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000037, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000039, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000041, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000042, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000044, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000141, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000142, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000143, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000144, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000149, 2, 1, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000150, 2, 1, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000152, 2, 1, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000154, 2, 1, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000160, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000161, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000163, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000170, 2, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000171, 2, 3, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000173, 2, 3, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000180, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000181, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000183, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000200, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000201, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000203, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000210, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000211, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000213, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000220, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000221, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000223, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000230, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000231, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000233, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000236, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000292, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000293, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000294, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000295, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000300, 2, 1, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000301, 2, 1, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000303, 2, 1, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000305, 2, 1, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000311, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000312, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000314, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000321, 2, 3, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000322, 2, 3, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000324, 2, 3, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000331, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000332, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000334, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000351, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000352, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000354, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000361, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000362, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000364, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000371, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000372, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000374, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000381, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000382, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000384, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000387, 2, 2, 8, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000388, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000389, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000390, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000395, 2, 1, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000396, 2, 1, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000398, 2, 1, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000400, 2, 1, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000406, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000407, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000409, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000416, 2, 3, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000417, 2, 3, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000419, 2, 3, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000426, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000427, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000429, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000446, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000447, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000449, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000456, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000457, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000459, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000466, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000467, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000469, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000476, 2, 2, 4, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000477, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000479, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000482, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000483, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000485, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000487, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000488, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000490, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000492, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000493, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000495, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000502, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000503, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000505, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000507, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000508, 2, 2, 6, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000510, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000512, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000513, 2, 2, 2, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000515, 2, 2, 5, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000517, 2, 2, 1, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000518, 2, 2, 3, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000520, 2, 2, 7, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000522, 3, 5, null, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000523, 3, 4, null, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000524, 3, 3, null, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000525, 3, 2, null, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000526, 3, 1, null, null);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000005, 4, 4, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000045, 4, 5, 3, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000053, 4, 3, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000064, 4, 4, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000074, 4, 5, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000084, 4, 4, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000104, 4, 4, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000114, 4, 4, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000124, 4, 4, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000134, 4, 4, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000145, 4, 2, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000146, 4, 2, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000148, 4, 2, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000153, 4, 2, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000155, 4, 3, 2, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000156, 4, 3, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000157, 4, 3, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000159, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000164, 4, 3, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000166, 4, 4, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000167, 4, 4, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000169, 4, 4, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000174, 4, 4, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000176, 4, 3, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000177, 4, 3, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000179, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000184, 4, 3, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000196, 4, 3, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000197, 4, 3, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000199, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000204, 4, 3, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000206, 4, 3, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000207, 4, 3, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000209, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000214, 4, 3, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000216, 4, 3, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000217, 4, 3, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000219, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000224, 4, 3, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000226, 4, 3, 4, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000227, 4, 3, 7, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000229, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000234, 4, 3, 5, 2);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000237, 4, 2, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000238, 4, 2, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000240, 4, 2, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000241, 4, 2, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000242, 4, 2, 6, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000243, 4, 4, 2, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000244, 4, 3, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000245, 4, 3, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000247, 4, 3, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000248, 4, 3, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000250, 4, 4, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000251, 4, 4, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000253, 4, 4, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000254, 4, 4, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000256, 4, 3, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000257, 4, 3, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000259, 4, 3, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000260, 4, 3, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000268, 4, 3, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000269, 4, 3, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000271, 4, 3, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000272, 4, 3, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000274, 4, 3, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000275, 4, 3, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000277, 4, 3, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000278, 4, 3, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000280, 4, 3, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000281, 4, 3, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000283, 4, 3, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000284, 4, 3, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000286, 4, 3, 4, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000287, 4, 3, 1, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000289, 4, 3, 3, 1);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000290, 4, 3, 5, 3);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000296, 4, 2, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000297, 4, 2, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000299, 4, 2, 8, 7);
-- Fixed: the source has this one as (4, 5), which would make it drop from 445/454/544,
-- but it is only ever observed dropping from 455/545/554. Stored swapped, as (5, 4).
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000304, 4, 2, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000306, 4, 3, 2, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000307, 4, 3, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000308, 4, 3, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000310, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000315, 4, 3, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000317, 4, 4, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000318, 4, 4, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000320, 4, 4, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000325, 4, 4, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000327, 4, 3, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000328, 4, 3, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000330, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000335, 4, 3, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000347, 4, 3, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000348, 4, 3, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000350, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000355, 4, 3, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000357, 4, 3, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000358, 4, 3, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000360, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000365, 4, 3, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000367, 4, 3, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000368, 4, 3, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000370, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000375, 4, 3, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000377, 4, 3, 4, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000378, 4, 3, 7, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000380, 4, 3, 8, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000385, 4, 3, 5, 4);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000391, 4, 2, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000392, 4, 2, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000394, 4, 2, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000399, 4, 2, 5, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000401, 4, 3, 2, 8);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000402, 4, 3, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000403, 4, 3, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000405, 4, 3, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000410, 4, 3, 5, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000412, 4, 4, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000413, 4, 4, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000415, 4, 4, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000420, 4, 4, 5, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000422, 4, 3, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000423, 4, 3, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000425, 4, 3, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000430, 4, 3, 5, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000442, 4, 3, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000443, 4, 3, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000445, 4, 3, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000450, 4, 3, 5, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000452, 4, 3, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000453, 4, 3, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000455, 4, 3, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000460, 4, 3, 5, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000462, 4, 3, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000463, 4, 3, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000465, 4, 3, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000470, 4, 3, 5, 7);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000472, 4, 3, 4, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000473, 4, 3, 7, 6);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000475, 4, 3, 8, 5);
INSERT INTO m_lesson_skill_content (skill_master_id, drop_type, rarity, lesson_menu_id1, lesson_menu_id2) VALUES (30000480, 4, 3, 5, 7);
