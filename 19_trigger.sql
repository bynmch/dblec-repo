-- trigger
-- 특정 테이블 또는 데이터에 변화가 생기면 실행할 내용을 저장하는 db의 오브젝트
-- 한 테이블에 CUD가 발생하면  다른 테이블에 변화가 발생하도록 만드는 옵젝

delimiter //
CREATE OR REPLACE TRIGGER after_order_menu_INSERT
    AFTER INSERT
    ON tbl_order_menu
    FOR EACH ROW -- (각각의 row마다 insert가 발생할 때 마다)
BEGIN
    UPDATE tbl_order
	    SET total_order_price = total_order_price + NEW.order_amount *
-- new.menu_code tbl_order_menu에 insert한 새로운 menu_code값	    
	(SELECT menu_price FROM tbl_menu WHERE menu_code = NEW.menu_code) 
	  WHERE order_code = NEW.order_code;
END //
delimiter ;

-- 주문 테이블(tbl_order)에 insert 후 주문 메뉴 테이블 (tbl_order_menu)에
-- 주문한 메뉴마다 insert 후 주문 테이블의 총 금액(total_order_price)을 업데이트
-- 되는지 확인하자.

-- 1) 부모 테이블인 tbl_order부터 insert
INSERT
  INTO tbl_order
(
  order_code, order_date
, order_time, total_order_price
)
VALUES
(
  NULL
, CONCAT(CAST(YEAR(NOW()) AS VARCHAR(4))
       , CAST(LPAD(MONTH(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(lpad(DAYOFMONTH(NOW()), 2, 0) AS VARCHAR(2)))
, CONCAT(CAST(LPAD(HOUR(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(MINUTE(NOW()), 2, 0) AS VARCHAR(2))
		 , CAST(LPAD(SECOND(NOW()), 2, 0) AS VARCHAR(2)))       
, 0
);

DESC tbl_order;

SELECT * FROM tbl_order;

-- 2) 자식 테이블인 tbl_order_menu에 메뉴 추가
-- 갈릭미역파르페 3개 추가
INSERT
  INTO tbl_order_menu
(order_code, menu_code, order_amount)
VALUES
(1, 4, 3);

SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_order;

--우럭스무디 2개 추가
INSERT
  INTO tbl_order_menu
(order_code, menu_code, order_amount)
VALUES
(1, 2, 2);

SELECT * FROM tbl_order;

-- insert만 해도 자동으로 문제없이 유도속성이 update된다. (= 업무 무결성 만족.)
-- 입출고용 트리거 생성

DROP TABLE if EXISTS pro_detail;
DROP TABLE if EXISTS product;
-- 1) 이력 테이블(update) 
CREATE TABLE if NOT EXISTS product
(
    pcode INT PRIMARY KEY AUTO_INCREMENT,
    pname VARCHAR(30),
    brand VARCHAR(30),
    price INT,
    stock INT DEFAULT 0,
    CHECK(stock >= 0)
);
-- 2) 내역 테이블(insert)
CREATE TABLE if NOT EXISTS pro_detail 
(
   dcode INT PRIMARY KEY AUTO_INCREMENT,
   pcode INT,
   pdate DATE,
   amount INT,
   STATUS VARCHAR(10) CHECK(STATUS IN ('입고', '출고')),
   FOREIGN KEY(pcode) REFERENCES product
);

delimiter //
CREATE OR REPLACE TRIGGER trg_productafter
    AFTER INSERT
    ON pro_detail -- 내역 테이블
    FOR EACH ROW
BEGIN
    if NEW.status = '입고' then
        UPDATE product -- 이력 테이블
           SET stock = stock + NEW.amount
         WHERE pcode = NEW.pcode;
    ELSEIF NEW.status = '출고' then
        UPDATE product
           SET stock = stock - NEW.amount
         WHERE pcode = NEW.pcode;
    END if;
END //
delimiter ;


SELECT * FROM product;
SELECT * FROM pro_detail;

-- 1) 상품 등록(초기 수량 부여)
INSERT
  INTO product
(
  pcode, pname, brand
, price, stock
)
VALUES
(
  NULL, '갤럭시플림', '삼송'
, 900000, 5
),
(
  NULL, '아이펀17', '사과'
, 1100000, 3
),
(
  NULL, '투명폰', '삼송'
, 2100000, 4
);

SELECT * FROM product;

-- 2) 입고 및 출고 진행
INSERT
  INTO pro_detail
(
  dcode, pcode, pdate
, amount, status
)
VALUES
(
 NULL, 3, CURDATE()
, 3, '출고'
);

SELECT * FROM product;
SELECT * FROM pro_detail;


-- insert 시 동작할 trigger -> new.컬럼명
-- update 시 동작할 trigger -> new.컬러명, old.컬럼명
-- delete 시 동작할 trigger -> old.컬럼명

