/*
    DCL(DATA CONTROL LANGUAGE)
    데이터 제어 언어.
    
    계정에서 시스템권한 또는 객체접근권한을 부여(GRANT)하거나 회수하는 언어
    
    -권한부여(GRANT)
        시스템권한: 특정 DB에 접근하는 권한 객체들을 생성할 수 있는ㄴ 권한
        객체 접근권한 : 특정 객체들에 접근해서 조작할 수 있는 권함
    
    -시스템 권한
        [표현법]
        GRANT 권한1, 권한2,.... TO 계정명
        
        -시스템 권한의 종류
        CREATE SESSION : 계정에 접속할 수 있는 권한. 
        CREATE TABLE : 테이블을 생성할 수 있는 권한.
        CREATE VIEW : 뷰를 생성 할 수 있는 권한.
        CREATE SEQUENCE : 시퀸스를 생성할 수 있는 권한.
        CREATE USER : 계정을 생성 할 수 있는 권한.
    
    
*/

--1. SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

--2. SAMPLE계정에 접속하기 위한 CREATE SESSION 권한부여
GRANT CREATE SESSION TO SAMPLE;

--3. SAMPLE에 TABLE을 생성할수있는 CREATE TABLE 을 부여한다.
GRANT CREATE TABLE TO SAMPLE;
--4. SAMPLE 계정에 TABLESPACE 를 할당해 주기 (SAMPLE 계정 변경)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-- QUQTA : 몫 -> 나눠주다. 할당한다.
-- 2M: 2MAGA BYTE

--5. SAMPLE 계정에 VIEW생성할수있는 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO SAMPLE;

--6. SAMPLE 계정에 KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여.
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;



/*
    -객체권한
    특정객체들을 조작할 수 있는 권한
    조작 : SELECT, INSERT , UPDATE, DELETE => DML
    
    [표현법]
    GRANT 권한 종류 ON 특정객체 TO 계정명
    
    권한종류
    SELECT : TABLE, VIEW, SEQUENCE
    INSERT : TABLE, VIEW
    UPDATE : TABLE, VIEW
    DELETE : TABLE, VIEW
*/

--7. SAMPLE계정에 KH.DEPARTMENT 테이블에 행을 삽입 할 수 있는 권한 부여.

GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

/*
    <롤 ROLE>
    특정 권한들을 하나의 집합으로 모아 놓은것.
    
    CONNECT : CREATE SESSION(데이터 베이스에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE , SELECT , INSERT
            (특정 객체들을 생성 및 조작 할 수 있는 권한.)    
*/
------------------------------------------------------------------------------------------
/*
    <권한 회수 REVOKE>
    [표현법]
    REVOKE 권한1, 권한2 FROM 계정명;
    
    권한을 뺏을때 사용하는 명령어
*/

--8. SAMPLE에서 테이블을 생성할수 있는 권한을 뺏어본다.

REVOKE CREATE TABLE FROM SAMPLE;


------------------DCL 실습권한----------------

-- 사용자에게 부여할 권한 :CONNECT RESOURCE
-- 받은 사용자는 : MYMY
CREATE USER MYMY IDENTIFIED BY MYMY;

GRANT CONNECT,RESOURCE TO MYMY;
