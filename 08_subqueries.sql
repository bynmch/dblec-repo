-- subqueries

-- '민트미역국'과 같은 카테고리의 메뉴를 조회
-- (쿼리를 두번 이상 실행해야 될 것)
-- 백엔드 서버와 DB서버간 데이터를 주고받을 때 쿼리가 많으면 딜레이도 늘어남.
-- 하나의 쿼리로 만들어줘야 시간 줄어듦.

-- 서브쿼리(먼저 실행 되어야 함)
SELECT
       menu_name
     , category_code
  FROM tbl_menu
 WHERE menu_name = '민트미역국'; -- 4번확인

-- 메인쿼리 
SELECT
       menu_name
  FROM tbl_menu
 where category_code = 4;
 
-- 하나의 쿼리로 바꾸기
SELECT
       menu_name
  FROM tbl_menu
 WHERE category_code = (SELECT category_code
                          FROM tbl_menu
                         WHERE menu_name = '민트미역국'
                       )
	AND menu_name != '민트미역국';

-- 이름이 민트미역국이 아닌 것 만 가져오기




