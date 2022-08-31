--SELECT BASIC
--1
SELECT
    DEPARTMENT_NAME,
    CATEGORY
FROM TB_DEPARTMENT;
--2.
SELECT
    DEPARTMENT_NAME||'의 정원은'||CATEGORY||'명 입니다.'
FROM TB_DEPARTMENT;
--
--3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이
--들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서
--찾아 내도록 하자
SELECT
    STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO =(SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='국어국문학과')
     AND ABSENCE_YN='Y';
     
--4.A513079, A513090, A513091, A513110, A513119 를찾는 구문
SELECT
    STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

--5 . 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.
SELECT
    department_name,
    category
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;
--6. 총장찾기
SELECT
    professor_name
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;
--7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.
SELECT
    student_name
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;
--8. 수강신청을 하려고 핚다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회해보시오.
SELECT 
    class_no
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;
--9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
SELECT 
    DISTINCT(CATEGORY)
FROM TB_DEPARTMENT;
--10. 02 학번 전주 거주자들의 모임을 맊들려고 핚다. 휴학핚 사람들은 제외핚 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
SELECT
    STUDENT_NO,
    STUDENT_NAME,
    STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN='N' AND SUBSTR(STUDENT_NO,1,2)='A2' AND STUDENT_ADDRESS LIKE '%전주%';


--Additional SELECT 
--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.
--( 단, 헤더는 "학번", "이름", "입학년도" 가표시되도록 핚다.)
SELECT
    STUDENT_NO AS 학번,
    STUDENT_NAME AS 이름,
    ENTRANCE_DATE AS 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO=002
ORDER BY 3;

--
/*
2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 핚 명 있다고 핚다. 그 교수의
이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성핚 SQL 
문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
--?? 이름이 2글자 5글자일수도있어서
*/
SELECT
    PROFESSOR_NAME,
    PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE NOT PROFESSOR_NAME LIKE '___';
/*
3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단
이때 나이가 적은 사람에서 맋은 사람 순서로 화면에 출력되도록 맊드시오. (단, 교수 중
2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 핚다. 나이는 ‘맊’으로
계산핚다.)
*/
    SELECT
        PROFESSOR_NAME 교수이름,
        100+TO_CHAR(SYSDATE,'YY')-TO_NUMBER(SUBSTR(PROFESSOR_SSN,1,2)) AS 나이
               
    FROM TB_PROFESSOR
    WHERE SUBSTR(PROFESSOR_SSN,8,1) IN (1,3)
    ORDER BY 나이 ASC;
 /*   
4. 교수들의 이름 중 성을 제외핚 이름맊 출력하는 SQL 문장을 작성하시오. 출력 헤더는
이름 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
*/
    SELECT
        SUBSTR(PROFESSOR_NAME,2) AS 이름
    FROM TB_PROFESSOR;
    
/*
5. 춘 기술대학교의 재수생 입학자를 구하려고 핚다. 어떻게 찾아낼 것인가? 이때, 
19 살에 입학하면 재수를 하지 않은 것으로 갂주핚다
*/

SELECT
    STUDENT_NAME
FROM TB_STUDENT
--WHERE 100+TO_CHAR(SYSDATE,'YY')-TO_NUMBER(SUBSTR(STUDENT_SSN,1,2))>20;
WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE,TO_DATE(SUBSTR(STUDENT_SSN,1,2),'RR'))/12)>18;


/*
6. 2020 년 크리스마스는 무슨 요일인가?
*/
SELECT
    TO_CHAR(TO_DATE('2020/12/25'),'DAY')
FROM DUAL;

/*7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇
월 몇 일을 의미핛까? 또 TO_DATE('99/10/11','RR/MM/DD'), 
TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까
     TO_DATE('99/10/11','YY/MM/DD'), : 1999년 
     TO_DATE('49/10/11','YY/MM/DD'), : 2049년
     TO_DATE('49/10/11','RR/MM/DD'), : 1949년
     TO_DATE('99/10/11','RR/MM/DD') :1999년
     
     =>정답 2099 2049 2049 1999
*/
SELECT
    TO_DATE('99/10/11','YY/MM/DD'),
     TO_DATE('49/10/11','YY/MM/DD'),
     TO_DATE('49/10/11','RR/MM/DD'),
     TO_DATE('99/10/11','RR/MM/DD')
FROM DUAL;

/*
8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
이젂 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
*/
SELECT
    STUDENT_NO,
    STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

/*
9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단,
이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 핚
자리까지맊 표시핚다.
*/

SELECT
    ROUND(AVG(POINT),1)
FROM TB_GRADE
GROUP BY STUDENT_NO
HAVING STUDENT_NO ='A517178';
/*
10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이
출력되도록 하시오.
*/


