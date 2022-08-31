/*
    <GROUP BY 절>
    
    그룹을 묶어줄 기준을 제시할 수 있는 구문 - > 그룹함수와 같이 쓰임.
    해당 제시된 기준별로 그룹을 묶을수 있음.
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
    
    [표현법]
    GROUP BY 묶어줄 기준이될 칼럼.
*/

SELECT DEPT_CODE, SUM(SALARY) -- 4
FROM EMPLOYEE -- 1
WHERE 1=1 -- 2
GROUP BY DEPT_CODE -- 3
ORDER BY DEPT_CODE -- 5
;

-- D1부서의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE ='D1';

-- 각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여 합을 급여별로 내림차순으로 정렬해서 조회.
SELECT 
    dept_code,
    sum(salary) AS "급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 급여 DESC;

-- 각 직급별로 직급코드 , 총 급여의 합 , 사원수 , 보너스를 받는 사원수, 평균급여 , 최고급여, 최소급여.
-- JOB코듭별로 오름차순정렬
SELECT
    JOB_CODE,
    SUM(SALARY),
    COUNT(*),
    COUNT(BONUS),
    FLOOR(AVG(SALARY)),
    MAX(SALARY),
    MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 각 부서별 부서코드 , 사원수 , 보너스를 받는 사원수 , 사수가 있는 사원수 , 평균급여
-- 부서별 오름차순정렬
SELECT 
    dept_code AS "부서코드",
    COUNT(*) AS "사원수",
    COUNT(BONUS) AS "보너스를 받는 사원수",
    COUNT(MANAGER_ID) AS "사수가 있는 사원수",
    FLOOR(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 성별 별 사원수
--  SUBSTR(EMP_NO,8,1) == 1 ,2
SELECT
    DECODE(SUBSTR(EMP_NO,8,1) ,'1','남','2','여') AS "성별",
    COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

-- 성별 기준으로 성별, 평균급여 , 사원수
-- CASE WHEN구문으로 남자, 여자 
-- 평균급여에 "원"
SELECT  
    CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남자'
         WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여자'
    END AS "성별",
    FLOOR(AVG(SALARY)) || '원' AS "평균급여",
    COUNT(*) AS "사원수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);    

-- 각 부서별 평균급여가 300만원인 이상인 부서들만 조회.
SELECT 
    dept_code,
    FLOOR(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 오류남. 
/*
    <HAVING 절>
    그룹에 대한 조건을 제시하고자할때 사용되는 구문
    (주로 그룹함수를 가지고 조걵제시) => GROUP BY 절과 함께 쓰인다.
*/
SELECT 
    dept_code,
    FLOOR(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING FLOOR(AVG(SALARY)) >= 3000000;

-- 각 직급별로 총 급여합이 1000만원 이상인 직급 코드 , 급여 합을조회.
SELECT
    job_code,
    SUM(salary)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;
-- 각 직급별로 급여 평균이 300만원이상인 직급코드 , 평균급여, 사원수, 최고급여, 최소급여
SELECT -- 5
    job_code,
    FLOOR(AVG(SALARY)) AS "평균급여",
    COUNT(*) AS "사원수",
    MAX(SALARY) AS "최고급여",
    MIN(SALARY) AS "최소급여"
FROM EMPLOYEE -- 1
WHERE 1=1 -- 2
GROUP BY JOB_CODE -- 3
HAVING FLOOR(AVG(SALARY)) >= 3000000 --4
ORDER BY DEPT_CODE -- 6
; 

-- 각 부서별 보너스를 받는 사원이 없는 부서만을 조회.
SELECT
    dept_code,
    COUNT(BONUS) AS "보너스받는 사원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-- 각 부서별 평균 급여가 350만원 이하인 부서만을 조회.
SELECT
    dept_code,
    FLOOR(AVG(SALARY)) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) <= 3500000;
------------------------------------------------------------------
/*
    <SELECT문 구조 및 실행순서>
    5. SELECT 조회하고자 하는 컬럼명들 나열 / * / 리터럴 / 산순연산식 / 함수식 AS 별칭
    1. FROM 조회하고자하는 테이블명 / DUAL(가상테이블)
    2. WHERE 조건식(그룹함수 X)
    3. GROUP BY 그룹 기준에 해당하는 칼럼명/ 함수식
    4. HAVING 그룹함수식에 대한 조건식
    6. ORDER BY [정렬기준에해당하는 컬러명 / 별칭/ 칼럼의순번] [ASC/DESC] [NULLS FIRST/NULLS LAST]
*/
-------------------------------------------------------------------
/*
    <집합 연산자 SET OPERATOR>
    
    여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자.
    
    - UNION(합집합) : 두 쿼리문을 수행한 결과값을 더한 후 중복되는 부분은 한번만 빼서 중복을 제거한것 => OR
    - UNION ALL : 두 쿼리문을 수행한 결과값을 더한 후 중복 제거를 하지 않은 것.
                  => 합집합 + 교집합
    
    - INTERSECT(교집합) : 두 쿼리문을 수행한 결과값의 중복된 부분 => AND
    - MINUS(차집합) : 선행 쿼리문 결과값에서 후행 쿼리문 결과값을 뺀 나머지 부분.
                     -> 선행 쿼리문 결과값 - 교집합1
                    
    주의할점 : 두 쿼리문의 결과를 합쳐서 한개의 테이블로 보여줘야 하기 때문에 
              두 쿼리문의 SELECT절 부분은 같아야한다 -> 즉, 조회할 칼럼이 동일해야함.  
*/
-- 1. UNION : 두 쿼리문을 수행한 결과값을 더하지만 중복은 제거해줌.

-- 부서코드가 D5이거나또는 급여가 300만원 초과인 사원들 조회( 사번, 사원명 , 부서코드 , 급여) 

-- 부서코드가 D5인 사원들만조회
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6명 조회.

-- 급여가 300만원 초과인 사원들
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY >= 3000000; -- 8명중 부서코드가 D5인 사원은 2명 존재.


SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' OR SALARY > 3000000 -- 12명
-- 직급코드가 J6이거나 또는 부서코드가 D1인 사원들조회
UNION
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' OR DEPT_CODE ='D1'; -- 7명 

-- 2. UNION ALL : 여러개의 쿼리결과를 더해서 보여주는 연산자(중복제거를 안함!)
-- 직급 코드가 J6이거나 또는 부서코드가 D1인 사원들 조회 (사번 ,사원명, 부서코드 ,직급코드)

-- 1. 중복제거하지않고, 전체결과조회
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE ='J6' -- 6명의 사원이 출력 그중 부서코드가 D1인 사원은 2
UNION ALL
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; -- 3명있고 J6인 사원은 2명
-- 3. INTERSECT : 교집합 , 여러 쿼리결과의 중복된 결과만을 조회 (AND)
-- 2. 중복된 사원만 조회.
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE ='J6' -- 6명의 사원이 출력 그중 부서코드가 D1인 사원은 2
INTERSECT
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; -- 3명있고 J6인 사원은 2명

-- 4. MINUS : 차집합 , 선행쿼리 결과에 후행 쿼리 결과를 뺀 나머지.
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE ='J6' -- 6명의 사원이 출력 그중 부서코드가 D1인 사원은 2
MINUS
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'
ORDER BY DEPT_CODE NULLS LAST;
    
   





















