-- transaction
-- 논리적 일의 단위
-- 예) 주문 -> 배송, 결제, 재고

-- autocommit 상태 확인 (1: on, 0: off)
SELECT @@autocommit;

START TRANSACTION; 	
-- autocommit기능 자동으로 꺼짐.						
-- insert, update, delete 각각 마다 commit하지 않음

INSERT
  INTO tbl_menu
VALUES
(
  NULL, '바나나해장국', 8500
, 4, 'Y'
);

-- insert 이후 sp1으로 저장
SAVEPOINT sp1;

UPDATE tbl_menu
   SET menu_name = '수정된 메뉴'
 WHERE menu_code = 5;
 
DELETE from tbl_menu WHERE menu_code = 10;

-- ROLLBACK;
-- COMMIT;
-- rollback이나 commit을 만나기 전 작업은 가상의 작업
-- rollback이나 commit을 만나면 작업은 되돌리기 혹은 적용.
-- rollback: 아직 적용되지 않은 원본 데이터 상태로 돌아감(취소, 뒤로가기)
-- commit: 원본 데이터에 반영한다.(더이상 rollback이 되지 않음)

-- sp1으로 rollback한다.
ROLLBACK to sp1;

SELECT * FROM tbl_menu;

-- start transaction 부터 rollback/commit까지의 묶음이 끝나고 나면 다시 autocommit 상태가 된다.
-- autocommit을 끄는게 무조건 좋다. 되돌리기 가능하도록.
DELETE
  FROM tbl_menu
 WHERE mennu_code = 11;
-- commit;
ROLLBACK;
SELECT * FROM tbl_menu;

-- autocommit을 꺼주려면
-- SET autocommit = 0;
set autocommit = false;
DELETE
  FROM tbl_menu
 WHERE menu_code = 13;
ROLLBACK;
SELECT * FROM tbl_menu;

-- 번호가 중간이 비어있다면?
-- 번호발생기인 auto_increment를 다시 원하는 숫자로 초기화

-- 다음 번호 발생을 23번으로 하고싶다
ALTER TABLE tbl_meny AUTO_INCREMENT = 23;

