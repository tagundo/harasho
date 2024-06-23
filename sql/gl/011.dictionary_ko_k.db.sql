-- Translated buttons for daily theater
-- use ChatGPT based

-- Archive button. Original: アーカイブ
UPDATE m_dictionary SET message = "아카이브 보기" WHERE id = "daily_106";

-- Year/Month/Day format strings. Original: {0}年{1}月{2}日
UPDATE m_dictionary SET message = "{0}/{1}/{2}" WHERE id = "daily_theater_archive_101";
UPDATE m_dictionary SET message = "{0}/{1}/{2}" WHERE id = "daily_theater_archive_205";

-- Daily Theater Archive tile. Original: 毎日劇場アーカイブ
UPDATE m_dictionary SET message = "일일 극장 아카이브" WHERE id = "daily_theater_archive_201";

-- Favorite List. Original: お気に入りリスト
UPDATE m_dictionary SET message = "즐겨찾기" WHERE id = "daily_theater_archive_202";

-- Favorite button. Original: <img src="Common/InlineImage/Icon/tex_inlineimage_dailytheater_01" width="32px" height="32px" offsetY="-5px" margin-right="5px" />お気に入り
-- Toggled favorite button. Original: <img src="Common/InlineImage/Icon/tex_inlineimage_dailytheater_02" width="32px" height="32px" offsetY="-5px" margin-right="5px" />お気に入り
-- Remember to fix the margins for best looking button
-- viewing menu favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_01"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />마음에 들어" WHERE id = "daily_104";
-- viewing menu toggled favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_02"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />마음에 들어" WHERE id = "daily_105";
-- Aarchive favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_01"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />마음에 들어" WHERE id = "daily_theater_archive_204";
-- Archive toggled favorite
UPDATE m_dictionary SET message = "<img src=""Common/InlineImage/Icon/tex_inlineimage_dailytheater_02"" width=""32px"" height=""32px"" offsetY=""-5px"" margin-right=""5px"" />마음에 들어" WHERE id = "daily_theater_archive_220";


-- Year format strings. Original: {0}年
UPDATE m_dictionary SET message = "연도 {0}" WHERE id = "daily_theater_archive_207";

-- Months strings. Original: 1月, 2月, ..., 12月
Update m_dictionary SET message = "1월" WHERE id = "daily_theater_archive_208";
Update m_dictionary SET message = "2월" WHERE id = "daily_theater_archive_209";
Update m_dictionary SET message = "3월" WHERE id = "daily_theater_archive_210";
Update m_dictionary SET message = "4월" WHERE id = "daily_theater_archive_211";
Update m_dictionary SET message = "5월" WHERE id = "daily_theater_archive_212";
Update m_dictionary SET message = "6월" WHERE id = "daily_theater_archive_213";
Update m_dictionary SET message = "7월" WHERE id = "daily_theater_archive_214";
Update m_dictionary SET message = "8월" WHERE id = "daily_theater_archive_215";
Update m_dictionary SET message = "9월" WHERE id = "daily_theater_archive_216";
Update m_dictionary SET message = "10월" WHERE id = "daily_theater_archive_217";
Update m_dictionary SET message = "11월" WHERE id = "daily_theater_archive_218";
Update m_dictionary SET message = "12월" WHERE id = "daily_theater_archive_219";

-- Favorite limit display. Original: お気に入り登録：{0}/{1}
Update m_dictionary SET message = "즐겨찾기 한도: {0}/{1}" WHERE id = "daily_theater_archive_401";

-- Favorite limit text. Used for reaching the limit Original: お気に入りの上限
Update m_dictionary SET message = "즐겨찾기 한도 초과" WHERE id = "daily_theater_archive_501";

-- Favorite limit message. Original: お気に入りの上限に達しています\nお気に入りは最大{0}件まで設定できます
Update m_dictionary SET message = "즐겨찾기 한도에 도달했습니다. 최대 {0}개의 즐겨찾기를 추가할 수 있습니다." WHERE id = "daily_theater_archive_502";

-- Finding nothing in archive result. Original: 該当する毎日劇場がありません
Update m_dictionary SET message = "일일 극장을 찾을 수 없습니다" WHERE id = "daily_theater_archive_801";

-- The text for the filters
-- Filter title. Original: 既読/未読
Update m_dictionary SET message = "읽음/읽지 않음" WHERE id = "m_filter_category_read_state";
-- Read filter. Original: 既読
Update m_dictionary SET message = "읽음" WHERE id = "m_filter_condition_pattern_read_state_read";
-- UnRead filter. Original: 未読
Update m_dictionary SET message = "읽지 않음" WHERE id = "m_filter_condition_pattern_read_state_unread";