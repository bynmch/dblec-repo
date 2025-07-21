-- JOIN
-- 관계를 맺은 두 개 이상의 테이블을 한 번에 조회하고 싶을 때

-- 메뉴명과 카테고리명을 한 번에 보고싶다.
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

-- 1) '메뉴명'과 '카테고리명'이 각각 어떤 테이블에 존재하나?( 두 개이상이면)
-- 2) tbl_menu와 tbl_category에서 확인을 하고 서로 관계를 맺었는지 확인
-- 3) join으로 해결 가능함을 확인

-- 메뉴를 기준으로 카테고리도 함께 보는 개념
SELECT
       *
  FROM tbl_menu 
  JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code;
-- on 뒤는 등호, 부등호 가능 일반적으로는 등호 조건식
-- from에 가까울 수록 기준
-- join절은 아니지만코딩컨벤션을 지키기 위해
-- on은 join을 위한 조건절로 반드시 관계있는 컬럼을 토대로 조건을 작성할 것.
-- menu테이블의 카테고리 코드를 확인하고 거기서 카데고리 테이블의 카테고리 코드를 확인

-- 별칭을 활용한 조인 사용
-- "조인의 순서를 알기 쉽도록" 알파벳으로 별칭을 붙인다.
-- '' 붙이면 syntax 오류 난다.
-- 테이블에 별칭 추가 시에는 as를 붙여도 안 붙여도 된다. 대신 붙일거면 모두 붙이고 안 붙일거면 모두 안 붙인다.
SELECT
       *
  FROM tbl_menu AS a
  JOIN tbl_category AS b ON a.category_code = b.category_code;

DESC tbl_menu;
DESC tbl_category; 


-- a와 b에 모두 존재하는 컬럼명이 있으면 어떤 테이블의 컬럼인지 별칭이나 테이블로 명확히 한다. (a.category_code or b.category_code)
-- 다른 컬럼을 가져올 때도 컨벤션을 지키기 위해 별칭을 붙이는 것이 깔끔하다.(가독성과 유지보수성 향상시킬 수 있다.)
-- 테이블 말고 컬럼은 ''가능.
SELECT
       a.menu_name AS '메뉴명'
     , a.menu_price
	  , b.category_name
	  , a.category_code
	  , b.category_code
  FROM tbl_menu AS a
  JOIN tbl_category AS b ON a.category_code = b.category_code;
-- 심플하면서도 모든 걸 갖춘 코드
-- 코딩 컨벤션을 신경쓰자.
-- 별칭은 웬만하면 다 추가하자.

-- -----------------------------------------------------------
-- inner join
-- 각 테이블이 모두 매칭될 경우만 join
-- inner는 생략가능.
-- 1) on을 활용
SELECT 
       a.menu_name
     , b.category_name  
  FROM tbl_menu a
  INNER JOIN tbl_category b ON (a.category_code = b.category_code);

-- 컬럼명이 중복되는 게 싫음
-- 2) using을 활용(컬럼명이 같을 때는 using 사용가능하고 별칭 쓰면 안된다.)
-- using 뒤 소괄호 반드시 써야한다. 안쓰면 syntax 오류난다.
-- 선생님 팁: 같아도 1)경우 사용.
SELECT 
  FROM tbl_menu a
  JOIN tbl_category b USING (category_code);

-- ----------------------------------------------------------- 
-- outer join
-- left나 right는 생략 불가.
-- 메뉴로 할당되지 않는 카테고리를 다 보고싶을 때
-- join 시에 기준이 될 테이블의 모든 행을 보고자 하는 경우 사용
-- (매칭이 안되도 다 보고 싶을 때)
-- left나 right는 join의 기준.
-- join에서 나올 테이블 순서는 중요하나 resultset에 나올 컬럼의 순서는 임의로 판단한다.
-- 

-- 1) left join 
SELECT
       a.category_name
     , b.menu_name  
  FROM tbl_category a
  LEFT JOIN tbl_menu b ON a.category_code = b.category_code;

-- 2) right join
SELECT
       a.menu_name
     , b.category_name
  FROM tbl_menu a
  RIGHT JOIN tbl_category b ON a.category_code = b.category_code;	    

-- 만약에 다중 join(여러 테이블이 많이 join될 경우) 에서 outer join을 발생시키면
-- 끝까지 outer join 을 유지해 주어야 의미가 있다.

-- 3) cross join
-- 두 테이블의 모든 매칭의 경우를 다 보여준다.
-- 행*행 만큼 보여준다.
-- nested loop방식으로 모두 매칭한다.
SELECT
       *
  FROM tbl_menu
 CROSS JOIN tbl_category;
 
-- cross join 은 조건을 잘못 작성한 join일 경우 발생하게 되며 고의로
-- cross join 을 일으키는 경우는 없다.

-- 4) self join
-- 나 자신과 조인
-- 
SELECT * from tbl_category;
SELECT
       a.category_name AS '상위카테고리'
     , b.category_name AS '하위카테고리' 
  FROM tbl_category a
  JOIN tbl_category b ON (a.ref_category_code = b.category_code);
-- 초록키가 노란키를 참조하는 컬럼 관계가 테이블내에 있어야 한다.




