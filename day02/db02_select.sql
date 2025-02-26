-- 쿼리 3-1 : 모든 도서의 이름과 가격을 검색하시오 
SELECT bookname, price
  FROM Book;

-- 워크벤치에서 쿼리 실행할 때는 편하다 
SELECT * 
  FROM Book;
 
 
 
-- 3.2 : 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.alter
-- C, Python, C#등,.. 프로그래밍 언어로 가져갈 때는 컬럼이름과 컬럼갯수를 모두 파악해야 하기 때문에 아래와 같이 사용
SELECT bookid, bookname, publisher, price
  FROM Book;	    	
  
  
  
-- 3.3 : 도서 테이블의 모든 출판사를 검색하시오.
-- 출판사별로 한번만 출력하면 좋겠음(즉, 중복 없애고 출력하기)
-- ALL : 전부 다
-- DISTINCT : 중복제거하고 한개만 출력
SELECT DISTINCT publisher
  FROM Book;  
  
  
  
-- 3.4 : 도서 중 가격이 20,000 미만인 도서를 검색
-- > 미만  < 초과 >= 이하 <= 이상, <> 같지않다, != 같지않다  =같다(프로그래밍 언어와 차이)
SELECT *
  FROM Book
 WHERE price < 20000 
   AND publisher = '굿스포츠';




-- 3.5 : 가격이 10000이상 ~ 20000 이하인 도서를 검색하시오.
SELECT *
  from Book
 where price >= 10000
   and price <= 20000;  
   
SELECT *
from Book
where price BETWEEN 10000 AND 20000; -- BETWEEN 사용 -> 이상 이하 할 때 사용




-- 3.6 : 출판사가 '굿스포츠' 또는 '대한미디어'인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE publisher = '굿스포츠' OR publisher = '대한미디어';
 
 
SELECT *
  FROM Book
 WHERE publisher IN('굿스포츠','대한미디어');

    
-- NOT IN 사용
SELECT *
  FROM Book
 WHERE publisher NOT IN('굿스포츠','대한미디어');
 
 
 
 
 
 -- 3-7: '축구의 역사'를 출간한 출판사를 검색하시오.
 SELECT publisher
   FROM Book
  WHERE bookname = '축구의 역사';
 
 
 -- 패턴 
 -- [] 은 Oracle, SQL Server 사용가능 | MySQL에서는 사용불가
 -- [0-5] 1 개의 문자가 일치, 한 글자 0에서 5의 숫자를 포함한다
 -- [^] 1개의 문자가 일치하지 않는 것 
 -- _ 특정 위치에 있는 1개의 문자가 일치할 때
 SELECT publisher
   FROM Book
  WHERE bookname LIKE '%역사'; -- '역사'가 문자열을 포함된 도서를 찾는 것 
 
 
-- _ 구% : 첫번째 글자는 상관없고, 두번째 글자가 '구'라는 문자열을 갖는 도서를 구해라. 
 SELECT *
   FROM Book
  WHERE bookname LIKE '_구%'; 





-- Null 검색 -> IS | IS NOT 사용
-- 추가 : 고객 중에서 전화번호가 없는 사람을 검색하세요.
SELECT name
  FROM Customer 
 WHERE phone IS NULL;


SELECT name
  FROM Customer 
 WHERE phone IS NOT NULL;
 
 
 
 
-- 3-10 : 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE bookname LIKE '%축구%' AND PRICE >= 20000;
 
 



-- 3-11 : 도서를 이름순(오름차순)으로 검색하시오.
-- ASC(ending) 오름차순 -> 기본적으로 적용되는 정렬이므로 생략가능,  DESC(ending) 내림차순
SELECT *
FROM Book
-- ORDER BY bookname ASC; 
ORDER BY bookname desc;




-- 3-12 : 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT *
FROM Book
ORDER BY PRICE, bookname;





-- 3-13 : 도서를 가격의 내림차순으로 검색하시오. 가격이 같다면 출판사를 오름차순으로 출력하시오.
SELECT *
FROM Book
ORDER BY price DESC, publisher;





 