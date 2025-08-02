-- index
-- 데이터를 찾는 용도.
-- 사전(클러스터링, clustering, 고유 인덱스) 또는 용어 검색(넌클러스터링, non-clustering, 비고유 인덱스)

DROP TABLE if EXISTS phone;
CREATE TABLE if NOT EXISTS phone (
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price INTEGER
);

INSERT
  INTO phone
VALUES
(1, 'galaxyS24', 1200000),
(2, 'iphone17pro', 1430000),
(3, 'galaxfold8', 1730000);

SELECT * FROM phone;
SHOW INDEX FROM phone;
-- -------------------------------------------------------------------------------
-- primary key가 들어가면 자동정렬 (클러스터링, 고유 인덱스가 달려있다)
-- pk정렬대로 데이터가 저장된다.
-- 정렬이 되어있다면 binary search(이분 탐색)가능
-- 탐색 시간 감축
-- Cardinality(카디널리티): phone_code에 들어있는 값들이 중복되지 않는 갯수(종류)
-- binary search를 활용하니까 (N/(2^k) -> k = log_2 (N))
-- N개의 데이터를 찾는데 필요한 횟수는 log_2 (N) 회
-- index_type: B+TREE자료구조
-- ?? primary key를 설정하면 자동정렬되도록 고유인덱스를 가진다.
-- ?? 그럼 데이터가 저장될 때 저장되는 자료구조가 B+TREE의 구조로 저장된다는 의미?
-- ?? BTREE 구조는 binary search로 자료를 탐색? 
-- -------------------------------------------------------------------------------

-- 인덱스를 태워서(인덱스를 활용해서) 검색하면 속도가 빠르다.
-- 왜?

SELECT * FROM phone WHERE phone_code = 1;
-- 칸: 노드, 선: 엣지

-- phone_name = 'iphone17pro' 인 행을 탐색하여 select한다.
SELECT * FROM phone WHERE phone_name = 'iphone17pro';

-- EXPLAIN으로 쿼리 실행계획 확인
-- possible_keys = null: 모든 행을 다 탐색(풀 스캔)한다.
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iphone17pro';

-- 일반 컬럼에 비고유 인덱스 추가(= 해당 컬럼의 값으로 별도의 공간을 마련해 정렬해둠.(phone_name을 알파벳순으로 정렬하겠다.))
CREATE INDEX idx_name ON phone(phone_name);
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iphone17pro';

-- using index condition = 인덱스를 태운다.

-- where 조건에 따른 index 활용 확인
EXPLAIN SELECT * FROM phone WHERE phone_code = 1;
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iphone17pro';
EXPLAIN SELECT * FROM phone WHERE phone_price = '1730000';

-- rows = 3: 행을 3개를 탐색해서 찾았다. (풀스캔)
-- ----------------------------------------------------------
-- B tree와 B+ tree가 무엇인지 면접 전까지는 확실히 숙지하자.
-- ----------------------------------------------------------

-- 복수의 컬럼에 인덱스를 만들 수도 있다.
-- 카디널리티가 높은 컬럼을 사용해서 인덱스를 갖도록한다.
-- 중복되는 컬럼에 대해 인덱스를 만들면 탐색된 값에 대해서 한 번 더 탐색을 해야하는 일이 발생.

-- ----------------------------------------------------------
-- B+TREE의 맨 위 노드는 조건이 들어있다.
-- ----------------------------------------------------------

-- 인덱스는 필요한 곳에 달아야 한다.
-- 1) 조건으로 자주 활용할 컬럼(where절, having절, join 사용할 때 쓰는 컬럼들)에 인덱스를 만든다.
-- 2) '='을 사용하는 조건에 쓰는 컬럼일수록 효율적이다.
-- 3) 데이터가 자주 수정되지 않는 컬럼일수록 효율적이다.
-- 4) 전체 데이터의 10%~15%정도 일수록 가장 효율적이다. (수치를 넘어가는 순간 메모리의 사용량이 효율성을 침범한다.)
-- 5) 복합속성일 경우(컬럼 두 개 이상)는 카디널리티가 높은 (중복이 적은) 컬럼을 먼저 사용한다.

-- 인덱스 단점
-- 1) 별도의 저장공간 필요
-- 2) 주기적으로 인덱스를 다시 업데이트 해야 한다.

-- 인덱스 최적화(업데이트)
OPTIMIZE TABLE phone;

-- 인덱스 삭제
DROP INDEX idx_name ON phone;

SHOW INDEX FROM phone;
-- index_type은 B+TREE임(주의).