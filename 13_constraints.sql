-- constraints(제약조건)
-- 무결성 데이터를 위해
-- 정책 혹은 규약
-- 1. not null 제약조건
-- 반드시 데이터가 존재해야 한다.
-- 컬럼 레벨에서만 제약조건 부여 가능하다.
-- 3 tier 어쩌구... 꼭 필요.
-- 제약조건

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
-- 모든 테이블마다 하나씩 반드시 존재해야 한다.(문법적 규약이 아니다.  but, 논리적인 규약)
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

SELECT * FROM user_primarykey;

INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(2, 'user01', 'pass01', '홍길동', '남', '010-1234-0678', 'hong123@gmail.com');
-- auto_increment를 제약 조건으로 걸지 않으면, 일일이 pk값을 넣어줘야 한다. 
-- 매우 귀찮기 때문에 설정해 놓는 것이 편하다.
-- phone, user_id: 후보키. auto_increment로 생성이 안된다. 
-- auto_increment 설정안되니 일일이 pk값을 넣어주면 너무 힘드렁ㅠㅠ..

-- ----------------------------------------------------------------------------------------
-- 4. foreign key 제약조건
-- 반드시 다른 테이블에 있는 데이터를 참조한다.
-- 두 개 이상의 테이블 필요하다.
-- 한 쪽 테이블(primary key)에서 다른 쪽 테이블(일반컬럼)로 넘어간 컬럼에 작성한다.
-- foreign key 제약조건은 부모 테이블의 pk값을 참조 + null값이 들어갈 수 있다.
-- 부모테이블의 pk를 참조한 자식테이블 먼저 지우고 부모테이블을 지울 수 있다.
DROP TABLE if EXISTS user_grade;
DROP TABLE if EXISTS user_foreignkey;

CREATE TABLE if NOT EXISTS user_grade (
--    grade_code INT NOT NULL UNIQUE,
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT null
);

CREATE TABLE if not EXISTS user_foreignkey (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT, 
-- 윗쿼리에 있는 grade_code
--    FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
-- primary key 인것이 분명하기 때문에
-- 참조할 테이블의 컬럼명은 생략가능하다.
    FOREIGN KEY(grade_code) REFERENCES user_grade
);

INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;

INSERT 
  INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-9999-9999', 'yu123@gmail.com', NULL);

INSERT 
  INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 22);

SELECT * FROM user_foreignkey;

-- ---------------------------------------------------------------------------------
-- 삭제룰을 적용해서 부모 테이블의 데이터를 강제삭제 할 수 있다.
-- (추가로 이해하며 권장하지 않는다.)
DROP TABLE if EXISTS user_foreignkey2;
DROP TABLE if EXISTS user_grade2;

CREATE TABLE if NOT EXISTS user_grade2 (
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT null
);

CREATE TABLE if not EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT, 
    FOREIGN KEY(grade_code) REFERENCES user_grade2
    ON DELETE SET NULL -- 부모가 먼저 지워지면 null로 채운다.
);

INSERT
  INTO user_grade2
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade2;

INSERT 
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-9999-9999', 'yu123@gmail.com', NULL);

SELECT * FROM user_foreignkey2;

-- 부모 테이블의 10번 '일반회원'등급 삭제 후 확인
DELETE
  FROM user_grade2
 WHERE grade_code = 10;
 
SELECT * FROM user_foreignkey2;

-- ------------------------------------------------------------------------------
-- 5. check 제약조건
-- 조건식을 활용한 상세한 제약사항을 부여한다.
-- 제약조건이라는 말을 현업에서는 유효성이라고 표현하기도 한다.
-- check  제약조건은 컬럼레벨도 컬럼을 작성한다.
DROP TABLE if EXISTS user_check;
CREATE TABLE if NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남', '여')),
    age INT CHECK(age >= 19 AND age <= 30)
);

INSERT
  INTO user_check
VALUES
(NULL, '홍길동', '남', 25),
(NULL, '신사임당','여', 23);

-- 제약조건 위반
INSERT
  INTO user_check
VALUES
(NULL, '아무개', '중', 27);
SELECT * FROM user_check;

-- ---------------------------------------------------------------------
-- 6. default 제약조건
-- 휴먼에러 방지, 무결성 유지
DROP TABLE if EXISTS tbl_country;
CREATE TABLE if NOT EXISTS tbl_country (
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    population VARCHAR(255) DEFAULT '0명',
    add_day DATE DEFAULT (CURRENT_DATE),
    add_time DATETIME DEFAULT (CURRENT_TIME)
);

INSERT
  INTO tbl_country
VALUES
(NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM tbl_country;


-- -----------------------------------------------------------------------
SELECT 
    TABLE_NAME as '테이블명',
    ENGINE as '엔진',
    TABLE_ROWS as '행수',
    ROUND(DATA_LENGTH/1024/1024, 2) as 'MB'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_TYPE = 'BASE TABLE';







