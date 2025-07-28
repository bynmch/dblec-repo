-- view
-- 가상 테이블
-- Result Set 을 활용한 가상의 테이블
CREATE VIEW v_menu
AS
SELECT
       menu_name AS '메뉴명'
     , menu_price AS '메뉴단가'
  FROM tbl_menu;
  
SELECT * FROM v_menu;

-- view는 OR REPLACE 라는 옵션 덕에 매번 DROP할 필요가 없다.  (DROP VIEW hansik; 필요없음)
CREATE OR REPLACE VIEW hansik
AS
SELECT
       menu_code AS '메뉴번호'
     , menu_name AS '메뉴명'
     , menu_price AS '메뉴가격'
     , category_code AS '카테고리코드'
     , orderable_status AS '주문가능상태'
  FROM tbl_menu -- 원본 테이블 , base table
 WHERE category_code = 4;
 
SELECT * FROM hansik;

-- VIEW를 통해 특정 조건을 만족하면 베이스 테이블에 영향(DML작업)을 줄 수 있기때문에 지양해야 한다. 
-- (하면 안됨. 알고만 있자.)
-- INSERT
INSERT
  INTO hansik
VALUES
(NULL, '커피맛솜사탕', 2000, 4, 'Y');

-- UPDATE
UPDATE hansik
   SET 메뉴명 = '딸기맛솜사탕'
     , 메뉴가격 = 4000
 WHERE 메뉴번호 = 23;

-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW v_test
AS
SELECT
        AVG(menu_price) + 3
   FROM tbl_menu;
   
SELECT * FROM v_test;

-- view를 사용하는 목적
-- 1) DBA가 일반 백엔드 개발자 각각에게 필요한 만큼의 정보를 제공하기 위해(접근제어)
-- 2) 실제 비즈니스에서 사용되는 용어로 별칭을 달아 가독성 및 오해 방지를 위해
-- 3) 복잡한 DB관계를 고민하지 않고 사용할 수 있게 하기 위해서

-- join한 걸로 view를 만들어서 수정이 안됨.
-- group by한 걸로 view를 만들어서 수정이 안됨.
-- 데이터가 들어있는 것이 아닌 쿼리만 저장.