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
    NCODE KH.NATIONAL.NATIONAL_CODE%TYPE;
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