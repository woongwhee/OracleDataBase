/*
    DML (DATA MANIPULATION LANGUAGE)
    
    데이터 조작언어
    
    테이블에 새로운 데이터를 삽입 하거나(INSERT)
    기존의 데이터를 수정하거나(UPDATE)
    삭제하는 구문(DELETE)
    
*/

/*
    1.INSERT: 테이블에 새로운 행을 추가하는 구문
    [표현법]
    INSERT INTO 계열
    
    CASE 1: INSERT INTO 테이블명 VALUES (값1,값2,값3)
    => 해당 테이블에 모든 컬럼에 대해 추가하고자 할때 사용하는 방법
    주의사항 : 컬럼의 순서, 자료형 , 갯수를 맞춰서 VALUES 괄호안에 값을 나열해야함.
    -부족하게 값을 넣은 경우 : NOT ENOUGH VALUE 오류
    -값을 더 많이 제시하는 경우 : TOO MANY VALUES 오류
    
*/
--EMPLOYEE 테이블에 사원 정보 추가
INSERT INTO EMPLOYEE VALUES (
223,'민경민','990512-1234567','alsrudals@iei.or.kr','01041213393','D1','J1','S2',5000000,0.25,201,
SYSDATE,NULL,DEFAULT
);

SELECT * FROM EMPLOYEE;

/*
    CASE 2 : INSERT INTO 테이블명(칼럼명1,칼럼명2,칼럼명3) VALUES (값1,값2,값3);
    -> 해당 테이블에 특정칼럼만 선택해 그 칼럼에 추가할 값만 제시하고자 할떄 사용.
        한 행 단위로 추가되기 때문에 선택이 안된 컬럼은 기본적으로  NULL값이 들어감.
        -단, DEFAULT 설정이 되어있는 경우 기본값이 들어감.
        
        주의사항: NOT NULL 제약조건이 걸려있는 칼럼은 반드시 직접 값을 제시해야함.(PRIMARY KEY도마찬가지).
                다만 DEFAULT 설정이 되어있다면 NOT NULL이라고 해도 선택 안해도됨.

*/
INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES (224,'우경우','980508-1234567','D2','J2','S5',SYSDATE);
/*
    CASE 3 : INSERT INTO 테이블명(서브쿼리)
        =>서브쿼리로 조회한 결과값을 통째로 INSERT 하는 구문
        즉 여러행을 한번에 INSERT할수있다.    
*/

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);
--전체 사원들의 사번 이름 부서명을 조회한 결과를 EMP01테이블에 통째로 추가
INSERT INTO EMP_01 
(
    SELECT
        emp_id,
        emp_name,
        dept_title
    FROM EMPLOYEE_COPY
    LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
);
/*
    INSERT ALL 계열
        두개이상의 테이블에 각각 INSERT 할때 사용
        조건 : 그때 사용되는 서브쿼리가 동일해야 한다.
        1)INSERT ALL
            INTO 테이블명1 VALUES()
            INTO 테이블명2 VALUES()
            서브쿼리;
        


*/
--새로운 테이블 만들기
--첫번쨰 테이블 : 급여가 300만원ㅇ ㅣ상인 사원들의 사번 , 사원명 ,직급명 보관할 테이블
-- 테이블명 : EMP_JOB /EMP_ID, EMP_NAME,JOB_NAME

CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(30)
);

--두번째 테이블 : 급여가 300만원 이상인 사원들의 사번 ,사원명 부서명 보관할 테이블
--테이블명 :EMP_DEPT / EMP_ID, EMP_NAME DEPT_TITLE
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(30)
);


INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_TITLE)
    INTO EMP_JOB VALUES(EMP_ID,EMP_NAME,JOB_NAME)
        SELECT 
        EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
        FROM EMPLOYEE
        LEFT JOIN JOB USING (JOB_CODE)
        LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
        WHERE SALARY>3000000;
        
/*
   2) INSERT ALL
        WHEN 조건1 THEN
            INTO 테이블명 1 VALUES(칼럼명1,칼럼명2)
        WHEN 조건2 THEN
            INTO 테이블명 2 VALUES (칼럼명1,칼럼명2)

        TJQMZNJFL
*/


--조건을 사용해서 각 테이블에 값 INSERT
--새로운 테스트용 테이블 생성
--2010년도 기준으로 이전 입사한 사원ㄷ르이 사번 사원명 입사일 급여를 담는 테입르 EMP_OLD
    CREATE TABLE EMP_OLD
    AS SELECT
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
        FROM EMPLOYEE
        WHERE 1=0;
--2010년도 기준으로 이후 입사한 사원ㄷ르이 사번 사원명 입사일 급여를 담는 테입르 EMP_NEW
CREATE TABLE EMP_NEW
    AS SELECT
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
        FROM EMPLOYEE
        WHERE 1=0;
        
        
        SELECT 
            
            EMP_ID,
            EMP_NAME,
            HIRE_DATE,
            SALARY
        FROM EMPLOYEE
        WHERE HIRE_DATE<'2010/01/01';
--        WHERE HIRE_DATE>='2010/01/01'
        
        
        INSERT ALL
            WHEN HIRE_DATE<'2010/01/01' THEN
                INTO EMP_OLT VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
            WHEN HIRE_DATE>='2010/01/01' THEN
                INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
        SELECT
            emp_id,
            emp_name,
            hire_date,
            salary
        FROM EMPLOYEE;


/*
    2.UPDATE
    테이블에 기록된 기존의 데이터를 '수정'하는 구문
    [표현법]
    UPDATE 테이블명
    SET 컬럼명 = 바꿀값,
        컬럼명 = 바꿀값,
        컬럼명 = 바꿀값,
        컬럼명 = 바꿀값(여러개 변경가능)
    WHERE 조건 생략가능하나 생략하면 모든 행의 값이 다 바뀐다.
    

*/
    UPDATE EMPLOYEE_COPY
        SET EMP_ID=EMP_ID+10;
--이렇게 일괄 수정도 가능하네[?        
    CREATE TABLE DEPT_COPY
        AS SELECT * FROM DEPARTMENT;
    --DEPT_COPY TABLE에서 D9인 부서명을 전략 기획팀으로수정
    UPDATE DEPT_COPY
    SET DEPT_TITLE ='전량기획팀'
    WHERE DEPT_ID='D9';
    --전채 행의 모든 DEPT_TITLE 이 전략기획팀으로 수정되어있음
    
    ROLLBACK; --변경사항에 대해서 되돌리는 명령어 : ROLLBACK;
    
    SELECT
        *
    FROM DEPT_COPY;
    
    
    --복사본 테이블
    --EMPLOYEE 테이블로 부터 EMP_ID,EMP_NAME , DEPT_CODE,SALARY,BONUS(값까지 복사)
        
    --EMP_SALARY
        CREATE TABLE EMP_SALARY
            AS SELECT  emp_id,emp_name,dept_code,salary,bonus
                FROM EMPLOYEE;
        SELECT * FROM EMP_SALARY;
    --노옹철 급여를 1000만원으로
        UPDATE EMP_SALARY
            SET SALARY=10000000
            WHERE EMP_NAME='노옹철';
    --성동일 급여를 7000000 보너스 0.2로변경
        UPDATE EMP_SALARY
            SET SALARY=7000000,
                BONUS=0.2
            WHERE EMP_NAME='선동일';
    --전체사원의 급여를 기존의 20프로 인상한 급액 변경
        UPDATE EMP_SALARY
            SET SALARY=SALARY*1.2;
        --EMAIL 주소 @GAMAIL.COM으로 통일
        CREATE TABLE EMP_EMAIL
            AS SELECT  emp_id,emp_name,email
                FROM EMPLOYEE;
        SELECT * FROM EMP_email;
        UPDATE EMP_EMAIL
            SET EMAIL= CONCAT(RPAD(EMAIL,INSTR(EMAIL,'@')),'gmail.com');
    /*
        UPDATE시에 서브쿼리 사용 : 서브쿼리를 수행한 결과값으로 기존의 값으로부터 변경하겠다.
        -CREATE 시에 서브쿼리 사용 : 서브쿼리를 수행한 결과를 테이블 만들때 넣어버리겠다.
        -INSERT 시에 서브쿼리 사용 : 서브쿼리를 수행한 결과를 해당 테이블에 삽입하겠다.
        
        [표현법]
        UPDATE 테이블명
        SET 컬럼명 = (서브쿼리)
        WHERE 조건;

    */
        -- EMP_SALARY 테이블에 민경민 사원의 부서코드를 선동일 사원의 부서코드로 변경
        -- 민경민 사원의 부서코드 =D1 , 선동일 사원의 부서코드 D9
        
    UPDATE EMP_SALARY
        SET DEPT_CODE=(
                    SELECT 
                        DEPT_CODE 
                    FROM EMP_SALARY
                    WHERE EMP_NAME='선동일'
            )
        WHERE EMP_NAME='민경민';
        
     SELECT * FROM EMP_SALARY;
            
        --박명수 사원의 급여와,보너스를 유재식 사원의 급여와 보너스 값으로 변경
    UPDATE EMP_SALARY
        SET (SALARY,BONUS) = (--IN 이 아니라 =으로 삽입하네?
                    SELECT
                        SALARY,
                        BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME='유재식'
                )
        WHERE EMP_NAME='방명수';
    
    --UPDATE 주의사항: 기존에 세팅된 제약사항은 지켜야된다.
    
    --EMPLOYEE 테이블에서 송종기 사원의 사번을 200으로 변경
    UPDATE EMPLOYEE
        SET EMP_ID=200
        WHERE EMP_NAME='송종기'; --unique constraint (KH.EMPLOYEE_PK) violated
    UPDATE EMPLOYEE
        SET EMP_ID=NULL
        WHERE EMP_ID=200; --PK 라 NOT NULL조건 위배다.
    -- 모든 변경사항을 확정짓는 명령어 : COMMIT;
    -- 오라클에서 DB를 변경하고 자바에서 바로뺴다쓰면 값이 없다고 나올것
    --그떄 COMMIT을 해주면된다.
    COMMIT;
    
    
    
    /*
        테이블에 기록된 데이터를 "행"단위로 삭제하는 구문.
        [표현법]
        
        DELETE FROM 테이블 명
        WHERE 조건; ---WHERE 생략가능. 생략시 모든행 삭제
           
    */
    --EMPLOYEE행에서 모든 행 삭제
    
    DELETE FROM EMPLOYEE;
    SELECT * FROM EMPLOYEE;
    ROLLBACK;-->마지막으로 커밋한 시점
    
    -- EMPLOYEE 테이블에서 민경민 경민2 사원의 정보를 지우기
    DELETE FROM EMPLOYEE
    WHERE (EMP_NAME='민경민'OR EMP_NAME='우경우');
    --DELETE 할때 OR를 잘못쓰면 잘못날라갈수도 있으니 괄호로 조심하자
    
    --DEPARTMET 테이블로부터 DEPT_ID 가 D1인 부서 삭제
    DELETE FROM DEPARTMENT
    WHERE DEPT_ID='D1';
    --만약에 EMPLOYEE 테이블ㅇ의 DEPT_CODE컬럼에서 외래키로 참조하고 있을경우
    --삭제가 되지 않았을것이다, 삭제가 되었다는 말은 즉 외래키로 사용하고 있지 않다.
    
    
    /*
        TRUNCATE : 테이블의 전체 행을 모두 삭제할때 사용하는 구문(절삭)
                    DELETE구문보다 수행속도가 빠름
                    별도의 조건제시 불가
                    ROLLBACK이 불가능함
        [표현법]
        TRUNCATE TABLE 테이블명;
        
        DELETE 구문과 비교
            TRUNCATE TABLE 테이블명         DELETE TABLE 테이블명
            ---------------------------------------------------
            별도의 조건 제시 불가 (WHERE X)   특정조건제시가능(WHERE O)
            수행속도가 빠름                    수행속도가 느림
            ROLLBACK 불가                    ROLLBACK 가능
    
    */
    
    SELECT * FROM EMP_SALARY;
    DELETE FROM EMP_SALARY;
    ROLLBACK;
    TRUNCATE TABLE EMP_SALARY;--잘렸습니다라는 말이나오고 삭제됨?
    
    
    
    
    
    
    
    