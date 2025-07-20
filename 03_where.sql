-- where 절
-- 테이블에 들어있는 행마다 조건을 확인(필터링)하는 절.

-- 주문 가능한 메뉴만 조회 (메뉴명만 조회)
SELECT * FROM tbl_menu;

SELECT 									-- 해석 순서: from - where - select
       *
  FROM tbl_menu
-- WHERE orderable_status = 'Y'; 	-- 모든 행에 대해 조건 확인 -> true만 통과
 											   -- orderable_status에 테이블에 존재하는 컬럼값'Y'가 들어감.
-- WHERE orderable_status != 'N';
 WHERE orderable_status <> 'N';
 
-- --------------------------------------------------------------------------------
-- Q) '기타' 카테고리에 해당하지 않는 메뉴 조회
 
-- Hint1) 카테고리 테이블을 통해 메뉴에 있는 카테고리 코드 번호 파악
SELECT 
       *
  FROM tbl_category
 WHERE category_name = '기타';
-- Hint2) 메뉴조회
SELECT * FROM tbl_menu;
SELECT
	    *
  FROM tbl_menu
 where category_code != 10;
 
 
 -- 서브쿼리로 하나의 쿼리를 통해서도 풀 수 있음.
 SELECT 
       *
  FROM tbl_menu
 WHERE category_code != (
                        SELECT category_code
                          FROM tbl_category
                         WHERE category_name = '기타'
                       );
 
 

 
 
 
-- 카테고리 별 category_code 확인
SELECT * FROM tbl_category;					
 
-- '기타'카테고리 코드번호인 10이 아닌 경우
SELECT				
       *
 FROM tbl_menu
WHERE category_code != 10;		 




-- 5000원 이상이면서 7000원 미만인 메뉴 조회(AND) (이면서, 동시에)
SELECT 
       *
  FROM tbl_menu
 WHERE menu_price >= 5000		-- menu_price가 5000원이상
   AND menu_price < 7000;   	-- 이면서 menu_price가 7000원 미만
										-- 왼쪽을 기준으로 부등호방향 설정
 
-- 10000원 보다 초과하거나 5000원 이하인 메뉴 조회(OR) (이거나, 또는)
SELECT 
	    *
  FROM tbl_menu
 WHERE menu_price > 10000
 	 OR menu_price <= 5000;


-- --------------------------------------------------
-- between 연산자 활용하기
-- 가격이 5000원 이상이면서 9000원 이하인 메뉴 전체 컬럼 조회
DESC tbl_menu;		-- 컬럼명 확인하기
SELECT 
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
-- WHERE menu_price >= 5000
--   AND menu_price <= 9000;
 WHERE menu_price BETWEEN 5000 AND 9000; 	-- and이면서 이상 도는 이하로 구성되면
 														-- between 연산자로 수정가능
 														
-- 만약 반대로 하고 싶다면 
-- (위의 결과와 배타적 관계 == 섞이지 않는다. 메시하게, mece하게 / 중복되지 않게 합쳐지면 하나가 되게)
SELECT 
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
-- WHERE menu_price >= 5000
--   AND menu_price <= 9000;
 WHERE menu_price NOT BETWEEN 5000 AND 9000;

-- -----------------------------------------------
-- (문법 적으로 암기 x, 예제로 암기하자o)
-- Like 문 같냐x, 포함하냐o
-- 제목, 작성자 등을 검색할 때 주로 사용
-- 자주쓰니 익숙하게 만들기
-- where 절 잘 서서 원하는 조건으로 데이터 만들기
SELECT
       *
  FROM tbl_menu
-- WHERE menu_name LIKE '%밥%';  -- % 와일드 카드를 써서 Like문 작성 가능(와일드 카드: 기능이 있는 특수 기호)    
-- WHERE menu_name LIKE '%밥'; -- 밥으로 끝나는 메뉴만
 WHERE menu_name LIKE '밥%';	--  밥으로 시작하는 메뉴만
 
-- -----------------------------------------------
-- IN연산자
-- 카테고리가 '중식', '커피', '기타'인 메뉴 조회하기
SELECT * FROM tbl_category;

SELECT 
       *
  FROM tbl_menu
-- WHERE category_code = 5
--    OR category_code = 8
--    OR category_code = 10; 	-- 각 연산에 해당하는 값이 나오고 나서 조건식 연산 실행.
    									-- '마라깐쇼한라봉'이 category_code에 들어가면, 5, 8, 10각각 비교연산하고, boolean값들끼리 비교 연산한다.
 WHERE category_code IN (5, 8, 10); -- =와 or이 반복될 경우 IN 연산자로 대체할 수 있다.
 
-- -----------------------------------------------
-- is null 연산자 활용
-- NULL과 비교연산할 때는 등호가 아닌 is로 연산자표기
-- NOT 연산은 is not으로.
SELECT 
       *
  FROM tbl_category;    

-- 상위 카테고리를 조회
SELECT
  FROM tbl_category
 WHERE ref_category_code is NULL;
 
-- 하위카테고리를 조회
SELECT
  FROM tbl_category
 WHERE ref_category_code IS NOT NULL;








