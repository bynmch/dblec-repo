-- distinct
-- 중복된 거 있으면 한 번만 보고싶다
-- 메뉴가 할당된 카테고리를 조회하고싶다
-- 중복을 제거해 종류를 알고자 할 때(그룹핑)
-- distinct를 쓸 때는 추출할 컬럼을 잘 고려해야 한다.
-- (일반적으로 하나의 컬럼을 쓸 것)

-- menu로 할당된 카테고리의 번호는 4, 5, 6, 8, 9, 10, 11, 12
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

SELECT 
       distinct category_code
--       category_code
--     , menu_name -- 다른 컬럼 쓰면 category_code만 중복x 못함
  FROM tbl_menu;


-- 해당 카테고리들의 이름을 조회(IN연산자를 활용할 수 있다.)
SELECT
       category_name
  FROM tbl_category
 WHERE category_code IN (4, 5, 6, 7, 8, 9, 10, 11, 12);
 
 
-- -----------------------------------------
-- 다중열 distinct
SELECT
       distinct 
		 category_code
     , orderable_status
  FROM tbl_menu;