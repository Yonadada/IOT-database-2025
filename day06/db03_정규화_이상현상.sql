-- 7-1 : 계절학기 테이블
DROP TABLE IF EXISTS Summer;	-- 기존 테이블이 존재하면 삭제

CREATE TABLE Summer(
	sid INTEGER, 
    class VARCHAR(20),
    price INTEGER
);

--
SELECT * FROM Summer;

-- 기본 데이터 추가(MYSQL 다중 데이터 한꺼번에 INSERT)
INSERT INTO Summer VALUES (100,'JAVA',20000),(150,'PYTHON',15000),(200,'C',10000),(250,'JAVA',20000);








