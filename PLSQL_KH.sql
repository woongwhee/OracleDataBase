/*
    <PL/SQL>
    PROCEDURE LANGUAGE EXENSION TO SQL
    
    오라클 자체에 내장되어있는 절차적 언어
    SQL 문장 내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP,FOR,WHILE) , 예외처리등을
    지원하여 SQL의 단점을 보완
    다수의 SQL문을 한번에 실행가능(BLOCK구조)
    
    PL/SQL 구조
    - [선언부 (DECLARE)]: DECLARE로 시작,변수나 상수를 선언 및 초기화하는 부분
    - 실행부 (EXECUTABLE): BEGIN으로 시작 , SQL문 또는 제어문(조건문,반복문)등의 로직을 기술하는 부분,
    -[예외 처리부](EXCEPTION): EXCEPTION으로 시작 예외발생시 해결하기위한 구문을 미리 기술에 둘 수 있는 부분.
    

*/

/*간단하게 화면에 HELLO WORLD 를 출력하기  */

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');

END;
/



/*

    1. DECLARE 선언부
        변수나 상수를 선언하는 공간(선언과 동시에 초기화도가능)
        일반타입변수 래퍼런스변수 ROW타입변수
        
        이반타입변수 선언및 초기화 
        [표현식]
        변수명 [CONSTRANT] W자료형 [:값];
    
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER:=3.14;
BEGIN
    EID:=300;
    ENAME:='민경민';
    
    DBMS_OUTPUT.PUT_LINE('DID:' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME:' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI:' ||PI);

END;
/


/*1-2) 레퍼런스 타입 변수 선언 및 초기화 (어떤테이블의 어떤컬럼의 데이터타입ㅇ르 참조해 그타이븡로 지정)
-- 표현식
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN 
    SELECT
        EMP_ID,EMP_NAME,SALARY
        INTO EID,ENAME,SAL
    FROM EMLOYEE
    WHERE EMP_ID= &사번;
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('EID : '||SAL);
END;
/

-------------------------실습문제----------------------------------------

/*
    레퍼런스 타입 변수로 EID,ENAMEMJCODE,SAL,DTITLED 을 선언하고
    각 자료형 EMPLOYEE(EMP_ID,EMP_NAME,JOB_CODE,SALARY)
        DEPARTMENT(DEPT_TITLE)을참조
        사용자가 입력한 사번인 사원의 사번, 사원명 직급코드 급여 부서명 조회후 변수에 담아서 출력하기

*/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT
        EMP_ID,EMP_NAME,JOB_CODE,SALARY,DEPT_TITLE
    INTO EID,ENAME,JCODE,SAL,DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID=&사번;
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : '||JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : '||DTITLE);
    
END;
/

/*1-3 ROW 타입 변수 선언
    테이블의 한행에 해당하는 모든변수를 담을 수 있는 변수
    [표현식] 변수명 테이블명%ROWTYPE;

*/
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT*
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID=&사번;
    DBMS_OUTPUT.PUT_LINE('사원명 :'||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 :'||E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 :'||NVL(E.BONUS,0)||'%');
 
    

END;
/


------------------------------------------------------------------------------
/*
    2. BEGIN
    <조건문
    1) IF 조건식 THEN 실행내용
*/

--사번 입력받은 후 해당 사우너의 사번 이름 급여 보너스율(%)를 출력
--단 보너스를 받지 않는 사원은 보너스 출력전 보너스를 지급받지 않는 사원입니다.'출력

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN
    
    SELECT EMP_ID,
        EMP_NAME,
        SALARY,
        NVL(BONUS,0)
    INTO EID,ENAME,SAL,BNS
    FROM EMPLOYEE
    WHERE EMP_ID=&사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('월급 : '||SAL);
    IF BNS=0 THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('보너스율 : '|| BNS||'%');

END;
/

/*
    2) IF 조건식 THEN 실행내용 ELSE 실행내용 END IF: (IF~ELSE)


*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN
    
    SELECT EMP_ID,
        EMP_NAME,
        SALARY,
        NVL(BONUS,0)
    INTO EID,ENAME,SAL,BNS
    FROM EMPLOYEE
    WHERE EMP_ID=&사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('월급 : '||SAL);
    IF BNS=0 
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('보너스율 : '|| BNS*100||'%');
    END IF;


END;
/

------------------------------
DECLARE
    --레퍼런스타입변수(EID,ENAME,DTITLE,NCODE)
    -- 참조할 컬럼(EMP_ID,EMP_NAME,DEPT_TITLE,NATIONAL_CODE)
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    DCODE DEPARTMENT.DEPT_ID%TYPE;
    NCODE KH.NATIONAL.NATIONAL_CODE%TYPE; -- NATIONAL이 이미 오라클에서 사용하는 키워드라 에러가 난다
    TEAM VARCHAR2(10);
    -- 일반타입변수(TEAM 가변문자열(10))<=해외팀,국내팀

BEGIN
    --사용자가 입력한 사번의 사원의 사번 이름 부서명 근무국가코드 조회후 각변수에대입
    SELECT
        EMP_ID,EMP_NAME,DEPT_TITLE,NATIONAL_CODE,DCODE
        INTO EID,ENAME,DTITLE,NCODE,DCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
    JOIN LOCATION ON LOCAL_CODE=LOCATION_ID
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE EMP_ID=&사번;
    
    IF NCODE='KO' 
        THEN TEAM:='국내팀';
    ELSE   
        TEAM:='해외팀';
    END IF;
    
    --NCODE 값이 KO인경우 TEAM에 한국팀 대입
    --그게아닐경우 TEAM에 해외팀 대입
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 :'||DTITLE);
    DBMS_OUTPUT.PUT_LINE('근무국가코드 : '||NCODE);
    DBMS_OUTPUT.PUT_LINE(TEAM);
END;
/

DECLARE
    --레퍼런스타입변수(EID,ENAME,DTITLE,NCODE)
    -- 참조할 컬럼(EMP_ID,EMP_NAME,DEPT_TITLE,NATIONAL_CODE)
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE JOB.JOB_CODE%TYPE;
    JNAME JOB.JOB_NAME%TYPE;
    -- 일반타입변수(TEAM 가변문자열(10))<=해외팀,국내팀

BEGIN
    --사용자가 입력한 사번의 사원의 사번 이름 부서명 근무국가코드 조회후 각변수에대입
    SELECT
        EMP_ID,EMP_NAME,J.JOB_CODE,JOB_NAME
        INTO EID,ENAME,JCODE,JNAME
    FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE=J.JOB_CODE
    --JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE EMP_ID=&사번;
    
    
    --NCODE 값이 KO인경우 TEAM에 한국팀 대입
    --그게아닐경우 TEAM에 해외팀 대입
    DBMS_OUTPUT.PUT_LINE('사번 : '||EID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('직급코드 :'||JCODE);
    DBMS_OUTPUT.PUT_LINE('직급명 : '||JNAME);
    
END;
/

-- 3) IF 조건식 THEN 실행내용 ELSIF 조건식2 THEN 실행내용 ...[ELSE] END IF;

--급여가 500이상이면 고급
--급여가 300이상이면 중급
--그외 초급

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT
        EMP_ID,EMP_NAME,SALARY
        INTO EID,ENAME,SAL
    FROM EMPLOYEE
    WHERE EMP_ID=&사번;
IF SAL>5000000 THEN GRADE:='고급';
ELSIF SAL>3000000 THEN GRADE:='중급';
ELSE GRADE:='초급';
END IF;

    DBMS_OUTPUT.PUT_LINE('ENAME:'||ENAME);
    DBMS_OUTPUT.PUT_LINE('EID:'||ENAME);
    DBMS_OUTPUT.PUT_LINE('SALARY:'||SAL);
    DBMS_OUTPUT.PUT_LINE('GRADE:'||GRADE);
    

END;
/
SELECT * FROM EMPLOYEE;

---4 CASE 비교대상자 WHEN 동등비교값1 THEN 결과값1 WHEN 동등비교값2 THEN 결과값2 ELSE 결과값 3 END; -> 
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT * INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID= &사번;
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '인사팀'
                WHEN 'D2' THEN '회계팀'
                WHEN 'D3' THEN '마케팅팀'
                WHEN 'D4' THEN '국내영업팀'
                WHEN 'D9' THEN '총무팀'
                ELSE '해외영업팀'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME||'부서는'||DNAME||'입니다.');
END;
/

-------------------------------------------------------------------------------
--반복문
/*
    1) BASIC LOOP문
    [표현식]
    LOOP
        반복적으로 실행할 구문;
        
        * 반복문을 빠져나갈수 있는 구문
    END LOOP;
    
    * 반복문을 빠져나갈수 있는 구문 (2가지)
    
    1)IF 조건식 THEN EXIT; END IF;
    2) EXIT WHEN 조건식;
*/
-- 1~5까지 순차적으로 1씩 증가하는 값을 출력.

DECLARE
    
    I NUMBER:= 1;
    
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I+1;
        
        EXIT WHEN I=6;
    END LOOP;
END;
/

/*
    2) FOR LOOP문
    FOR 변수 IN 초기값 ... 최종값
    LOOP
        반복적으로 수행할 구문;
        
    END LOOP;
*/
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/


CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
    START WITH 1
    INCREMENT BY 2
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;--시퀀스는 REPLACE가안됨
    
    
BEGIN 
    FOR I IN 1..500
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL,SYSDATE);
    END LOOP;
    
    
    
END;
/


SELECT * FROM TEST;


--3) WHELE LOOP문

/*

    [표현식]
    WHILE 반복문이 수행될 조건
    LOOP
        내가실행할 구문
    END LOOP;
    
*/
DECLARE
    I NUMBER:=1;
    
BEGIN
    WHILE I<1000    
    LOOP DBMS_OUTPUT.PUT_LINE(I);
    I:=I+1;
    END LOOP;
END;
/

/*
    예외처리부
    실행중에 발생하는 오류를 오류
    [표현식]
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문;
        WHEN 예외명2 THEN 예외처리구문;
        WHEN 예외명3 THEN 예외처리구문;
        .....
        WHEN OTERS THEN 예외처리구문
        
        * 시스템예외(오라클에서 미리정의해둔 예외 약20개)
        --NO_DATA_FOUND: SELECT 한행도 없는경우
        --TOO_MANY_ROWS: SELECT 결과가 여러행인경우
        --ZERO_DIVIDE : 0으로 나눌떄
        --DUP_VAL_ON_INDEX : UNIQUE 제약조건에 위배되었을때;
*/
--사용자가 입력한 수로 나눗셈 연산한 결과를 출력
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 1000/&숫자;
    DBMS_OUTPUT.PUT_LINE(RESULT);
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE ('나누기 연산시 0을 사용할수 없습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE ('나누기 연산 오류');    
END;
/
--UNIQUE 제약조건 위배.

BEGIN UPDATE EMPLOYEE
        SET EMP_ID=&사번
        WHERE EMP_NAME='선동일';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
     
BEGIN
    SELECT
        EMP_ID,EMP_NAME
        INTO EID,ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID=&사수사번;
    
    DBMS_OUTPUT.PUT_LINE('후임사번 : '||EID );
    DBMS_OUTPUT.PUT_LINE('후임이름 : '||ENAME );
EXCEPTION
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('너무많 은행이 조회 되었습니다.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
END;
/
--ORA-01422: exact fetch returns more than requested number of rows
--> TOO_MANY_ROWS
--ORA-06512: at line 6 01403. 00000 -  "no data found"
-->NO_DATE_FOUND

---------------------------------실습문제------------------------------------------
--1) 사원의 연봉을 구하는 PL/SQL블럭 작성, 보너스가 있는 사원은 보너스도 포함하여 계산.
-- 출력문 급여 사원이름 연봉 
--NVL버전
DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.EMP_NAME%TYPE;
    YSAL NUMBER;
BEGIN
    SELECT EMP_NAME,SALARY,SALARY*(NVL(BONUS,0)+1)*12 AS 연봉
        INTO ENAME,SAL,YSAL
    FROM EMPLOYEE
    WHERE EMP_ID=&사번;
    
    DBMS_OUTPUT.PUT_LINE('사원명 '||ENAME);
    DBMS_OUTPUT.PUT_LINE('월급 '||SAL);
    DBMS_OUTPUT.PUT_LINE('연봉 '||YSAL);
    
    
END;
/
--조건문 버전
    DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.EMP_NAME%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
    YSAL NUMBER;
BEGIN
    SELECT EMP_NAME,SALARY,BONUS
        INTO ENAME,SAL,BNS
    FROM EMPLOYEE
    WHERE EMP_ID=&사번;
    
    IF BNS IS NULL THEN YSAL := 12*SAL;
        ELSE YSAL := SAL*12*(1+BNS);
        END IF;
    
    DBMS_OUTPUT.PUT_LINE('사원명 '||ENAME);
    DBMS_OUTPUT.PUT_LINE('월급 '||SAL);
    DBMS_OUTPUT.PUT_LINE('연봉 '||YSAL);    
END;
/
--2) 구구단 짝수단 출력
--2-1) FOR LOOP 이용
BEGIN
FOR J IN 2..9 
    LOOP
    IF MOD(J,2)=0 THEN
        DBMS_OUTPUT.PUT_LINE(J||'단');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(J||'*'||I||'='||I*J);
            END LOOP;
            
        END IF;
END LOOP;
END;
/
    
--2-2) WHILE LOOP 사용
DECLARE
    I NUMBER :=2 ;
    J NUMBER :=1;
BEGIN
    WHILE I<10
        LOOP
            IF MOD(I,2)=0
                THEN
                WHILE J<10
                    LOOP
                        DBMS_OUTPUT.PUT_LINE(I||'*'||J||'='||I*J);
                        J:=J+1;
                    END LOOP;
                    
                J:=1;
            END IF;
            I:=I+1;
        END LOOP ;
END;
/

-- 단수 변수를 따로 선언해서 사용
DECLARE 
    INUM NUMBER:=2;
BEGIN
FOR J IN 1..4 
    LOOP
        DBMS_OUTPUT.PUT_LINE(INUM||'단');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(INUM||'*'||I||'='||I*INUM);
            END LOOP;      
        DBMS_OUTPUT.PUT_LINE('');
    INUM:=INUM+2;
END LOOP;
END;
/

--EXIT 활용 해보기
DECLARE 
    INUM NUMBER:=2;
BEGIN

FOR J IN 1..4 
    LOOP
        DBMS_OUTPUT.PUT_LINE(INUM||'단');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(INUM||'*'||I||'='||I*INUM);
            EXIT WHEN INUM*I=12;
            END LOOP;
            
        DBMS_OUTPUT.PUT_LINE('');
    INUM:=INUM+2;
END LOOP;
END;
/
--라벨을 이용한 중첩 루프문 빠저나오기 
DECLARE 
    INUM NUMBER:=2;
BEGIN
<<LOOP_FOR>>
FOR J IN 1..4 
    LOOP
        DBMS_OUTPUT.PUT_LINE(INUM||'단');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(INUM||'*'||I||'='||I*INUM);
            EXIT LOOP_FOR WHEN INUM*I=64;
            END LOOP;
            
        DBMS_OUTPUT.PUT_LINE('');
    INUM:=INUM+2;
END LOOP;
END;
/


--CONTINUE 활용 값 걸러내기;
BEGIN
FOR J IN 2..9 
    LOOP
    IF MOD(J,2)=1 THEN
    CONTINUE;
    END IF;
        DBMS_OUTPUT.PUT_LINE(J||'단');
        FOR I IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE(J||'*'||I||'='||I*J);
            END LOOP;
    END LOOP;
END;
/


SELECT
    EMP_NAME,
    EMP_ID,
    SUM(SALARY) OVER (PARTITION BY DEPT_CODE)
FROM EMPLOYEE

-- PARTITION BY 를 이용하면
-- 서브쿼리를 사용하지 않아 깔끔하다.
