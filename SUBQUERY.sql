/*
    <SUBQUERY 서브쿼리>
    
    하나의 주된 SQL(SELCT, CREATE ,INSERT, UPDET, ....) 안에 포함된 또 하나의 SELECT 문.
    
    메인 SQL문을 위해서 '보조' 역할을 하는 SELECT문.
    ->주로 조건절(WHERE, HAVING)안에서 쓰인다.
    ->()안에 쓰인다.

*/
---노옹철사원과 같은 부서인 사원들.
--1)노옹철 사원의 부서찾기
SELECT
    dept_code
FROM EMPLOYEE
WHERE EMP_NAME='노옹철';
--D9
--2) 1에서 찾은 부서코드와 일치하는 사원들을 찾기
SELECT
    *
FROM EMPLOYEE
WHERE DEPT_CODE='D9';    
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE=(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME ='노옹철');
--서브쿼리문을 이용하면 간단하게 쓸수있다.
SELECT
    EMP_ID,
    emp_name,
    job_code,
    SALARY
FROM EMPLOYEE
WHERE SALARY>(SELECT AVG(SALARY) FROM EMPLOYEE);
--단일행렬서브쿼리라고 한다 드래그해서 실행하면 결과값을 볼수있다.
/*
    서브쿼리 구분
    서브쿼리를 수행한 결과값이 몇행몇열이냐에 따라 구분됨
    -단일행 (단일열)서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개일때 (한칸의 컬럼값으로 나올때)
    -다중행(단일열)서브쿼리 (단일행)다중열 서브쿼리: 수행결과가 여러개지만 1줄짜리일때
    다중행 다중열 : 서브쿼리를 수행한 결과값이 여러행 여러열일때.(FROM절에 기술가능)
    서브쿼리의 구분에따라 사용가능한 연산자가 달라짐.   
*/

/*
    단단서브쿼리(single row subquery):결과값이 오로지 1개일때
    일반연산자 사용가능 (=,!=,>,<)

*/
--전직원의 평균급여 보다 적게 받는 사원들의 사원명 직급코드 급여조회
    SELECT 
        emp_name, 
        job_code,
        salary
    FROM EMPLOYEE
    WHERE SALARY< (SELECT AVG(salary)FROM EMPLOYEE);
    

--최저급여를 받는 사원들의 사번 사원명 직급코드 급여 입사일 조회
    SELECT
        emp_id,
        emp_name,
        job_code,
        hire_date
    FROM EMPLOYEE
    WHERE SALARY=(SELECT min(salary)FROM EMPLOYEE);

--노옹철의 급여보다 더받는 사원들의 사번 이름 부서코드 급여 조회
    SELECT
        EMP_NAME,
        JOB_CODE,
        SALARY
    FROM EMPLOYEE
    WHERE SALARY<(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');
    SELECT
        EMP_NAME,
        SALARY-(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME ='노옹철') --사칙연산도 된다.
    FROM EMPLOYEE;
-- 노옹철보다 더받는 사원들의 이름 부서명 급여조회
      SELECT
        EMP_NAME,
        JOB_CODE,
        SALARY,
        DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
    WHERE SALARY>(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');
    
    --부서별 급여 합이 가장큰 부서 하나만을 조회 부서코드 부서명 급여의합,
    SELECT
        DEPT_CODE,
        DEPT_TITLE,
        SUM(SALARY)
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
    GROUP BY DEPT_CODE ,DEPT_TITLE
    HAVING SUM(SALARY)=(SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);
    --대치되는 컬럼이라도 그룹으로 확실히 묶어주지않으면 사용할 수없다.
    /*
    다중행 서브쿼리(MULTI ROW SUBQUERY)
        서브쿼리의 조회 결과값이 여러행일 경우 사용한다.
        - IN() 서브쿼리 :여러개의 결과값중에 하나라도 일치하는 것이 있다면 /NOT IN 없다면
        
        - > ANY() 서브쿼리: 여러개의 결과값중에 "하나라도"클경우 즉  여러개의 결과값중에서 가장작은 값보다 클경우
        - < ANY() 서브쿼리:여러개의 결과값중에 "하나라도"작을경우 즉  여러개의 결과값중에서 가장큰은 값보다 작을경우
        
        - > ALL()서브쿼리 : 여러개의 결과값의 모든 값보다 클경우
                        즉여러개의 결과값중에서 가장 큰 값보다 클경우 
    */
--각부서별 최고급여를 받는 사원의 이름 , 직급코드 , 급여 조회

--1)각부서별로 최고급여 조회(여러행 , 단일열)
    (SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE);

--2) 위급여를 바탕으로 사원들 조회
    SELECT
        EMP_NAME,
        JOB_CODE,
        SALARY
    FROM EMPLOYEE
    WHERE SALARY IN (SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE);
    
--아마 그룹별로 일치하는 값을 저장후 거기랑 일치하는 값들과 일치하면 뽑아먹는다는 식인듯? GROUPBY는 일반 컬럼과 사용을못하니까

---------------------------------------------------------------------
--선동일 또는 유재석 사원과 같은 부서인 사원들을 조회하시오(사원명 ,부서코드 , 급여)
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE IN (
SELECT dept_code FROM EMPLOYEE WHERE EMP_NAME IN('선동일','유재식')
);
--이오리 또는 하동운과 같은 직급인 사원들을 조회하시오(사원명, 직급코드 부서코드 급여)
SELECT
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE IN(
    SELECT
        job_code
    FROM EMPLOYEE
    WHERE EMP_NAME IN ('이오리','하동운')
);
--대리인데 과장급여보다 많이받는 사원들을 조회(이름 사번 직급 급여)
    SELECT 
        emp_name,
        emp_id,
        dept_CODE,
        salary
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    WHERE JOB_NAME = '대리' AND SALARY >ANY(SELECT salary
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    WHERE JOB_NAME='과장');


-- 과장 직급임에도 "모든 " 모든 차장직급의 급여보다도 더 많이 받는 직원 조회(
--사번,이름 직급명 ,급여)
    SELECT
        EMP_ID,
        EMP_NAME,
        JOB_NAME,
        SALARY
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    WHERE JOB_NAME='과장' 
    AND SALARY >ALL(SELECT SALARY FROM EMPLOYEE E
    JOIN JOB J ON J.JOB_CODE=E.JOB_CODE WHERE JOB_NAME='차장');
    SELECT
        EMP_ID,
        EMP_NAME,
        JOB_NAME,
        SALARY
        FROM EMPLOYEE E,JOB J
        WHERE J.JOB_CODE=E.JOB_CODE 
        AND J.JOB_NAME='과장'
        AND SALARY > (SELECT 
        MAX(SALARY) FROM EMPLOYEE E,JOB J 
        WHERE E.JOB_CODE =J.JOB_CODE AND JOB_NAME ='차장' GROUP BY J.JOB_CODE,JOB_NAME );
   
    SELECT
        EMP_NAME,
        JOB_NAME
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    ORDER BY 2;
        
    --다중열 서브쿼리
    --칼럼의 개수가 여러개라면?
    --하이유 사원과 같은 부서코드 같은 직급코드에 해당되는 사원들 조회(사원명, 부서코드 ,직급코드, 고용일)
    --
    
    
    SELECT 
        emp_name,
        dept_code,
        job_code,
        hire_date
    FROM EMPLOYEE
    WHERE (DEPT_CODE,JOB_CODE) IN(SELECT DEPT_CODE,JOB_CODE FROM EMPLOYEE WHERE EMP_NAME='하이유'
    );
    --4) 단일행 다중열 서브쿼리로 바꾸기
    --[표현법] (비교할 대상 컬럼1, 비교한 대상 컬럼2)=비교한 값 1, 비교할 값2=>서브쿼리 형식으로 제시
    
    -- 박나라 사원과 같은 직급코드 같은사수사번을 가진 사원들의 사번 이름 직급코드 사수사번 조회
    SELECT 
        emp_name,
        emp_id,
        job_code,
        manager_id
    FROM EMPLOYEE
    WHERE (MANAGER_ID,JOB_CODE) IN(SELECT MANAGER_ID,JOB_CODE FROM EMPLOYEE WHERE EMP_NAME='박나라');
    
    --서브 쿼리 조회결과가 여러행 여러열인경우
    --각직급별 최소급여를 받는 사원들 조회(사번,이름 , 직급코드,급여)
   SELECT
        emp_id,
        emp_name,
        job_code,
        salary
    FROM EMPLOYEE
    --WHERE (JOB_CODE,SALARY) = (('J2',3700000));
    WHERE (JOB_CODE,SALARY) IN (('J2',3700000), ('J1',	8000000),('J3'	,3400000),('J5'	,2200000),('J6',2000000),('J7',	1380000),('J4',1550000));
    
    
    SELECT
        emp_id,
        emp_name,
        job_code,
        salary
    FROM EMPLOYEE
    WHERE (JOB_CODE,SALARY) IN (
        SELECT
            job_code,
        MIN(SALARY
        )
    FROM EMPLOYEE
    GROUP BY JOB_CODE);    
    
   
--각부서별 최고급여를 받는 사원들 조회 (사번 ,이름 ,부서 코드,급여)
--부서가없을 경우 없음이라는 부서로 통일해서 조회
    SELECT
        nvl(dept_code,'없음')as 부서,
        emp_id,
        emp_name,
        salary
    FROM EMPLOYEE
    WHERE (NVL(DEPT_CODE,'없음'),SALARY) IN(SELECT NVL(DEPT_CODE,'없음'), MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE)
    ORDER BY 1;
    
    
    /*
    
        5. 인라인 뷰 (INLINE VIEW)
        FROM절에 서브쿼리를 제시하는것
    */
--BONUS 포함 연봉이 3천만원 이상인 사원들의 사번,이름,보너스포함 연봉,부서코드를 조회.
    SELECT
        emp_id,
        emp_name,
        salary*(nvl(bonus,0)+1)*12 "보너스포함 연봉"
    FROM EMPLOYEE
    WHERE (SALARY*(NVL(BONUS,0)+1)*12)>=30000000;
    --인라인뷰를 사용해 사원명만 골라내기
    SELECT
        EMP_NAME
    FROM( 
        SELECT
            emp_id,
            emp_name,
            salary*(nvl(bonus,0)+1)*12 "보너스포함 연봉",
            dept_code
        FROM EMPLOYEE
        WHERE (SALARY*(NVL(BONUS,0)+1)*12)>=30000000
        ) B
    WHERE B.DEPT_CODE IS NULL;
-- 인라인뷰를 주로 사용하는 예
-- TOP- N 분석 : 데이터베이스 상에 있는 자료중 최상위 N개 자료를 보기위해 사용하는 기능.


--전직워중에 급여가 가장높은 상위 5명(순위,사원명,급여)
--*ROWNUM :오라클에서 제공해주는 칼럼, 조회된 순서대로 1부터 순번을 부여해주는 칼럼
    
SELECT
    ROWNUM,
    emp_name,
    salary
FROM EMPLOYEE
WHERE ROWNUM<=5
ORDER BY SALARY DESC;
--해겨랑법 : ORDER BY로 정렬한 테이블을 가지고 ROWNUM순번을 부여후 5등까지만 추림.
SELECT
    ROWNUM,
    EMP_NAME,
    SALARY
FROM (
    SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
WHERE ROWNUM<=5;

--각 부서별 평균급여가 높은 3개의 부서의 부서코드 평균급여를 조회

SELECT 
    ROWNUM,
    --D.부서,
    --평균급여
    --FLOOR(AVG(SALARY)) 함수로 인식해 오류가 난다
    --"FLOOR(AVG(SALARY))" 컬럼명 자체를 변수명으로 인식하는 구조라 ""로 감싸줘도 문자열로 변환해 사용이 가능하다.
    D.* --이것도 된다고?
FROM(
    SELECT
        NVL(DEPT_CODE,'없음') AS 부서,
        FLOOR(AVG(SALARY)) AS 평균급여
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY 2 DESC
    ) D
WHERE ROWNUM<=3;
    
--ROWNUM은 컬럼을 이용해서 순위를 매길수있다.
--다만 정렬이 되지않은상태로 순위를 매기면 ORDER BY가 WHERE문보다 늦게 실행되기때문에 순위가 의미가 없게된다.
--선 정렬후 순위를 매기기를 해야한다. ->우선적으로 인라인뷰로  ORDER BY 정렬을 하고,메인쿼리에서 순번을 붙인다.


-- 가장 최근에 입사한 5명 조회(사원명,급여 , 입사일)
--입사일 기준 미래~과거(내림차순),순번 부여후 5명

SELECT
    ROWNUM,
    D.*
FROM(
    SELECT emp_name,salary,hire_date
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
    )D
WHERE ROWNUM<=5;


--SUBCURRY의 마지막

/*
    6. 순위 매기는 함수(WINDOW FUNCTION)
    
    RANK() OVER(정렬 기준): 공동 1위가 3이라고 하면 다음순위는 4로 하겠다
    DENSE_RANK() OVER (정렬 기준): 공동1위기ㅏ 3이라고하면 그 다음순위는 2로하겠다
    
    정렬기준 : ORDER BY (정렬기준 컬럼명,오름차순,내림차순),NULLS FIRST /NULLS LAST는사용불가
    SELECT절에서만 기술가능.
*/

-->>사원들의 급여가 높은대로 순위를 매겨 사원명 , 급여 ,순위, 조회 :RANK() OVER

SELECT
    EMP_NAME,
    SALARY,
    RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
-->>사원들의 급여가 높은대로 순위를 매겨 사원명 , 급여 ,순위, 조회 :DENSE_RANK() OVER
SELECT
    EMP_NAME,
    SALARY,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;

--WINDOW FUNCTION은 WHERE절에서 사용하면 사용불가
SELECT
    EMP_NAME,
    SALARY,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE
WHERE DENSE_RANK() OVER(ORDER BY SALARY DESC)<5;--
--> 인라인뷰를 사용해 조회

SELECT
    e.*
FROM(
    SELECT
        emp_name,
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS "순위"
    FROM EMPLOYEE
    )E
WHERE 순위>=10 ;





