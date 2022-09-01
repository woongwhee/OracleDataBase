/*
    <PROCEDURE>
    PL/SQL 구문을 저장해서 이용하는 객체
    필요할때마다 내가 작성한 PL/SQL문을 편하게 호출 가능하다.
    
    프로시져 생성방법
    [표현식]
    CREATE PROCEDURE 프로시저명[(매개변수)]
    IS 
        BEGIN
        실행코드
        END;
*/

-----EMPLOYEE 테이블에서 모든 칼럼을 복사한 COPYTABLE 생성
---PRO_TEST
CREATE TABLE PRO_TEST AS
    SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE DELETE_DATA
    IS 
    BEGIN
        DELETE FROM PRO_TEST;
        COMMIT;
    END;
/
SELECT * FROM USER_PROCEDURES;

EXEC DELETE_DATA;
SELECT * FROM PRO_TEST;
ROLLBACK;


----프로시저에 매개변수 넣기
-- IN : 프로시져 실행시 필요한 값을 "받는"변수 (자바에서 선언한 매개변수와 동일)
-- OUT: 호출한곳으로 되돌려 "주는" 변수 (결과값)

CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP(
   EID IN EMPLOYEE.EMP_ID%TYPE, 
   ENAME OUT EMPLOYEE.EMP_NAME%TYPE, 
   SAL OUT EMPLOYEE.SALARY%TYPE,
   BNS OUT EMPLOYEE.BONUS%TYPE )
IS
    EMP_DD VARCHAR2(20);
    BEGIN
        SELECT
            EMP_NAME,SALARY,BONUS, EMP_NAME||EMP_NAME
            INTO ENAME,SAL,BNS, EMP_DD
        FROM EMPLOYEE
        WHERE EMP_ID=EID;
        
    END;
/
--> IN 변수는 물론 OUT변수도 제시해 줘야된다.
VAR EMP_NAME VARCHAR2(20);
VAR SALARY NUMBER;
VAR BONUS NUMBER;
EXEC PRO_SELECT_EMP(205,:EMP_NAME,:SALARY,:BONUS);
PRINT EMP_NAME;
PRINT SALARY;
PRINT BONUS;
/*
    프로시져 장점
    1. 처리속도가 빠름(효율적으로 작성했다는 가정하에)
    2. 대량 자료처리시 유리함
    EX) DB에서 대용량의 데이터를 SELECT문으로 받아와서 자바에서 작업하는경우 VS
        DB에서 대용량 데이터를 SELECT한후 자바로 넘기지 않고 직접 처리하는 경우, DB에서 처리하는게 성능이 더 좋다.
        (자바로 데이터를 넘길때 네트워크 비용이 발생하기 때문에)
    프로시져 단점
    1. DB자원을 직접 사용하기 때문에 DB에 부하를 주게됨.(남용하면 안됨)
    2. 관리적 측면에서 자바의 소스코드, 오라클 코드를 동시에 형산관리하기 어렵다.
    
    정리)
    한번에 처리되는 데이터량이 많고 성능을 요구하는 처리는 대체로 자바보다는 DB상에서 처리하는것이 성능적인측면에서 나을것이고
    소스관리(유지보수)측면에서 자바로 처리하는 것이 더 좋다.
*/
------------------------------------------------------------------------------------------------------------------------------

/*
    <FUNCTION>
    프로시져와 유사하지만 실행결과를 반환(돌려)받을 수 있음
    FUNCTION 생성방법
    [표현식]
    CREATE [OR REPLACE] FUNCTION 프로시져명[(매개변수)]
    RETURN 자료형
    IS
    [DECLARE]
    BEGIN
        실행부분
    END;
    /
    
*/

CREATE OR REPLACE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN VARCHAR2
IS
    RESULT VARCHAR2(1000);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_STR);
    RESULT := '<'||V_STR||'>';
    RETURN RESULT;
END;
/

SELECT MYFUNC('민경민') FROM DUAL;

-- EMP_ID를 전달받아 연봉을 계산해서 출력해주는 함수만들기

CREATE OR REPLACE FUNCTION YSAL(EID VARCHAR2) RETURN NUMBER
IS 
    YSALA NUMBER;
BEGIN
    SELECT 
        SALARY*12*(NVL(BONUS,0)+1)
    INTO YSALA
    FROM EMPLOYEE
    WHERE EMP_ID=EID;
    RETURN YSALA;
END;
/
    
    SELECT 
        EMP_NAME AS 이름, 
        YSAL(EMP_ID) AS 연봉
    FROM EMPLOYEE;
COMMIT;


SELECT YSAL((&사번 )) FROM DUAL;

SELECT  YSAL((SELECT EMP_ID FROM EMPLOYEE WHERE EMP_NAME=&사원명 ))AS 연봉 FROM DUAL;
--&사용시 문자열을 받을때 작은따옴표를 ''추가해 줘야된다.

SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE=&사원명; 






