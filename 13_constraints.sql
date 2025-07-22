-- constraints(제약조건)
-- 무결성 데이터를 위해
-- 정책 혹은 규약
-- 1. not null 제약조건
-- 반드시 데이터가 존재해야 한다.
-- 컬럼 레벨에서만 제약조건 부여 가능하다.
-- 3tier 어쩌구... 꼭 필요.
DROP TABLE if EXISTS user_notnull;
CREATE TABLE if not EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-9999-9999', 'yu123@gmail.com');

SELECT * FROM user_notnull;

-- 2. unique 제약조건
-- 중복된 데이터가 해당 컬럼에 들어가지 않아야 함
-- 컬럼레벨 + 테이블레벨

DROP TABLE if EXISTS user_unique;
CREATE TABLE if not EXISTS user_unique (
    user_no INT NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(phone)
--    UNIQUE(phone, email) 
-- phone과 email이 모두 중복일 때 하나의 제약조건으로 컬럼을 복수개 unique 제약조건을 걸 때 테이블레벨만 가능
);

INSERT 
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-9999-9999', 'yu123@gmail.com');

SELECT * FROM user_unique;
DESC user_unique;
-- 붉은 키 = unique

-- -----------------------------------------------------------------------------
-- 3. primary key 제약조건
-- 모든 테이블마다 하나씩 반드시 존재해야 한다.(문법적 규약x error없다.  but, 논리적인 규약)
-- not null + unique
-- 컬럼레벨 + 테이블레벨
DROP TABLE if EXISTS user_primarykey;
CREATE TABLE if not EXISTS user_primarykey (
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(phone),
    PRIMARY KEY(user_no)
--    PRIMARY KEY(user_no, user_id) -- 복합 키, 두 컬럼이 같을 때만 
);

INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-9999-9999', 'yu123@gmail.com');

INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(2, 'user01', 'pass01', '홍길동', '남', '010-1234-0678', 'hong123@gmail.com');

-- phone, user_id: 후보키. auto_increment로 생성x, 일일이 추가 어려움.

-- ----------------------------------------------------------------------------------------
-- 4. foreign key 제약조건
-- 반드시 다른 테이블에 있는 데이터를 참조한다.
-- 두 개 이상의 테이블 필요하다.
-- 한 쪽 테이블(primary key)에서 다른 쪽 테이블(일반컬럼)로 넘어간 컬럼에 작성한다.
DROP TABLE if EXISTS user_grade;
CREATE TABLE if NOT EXISTS user_grade (
    grade_code INT NOT NULL UNIQUE,
    grade_name VARCHAR(255) NOT null
);

DROP TABLE if EXISTS user_foreignkey;
CREATE TABLE if not EXISTS user_foreignkey (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
    FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
);