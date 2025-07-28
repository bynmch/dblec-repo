-- type casting
-- 명시적 형변환

-- 1) 숫자 -> 숫자
-- cast A as B: A를 B로 형 변환한다.
SELECT 
       AVG(menu_price)
     , CAST(AVG(menu_price) AS UNSIGNED INTEGER) AS '가격평균'
     , CONVERT(AVG(menu_price), DOUBLE) AS '가격 평균2'
  FROM tbl_menu
 GROUP BY category_code;
 
DESC tbl_menu;

-- 2) 문자 -> 날짜
-- 구분자 자동인식
SELECT CAST('2025%07%23' AS DATE);
SELECT CAST('2025/07/23' AS DATE);
SELECT CAST('2025?07?23' AS DATE);
SELECT CAST('20250723' AS DATE);

-- 3) 숫자 -> 문자
-- 1000 -> '1000'
SELECT CAST(1000 AS CHAR);

-- 명시적 형변환
SELECT CONCAT(CAST(1000 AS CHAR), '원');

-- 묵시적 형변환
SELECT CONCAT(1000, '원');

-- varchar(3)인 emp_id이지만 200을 묵시적으로 varchar형으로 변환 해준다.
SELECT
       *
  FROM employee
 WHERE emp_id = 200;

DESC employee;

SELECT '2' + 1;
SELECT 5 > '반가워';

-- '반가워'가 0이 되는 이유: (true == 1, false == 0)
-- '반가워' 문자열을 숫자로 바꿀 땐 0으로 형변환한다.
