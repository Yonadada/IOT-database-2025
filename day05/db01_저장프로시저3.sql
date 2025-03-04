-- 결과를 반환하는 프로시저 Pg292
-- 5-3 : Book 테이블에 저장된 도서 평균 가격 반환 프로시저
DELIMITER //
-- 파라미터 IN : 값을 프로시저로 전달 
-- 파라미터 OUT : 프로시저에서 리턴값을 보내는 매개변수
CREATE PROCEDURE AveragePrice(
	OUT Val INTEGER
)
BEGIN
	SELECT AVG(price)INTO Val
	  FROM Book WHERE price IS NOT NULL;
END;

-- 프로시저를 실행할 때는 Ctrl + Enter가 제대로 실행이 안된다. 마우스로 드래그한 뒤 번개 아이콘 클릭
CALL AveragePrice(@myValue);
SELECT @myValue;