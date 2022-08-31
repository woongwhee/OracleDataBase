/*
    DDL(DATA DEFINITION LANGUAGE):데이터 정의언어
    오라클에서 제공하는 객체(OBJECT)를
    새로이 만들고(CREAT), 구조를 변경하고(ALTER),구조 자체를 삭제(DROP) 하는 명령문.
    즉, 구조 자체를 정의하는 언어로 DB관리자 , 설계자가 사용함
    오라클에서의 객체(DB)를 이루는 구조물들
    테이블(TABLE),사용자(USER), 함수(FUNCTION),뷰(VIEW),시퀸스(SEQUENCE),
    인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER), 프로시저(PROCEDURE), 동의어(SYNONYM)
*/

/*
    <CREAT TABLE>
    테이블 : 행(ROW),열(COLUM)으로 구성되는 기본적인 데이터베이스 객체 종류중 하나.
        모든 데이터는 테이블을 통해서 저장됨(데이터를 조작하고자 하라면 무조건 테이블을 만들어야함)
        
        [표현법]
        CREATE TABLE 테이블명 (
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형,
        ......
        )
        <자료형>
        --문자(CHAR(크기)/VARCHAR2(크기)):크기는 BYTE단위임 . (숫자,영어,특수문자->글자당 1BYTE),
            CHAR (바이트수):최대 2000BYTE 까지 지정 가능
                            고정길이(아무리 적은 값이 들어와도 공백으로 채워서 처음 할당한 크기를 유지함)
                            주로 들어올 값의 글자수가 정해져 있을 경우 사용
                            EX)성별 :M/F, 주민번호 : 14글자
            VARCHAR2(바이트수): 최대 4000BYTE까지 지정 가능
                                가변길이(적은값이 들어올 경우 그 담긴 값에 맞춰 크기가 줄어든다.)
                                VAR는 '가변',2는 2배를 의미한다.
                                주로들어올 값의 글자수가 정해지지 않은 경우 사용
                                EX)이름, 아이디,비밀번호 등등등.
            숫자(NUMBER):정수/실수 상관없이 NUMBER하나
            날짜(DATE): 년/월/일/시/분/초 형식으로 시간 지정.

*/

--회원들에 데이터 아이디 비밀번호 이름 생년월이 를 담기위한 테이블 MEMBER생성

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
);
--테이블 확인 방법
--1)데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 테이블
SELECT *
FROM USER_TABLES;
--2)접속탭에서 확인하기.
--3)

--참고사항 칼럼들을 확인 법

SELECT *
FROM USER_TAB_COLUMNS;
--USER_TAB_COLUMNS: 현재 이 사용자 계정이 가지고 있는 테이블의 모든 컬럼정보를 조회할 수 있는 시스템 테이블.
--컬럼에 주석달기(COMENT)
/*
    [표현법]
    COMMENT ON COLUMN 테이블명 . 컬럼명  IS '주석내용'
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
--회원비밀번호 
--회원이름
--생년월일
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '생년월일';

SELECT *
FROM MEMBER;
/*--데이터 추가
--INSERT(DML):데이터를 추가할수있는 구문.
--한행으로 추가 (행을 기준으로 추가),추가할 값을 기술(값의 순서 중요)
    [표현법]
    INSERT INTO 테이블명 VALUES(첫번째 칼럼의 값,두번째 칼럼의 값, ....)

*/
INSERT INTO MEMBER VALUES('user01','password01','민경민','1990-10-06');
INSERT INTO MEMBER VALUES('user02','password02','이경민','1996-12-16');
INSERT INTO MEMBER VALUES('user03','password03','김경민','1992-11-30');
INSERT INTO MEMBER VALUES('user04','password04','신경민','2000-10-06');

INSERT INTO MEMBER VALUES(NULL,NULL,NULL,SYSDATE);
INSERT INTO MEMBER VALUES('user03','password03','김경민','1992-11-30');

--NULL값이나 중복된값은 유효하지 않은 값이다.
--유효한 데이터값을 유지하기 위해서 제약조건이란것을 걸어줘야함.
--제약조건을 통해 데이터의 무결성 보장이 가능해짐.
--제약조건 :테이블을 만들때 지정가능 후에 수정 추가 가능.


/*
    <제약조건 CONSTRAINTS>
    
    -원하는 데이터값만 유지,보관하기 위해서 특정 COLUMN마다 설정하는 제약
    (데이터 무결성 보장을 목적으로)
    -제약 조건이 부여된 컬럼에 들어올 데이터의 문제가 있는지 없는지 자동으로 검사할 목적.
    -종류: NOT NULL, UNIQUE,CHECK,PRIMARY KEY,FOREIGN KEY
    

    - 컬럼에 제약조건을 부여하는 방식 :컬럼레벨 방식 /테이블 레벨 방식.   
*/

    /*
        1. NOT NULL제약조검: 해당컬럼에 반드시 값이 존재해야될때 사용
        -> NULL값이 들어와서는 안되는 컬럼에 부여하느 제약조건
            삽입 수정시 NULL값을 허용하지 않도록 제한하는 제약조건
        주의사항 :컬럼레벨 방식밖에 안됨.
        
        --컬럼레벨방식: 컬럼명 자료형 제약조건 =?> 제약조건을 부여하고자 하는 컬럼뒤에 곧바로 기술
        2.    
            
            
    */
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENTER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

INSERT INTO MEM_NOTNULL values ( 1,'user01','pass01','경민경','남','010-4121-5555','alsrudals@iei.or.kr');
INSERT INTO MEM_NOTNULL VALUES(2,NULL,NULL,NULL,NULL,NULL,NULL);--cannot insert NULL
-->NOTNULL제약조건에 위반
INSERT INTO MEM_NOTNULL VALUES(2,'user01','pass01','남경민',NULL,NULL,NULL);
/*
    2.UNIQUE 제약조건
    컬럼에 중복값을 제한하는 제약조건.
    삽입 수정시 기존에 해당 칼럼값중에 중복된 값이 있는 경우 추가나 수정이 되지않게끔 제약시킴
    컬럼레벨방식/테이블레벨방식

*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE , --별도의 콤마없이 연달아 제약가능
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER VARCHAR2(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    /*,UNIQUE(MEM_ID)*/
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;--테이블을 삭제시키는 키워드

INSERT INTO MEM_UNIQUE VALUES( '1','USER01','PASS01','김경민','남','010-3338-6666'
,'email@gmail.com');
INSERT INTO MEM_UNIQUE VALUES( '2','USER01','PASS02','남경민','여','010-2338-6666'
,'gemail@mail.com');
--unique constraint (DDL.SYS_C007046) violated
--동일한 쿼리문 두번 실행시켰을때, unique 제약조건에 위배 되었으므로 insert 실패함
--DDL.SYS_C007046에 해당하는 컬럼이 뭔지 확인할려면 테이블에 가서 확인해야된다.
-->제약조건 부여시 제약조건 명도 지정하는 표현법
/*
    -> 컬럼레벨 방식
    CREATE TABLE 테이블명 (
        컬럼명 자료형 제약조건1 제약조건2,
        컬럼명 자료형 CONSTRAINT제약조건명 제약조건,
        컬럼명 자료형
    );
    ->테이블레벨 방식
    CREATE TABLE 테이블명 (
        컬럼명 자료형 제약조건1 제약조건2,
        컬럼명 자료형 제약조건1,
        컬럼명 자료형,
        CONSTRAINT 제약조건명 제약조건(컬럼명)
    );
*/

CREATE TABLE MEM_CON_NN(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    EMAIL VARCHAR2(30) NOT NULL
--    CONSTRAINT ID_UQ UNIQUE(MEM_ID)
    );
    
INSERT INTO MEM_CON_NN VALUES(
'1','USER01','PASS01','김경민','남'
,'email@gmail.com'
);--한번더 실행하면 내가 지정한 제약조건 코드가 뜬다.
--ORA-00001: unique constraint (DDL.MEM_ID_UQ) violated
INSERT INTO MEM_CON_NN VALUES(
'1','USER02','PASS01','김경민','남'
,'email@gmail.com'    );
INSERT INTO MEM_CON_NN VALUES(
'1','USER03','PASS01','김경민','나'
,'email@gmail.com'    );
/*
    1. CHECK 제약조건
        컬럼에 기록될수 있는 값에 대한 조건을 설정할 수 있다.
        EX)성별 남 여 만 들어오게끔 하고싶다,
        [표현법]

*/

CREATE TABLE MEM_MEMCHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30) NOT NULL,
    MEM_DATE DATE NOT NULL
--    CONSTRAINT ID_UQ UNIQUE(MEM_ID)
    );
    
    
INSERT INTO MEM_MEMCHECK VALUES( '2','USER01','PASS01','김경민','남','010-3333-4444'
,'email@gmail.com',SYSDATE
);
INSERT INTO MEM_MEMCHECK VALUES( '2','USER01','PASS01','김경민','열','010-3333-4444'
,'email@gmail.com',SYSDATE
);

--만약 체크 제약조건을 걸고 D안에 NULL이 들어가는 경우 정상적으로 INSERT가됨

--추가적으로 NULL값이 못들어 오게 하고싶다면 NOTNULL제약조건도 같이 걸어주면됨

/*
    DEFAULT 설정
        특정 칼럼에 들어온 값에 대한 기본값 설정 가능
        제약조건은아님
        EX) 회원가입일 컬럼에 회원정보가 사빙된 순간을 기록하고 싶다. ->DEFAULT 설정을 SYSDATE 넣으면됨
    
*/

DROP TABLE MEM_MEMCHECK;
CREATE TABLE MEM_MEMCHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_GENDER CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --> DEFAULT 제약조건은 반드시 먼저 걸어뭐야됨
    );
    
INSERT INTO MEM_MEMCHECK VALUES
( '2','user3','PASS01','김경민','남','010-3333-4444','1@2',SYSDATE);
SELECT * FROM MEM_MEMCHECK;

/*
INSERT INTO MEM_CHECK (컬럼명 나열)VALUES (값들나열)
*/
INSERT INTO MEM_MEMCHECK (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME) VALUES (
    '3','UESR02','PWPW','아아');--알아서 SYSDATE로 초기화 되었다.

/*
    PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행들의 정보를 유일하게 식별할수 있는 칼럼에 부여하는 제약조건.
    => 각 행들을 구분할 수있는 식별자 의 역할
        예) 사번,부서아이디,직급코드,회원번호..
    =>식별자의 조건 :중복되어서는 안됨, 값이 없으면 안됨 => NOT NULL +UNIQUE
    
    주의사항 : 한 테이블당 한개의 칼럼값만 기본키로 지정 가능.
*/  
DROP TABLE MEM_PRIMARYKEY1;
CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_GENDER CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
);

INSERT INTO MEM_PRIMARYKEY1 VALUES(
 '2','user3','PASS01','김경민','남','010-3333-4444','1@2',SYSDATE
);
INSERT INTO MEM_PRIMARYKEY1 VALUES(
 '2','user3','PASS01','김경민','남','010-3333-4444','1@2',SYSDATE
);--오류 겹침
INSERT INTO MEM_PRIMARYKEY1 VALUES(
 NULL,'user3','PASS01','김경민','남','010-3333-4444','1@2',SYSDATE
);--입력안해서 실행불가
DROP TABLE MEM_PRIMARYKEY2;
CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ2 UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_GENDER2 CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO)
);

--name already used by an existing constraint
--제약조건명은 다른테이블에 있더라도 중복될수없다 ㄷㄷ
--두컬럼을 묶어서 한번에 PRIMARY KEY 로 설정 가능 => 테이블레벨 방식으로만 가능.
CREATE TABLE MEM_PRIMARYKEY3(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_PK_GENDER2 CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT MEM_PK3 PRIMARY KEY(MEM_NO,MEM_ID)-->복합키.
);

INSERT INTO MEM_PRIMARYKEY3 (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (
1,'U1','P1','경민');
INSERT INTO MEM_PRIMARYKEY3 (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (
1,'U2','P1','경민');
--복합키일경우 2키가 다 일치해야 제약조건에 위배됨
INSERT INTO MEM_PRIMARYKEY3 (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (
1,NULL,'P1','경민');
--복합키의 경우 2키중 하나라도 NULL이면 제약조건에 위배됨

/*
    5. FOREIGN KEY(외래키)
        해당칼럼에 다른테이블에 존재하는 값만 들어와야 하는 컬럼
        컬럼에 부여하는 제약조검
        => 다른테이블(부모테이블)을 참조한다 라고 표현
        즉 참조된 다른테이블 이 제공하는 있는 값만 들어올수있다.
        EX) KH 계정에서
            EMPLOYEE 테이블(자식테이블)<=========DEPARTMENT 테이블(부모테이블)
            DEPT_CODE                           DEPT_ID
            =>DEPT_CODE에는 DEPT_ID에 존재하는 값들만 들어올 수있따.
            
            =?FORIGN KEY 제약조건 (==연결고리)으로 다른 테이블과 관계를 형성할수있다.(==JOIN)
            
            [표현법]
            >컬럼레벨 방식
            컬럼명 자료형 CONSTRAINT 제약조건명 REFERENCES 참조할 테이블명 (참조할 칼럼명)
            >테이블레벨 방식
            CONSTRAINT 제약조건명 FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 칼럼명)
            
            참조할 테이블 == 부모테이블
            생략가능한것 : CONSTRAINT 제약조건명 , 참조할 컬럼명 (두방식 모두 해당됨)
            -> 자동적으로 참조할 테이블의 PRIMARY KEY에 해당되는 컬럼이 참조할 컬럼명으로 잡힘.
            
            주의사항 : 참조할 컬럼타입과 외래키로 지정한 컬럼타입이 같아야한다.
            

*/


/*
    부모테이블
    회원의 등급에 대한 테이블 (등급코드 ,등급명)보관하는 테이블

*/
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY, --등급코드 /문자열 ('G1''G2''G3'...)
    GRADE_NAME VARCHAR(20) NOT NULL -- 등급명 //문자열(일반회원 우수회원 특별회원)
);
INSERT INTO MEM_GRADE VALUES( 'G1','일반회원');
INSERT INTO MEM_GRADE VALUES( 'G2','우수회원');
INSERT INTO MEM_GRADE VALUES( 'G3','특별회원');

SELECT * 
FROM MEM_GRADE;
--회원정보를 담는 자식테이블 생성


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),
    GENDER CHAR(3)  CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --테이블 방식
);
DROP TABLE MEM;
SELECT *
FROM MEM;

INSERT INTO MEM VALUES(
 '1','user1','PASS02','신김경','G3','여','010-3233-4454','2@22',SYSDATE
);
INSERT INTO MEM VALUES(
 '2','user3','PASS01','김경민','G1','남','010-3333-4444','1@2',SYSDATE
);
INSERT INTO MEM VALUES(
 '3','user4','PASS02','김경','G2','남','010-3333-4454','1@22',SYSDATE
);

SELECT 
MEM_NAME,
GRADE_NAME
FROM MEM
JOIN MEM_GRADE ON (GRADE_ID=GRADE_CODE);

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GENDER,GRADE_ID) VALUES (
    '4','USER33','1Q2W3E','김상현','남','G4'
);--parent key not found
--부모키와 일치하지 않으면 안된다
INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GENDER,GRADE_ID) VALUES (
    '5','USER33','1Q2W3E','김상현','남',NULL
);--NULL값은 삽입이 됨

--문제 ) 부모테이블에서 값이 삭제된다면?
DELETE FROM MEM_GRADE
WHERE GRADE_CODE='G1';
-- child record found
-- 자식 테이블에서 해당 값을 참조해서 사용중이기 때문에 삭제할수 없다.

DROP TABLE MEM;--자식테이블 삭제는 실행이 가능하다.

/*
    자식 테이블 생성시(==외래키 제약조건을 부여했을때)
    부모테이블의 데이터가 삭제되었을때 자식테이블에는 어덯게 처리할지 옵션을 지정해줄수있다.
    FOREIGN KEY 삭제옵션
        - ON DELETE SET NULL : 부모데이터를 삭제할때 데이터를 사용하는 자식 데이터를 NULL로 바꾸겠다.
        - ON DELETE CASECADE : 부모데이터를 삭제할떄 해당 데이터를 사용하는 자식데이터를 같이 삭제하겠다.
        - ON DELETE RESTRICTED : 삭제제한 -> 기본옵션

*/

-- ONDELETE SET NULL

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL,
    GENDER CHAR(3)  CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --테이블 방식
);

INSERT INTO MEM VALUES(
 '1','user1','PASS02','신김경','G3','여','010-3233-4454','2@22',SYSDATE
);
INSERT INTO MEM VALUES(
 '2','user3','PASS01','김경민','G1','남','010-3333-4444','1@2',SYSDATE
);
INSERT INTO MEM VALUES(
 '3','user4','PASS02','김경','G2','남','010-3333-4454','1@22',SYSDATE
);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';--자식테이블의 G1이모두 NULL로 변경되었다.


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE ,
    GENDER CHAR(3)  CHECK (GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --테이블 방식
);
SELECT * FROM MEM;
DELETE FROM MEM_GRADE WHERE GRADE_CODE = 'G2';--자식테이블중 G2을 포함한 열이 모두 삭제된다.
--조인문제
--전체 회원의 회원번호 아이디 비밀번호 이름 등급명조회
SELECT
    mem_no,
    mem_id,
    mem_pwd,
    mem_name,
    grade_name
FROM MEM
LEFT JOIN MEM_GRADE ON GRADE_CODE=GRADE_ID;
SELECT
    mem_no,
    mem_id,
    mem_pwd,
    mem_name,
    grade_name
FROM MEM,MEM_GRADE
WHERE GRADE_CODE=GRADE_ID(+);

--굳이 외래키가 설정되어있지않아도 JOIN이가능함
--단 두 컬럼에 동일한 의미의 데이터가 담겨있어야 함. (자료형이 같고 담긴종류 의미도 비슷해야함.
---------------------------------------------
--사용자계정 KH로 변경

/*
SUBQUALY를 이용한 INSERTE 테이블 생성 (테이블 복사의 개념)

메인 SQL 문 (SELECT, CREATE , INNSERT,UPDATE...)을 보존하는 역할의 쿼리문이 서브쿼리였음
    [표현법]
    CREATE TABLE 테이블명
    AS서브쿼리;
*/
CREATE TABLE EMPLOYEE_COPY
AS(
    SELECT *
    FROM EMPLOYEE
);
--컬럼들 자료형 NOT NULL 제약조건을 제대로 복사됨.
--PRIMARY KEY 제약조건은 제대로 복사가 안됨.
-->서브쿼리를 통해 테이블을 생성할 경우 제약조건의 경우 NOT NULL 제약조건만 복사된다
SELECT * FROM EMPLOYEE_COPY;
SELECT * FROM EMPLOYEE;
CREATE TABLE BLANK_EMPLOYEE AS(
SELECT * FROM EMPLOYEE
WHERE 1=0);--1=0은 FALSE를의미함 1=1은 TRUE;
-->이를이용해 칼럼의 구조만 복사해올수있다.
SELECT* FROM BLANK_EMPLOYEE;

--전체사원들중 300만원이상인 사원들의 사번 이름 부서코드 급여 복제 칼럼
--EMPLOYEE_COPY3
CREATE TABLE EMPLOYEE_COPY3 AS(
    SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
    FROM EMPLOYEE
    WHERE SALARY>=3000000
    
);
--2. 전체 사원들의 사번 사원명 급여 연봉 조회 결과를 복제한 테이블 생성
---EMPLOYEE_COPY4
DROP TABLE EMPLOYEE4;
CREATE TABLE EMPLOYEE_COPY4 AS(
SELECT EMP_ID,EMP_NAME,SALARY,SALARY*12 AS annual_income
FROM EMPLOYEE);
--서브쿼리의 SELECT절에 산술연산 또는 함수식이 기술된경우 반드시 별칭을 붙여주자.
