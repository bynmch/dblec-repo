-- DML (Data Manipulation Language)
-- insert, update, delete

-- insert
-- 새로운 행을 추가하는 구문
-- insert 시에는 컬럼을 작성할 수도 안할 수도 있다.
-- 이때 무시해도 되는 컬럼은 auto_increment가 달려있느 ㄴ컬럼이고
-- 알아서 다음 번호를 작성해준다.
SELECT * FROM tbl_menu;
INSERT 
  INTO tbl_menu
(
  menu_name
, menu_price
, category_code
, orderable_status
)
VALUES
(
  '초콜릿죽'
, 6500
, 7
, 'Y'
);

DESC tbl_menu;

-- auto increment: 나머지 컬럼값(행)을 추가해주면 알아서 추가해주는 값
SELECT * FROM tbl_menu ORDER BY 1 DESC;

-- --------------------------------------------------------------------
-- multi-insert
-- 하나의 insert 구문으로 여러 데이터를 insert할 수 있다.
INSERT
  INTO tbl_menu
VALUES
(NULL, '참치맛아이스크림', 1700, 12, 'Y'),
(NULL, '멸치맛아이스크림', 1500, 11, 'Y'),
(NULL, '소세지맛커피', 2500, 8, 'Y');


-- --------------------------------------------------------------
-- update
-- 컬럼에 있는 컬럼값을 원하는 컬럼값으로 바꾸는 것
-- 주의: 반드시 해당되는 행을 where조건으로 잘 추릴 것! (rollback 안되기 때문에 실수해서 바꾸면 안됨.)
SELECT * FROM tbl_menu ORDER BY 1 DESC;
UPDATE tbl_menu
   SET category_code = 8,
       menu_price = 3000
 WHERE menu_code = 25;      

-- 서브쿼리도 활용가능
-- '멸치맛아이스크림'의 가격을 2000원으로 수정
UPDATE tbl_menu
   SET menu_price = 2000
 WHERE menu_code = (SELECT menu_code
                      FROM tbl_menu
                     WHERE menu_name = '멸치맛아이스크림'
                   );

-- ------------------------------------------------------------                   
-- delete
-- soft delete(update), hard delete(delete)
-- 주의: 지울 데이터를 where절로 조건처리 잘 할 것.
DELETE
  FROM tbl_menu
 WHERE menu_code = 21;

-- where 1 = 1(항상 true) , where 1 = 0(항상 false)
 
DELETE
  FROM tbl_menu
 ORDER BY menu_price ASC
 LIMIT 2;

-- 낮은 가격 두 줄 삭제

SELECT * FROM tbl_menu ORDER BY menu_price ASC;

-- -----------------------------------------------------------
-- replace (치환)
-- 덮어씌우기, pk(primary key) 컬럼에 해당하는 값으로 기존과 새로움을 구분.
-- 1) 기존에 있는 메뉴는 수정
REPLACE
   INTO tbl_menu
VALUES
(
  17
, '참기름소주'
, 5000
, 10
, 'Y'
);

-- 중복되지 않고 비어있어도 안됨. 수정도 안됨. => primary key
-- pk 이유? 행의 identity를 제공 -> 구분 가능한 한 행의 데이터만 존재해야 하기 때문에 pk가 존재한다.

-- 100이 있으면 치환, 없으면 추가
-- 2) 기존에 없는 메뉴는 추가
REPLACE
   INTO tbl_menu
VALUES
(
  100
, '참기름소주'
, 5000
, 10
, 'Y'
);


