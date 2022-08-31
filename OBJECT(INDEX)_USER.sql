
/*
    <INDEX>
    책에서 목차같은 역할
    
    만약 목차가 없다면 내가 원하는 챕터, 칼럼이 어디있는지 모든책을 하나하나 훑어봐야함.
    
    마찬가지로 테이블에서 JOIN 혹은 서브쿼리로 데이터를 조회(SELECT)할때,
    인덱스가 엉ㅄ다면 테이블의 모든 데이터를 하나한 뒤져서 (FULL SCAN)내가 원하는 데이터를 가져올거임.
    
    따러ㅏ서 인덱스 설정을 해두면 모든 테이블을 뒤지지 않고 내가 원하는 조건만 빠르게 가져올수 있을것임.
    
    인덱스의 특징
    
    - 인덱스로 설정한 칼럼의 데이터들을 별도로 '오름차순'으로 정렬ㄹ하여 특정메모리공간에 물리적 주소와 함께 저장시킴
    => 즉 메모리에 공간을 차지한다.
    
*/

SELECT * FROM USER_INDEXES;--PK설정시 자동으로 인덱스가 생성된다.

-- 현재 계정의 인덱스와 인덱스가 적용된 컬럼을 확인해볼려면
SELECT * FROM USER_IND_COLUMNS;


--실행계획확인.

SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
WHERE EMP_NAME='송종기';
--0.022초

SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
WHERE EMP_ID='201';
--0.003초 어마어마한 성능차이

---SELECT문을 2번실행하면 0.001초로 바뀌네

--인덱스 생성방법
--[표현식]
--CREATE INDEX 인덱스명 ON 테이블명(컬럼명);
CREATE INDEX EMPLOYEE_EMP_NAME ON EMPLOYEE(EMP_NAME);
SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
WHERE EMP_NAME='송종기';
--0.002초 !!

--유용한경우는 테이블에 100만건에서 10만건만 조회할때 10~15프로의 데이터를 조회할때 효율이 좋다네요~
-- 우리가 인덱스를 만들고 조적ㄴ절에 해당 컬럼을 사용해도 인덱스를 사용하지 않는 경우도잇음
-- 해당 인덱스는 탈지 안탈지는 옵티마이저가 판단하다.'



---인덱스 삭제
DROP INDEX EMPLOYEE_EMP_NAME;



-- 여러컬럼에 인덱스를 부여 할 수 있음.
CREATE INDEX EMPLOYEE_EMP_NAME_DEPE_CODE ON EMPLOYEE(EMP_NAME,DEPT_CODE);
--하나라도 INDEX화되어있으면 탈수도 있다.

SELECT * FROM EMPLOYEE
WHERE EMP_NAME='박나라' AND DEPT_CODE='D5'; -- FULLSCAN함

DROP INDEX EMPLOYEE_EMP_NAME_DEPE_CODE ;
CREATE USER INDEXTEST IDENTIFIED BY KH;
GRANT CONNECT, RESOURCE TO INDEXTEST;

/*
    인덱스를 효율적으로 쓰기위해선?
    데이터의 분포도가 높고, 조건절에 자주 호출되며, 중복값은 적은 컬럼이 제일좋다.
    => 즉 , PK컬럼이 제일 효율이 좋다.
    
    1) 조건절에 자주 등장하는 컬럼
    2) 항상 = 으로 비교되는 컬럼
    3) 중복되는 데이터가 최소한인 컬럼(==분포도가 높다.)
    4) ORDER BY 절에 자주 사용되는 컬럼
    5) JOIN 조건으로 자주 사용되는 컬럼.
*/



