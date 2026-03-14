-- This is only place holders until we have a proper translation of the daily theaters as well.

-- Archive button. Original: アーカイブ
UPDATE m_dictionary SET message = "View archive" WHERE id = "daily_106";

-- Year/Month/Day format strings. Original: {0}年{1}月{2}日
UPDATE m_dictionary SET message = "{0}/{1}/{2}" WHERE id = "daily_theater_archive_101";
UPDATE m_dictionary SET message = "{0}/{1}/{2}" WHERE id = "daily_theater_archive_205";

-- Daily Theater Archive tile. Original: 毎日劇場アーカイブ
UPDATE m_dictionary SET message = "Daily Theater Archive" WHERE id = "daily_theater_archive_201";

-- Favorite List. Original: お気に入りリスト
UPDATE m_dictionary SET message = "Favorite" WHERE id = "daily_theater_archive_202";

-- Favorite button. Original: <img src="Common/InlineImage/Icon/tex_inlineimage_dailytheater_01" width="32px" height="32px" offsetY="-5px" margin-right="5px" />お気に入り
-- Toggled favorite button. Original: <img src="Common/InlineImage/Icon/tex_inlineimage_dailytheater_02" width="32px" height="32px" offsetY="-5px" margin-right="5px" />お気に入り
-- Remember to fix the margins for best looking button
-- viewing menu favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_01"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />Favorite" WHERE id = "daily_104";
-- viewing menu toggled favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_02"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />Favorite" WHERE id = "daily_105";
-- Aarchive favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_01"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />Favorite" WHERE id = "daily_theater_archive_204";
-- Archive toggled favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_02"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />Favorite" WHERE id = "daily_theater_archive_220";


-- Year format strings. Original: {0}年
UPDATE m_dictionary SET message = "Year {0}" WHERE id = "daily_theater_archive_207";

-- Months strings. Original: 1月, 2月, ..., 12月
Update m_dictionary SET message = "Jan" WHERE id = "daily_theater_archive_208";
Update m_dictionary SET message = "Feb" WHERE id = "daily_theater_archive_209";
Update m_dictionary SET message = "Mar" WHERE id = "daily_theater_archive_210";
Update m_dictionary SET message = "Apr" WHERE id = "daily_theater_archive_211";
Update m_dictionary SET message = "May" WHERE id = "daily_theater_archive_212";
Update m_dictionary SET message = "Jun" WHERE id = "daily_theater_archive_213";
Update m_dictionary SET message = "Jul" WHERE id = "daily_theater_archive_214";
Update m_dictionary SET message = "Aug" WHERE id = "daily_theater_archive_215";
Update m_dictionary SET message = "Sep" WHERE id = "daily_theater_archive_216";
Update m_dictionary SET message = "Oct" WHERE id = "daily_theater_archive_217";
Update m_dictionary SET message = "Nov" WHERE id = "daily_theater_archive_218";
Update m_dictionary SET message = "Dec" WHERE id = "daily_theater_archive_219";

-- Favorite limit display. Original: お気に入り登録：{0}/{1}
Update m_dictionary SET message = "Favorite limit: {0}/{1}" WHERE id = "daily_theater_archive_401";

-- Favorite limit text. Used for reaching the limit Original: お気に入りの上限
Update m_dictionary SET message = "Favorite limit reached" WHERE id = "daily_theater_archive_501";

-- Favorite limit message. Original: お気に入りの上限に達しています\nお気に入りは最大{0}件まで設定できます
Update m_dictionary SET message = "You have reached ravorite limit. You can have a maximum of {0} favorites" WHERE id = "daily_theater_archive_502";

-- Finding nothing in archive result. Original: 該当する毎日劇場がありません
Update m_dictionary SET message = "No daily theater found" WHERE id = "daily_theater_archive_801";

-- The text for the filters
-- Filter title. Original: 既読/未読
Update m_dictionary SET message = "Read/Unread" WHERE id = "m_filter_category_read_state";
-- Read filter. Original: 既読
Update m_dictionary SET message = "Read" WHERE id = "m_filter_condition_pattern_read_state_read";
-- UnRead filter. Original: 未読
Update m_dictionary SET message = "Unread" WHERE id = "m_filter_condition_pattern_read_state_unread";

-- =============================
-- appended from 020.dictionary_ko_k.db.sql
-- =============================

-- Inline images for shop item for event mining
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31041", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20041_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31040", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20040_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31039", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20039_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31038", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20038_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31037", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20037_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31036", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20036_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31035", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20035_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31034", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20034_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31033", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20033_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31032", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20032_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31031", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20031_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31030", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20030_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31029", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20029_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31028", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20028_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31027", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20027_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31026", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20026_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31025", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20025_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31024", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20024_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31023", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20023_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31022", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20022_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31021", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20021_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31020", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20020_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31019", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20019_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31018", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20018_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31017", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20017_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31016", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20016_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31015", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20015_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31014", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20014_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31013", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20013_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31012", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20012_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31011", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20011_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31010", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20010_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31009", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20009_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31008", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20008_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31007", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20007_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31006", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20006_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31005", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20005_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31004", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20004_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31003", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20003_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31002", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20002_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");
INSERT INTO `m_dictionary` VALUES ("event_mining_shop_item_inline_image_31001", "<img src=""Common/InlineImage/Icon/tex_inlineimage_item_20001_s"" height=""24px"" width=""24px"" offsetY=""-5px"" />");