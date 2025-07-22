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

-- 먼저 뽑은 ResultSet이 서브쿼리를 통해 얻은 결과이다.

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

-- -------------------------------------------------------------
-- 가격이 가장 비싼 메뉴명 조회
-- 1) 메뉴의 가장 비싼 가격을 먼저 조회
SELECT
       MAX(menu_price)
  FROM tbl_menu;

-- 2) 해당 가격의 메뉴 조회
SELECT
       menu_name
--     , menu_price  
  FROM tbl_menu
 WHERE menu_price = (SELECT MAX(menu_price)
                       FROM tbl_menu
                    );   
                            
-- -------------------------------------------------------------
-- 상관 서브쿼리
-- 메인쿼리가 서브쿼리에 영향을 주는 것
-- 메인쿼리에 의해 결과가 달라지는 서브쿼리를 상관서브쿼리라고 한다.
-- 메뉴별 각 메뉴가 속한 카테고리의 평균보다 높은 가격의 메뉴들만 조회
-- 선행: 카테고리의 평균, 후행: 메뉴별 - 평균 보다 큰가?
-- 1) 카테고리가 10번인 경우 해당 카테고리에 속한 메뉴들의 평균
SELECT
       AVG(menu_price)
  FROM tbl_menu
 WHERE category_code = 10;

-- 2) 메뉴별 카테고리를 보고 위의 서브쿼리를 활용한 상관 서브쿼리 작성
SELECT
       a.menu_code
     , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status  
  FROM tbl_menu a
 WHERE a.menu_price > (SELECT AVG(b.menu_price)
                            FROM tbl_menu b
                           WHERE b.category_code = a.category_code
								 );

-- 메인쿼리에 있는 값이 서브쿼리에서 사용된다.
-- 서브쿼리 값도 매번 바뀐다.

-- ---------------------------------------------------------------------
-- exists
-- 메뉴로 할당된 카테고리를 조회
-- (서브쿼리에서?) 조회된 result set 의 행이 존재하면 true, 아니면 false이다.
SELECT
       a.category_name
  FROM tbl_category a
 WHERE EXISTS (SELECT menu_code
                 FROM tbl_menu b
                WHERE b.category_code = a.category_code
              );

-- 서브쿼리만 동작시킬 수 없다.

SELECT * FROM tbl_category;
SELECT * FROM tbl_menu;
