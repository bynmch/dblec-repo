-- procedure (시험ㄴㄴ)
-- 쿼리를 나열한 절차를 저장해서 사용.
-- 기능을 정의한다.
-- 재활용

-- 문장의 끝(한 procedure의 끝)을 //로 하겠다.
delimiter //
CREATE OR REPLACE PROCEDURE getAllEmployees()
BEGIN
   SELECT emp_id, emp_name, salary
     FROM employee;
END //

-- 다시 문장의 끝을 ;로 돌려 놓겠다.
delimiter ;

CALL getAllEmployees();


-- ----------------------------------------------------
-- IN 매개변수
delimiter //

CREATE OR REPLACE PROCEDURE getEmployeesByDepartment(
    IN dept CHAR(2)
)
BEGIN
    SELECT emp_id, emp_name, salary, dept_code
      FROM employee
     WHERE dept_code = dept;
END //     
     
delimiter ;

-- 편리함 + 재사용성 측면
CALL getEmployeesByDepartment('D8');
CALL getEmployeesByDepartment('D6');

-- -------------------------------------------------------
-- out 매개변수
delimiter //

CREATE OR REPLACE PROCEDURE getEmployeeSalary(
    IN id VARCHAR(3),
    OUT sal2 integer
)
BEGIN
    SELECT salary INTO sal2
      FROM employee
     WHERE emp_id = id;
END //

delimiter ;

SET @sal1 = 0;
CALL getEmployeeSalary('210', @sal1);
SELECT @sal1;

-- ------------------------------------------------------
-- INOUT 매개변수
delimiter //

CREATE OR REPLACE PROCEDURE updateAndReturnSalary(
     IN id VARCHAR(3),
     INOUT sal INTEGER
)
BEGIN
    UPDATE employee
       SET salary = sal
     WHERE emp_id = id;
     
    SELECT salary + (salary * IFNULL(bonus, 0)) INTO sal
      FROM employee
     WHERE emp_id = id;
END //

delimiter ;

SET @new_sal = 9000000;
CALL updateAndReturnSalary('200', @new_sal);
SELECT @new_sal;

-- @변수의 의미
-- '사용자 정의형 변수', '이름이 잇는 저장 공간'
-- 전역변수의 의미를 가진다.








