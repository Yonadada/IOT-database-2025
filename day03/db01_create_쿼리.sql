-- 데이터베이스 생성
CREATE DATABASE	sample;

-- 데이터베이스 생성(CharSet, Collation 지정)
 CREATE DATABASE sample2
 CHARACTER set utf8mb4
 collate utf8mb4_unicode_ci;
 
 -- 데이터베이스 변경 
 ALTER DATABASE sample
  CHARACTER set utf8mb4
 collate utf8mb4_unicode_ci;
 
 -- 데이터베이스 삭제
 -- 운영DB에서 실행하면 절대 안된다
 DROP DATABASE sample;
 
 
-- 테이블 생성
-- 3-34 NewBook 테이블을 생성하세요. 정수형은 Integer 사용, 문자형은 가변형인 Varchar 사용
-- 기본키를 설정합니다(3가지 방법이 있음)
-- 기본키가 두개 이상일 경우 아래와 같이 작성해야 한다
-- #1.방법
CREATE TABLE NewBook (
	booId 	  INTEGER,
    bookName  VARCHAR(255),
    publisher VARCHAR(50),
    price 	  INTEGER,
    PRIMARY KEY (bookId, publisher)
);

-- 기본키가 하나면 컬럼 하나에 작성 가능
-- 기본키가 두개 이상일 경우 컬럼에 primary key 두군데 이상 작성 불가
-- #2.방법
CREATE TABLE NewBook (
	booId 	  INTEGER PRIMARY KEY,
    bookName  VARCHAR(255),
    publisher VARCHAR(50), -- publisher varchar (50) primary key -> (불가)
    price 	  INTEGER
);
 
-- 테이블 생성 시, 제약조건 추가 가능
-- bookName은 Null값을 가질 수 없고, publisher 은 같은 값이 있으면 안된다.
-- price는 값이 입력되지 않은 경우, 기본값 10000을 저장
-- 최소가격은 1000원 이상으로 설정
CREATE TABLE NewBook (
	bookId    INTEGER,
    bookName  VARCHAR(255) NOT NULL, -- NULL값 허용X
    publisher VARCHAR(50) UNIQUE, -- unique 중복허용X
    price 	  INTEGER DEFAULT 10000 CHECK (price >= 1000),
    PRIMARY KEY (bookId)
);


-- 3-35 : 아래 속성의 NewCustomer 테이블을 생성하시오.
-- custid -> Integer, 기본키
-- name -> Varchar(100), not null
-- address -> Varchar(255), not null
-- phone -> Varchar(30), not null
CREATE TABLE NewCustomer (
	custid  integer primary key,
    name   	varchar(100) not null,
    address varchar(255) not null,
    phone 	varchar(30) not null
);


-- 3-36 : 다음과 같은 속성의 NewOrders 를 생성하시오.
-- orderId -> integer, primary key
-- bookId -> integer, not null, foreign key(NewBook bookId)
-- custId -> integer, not null, FK(NewCustomer custId)
-- salePrice -> integer
-- orderDate -> date
CREATE TABLE NewOrders (
	orderid	  integer,
    bookid 	  integer not null,
    custid	  integer not null, -- FK 때문에 기본키의 데이터타입과 동일해야함
    saleprice integer,
    orderdate date,
    primary key (orderid),
    foreign key (bookid) references NewBook(bookid) on delete cascade,
    foreign key (custid) references NewCustomer(custid) on delete cascade
);

--  ON DELETE CASCADE란?
-- ON DELETE CASCADE는 부모 테이블에서 데이터가 삭제될 경우, 
-- 해당 데이터를 참조하는 자식 테이블의 데이터도 함께 삭제되는 옵션입니다.
-- 즉, NewBook 테이블에서 어떤 bookid가 삭제되면, NewOrders에서 해당 bookid를 가지고 있는 
-- 주문도 자동으로 삭제됩니다.
-- 마찬가지로, NewCustomer 테이블에서 특정 custid가 삭제되면, 
-- 해당 고객이 주문한 내역(NewOrders)도 함께 삭제됩니다.


-- ===============================================
-- ALTER 
-- 3-37 : NewBook 테이블에 varchar(13)의 isbn 속성을 추가하시오.
ALTER TABLE NewBook ADD isbn VARCHAR(13);


-- 3-38 : NewBook에 isbn 데이터타입을 integer 로 변경하시오
ALTER TABLE NewBook MODIFY isbn INTEGER; 


-- 3-38 : NewBook에 publiser의 제약사항을 not null 로 변경
ALTER TABLE NewBook MODIFY publisher VARCHAR(100) NOT NULL;



-- ==================================
-- DROP (조심해야함)
-- 3-42 : NewBook 테이블을 삭제하시오
-- 부모테이블은 자식테이블을 지우기 전까지는 부모테이블을 삭제할 수 없음
DROP TABLE NewBook; -- 에러발생 => NewOrders가 NewBook 을 FK 참조하고 있기 때문

DROP TABLE NewOrders; -- 먼저 지우고 => NewBook 삭제하면 테이블 삭제완료~!

 
 
 
 
 
 
 