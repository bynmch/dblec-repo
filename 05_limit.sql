-- Limit ResultSet에서 추출하기(데이터에서 일부 잘라내기 ex 게시판 페이지, 유튜브 동영상 보이는 갯수, ...)

-- 해석 순서: from - where - select - order by - limit
-- LIMIT [시작위치], [길이(INDEX)]
-- 7번 행부터 6개의 행을 추출
SELECT
       menu_code
     , menu_name
	  , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC, menu_code DESC
 LIMIT 6, 6;		

-- 첫 행부터 길이만큼 추출
SELECT
       *
  FROM tbl_menu
 ORDER BY menu_code
 LIMIT 5;		