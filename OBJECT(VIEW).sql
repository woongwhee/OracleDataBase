/*
    OBJECT
    데이터 베이스를 이루는 논리적 구조물들
    
    OBJECT종류
    - TABLE, USER, VIEW , SEQUENCE, INDEX , FUNCTION , TRIGGER, PROCEDURE
    
    <VIEW 뷰>
    
    SELECT 문을 저장해 둘 수 있는 객체
    (자주 쓰이는 SELECT문을 VIEW에 저장해두면 매번 긴 SELECT문을 다시 기술할 필요가 없음)
    ->조회용 임시테이블 같은존재(문자열형테로 ㅓㅈ장)

*/
--한국에서 근무하는 사원들의 사번 이름 부서명 급여 금무국가명 직급명 조회하세요
--ANSI
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE,
    SALARY,
    NATIONAL_NAME AS 근무국가명,
    JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID=DEPT_CODE
JOIN LOCATION ON LOCATION_ID=LOCAL_CODE
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN JOB USING (JOB_CODE)
WHERE NATIONAL_CODE='KO';
--ORACLE
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE,
    SALARY,
    NATIONAL_NAME
FROM EMPLOYEE E,DEPARTMENT,LOCATION L,JOB J,NATIONAL N
WHERE DEPT_ID=DEPT_CODE AND LOCATION_ID=LOCAL_CODE 
AND L.NATIONAL_CODE='KO' AND E.JOB_CODE=J.JOB_CODE AND L.NATIONAL_CODE=N.NATIONAL_CODE;

----------------------
/*
    1. VIEW 생성방법
    [표현법]
    CREATE VIEW 뷰명
    AS 서브쿼리;
    
 
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE AS
    SELECT
        EMP_ID,
        EMP_NO,
        BONUS,
        EMP_NAME,
        DEPT_TITLE,
        SALARY,
        NATIONAL_NAME,
        JOB_NAME
    FROM EMPLOYEE E,DEPARTMENT,LOCATION L,JOB J,NATIONAL N
    WHERE DEPT_ID=DEPT_CODE AND LOCATION_ID=LOCAL_CODE  AND E.JOB_CODE=J.JOB_CODE AND L.NATIONAL_CODE=N.NATIONAL_CODE;
--권한을 안줬네?

SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='한국';
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='일본';
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='중국';
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='러시아';
--근무지가 러시아인 사원들의 이름 사번 직급명 보너스

SELECT EMP_NAME,EMP_NO,NATIONAL_NAME, JOB_NAME,BONUS FROM VW_EMPLOYEE WHERE NATIONAL_NAME='러시아';
SELECT EMP_NAME,EMP_NO,NATIONAL_NAME, JOB_NAME,BONUS FROM VW_EMPLOYEE WHERE NATIONAL_NAME='러시아';
--뷰에 없는 컬럼을 조회하고자 하면 새롭게 만들어야됨.


/*
    산술연산식있으면 반드시 별칭지정을 해줘야 된다.
*/
--사원의 사번 이름 직급명 성별 근무년수를 조회 있는 SELECT VIEW로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB AS
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여'),
    FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

--must name this expression with a column alias"
--별칭지정을 안했다고 에러뜸

CREATE OR REPLACE VIEW VW_EMP_JOB AS
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME AS 직급명,
    DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') AS 성별,
    FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) AS 근속연수
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

SELECT * FROM VW_EMP_JOB;
SELECT 성별,EMP_NAME,근속연수,JOB_NAME FROM VW_EMP_JOB;
--별칭지정한 그대로 들고 와야됨




---별칭부여하는 또다른 방법
--이방법은 대신 모든 컬럼에 대해 별칭을 지정해 주어야 한다.
CREATE OR REPLACE VIEW VW_EMP_JOB(사번,이름,직급명,성별,근속년수)AS
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여'),
    FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

select 사번,이름,직급명,성별,근속년수 from vw_emp_job;
select 사번,이름,직급명,성별,근속년수 from vw_emp_job where  근속년수>20;

DROP VIEW VW_EMP_JOB;

SELECT * FROM USER_VIEWS;


--사용가능하다.(권장하진않음)
/*
    *INSERT , UPDATE, DELETE
    * 생성된 뷰를 이용해서 DML 사용가능 뷰를 조작하는게 아닌 뷰에 사용된 테이블을 조작하는 개념
    주의사항 : 뷰를 통해서 조작하게 된다면 , 데이터가 담겨있는 테이블에도 변경사항이 적용된다.

*/

CREATE VIEW VW_JOB AS
    SELECT * FROM JOB;
    
    SELECT * FROM JOB;
    
INSERT INTO VW_JOB VALUES('J8','인턴');

SELECT * FROM VW_JOB;
SELECT * FROM JOB;--잡테이블의 내용도 변경되었다.
--VW_JOB 뷰에 JOB_CODE= J8인 JOB_NAME ='알바'로 업데이트
UPDATE VW_JOB
    SET JOB_NAME = '알바'
    WHERE JOB_CODE='J8';
DELETE VW_JOB
    WHERE JOB_CODE='J8';
----------------------------
/*
    DML이 가능한 경우 : 서브쿼리를 이용해서 기존의 테이블을 별도의 처리없이 복제하고자 할 경우.
    
    
    
    1. 뷰에 정의되어 있지 않은 컬럼을 조작하는경우.
    2. GROUP BY 되어 있는 경우.
    3. JOIN 되어 있는 경우.
*/
--1) 뷰에 정의되어있지 않은 컬럼을 조작하는경우

CREATE OR REPLACE VIEW VW_JOB
    AS SELECT JOB_NAME FROM JOB;

INSERT INTO VW_JOB VALUES('J8','인턴');--too many values

UPDATE VW_JOB
    SET JOB_NAME = '인턴'
    WHERE JOB_CODE='J8'; --"%s: invalid identifier"

--2) 뷰에 정의되어있지 않은 컬럼중에 베이스테이블 상에 NOT NULL 제약조건이 정의된 경우
CREATE OR REPLACE VIEW VW_JOB
    AS SELECT JOB_NAME FROM JOB;
INSERT INTO VW_JOB VALUES('인턴');--cannot insert NULL into ("KH"."JOB"."JOB_CODE")
--VIEW 에 PK 나 NOTNULL 제약조건의 값이 없기떄문에 수정불가

--UPDATE
UPDATE VW_JOB
    SET JOB_NAME='알바'
    WHERE JOB_NAME='인턴';
--가능
ROLLBACK;
--DELETE 
    DELETE VW_JOB
         WHERE JOB_NAME='대리';
--FOREIN KEY 가 설정되어있는 경우  에러발생 삭제되는게 맞다

--3) 산술연산식 또는 함수를 통해서 정의되어 있는 뷰의 경우.
CREATE OR REPLACE VIEW VW_EMP_SAL
    AS SELECT
        EMP_NO,
        EMP_ID,
        EMP_NAME,
        SALARY,
        JOB_CODE,
        SAL_LEVEL,
        SALARY*12 AS 연봉
        FROM EMPLOYEE;
SELECT *FROM VW_EMP_SAL;        
INSERT INTO VW_EMP_SAL VALUES(400,'민경민',300000,30000000);--virtual column not allowed here" 가상칼럼은 INSERT시 사용 할 수 없다.
INSERT INTO VW_EMP_SAL (EMP_NO,EMP_ID,EMP_NAME,SALARY,JOB_CODE,SAL_LEVEL)VALUES('997979-1354566','400','민경민',300000,'J7','S1');
--UPDATE 는 산술연산식이 이쓴 경우 사용불가
--함수에선 WHERE절로 사용가능

--4) 그룹함수 혹은 GROUP BY 절이 포함된 경우
CREATE OR REPLACE VIEW VW_GROUPDEPT
    AS SELECT DEPT_CODE,SUM(SALARY) AS 합계,FLOOR(AVG(SALARY)) AS 평균급여 FROM EMPLOYEE
    GROUP BY DEPT_CODE;
    
SELECT * FROM VW_GROUPDEPT;
--INSERT
INSERT INTO VW_GROUPDEPT VALUES('D3',
33333,55555); --안됨
--UPDATE DELETE 모두 에러남
UPDATE VW_GROUPDEPT
    SET DEPT_CODE ='D0'
    WHERE 합계=6986240;
--5) DISTINCT 구문이 포함된 경우.

CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;
--INSERT UPDATE DELETE 뭘하던 에러남.

--6) JOIN 을 이용해 여러 테이블을 매칭시켜 놓은 경우.

CREATE OR REPLACE VIEW VW_JOIN
AS SELECT EMP_ID,EMP_NAME,JOB_NAME FROM EMPLOYEE JOIN JOB USING (JOB_CODE);

SELECT * FROM VW_JOIN;

INSERT INTO VW_JOIN VALUES (300,'경민','대리');--안됨
--이름변경 가능
UPDATE VW_JOIN
    SET EMP_NAME = '민경민'
    WHERE EMP_ID = '200';
UPDATE VW_JOIN
    SET JOB_NAME='인턴'
    WHERE EMP_ID ='200';
UPDATE VW_JOIN
    SET EMP_ID ='200'
    WHERE JOB_NAME='인턴';
--VIEW에 기준테이블의 KEY가 보관된다 때문에 기준테이블만 업데이트가능
--조건절에는 KEY가 보관되지 않은 컬럼은 사용가능


--DELETE
DELETE VW_JOIN
    WHERE EMP_ID=200;
    --잘됨
DELETE VW_JOIN
    WHERE JOB_NAME='대리';
    --잘됨
ROLLBACK;


/*
   옵션
    1.OR REPLACE : 같은 이름의 뷰가 있으면 대체하고 없으면 새로생성함.
    2.FORCE/NOFORCE 옵션: 실제 테이블이 없어도 VIEW를 먼저 생성할수 잇게 해주는 옵션.
    CREATE OR REPLACE NOFORCE(기본값)
*/
CREATE FORCE VIEW V_FORCETEST
    AS SELECT A,B,C FROM NOTHINGTEST;
--존재하지 않는 테이블에 대한 VIEW가 생성이 가능해진다
SELECT * FROM V_FROCETEST;
--에러 발생 테이블 생성하기 전엔 조회
CREATE TABLE NOTHINGTEST(
    A NUMBER,
    B NUMBER,
    C NUMBER
);

SELECT * FROM V_FROCETEST;

--3.WITH CHECK OPTION
--SELECT 문의 WHERE 절에서 사용한 컬럼을 수정하지 못하게 하는 옶션
CREATE OR REPLACE NOFORCE VIEW V_CHECKOPTION
AS SELECT EMP_ID,EMP_NAME,SALARY,DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE='D5' WITH CHECK OPTION;
    
UPDATE V_CHECKOPTION
    SET DEPT_CODE='D9'
    WHERE EMP_ID= 215;--에러
UPDATE V_CHECKOPTION
    SET SALARY=8000000
    WHERE EMP_ID= 215;--이건또 가능
    ROLLBACK;
    
--4)WITH READ ONLY
--VIEW 자체를 수정하지 못하게 차단하는 옵션.
--보통 이렇게 많이씀
CREATE OR REPLACE VIEW V_READ
    AS SELECT EMP_ID,EMP_NAME,SALARY,DEPT_CODE
    FROM EMPLOYEE WHERE DEPT_CODE='D5'
    WITH READ ONLY;
SELECT * FROM V_READ;

UPDATE V_READ SET SALARY =0 WHERE DEPT_CODE=215;
--Cannot perform a DML operation on a read-only view

