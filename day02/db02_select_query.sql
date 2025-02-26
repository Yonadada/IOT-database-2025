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
-- DISTINCT : 중복제거하고 
SELECT DISTINCT publisher
  FROM Book;  
  
-- 3.4 : 