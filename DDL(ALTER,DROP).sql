/*
    DDL: 데이터 정의 언어
    
    객체들을 새롭게 생성(CREATE),수정하고 ,삭제하는 구문
    
    1.ALTER
    객체의 구조를 수정하는 구문.
    
    <테이블 수정>
    [표현법]
    ALTER TABLE 테이블명 수정할 내용;
    
    -수정할 내용
    1)컬럼추가 /수정 /삭제
    2)제약조건 추가/삭제=> 수정은 불가(수정하고자한다면 삭제후 새로이 추가)
    3)테이블명 /칼럼명/제약조건명 수정
*/
--1. 칼럼 추가/수정/삭제
    --ADD 칼럼명 자료형 DEFAULT 기본값(DEFAULT 생략가능)

SELECT * FROM DEPT_COPY;
--CNAME 칼럼추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(2);
--새로운 컬럼이 만들어지고 기본적으로 NULL값으로 채워짐
--LNAME 칼럼 추가 DEFUALT 지정
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
CONSTRNT
--새로운 칼럼을 추가하고 기본값으로 한국을 추가함
   
    --MODIFY
        --MODIFY 칼럼명 바꿀 자료형
        --MODIFY 칼럼명 DEFAULT 바꿀기본값
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
--현재 변경하고자하는 컬럼에 이미 담겨있는 값과 완전히 다른 타입으로는 변경이 불가능함
-- DEPT_COPY테이블 DEPT_ID를 NUMBER로 변경하고자한다면 오류가 날것이다
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;    
--"column to be modified must be empty to change datatype"
--현재 변경하고자 하는 컬럼에 이미 담겨있는 값과 일치하는 컬럼이거나 혹은 속해있는 컬럼, 
--그리고 더 큰바이트의 자료형으로만 변경가능함
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1);
--cannot decrease column length because some value is too big 사이즈가 

/*문자 -> 숫자(X)
    문자->사이즈 축소(X)
    숫자->문자 (O)
    문자->사이즈 확대(O)
*/
--한번에 여러개 칼럼 자료형 변경
--DEPT_TITLE의 데이터 타입을 VARCHAR2(40)으로
--LOCATION_ID의 데이터타입ㅇ르 VARCHAR2(2)로
--LNAME칼럼의 기본값을 '미국'
SELECT * FROM DEPT_COPY;
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATTION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '미국';
--컬럼삭제 DROM COLUMN 컬럼명
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;
--DDL 문은 복구가 불가능 하다.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
--cannot drop all columns in a table"
--즉 DROP COLUMN을 하기위해서는 최소한 COLUMN이 하나는 존재해야된다.

/*
    2)제약조건 추가/ 삭제
        제약조건 추가
        -PRIMARY KEY : ADD PRIAMRY KEY(컬럼명)
        -FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)]
        -UNIQUE : ADD UNIQUE(컬럼명)
        -CHECK : ADD CHECK(컬럼에 대한 제약조건)
        -NOT NULL : MODIFY 컬럼명 NOT NULL;
        
        나만의 제약조건을 만들고싶다면
        CONSTRAINT 제약조건명 앞에다붙임
            -> 생략이가능했음
            ->주의사항 : 현재 계정내 고유한 이름으로 부여함.
          */
          /*  
        DEPT_COPY 테이블로부터
        DEPT_ID 컬럼에 PRIMARY _KEY  제약조건 추가
        DEPT_TITLE 컬럼에 UNIQUE 제약조건추가
        LNAME칼럼에 NOT NULL 제약조건 추가
    
*/
    ALTER TABLE DEPT_COPY
        ADD PRIMARY KEY (DEPT_ID)
        ADD CONSTRAINT DCOPY_UNIQUE UNIQUE (DEPT_TITLE)
        MODIFY LNAME NOT NULL;
/*
    제약조건 삭제
    
*/
--DEPT_COPY테이블로부터 PK에 해당하는 조건을 삭제
    ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007295;
    ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UNIQUE;
    ALTER TABLE DEPT_COPY MODIFY LNAME NULL;
    
--3) 컬럼명 /제약조건명 / 테이블명 변경
/*컬럼명변경
    RENAME COLUMN 기존컬럼명 TO 바꿀 컬럼명
  */  
  ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
    
    --제약조건명 변경 RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
    --DEPT COPY의 SYS_C007286를 DCOPY_DI_NN
    ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007286 TO DCOPY_DI_NN;
    
    --테이블 명 변경 : RENAME 기존테이블명 TO 바꿀 테이블명( 기존테이블명 생략가능)
    ALTER TABLE DEPT_COPY RENAME TO DEPT_COFFE;
    ALTER TABLE DEPT_COFFE RENAME TO DEPT_COPY;

/*
    2.DROP
    객체를 삭제하는 구문
    [표현법]
    DROP TABLE 삭제하고자하는 테이블이름

*/            
 --FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)]
    DROP TABLE EMP_NEW;
    --부모테이블을 삭제하는 경우에는 제대로 지워 지지 않음
    --부모테이블을 만드는 경우 테스트
    CREATE TABLE DEPT_TEST
        AS SELECT * FROM DEPARTMENT;
    --DEPT_TEST 에 DEPT_ID를 PRIMARY_KEY 추가 
    ALTER TABLE DEPT_COPY ADD PRIMARY_KEY(DEPT_ID);
    ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007304 TO DCOPY_ID_PK;
    --EMPLOYEE_COPY3에 외래키(DEPT_CODE)를 추가(외래키이름 ECOPY_FK)
    ALTER TABLE EMPLOYEE_COPY3 
        ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_COPY(DEPT_ID);
    -- 이때 부모테이블은 DEPT_TEST테이블 , DEPT_ID를 참조
    DROP TABLE DEPT_COPY;--unique/primary keys in table referenced by foreign keys
    --물려있어서 부모테이블이 삭제되지않음
 
--부모테이블 삭제 


    


--1.자식테이블을 먼저 삭제한후 테이블 삭제한다.
DROP TABLE EMPLOYEE_COPY3;
DROP TABLE DEPT_COPY;
COMMIT;

--2. 부모테이블만 삭제하되 맞물려잇는 외래키 제약조건도 함께 삭제한다
DROP TABLE DEPT_COPY CASCADE CONSTRAINT;