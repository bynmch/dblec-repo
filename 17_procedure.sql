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

-- ------------------------------------------------------------
-- if-else 활용
delimiter //

CREATE OR REPLACE PROCEDURE checkEmployeeSalary (
     IN id VARCHAR(3),
     IN threshold INTEGER,
     OUT result VARCHAR(50)
)
BEGIN
    DECLARE sal INTEGER;
    
    SELECT salary INTO sal
      FROM employee
     WHERE emp_id = id;
     
    if sal > threshold then
	     SET result = '기준치를 넘는 급여입니다.';
	 else
	     SET result = '기준치와 같거나 기준치 미만의 급여입니다.';
	 END if; 
END //

delimiter ;

SET @result = '';
CALL checkEmployeeSalary('200', 3000000, @result);
SELECT @result;

-- -----------------------------------------------------------------------------
-- case
delimiter //
CREATE OR REPLACE PROCEDURE getDepartmentMessage(
     IN id VARCHAR(3),
     OUT message VARCHAR(100)
)
BEGIN
    DECLARE dept VARCHAR(50);
    
    SELECT dept_code INTO dept
      FROM employee
     WHERE emp_id = id;
     
    case
        when dept = 'D1' then
            SET message = '인사관리부 직원이시군요!';
        when dept = 'D2' then
            SET message = '회계관리부 직원이시군요!';
		  when dept = 'D3' then
            SET message = '마케팅부 직원이시군요!';	    
        else
            SET message = '어떤 부서 직원이신지 모르겠어요!';
    END case;        
END //
delimiter ;
SET @message = '';
CALL getDepartmentMessage('217', @message);
SELECT @message;


-- --------------------------------------------------------
-- 면접 시 index 관련 질문 많이 나오니 확실히 숙지할 것.
-- -----------------------------------------------------
-- while 활용
delimiter //

CREATE OR REPLACE PROCEDURE calculateSumUpTo (
     IN max_num INT, -- 10
     OUT sum_result INT
)
BEGIN
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;
   															-- /  							0회차   /...
    while current_num <= max_num DO 			-- 10/  1 <= 10만족하니 아래 실행 		/...
        SET total_sum = total_sum + current_num;-- 0 + 1을 total_num에 담는다 		/...  
        SET current_num = current_num + 1; 		-- currrent_num에 1 + 1을 담는다.	/...
    END while;
	 
	 SET sum_result = total_sum;    
END //

delimiter ;

SET @result=0;
CALL calculateSumUpTo(10, @result);
SELECT @result;

-- ---------------------------------------------------------
-- 예외처리
-- 정의한 대로 예외상황을 처리할 수 있다.
-- ex. 0으로 나누기,...
delimiter //
CREATE OR REPLACE PROCEDURE divideNumber (
     IN numerator DOUBLE,
     IN denominator DOUBLE,
     OUT result DOUBLE
)
BEGIN
-- 사용자 정의형 예외
    DECLARE division_by_zero CONDITION FOR SQLSTATE '45000';
    DECLARE exit handler FOR division_by_zero
    BEGIN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '0으로 나눌 수 없습니다.';
    END;
-- -----------------
	 if denominator = 0 then
	     SIGNAL division_by_zero;
	 ELSE
	     SET result = numerator / denominator;
	 END if;	  	      
END //
delimiter ;

SET @result = 0;
CALL divideNumber(10, 2, @result);
SELECT @result;
CALL divideNumber(10, 0, @result);
SELECT @result;

-- ---------------------------------------------------------------------------------
-- stored function
delimiter //
CREATE OR REPLACE FUNCTION getAnnualSalary (
    id VARCHAR(3)
)
RETURNS INTEGER -- 한 가지타입만 반환.
DETERMINISTIC
BEGIN
    DECLARE monthly_salary INTEGER;
    DECLARE annual_salary INTEGER;
    
    SELECT salary INTO monthly_salary
      FROM employee
     WHERE emp_id = id;
     
   SET annual_salary = monthly_salary * 12;
   
   RETURN annual_salary;
END //   
delimiter ;

SELECT
       emp_name
     , getAnnualSalary(emp_id) AS '연봉' 
  FROM employee;

-- -------------------------------------------------------------------------------------------
-- 



