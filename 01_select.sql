-- 주석

SELECT * FROM tbl_menu;													-- 메뉴 조회
SELECT * FROM tbl_category;


-- 원하는 컬럼만 보고싶다
SELECT category_code, category_name FROM tbl_category;
SELECT category_name, category_code FROM tbl_category;
																						
SELECT
       category_code 													-- * 쓰지 말고 컬럼 다 쓰기, 감리사 한테 혼남ㅠㅠ
     , category_name
     , ref_category_code
  FROM tbl_category;
																				--코딩컨벤션에 따라 콤마는 다음줄에 끝에 쓰게 되면 syntax오류가 날 수 있다.
  

-- --------------------------------------------------------

-- from 절 없는 select 해보기

SELECT 7 + 3;
SELECT 10 * 2;
SELECT 6 % 3, 6 % 4;														-- mod, modulus: 나누고 나머지 연산자 
SELECT NOW();																-- 컴퓨터의  시스템 시간(데이터베이스 서버 시스템 시간)
SELECT CONCAT('유', ' ', '관순');									-- 하나의 문자열로 변환

																				-- 문자 -> 아스키 코드(여어, 숫자, 특수기호), 유니코드 기반(영어, 숫자, 특수기호, 그 외) 
																				-- 문자열('): 문자 0개 이상

SELECT * FROM tbl_menu;
SELECT
		 CONCAT(menu_price, '원')
  FROM tbl_menu;


-- 별칭(alias)
SELECT 7 + 3 AS '합';                                       -- 가독성 위해  as 및 '를 붙임
SELECT 7 + 3 '합';
SELECT 7 + 3 합;


-- 별칭에 띄어 쓰기를 포함한 특수기호 있다면 '생략 불가
-- SELECT 7 + 1 합 계; -- 에러
SELECT 7 + 1 '합 계';

SELECT 
		 menu_name AS '메뉴명'
     , menu_price AS '메뉴가격'
  FROM tbl_menu;
  

