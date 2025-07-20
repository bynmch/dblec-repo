SELECT * FROM USER;

CREATE user 'swcamp'@'%' IDENTIFIED BY 'swcamp';
-- 계정확인

SELECT * FROM USER;

CREATE DATABASE menudb;
-- 여기까지 default로 

-- menudb 데이터 베이스의 모든 menudb의 테이블에 대해 모든 권한을 swcamp에 부여
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';

-- 부여된 권한 확인
SHOW GRANTS FOR 'swcamp'@'%';