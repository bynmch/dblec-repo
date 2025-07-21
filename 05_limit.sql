-- Limit ResultSet에서 추출하기(데이터에서 일부 잘라내기 ex 게시판 페이지, 유튜브 동영상 보이는 갯수, ...)
SELECT
       menu_code
     , menu_name
	  , menu_price
  FROM tbl_menu
-- WHERE tbl_menu
 ORDER BY menu_price DESC, menu_code DESC
-- 해석 순서: from - where - select - order by
-- LIMIT 시작위치, 길이(INDEX)
LIMIT 6, 6;		-- 7번 째 행부터 이후 6개의 행을 추출

SELECT
       *
  FROM tbl_menu
 ORDER BY menu_code
 LIMIT 5;		--첫 행부터 작성된 숫자 길이만큼 추출