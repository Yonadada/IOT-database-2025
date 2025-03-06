-- 데이터베이스 관리
show databases;

-- information_schema, performance_schema, mysql 등은 시스템 DB라서 개발자, DBA 사용하는게 아님
use madang;

-- DB내, 존재하는 테이블들 확인
show tables;

-- 테이블의 구조
desc madang.NewBook;

select * from V_orders;

-- 사용자 추가
-- madang 데이터 베이스만 접근 가능한 사용자madang 생성

-- 내부 접속용(지금 컴퓨터)
CREATE user madang@localhost IDENTIFIED by 'madang';

-- 외부 접속용
CREATE user madang@'%' IDENTIFIED by 'madang';

-- ===========================
-- DCL : GRANT, REVOKE

-- 데이터 삽입, 조회, 수정 권한만 부여
GRANT SELECT, INSERT, UPDATE ON madang.* TO madang@localhost WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE ON madang.* TO madang@'%' WITH GRANT OPTION;


-- 모든 권한 부여
GRANT ALL PRIVILEGES ON madang.* TO madang@localhost WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON madang.* TO madang@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;


-- 권한 해제
-- madang 사용자의 권한 중, select 권한만 제거
REVOKE SELECT ON madang.* FROM madang@localhost;
REVOKE ALL PRIVILEGES ON madang.* FROM madang@localhost;
REVOKE ALL PRIVILEGES ON madang.* WITH madang@'%';
FLUSH PRIVILEGES;




