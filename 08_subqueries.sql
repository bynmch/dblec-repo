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

-- ---------------------------------------------------
-- 서브쿼리의 종류
-- 1) 다중행 다중열 서브쿼리
SELECT
       *
  FROM tbl_menu;
  
-- 2) 다중행 단일열 서브쿼리
SELECT
       menu_name
  FROM tbl_menu;
  
-- 3) 단일행 다중열 서브쿼리
SELECT
       *
  FROM tbl_menu
 WHERE menu_name = '우럭스무디';

-- 4) 단일행 단일열 서브쿼리
SELECT
       category_code
  FROM tbl_menu
 WHERE menu_name = '우럭스무디';

-- 단일행 다중열 서브쿼리의 특이케이스
-- '아이스가리비관자육수'와 동일한 메뉴가격과 카테고리인 메뉴 조회
SELECT
       menu_name
  FROM tbl_menu
 WHERE (menu_price, category_code) = (SELECT menu_price
                                           , category_code
													 FROM tbl_menu
													WHERE menu_name = '아이스가리비관자육수'
												  ); 

-- 다중행 단일열 서브쿼리의 특이케이스
-- 기타 카테고리인 메뉴들을 조회
SELECT
       a.menu_name
  FROM tbl_menu a
 WHERE a.menu_name IN (SELECT b.menu_name
                         FROM tbl_menu b
                         JOIN tbl_category c ON b.category_code = c.category_code
						      WHERE c.category_name = '기타'
							   );
-- =>아래와 같음.
SELECT
       a.menu_name
  FROM tbl_menu a
 WHERE a.menu_name IN ('우럭스무디', '생갈치쉐이크', '갈릭미역파르페', ..., '아이스가리비관자육수' );
 
-- ----------------------------------------------------------------------
-- from 절에 작성하는 서브쿼리(인라인 뷰)
-- 가장 많은 메뉴가 포함된 카테고리의 메뉴 개수를 구해보자.(count(), max())
SELECT
       COUNT(*)
     , category_code  
  FROM tbl_menu
 GROUP BY category_code;

-- 먼저 뽑은 게 서브

-- 인라인 뷰에 함수가 있다면 반드시 별칭을 달아주고 그래야 메인 쿼리에서
-- 해당 별칭으로 컬럼의 값을 뽑을 수 있다.
SELECT
       MAX(a.count)
     , a.category_code  
  FROM (SELECT COUNT(*) AS 'count'
             , category_code  
          FROM tbl_menu
         GROUP BY category_code
        ) a;
 













 
 
 