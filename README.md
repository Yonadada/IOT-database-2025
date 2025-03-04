# IOT-database-2025
iot 개발자 데이터베이스 저장소

## 1일차

- 데이터 베이스 시스템 
  - 통합된 데이터를 저장하고 운영하면서, 동시에 여러 사람이 사용할 수 있도록 하는 시스템
  - 실시간 접근, 계속 변경 가능, 동시 공유가 가능, 내용으로 참조(물리적으로 떨어져 있어도 사용가능)

  - DBMS - SQL Server, Oracle, MySQL, MariaDB, MongoDB...

- 데이트 베이스 언어
    - SQL(Structured Query Language)은 구조화된 질의 언어(프로그래밍 언어와 동일)
        - DDL : DB나 테이블 생성, 수정, 삭제 언어
        - DML : 데이터 검색, 삽입, 수정, 삭제
        - DCL : 권한 부여, 해제 제어 언어

- MySQL 설치(Docker)
    - 도커 오류시, 파워쉘 접속 -> wsl --update

    1. poweShell 오픈, 도커 확인
    ```shell
    > docker -v 입력
    Docker version 27.5, build 9f9e405
    ```
    
    2. MySQL Docker 이미지 다운로드
    ```shell
    > docker pull mysql 입력
    Using default tag: latest
    latest: Pulling from library/mysql
    893b018337e2: Download complete
    2be0d473cadf: Download complete
    d255dceb9ed5: Download complete
    431b106548a3: Download complete
    43759093d4f6: Download complete
    f56a22f949f9: Download complete
    df1ba1ac457a: Download complete
    23d22e42ea50: Download complete
    277ab5f6ddde: Download complete
    cc9646b08259: Download complete
    Digest: sha256:146682692a3aa409eae7b7dc6a30f637c6cb49b6ca901c2cd160becc81127d3b
    Status: Downloaded newer image for mysql:latest
    docker.io/library/mysql:latest
    ```

    3. MySQL Image 확인 
    ```shell
    > docker images
    ```
    REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
    mysql        latest    146682692a3a   4 weeks ago   1.09GB

    4. Docker 컨테이너 생성
    - MySQL Port 번호는 3306이 기본
    - Oracle Port 번호는 1521
    - SQL Server 1433
    ```shell
    > docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=12345 -d -p 3306:3306 mysql:latest
    ```

    5. 컨테이너 확인
    ```shell
    > docker ps -a
    CONTAINER ID   IMAGE          COMMAND                   CREATED          STATUS          PORTS
     NAMES
    8623b64c0a9b   mysql:latest   "docker-entrypoint.s…"   37 seconds ago   Up 36 seconds   0.0.0.0:3306->3306/tcp, 33060/tcp   mysql-container
    ```

    6. Docker 컨테이너 시작, 중지, 재시작
    ```shell
    > docker stop mysql-container # 중지
    > docker start mysql-container # 시작
    > docker restart mysql-container # 재시작
    ```

    7. MySQL Docker 컨테이너 접속 
    ```shell
    > docker exec -it mysql-container bash # bash 리눅스의 powershell
    ```
    PS C:\Users\Admin> docker exec -it mysql-container bash
    bash-5.1# mysql -u root -p
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 9
    Server version: 9.2.0 MySQL Community Server - GPL

    Copyright (c) 2000, 2025, Oracle and/or its affiliates.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | mysql              |
    | performance_schema |
    | sys                |
    +--------------------+
    4 rows in set (0.01 sec)
    ```
    
<img src="./images/db001.png" width="700">

- Workbench 설치
    - https://dev.mysql.com/downloads/workbench/ MySQL Workbench 8.0.41 설치
    - Dev 파일 -> Tool 파일 생성 -> MySQL\Samples and Examples 8.0,MySQL\Samples and Examples 8.0 경로 Tool로 변경
    - MySQL Installer에서 Workbench 설치 

    - Workbench 실행 수 
        1. MySQL Connection 

- 관계 데이터 모델 
    - 3단계 DB 구조 : 외부 스키마(실세계와 매핑) -> 개념 스키마(DB 논리적 설계) -> 내부 스키마(DB 물리적 설계) -> DB
    
    - 모델에 쓰이는 용어
        - 릴레이션 : 행과 열로 이루어진 **테이블** 
        - 속성(애튜리뷰트, 열column) : 헤더에 나타나며 각 데이터의 특징이나 정보를 담고 있다(테이블 컬럼) 
        - 튜플 : 릴레이션의 행(Row) 
            - 키 : 특정 튜플을 식별할 때 사용하는 속성 (중복된 튜플을 허용x)
        - 관계 : 릴레이션(테이블)내의 관계와 릴레이션(테이블)간의 관계를 의미(부모, 자식 연관)
        - 스키마 : 테이블의 데이터 구조를 의미
        - 인스턴스 : 정의된 스키마에 따라 저장된 데이터를 의미
        - 카디널리티(차수) : 튜플의 수

    - `무결성 제약조건`
        - 슈퍼키 : 튜플을 유일하게 식별할 수 있는 하나의 속성 
        - 후보키 : 튜플을 유일하게 식별할 수 있는 최소 집합
        - **기본키(Primary Key)** : 고유한 값(unique), Not null
        - 대리키(인조키) : 마땅한 기본키가 없을 때 일련번호 같은 가상의 속성을 만들어 기본키로 삼는경우
        - 대체키 : 기본키로 선정되지 않은 후보키
        - **외래키(Foreign Key)** : 다른 릴레이션의 기본키를 참조하는 속성

    - 무결성 제약조건 : 데이터베이스에 저장된 데이터의 일관성과 정확성을 지키는 것
        1. 도메인 무결성 제약조건 : 각 속성의 도메인에 지정된 값만 가져야 한다

        2. 개체 무결성(즉,기본키 제약 조건) : not null, unique

        3. 참조 무결성 - 부모 릴레이션의 기본키와 도메인이 같아야함(영향을 받는다) 
            - 삽입, 수정, 삭제

- SQL 기초
    - SQL 개요

    ```sql
    -- DML SELECT문
    SELECT publisher, price
    FROM Book
    WHERE bookname = '축구의 역사'; 
    ```



## 2일차 
- SQL 기초 
    - 개요
        - 데이터베이스에 있는 데이터를 추출 및 처리작업을 위해 사용되는 프로그래밍 언어
        
        - 일반 프로그래밍 언어와 차이점 
            - DB에서만 문제를 해결가능 
            - 입.출력을 모두 DB에서 테이블로 처리
            - 컴파일 및 실행은 DBMS가 수행 

        - DML(데이터 조작어) - 검색, 삽입, 수정, 삭제
            - SELECT, DELETE, UPDATE, INSERT

        - DDL(데이터 정의어) : 테이블의 구조를 생성
            - CREATE, ALERT, DROP

        - DCL(데이터 제어어) : 데이터 사용 권한을 관리
            - GRANT, REVOKE
    
    - DML 중 SELECT 

        ```sql
        -- SLECT 문 기본문법
        SELECT [ALL|DISTINCT] 컬럼명(들)
        FROM 테이블명(들)
        [WHERE 검색조건(들)]
        [GROUP BY 속성이름(들)]
        [HAVING 집계함수검색조건(들)]
        [ORDER BY 정렬할속성(들) [ASC|DESC]]
        [WITH ROLLUP]
        ```

        - 쿼리 연습(정렬까지) : [SQL](./day02/db02_select.sql)
        - 쿼리 연습(집계함수부터) : [SQL](./day02/db03_select_집계함수.sql)



## 3일차
- Visual Studio Code에서 MySQL 연동
    - 확장 > MySQL 검색
        - Weijan Chen 개인 개발자가 만든 MySQL 확장도 준수
        - Weijan Chen 개발한 Database Client 설치
            - 데이터베이스 아이콘 생성
        - Oracle에서 개발한 MySQL Shell for VS Code 사용 X 불편함

    - Database Client
        1. 툴바의 Database 아이콘 클릭
        2. Create Connection 클릭
        3. 정보 입력 > 연결 테스트

            <img src='./image/db002.png' width='600'>


        4. Workbench 처럼 사용

            <img src='./image/db003.png' width='600'>


- SQL 기초
    - 기본 데이터형
        - 데이터베이스에는 엄청 많은 데이터형이 존재(데이터의 사이즈 저장용량을 절약하기 위함)

        - 주요 데이터형
            - SmallInt(2byte) - 65535가지 수(음수 포함)를 저장 (-32768 ~ 32767)
            - **Int(4)** - 모든 데이터타입의 기준! 42억 정수(음수 포함) 저장
            - BigInt(8) - Int보다 더 큰 수 저장
            - Float(4) - 소수점아래 7자리까지 저장
            - Deciaml(5~17) - Float보다 더 큰 수 저장
            - Char(n) - n은 가변(1 ~ 255). **고정 길이 문자열**
                - 주의점! Char(10)에 Hello 입력하면 **'Hello     '** 과 같이 저장
            - Varchar(n) - n은 가변(1 ~ 65535). **가변 길이 문자열**
                - 주의점! Varchar(10)에 Hello 입력하면 **'Hello'** 저장됨
            - Longtext(최대 4GB) - 뉴스나 영화스크립트 저장시 사용
            - LongBlob(최대 4GB) - mp3, mp4 음악, 영화 데이터 자체 저장시 사용
            - Date(3) - 2025-02-27까지 저장하는 타입
            - DateTime(8) - 2025-02-27 10:46:34 까지 저장하는 타입
            - JSON(8) - json 타입 데이터를 저장

    - DDL 중 CREATE :[SQL](./day03/db01_ddl_query.sql)

        ``` sql
        CREATE DATABASE 데이터베이스명
            [몇 가지 사항];

        CREATE TABLE 테이블명(
            컬럼(속성)명 제약사항들, ...  
            PRIMARY KEY (컬럼(들))
            FOREIGN KEY (컬럼(들)) REFERENCES 테이블명(컬럼(들)) ON 제약사항
        );
        ```
        - DDL문은 Workbench에서 마우스 클릭으로 많이 사용(개발자 - 사용빈도 낮음)
        - 테이블 생성 후 확인
            1. 메뉴 Database > Reverse  Engineer(데이터베이스를 ERD 변경) 클릭
            2. 연결은 패스
            3. Select Schemas to RE 에서 특정 DB 체크
            4. Excute 버튼 클릭
            5. ERD 확인
            
            <img src='./image/db004.png' width='600'>

    - DDL 중 ALTER
        ``` sql
        ALTER DATABASE 데이터베이스명
            [몇 가지 사항];

        ALTER TABLE 테이블명
            [ADD 속성명 데이터타입]
            [DROP COLUMN 속성명]
            [ALTER COLUMN 속성명 데이터타입]
            -- ...
        ```
        - 테이블 수정


    - DDL 중 DROP
        ``` sql
        DROP [DATABASE|TABLE|INDEX|...] 개체명
        ```
        - 테이블 삭제. 복구 안됨! 백업 필수

    - DML 중 INSERT, UPDATE, DELETE : [SQL](./day03/db02_dml_query.sql)
        ``` sql
        -- 삽입
        INSERT INTO 테이블명 [(컬럼리스트)]
        VALUES (값리스트);

        -- 다른 테이블의 데이터 가져오기
        INSERT INTO 테이블명 [(컬럼리스트)]
        SELECT 컬럼리스트 FROM 테이블명
        [WHERE 조건];

        -- 수정
        UPDATE 테이블명
           SET 속성 = 값
             [, 속성 = 값]
         WHERE 조건;

        -- 삭제
        DELETE FROM 테이블명
         WHERE 조건;
        ```
        - INSERT 데이터 삽입, 새로운 데이터 생성
        - UPDATE 데이터 수정, 기존 데이터 변경
        - DELETE 데이터 삭제
        - `UPDATE와 DELETE는 WHERE절 없이 사용하면 문제 발생 위험!!!`
            - 트랜잭션을 사용하지 않으면 복구가 어려움 **(조심할 것)**

- SQL 고급
    - 내장함수, NULL : [SQL](./day03/db03_sql_고급.sql)
        - 수학함수, 문자열함수, 날짜함수 등

## 4일차
- SQL 고급 : [SQL](./day04/db01_sql고급.sql)
    - 행번호 출력
        - LIMIT, OFFSET 잘 쓰면 필요없음
        - 행번호가 필요한 경우도 있음

- SubQuery 고급 : [SQL](./day04/db02_sql고급_서브쿼리.sql)
    - WHERE절 - 단일값(비교연산), 다중행(ALL|ANY|EXISTS|IN|NOT IN...) 
    - SELECT절 - 무조건 스칼라값(단일행 단일열)
    - FROM절 - 인라인뷰. 하나의 테이블처럼 사용 - 가상테이블

- SQL 고급
    - 뷰 : [SQL](./day04/db03_sql고급_뷰.sql)
        - 자주 사용할 쿼리로 만들어진 가상 테이블을 계속 사용하기 위해서 만든 객체
        - 입력, 수정도 가능. 조인된 뷰는 불가능
        - 보안적, 재사용성, 독립성을 위해서 사용

    - 인덱스 : [SQL](./day04/db04_sql고급_인덱스.sql)
        - 빠른 검색을 위해서 사용하는 개체
        - 클러스터 인덱스 : 기본키에 자동으로 생성되는 인덱스(테이블당 1개)
        - 논클러스터(보조) 인덱스 : 수동으로 컬럼들에 생성할 수 있는 인덱스(여러개 가능)
        
        - 주의점
            - WHERE절에 자주 사용하는 컬럼에 인덱스 생성
            - 조인문에 사용하는 컬럼(PK 포함) 인덱스 생성
            - 테이블당 인덱스 개수는 5개 미만 생성할 것(너무 많으면 성능 저하)
            - 자주 변경되는 컬럼에는 인덱스 생성하지 말 것(성능 저하)
            - NULL값이 많은 컬럼에 인덱스 생성하지 말 것(성능 저하)

- 데이터베이스 프로그래밍
    - 저장 프로시저 : [SQL](./day04/db05_저장프로시저.sql)
        - 많은 쿼리로 일을 처리해야 할 때, 파이썬 등 프로그램에서 구현하면 복잡함
        - 저장 프로시저 하나로 프로그램 구현시 코드가 매우 짧아짐
        - 개발 솔루션화, 구조화 해서 손쉽게 DB 처리를 가능하게 하기 위해서
        - 예제 : [SQL](./day04/db05_저장프로시저2.sql)





## 5일차
- 데이터베이스 프로그래밍
    - 리턴문을 쓸 수 있으면 함수, 아니면 프로시저.
    - 프로시저에서도 값을 반환하려면 OUT 파라미터를 선언
    
    - 저장 프로시저 계속    
        - 결과를 반환하는 프로시저 : [SQL](./day05/db01_저장프로시저3.sql)
        - 커서 사용 프로시저 : [SQL](./day05/db02_프로시저4.sql)

    - 트리거 : [SQL](./day05/db03_트리거.sql)

    - 사용자 정의 함수 : [SQL](./day05/db04_사용자정의함수.sql)
        - 리턴 키워드 사용

- 데이터베이스 연동 프로그래밍  
    - PyMySQL 모듈 사용
    - 파이썬 DB연동 콘솔 : [노트북](./day05/db05_파이썬_DB연동.ipynb)
    - 파이선 DB연동 웹(Flask) : [Python](./day05/index.py)
        - templates 폴더내 html을 저장!

- 데이터 모델링
    - 현실 세계에 데이터 처리 내용을 디지털 환경에 일치시켜서 모델링
    - DB 생명주기 
        1. 요구사항 수집 및 분석
        2. 설계
        3. 구현
        4. 운영
        5. 감시 및 개선
    
    - 모델링 순서
        1. 개념적 모델링 - 요구사항 수집 및 분석을 토대로 전체 뼈대를 세우는 과정
        2. 논리적 모델링 - ER 다이어그램 체계화. DBMS에 맞게 매핑. 키 선정(추가), 정규화, 데이터 표준화 
        3. 물리적 모델링 - DBMS 종류에 맞게 데이터타입 지정, 물리적 구조 정의. 응답시간 최소화/트랜잭션 검토/ 저장공간 배치
    
    - 현재 ER 다이어그램은 IE(Information Engineering)방식으로 설계
    - ERWin 설계 실습 : [ERWin](./day05/madangstore.erwin)


## 6 일차
- 데이터모델링 계속
    - 마당대학 데이터베이스
- 정규화 
- 트랜잭션
- 데이터베이스 관리와 보안
- 실무 실습

- Python GUI DB 연동으로 앱 개발