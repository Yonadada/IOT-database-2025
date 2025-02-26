
-- 3-14 : 고객이 주문한 도서의 총판매액을 구하시오.
-- MySQL에서 문자열은 ''홑따옴표를 사용한다. "" 사용 불가 !!!! 
SELECT saleprice 
  FROM Orders;

SELECT SUM(saleprice) AS 총매출
  FROM Orders;
  
  
-- 3-15 : 2번 김연아 고객이 주문한 도서의 총판매액을 구하시오
SELECT SUM(saleprice) AS 합계
  FROM Orders
WHERE custid = 2;


-- 3-18 : 마당서점의 도서 판매 건수를 구하시오
SELECT COUNT(*) AS 총판매건수
  FROM Orders;
  
  
  
  
 
  
-- 3-17 : 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT SUM(saleprice) TOTAL,  -- 합계
	   AVG(saleprice) AVERAGE, -- 평균
       MIN(saleprice) MINPRICE, -- 최소
       MAX(saleprice) MAXPRICE, -- 최대
       STD(saleprice) STANDERV -- 표준편차
  FROM Orders;
  
  
  
  
  
-- 3-19 : 고객별로 주문한 도서의 총수량과 총판매액을 구하시오.
-- GROUP BY 키워드 사용
-- GROUP BY를 사용하면 반드시 집계함수 및 GROUP BY에 포함된 컬럼이 SELECT 안에 들어가 있어야한다.
-- GROUP BY에 있는 컬럼만 SELECT 안에 사용 할 수 있고, 그 외는 사용불가
SELECT custid
	 , count(*) 구매도서수량 -- 함수 매개변수로 *, custid
     , SUM(saleprice) 고객별총액 
  FROM Orders
group by custid;


-- 추가 : 3-19의 내용에서 고객별총액을 내림차순으로 출력하시오.
SELECT custid
	 , count(*) AS 구매도서수량 
     , SUM(saleprice) AS 고객별총액 
  FROM Orders
GROUP BY custid
ORDER BY 고객별총액 DESC; --  ORDER BY 3 DESC;




-- ===============
-- 3-20 : 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문도서의 총수량을 구하시오.
-- 단, 2권이상 구매한 고객에 대해서만 한정합니다.
-- COUNT() 등 집계함수는 WHERE 절에 넣을 수 없다.
SELECT custid
	 , COUNT(*) AS 총수량
  FROM Orders
 WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2; -- HAVING 2 >= 2; || HAVING 총수량 >= 2;
-- ORDER BY가 제일 마지막에 위치한다


-- 추가 : 고객별 구매수량과 구매총액을 출력하고, 전체를 합산하여 통계를 표시하세요.
SELECT custid
	 , count(*) 구매도서수량 -- 함수 매개변수로 *, custid
     , SUM(saleprice) 고객별총액 
  FROM Orders
group by custid
 WITH ROLLUP;
-- ===============

-- 조인(JOIN) : 두개 이상의 테이블을 합쳐서 출력
-- 3-21 : 고객과 고객의 주문에 관한 데이터를 모두 나타내시오. => 표준형
SELECT *
  FROM Customer C
  INNER JOIN Orders O
	 ON C.custid = O.custid;
     
-- 추가 (생략형 쿼리문)
SELECT *
  FROM Customer C, Orders O
 WHERE C.custid = O.custid;
 




-- 중복되거나 필요없는 컬럼은 제거하고 출력
SELECT c.custid
	  , c.name
	  , c.address
	  , o.orderid
	  , o.saleprice
      , o.orderdate
  FROM Customer as c, Orders as o
 WHERE c.custid = o.custid;
	
    
    
-- 필요하면 테이블 조인하면 된다
SELECT c.custid
	  , c.name
	  , c.address
	  , o.orderid
	  , o.saleprice
      , o.orderdate
      , b.bookname
      , b.publisher
      , b.price
  FROM Customer as c, Orders as o, Book b
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;


-- 3-22 : 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 나타내시오.
-- 고객명으로 정렬
SELECT c.*
	  ,o.*
  FROM Customer as c, Orders as o
 WHERE c.custid = o.custid
ORDER BY c.name ASC;
-- ===============


-- 3-23 : 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT C.name 이름
	  ,O.saleprice 판매가격 
  FROM Customer C, Orders O
 WHERE C.custid = O.custid
 ORDER BY C.NAME;



-- 3-24 : 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬하시오.
SELECT name, SUM(saleprice) 총판매액
FROM Customer C, Orders O
WHERE C.custid = O.custid
group by C.name
ORDER BY C.name;



-- 3-25 : 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT C.name, b.bookname  
FROM Customer C, Orders O, Book b
WHERE C.custid = O.custid
  AND O.bookid = b.bookid;



-- 3-26 : 가격이 20000인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT c.name 이름, b.bookname 책이름
FROM Customer c, Orders o, Book b
where c.custid = o.custid
  AND b.bookid = o.bookid 
  AND b.price = 20000;
  
-- =====================
-- 외부조인 : 조건을 만족하지 않는(일치하지 않는)데이터도 출력이 필요할 때 사용하는 조인
-- 3-27 : 도서를 구매하지 않은 고객을 포함해 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
-- LEFT OUTER JOIN 또는 RIGHT OUTER JOIN -> LEFT, RIGHT 는 기준이 되는 테이블 위치
SELECT *
  FROM Customer C
  LEFT JOIN Orders O -- LEFT OUTER JOIN Orders AS O
  ON C.custid = O.custid;
    
    

-- RIGHT OUTER JOIN으로 하면?
SELECT *
  FROM Customer C
  RIGHT JOIN Orders O -- LEFT OUTER JOIN Orders AS O
  ON C.custid = O.custid;
    
 
 -- 서브쿼리(부속질의)
 SELECT MAX(price)
 FROM Book;
 
 
 -- 3-28 : 가장 비싼 도서의 이름을 나타내시오
 SELECT *
 FROM Book
 where price = (
  SELECT MAX(price)
  FROM Book
 );
 
 
 -- 3-29 : 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT c.name
FROM Customer c
WHERE c.custid in (
	SELECT DISTINCT custid FROM Orders
    );




-- 3-30 대한미디어에서 출판한 도서를 구매한 고객의 이름을 나타내시오. 
select c.name 
  from Customer c
 where c.custid in(
					select o.custid 
					from Orders o
					where o.bookid in(
									select b.bookid 
									from Book b
									where b.publisher = '대한미디어'
									)
					);


-- 3-30은 조인으로 변경가능(SubQuery <--> Join)
select c.name
  from Customer c, Book b, Orders o
 where c.custid = o.custid
   and   b.bookid = o.bookid
   and b.publisher = '대한미디어';



-- 3-31 : 출반사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
-- 상관 서브쿼리
select *
  from Book as b1
 where b1.price > (
			select avg(b2.price)
            from Book as b2
            where b2.publisher = b1.publisher);

select avg(b2.price)
		, b2.publisher
from Book as b2
where b2.publisher = '대한미디어'
group by b2.publisher;
 
 
 
 -- 집합연산 ( union )
 select name
   from Customer
  union 
 select bookname
 from Book;
 
  -- 데이터 타입에 제약이 없음
 select name
   from Customer
  union 
 select price
 from Book;
 
 
 
 -- EXISTS : 상관서브쿼리에서 사용하는 키워드
 -- 주문이 있는 고객의 이름과 주소를 나타내시오.
 select *
   from Customer as c
  where exists (
			select  *  -- o.custid로 사용하지 않아도 된다
			from Orders as o
		    where o.custid = c.custid  -- 메인쿼리의 컬럼이 서브쿼리에 사용되고 있음
			);