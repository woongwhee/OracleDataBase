/*
    <함수 FUNCTION>
    자바로 따지면 메소드와 같은 존재
    매개변수로 전달된 값들을 읽어서 계산한 결과를 반환 -> 호출해서 쓸 것
    
    - 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴(매 행마다 함수 실행 후 결과 반환)
    - 그룹 함수 : N개의 값을 읽어서 1개의 결과를 리턴 (하나의 그룹별로 함수 실행후 결과 반환)
    
    단일행 함수와 그룹 함수는 함께 사용 할 수 없음 : 결과 행의 갯수가 다르기 때문
*/
-----------------< 단일행 함수 >----------------------------
/*
    <문자열과 관련된 함수>
    LENGTH / LENGTHB
    
    - LENGTH(문자열) : 해당 전달된 문자열의 글자수 반환.
    - LENGTHB(문자열) : 해당 전달된 문자열의 바이트 수 반환.
    
    결과 값은 숫자로 반환 -> NUMBER
    문자열 : 문자열 형식의 리터럴, 문자열에 해당하는 컬럼
    
    한글 : 김 -> 'ㄱ', 'ㅣ', 'ㅁ' => 한글자당 3BYTE취급
    영문, 숫자, 특수문자 : 한글자당 1BYTE취급
*/
SELECT LENGTH('오라클!'), LENGTHB('오라클!')
FROM DUAL; --> 가상테이블 : 산술연산이나 가상컬럼등 값을 한번만 출력하고 싶을때 사용하는 테이블

--이메일, 사원 이름을 컬럼값, 글자수, 바이트 글자수
SELECT 
    email,
    length(email),
    lengthb(email),
    emp_name,
    length(emp_name),
    lengthb(emp_name)
FROM EMPLOYEE;

/*
    INSTR
    - INSTR(문자열, 특정문자, 찾을 위치의 시작 값, 순번) : 문자열로부터 특정 위치값 반환.
    
    찾을 위치의 시작값, 순번은 생략 가능
    결과값은 NUMBER 타입으로 반환.
    
    찾을 위치의 시작값(1 / -1)
    1 : 앞에서부터 찾겠다.(생략시 기본값)
    -1 : 뒤에서 부터 찾겠다.
*/
SELECT INSTR('AABAACAABBAA','B')FROM DUAL;
-- 찾을 위치 , 순번을 생략 : 기본적으로 앞에서부터 첫번째 글자의 위치를 알려줌

SELECT INSTR('AABAACAABBAA','B', 1)FROM DUAL;
--위와 동일한 결과값 반환.

SELECT INSTR('AABAACAABBAA','B', -1)FROM DUAL;
-- 뒤에서 부터 첫번째 글자의 위치를 알려줌.

SELECT INSTR('AABAACAABBAA','B', -1, 2)FROM DUAL;
-- 뒤에서 부터 두번째 위치하는 B의 값의 위치값을 앞에서 부터 세서 알려준것.

SELECT INSTR('AABAACAABBAA','B', -1, 0)FROM DUAL;
-- 범위를 벗어난 순번을 제시한 경우 오류발생.

SELECT INSTR(EMAIL, '@')
FROM EMPLOYEE;

/*
    SUBSTR
    
    문자열부터 특정 문자열을 추출하는 함수
    - SUBSTR(문자열, 처음위치, 추출한 문자 갯수)
    
    결과값은 CHARACTER타입으로 반환(문자열)
    추출한 문자 갯수는 생략가능(생략했을때 문자열 끝까지 추출.)
    처음위치는 음수로 제시 가능 : 뒤에서부터 N번째 위치로부터 문자를 추출하겠다 라는 뜻.
*/
SELECT SUBSTR('SHOWMETHEMONEY',7) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',5, 2) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-8, 3) FROM DUAL;
--THE
SELECT SUBSTR('SHOWMETHEMONEY',-5) FROM DUAL;
--MONEY

--주민등록번호에서 성별 부분을 추출해서 남자(1)여자(2)를 체크.
SELECT 
    emp_name,
    substr(emp_no, 8,1) AS "성별"
FROM EMPLOYEE;
--이메일에서 ID부분만 추출해서 조회.
SELECT
    emp_name,
    substr(email, 1, INSTR(email, '@')-1) AS "ID"
FROM EMPLOYEE;
--남자사원들만 조회.
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) ='1';

/*
    LPAD / RPAD
    
    -LPAD/RPAD(문자열, 최종적으로 반환할 문자의 길이(BYTE), 덧붙이고자하는 문자)
    : 제시한 문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열로 변환.
    한글의 길이는 모두 2byte로 계산된다.
*/
SELECT LPAD(EMAIL, 16)
FROM EMPLOYEE;
-- 자바의 %5s랑 같은 개념

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT 
    emp_name,
    emp_no
FROM EMPLOYEE;

-- 1단계 : SUBSTR함수를 이용해서 주민번호 앞 8자리만 추출.
SELECT
    emp_name,
    substr(emp_no,1,8) AS 주민번호
FROM EMPLOYEE;
-- 2단계 : RPAD함수를 중첩해서 주민번호 뒤에 *붙이기
SELECT
    emp_name,
    RPAD(substr(emp_no,1,8),14, '*') AS 주민번호
FROM EMPLOYEE;

SELECT 
    LPAD(substr(phone,4),11,'*') 
FROM EMPLOYEE;

SELECT
    RPAD(substr(hire_date,1,6),8,'?')
FROM EMPLOYEE;

SELECT
    RPAD(substr(hire_date,1,3),5,'?') || substr(hire_date,6,8)
FROM EMPLOYEE;

/*
    LTRIM/RTRIM/TRIM
    
    -LTRIM/RTRIM(문자열,제거시키고자 하는 문자)
    : 문자열의 왼쪽 또는 오른쪽에서 제거시키고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환.
    
    결과값은 CHARACTER 형태로 나옴. 제거시키고자 하는 문자 생략 가능 (DEFAULT ' ')
    
*/
SELECT
    LTRIM('               K    H                        '),
    RTRIM('               K    H                        ')
FROM DUAL;
SELECT
    LTRIM(RTRIM('000001234000000','0'),'0')
FROM DUAL;
SELECT 
    LTRIM('123123KH123','123'),
    LTRIM('1231212222ZZ123KH123','123')
FROM DUAL;
--제거하고시키자 하는 문자열을 통으로 지워주는게 아니라 문자 하나하나가 다 존재하면 지워주는 원리

/*
    TRIM
    
    -TRIM(BOTH/LEADING/TAILING '제거하고자하는 문자'FROM '문자열')
    :문자열 (양쪽/앞쪽/뒤쪽)에 있는 특정문자를 제거한 나머지 문자열 반환
    
    결과값은 CHARACTER 타입 반환 BOTH/LEADING/TRAILING은 생략 가능(DEFAULT BOTH)

*/
SELECT 
    TRIM(' 'FROM'  12312312312  ')
FROM DUAL;
SELECT
    --TRIM(LEADING '123'FROM '123123Z12ZZ31Z23123')trim set should have only one character"--트림은 1글자만 제거가능    
    TRIM('Z'FROM 'ZZ1232131Z123ZZ')
FROM DUAL;    
/*
    LOWER/UPPER/INITCAP
    문자열을 소문자/대문자/앞글자만대문자 로
    LOWER/UPPER/INITCAP(문자열)
    
*/
SELECT
    LOWER('WELLCOME TO B CLASS'),--wellcome to b class
    UPPER('WELLCOME TO B CLASS'),--WELLCOME TO B CLASS
    INITCAP('WELLCOME TO B CLASS')--Wellcome To B Class 띄어쓰기 단위로 첫글자만 대문자로 변경됨
FROM DUAL;


/*
    CONCAT
    -CONCAT(문자열1, 문자열2)
    : 전달된 문자열 두개를 하나의 문자열로 합쳐서 반환.
*/

