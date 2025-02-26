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
- SQL 기초
    - DDL
    - DML 중 INSERT, UPDATE, DELETE

- SQL 고급
    - 