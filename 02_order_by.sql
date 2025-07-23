-- order by (정렬)

-- 오름차순(Ascending, ASC): 1 -> 2 -> 3 ->..., a -> b -> c ->
-- 내림차순(Descending, DESC)

SELECT
       menu_code
     , menu_name
     , menu_price
  FROM tbl_menu
 -- 위 코드를 통해 만들어진 result set으로 정렬.
 -- ORDER BY menu_code DESC;  	
 -- Order by 절은 해석할 때 가장 마지막에 하자.
 -- ORDER BY menu_code;									-- 안 쓴 것은 ASC와 같다. default.
 -- ORDER BY 2; 											-- select절의 컬럼 순서를 기준으로 정렬
 ORDER BY menu_price, menu_name DESC;				-- 1차 정렬 기준, 2차 정렬 기준...
 																-- 앞의 기준에 해당하는 컬럼값이 같을 경우 뒤의 기준 적용
-- -----------------------------------------------------------------------------------------------------
-- 1. 배운 코드 변형 많이 해보기
-- 2. 에러를 두려워말자. 
-- 3. 에러를 정리해서 정리해서 문서화 하는 것 (== 트러블 슈팅) 하기

-- --------------------------------------------------------------
-- 주문 불가능한 메뉴부터 보기
SELECT * FROM tbl_menu;							-- 테이블의 데이터를 토대로 확인
DESC tbl_menu;										-- DESC라는 명령어로 빠르게 인사이트 얻기
-- DESCRIBE tbl_menu;							-- DESC(RIBE) 내림차순 아님 주의 

-- 별칭을 써서 할 수도 있다.
SELECT 
       menu_name AS '메뉴명'
	  , orderable_status AS '주문가능상태'
  FROM tbl_menu
 ORDER BY 주문가능상태;							 -- 별칭이 인지되고나서 order by 되기 때문 
 -- --------------------------------------------------------------------------------
 -- null값(비어있는 컬럼값)에 대한 정렬
 SELECT * FROM tbl_category;
 
 -- 1) 오름차순 시 null이 먼저 나옴.
 SELECT 
       *
  FROM tbl_category
 ORDER BY ref_category_code ASC;
 
 -- 2) 내림차순 시 null이 나중에 나옴.
 SELECT 
       *
  FROM tbl_category
 ORDER BY ref_category_code DESC;
 
  -- 3) 오름차순 시 null이 나중에 나옴.
 SELECT 
       *
  FROM tbl_category
 ORDER BY -ref_category_code DESC;
 
  -- 4) 내림차순 시 null이 먼저 나옴.
 SELECT 
       *
  FROM tbl_category
 ORDER BY -ref_category_code ASC;			
 
 -- '-'는 반대의 의미. asc는 null 먼저나옴. desc는 null 나중에 나옴.
 -- 마인드 맵, 정렬 - asc/desc, -숫자, -null, -별칭

-- -----------------------------------------------------------------------------
-- field를 활용함 order by
SELECT
       orderable_status
     , FIELD(orderable_status, 'Y', 'N') AS '가능여부'
	  , menu_name  
  FROM tbl_menu
-- ORDER BY FIELD(orderable_status, 'Y', 'N') DESC; 
 ORDER BY 가능여부 DESC;






 