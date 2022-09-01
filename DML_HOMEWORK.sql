--1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
INSERT INTO TB_CLASS_TYPE VALUES('01','전공필수');
INSERT INTO TB_CLASS_TYPE VALUES('02','전공선택');
INSERT INTO TB_CLASS_TYPE VALUES('03','교양필수');
INSERT INTO TB_CLASS_TYPE VALUES('04','교양선택');
INSERT INTO TB_CLASS_TYPE VALUES('05','논문지도');
COMMIT;
--2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 맊들고자 한다.아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오. (서브쿼리를 이용하시오)

CREATE TABLE TB_NOMAL_STUDENT_INFO AS
    SELECT
        STUDENT_NO,
        STUDENT_NAME,
        STUDENT_ADDRESS
    FROM TB_STUDENT;
SELECT * FROM TB_NOMAL_STUDENT_INFO;
/*
3. 국어국문학과 학생들의 정보맊이 포함되어 있는 학과정보 테이블을 만들고자 핚다.
아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏
작성하시오)
*/

CREATE TABLE TB_국어국문학과 AS
    SELECT
        STUDENT_NO,
        STUDENT_NAME,
        '19'||SUBSTR(STUDENT_SSN,1,2) AS BRT_YEARS,
        PROFESSOR_NAME
    FROM TB_STUDENT S
    JOIN TB_PROFESSOR P ON COACH_PROFESSOR_NO=PROFESSOR_NO
    JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
    WHERE DEPARTMENT_NAME= '국어국문학과';
SELECT * FROM TB_국어국문학과;
--4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용핛 SQL 문을 작성하시오. (단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 핚다)
    UPDATE TB_DEPARTMENT
            SET CAPACITY=ROUND(CAPACITY*1.1);
          
--5. 학번 A413042 인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경되었다고핚다. 주소지를 정정하기 위해 사용핛 SQL 문을 작성하시오

UPDATE TB_STUDENT
    SET student_address='서울시 종로구 숭인동 181-21'
    WHERE STUDENT_NO='A413042' AND STUDENT_NAME='박건우';
SELECT * FROM TB_STUDENT WHERE STUDENT_NO='A413042' AND STUDENT_NAME='박건우';    
    
/*6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로
결정하였다. 이 내용을 반영핛 적젃핚 SQL 문장을 작성하시오.
(예. 830530-2124663 ==> 830530 )    */
    
UPDATE TB_STUDENT
    SET STUDENT_SSN = SUBSTR(STUDENT_SSN,1,6);
SELECT * FROM TB_STUDENT;

/*
    7. 의학과 김명훈 학생은 2005 년 1 학기에 자신이 수강핚 '피부생리학' 점수가
    잘못되었다는 것을 발견하고는 정정을 요청하였다. 담당 교수의 확인 받은 결과 해당
    과목의 학점을 3.5 로 변경키로 결정되었다. 적젃핚 SQL 문을 작성하시오
*/

    UPDATE TB_GRADE
        SET POINT=3.5
        WHERE CLASS_NO=(SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME='피부생리학')
        AND STUDENT_NO=(SELECT STUDENT_NO FROM TB_STUDENT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) WHERE STUDENT_NAME='김명훈'
                        AND DEPARTMENT_NAME='의학과')
        AND TERM_NO='200501';
        
        SELECT * 
        FROM TB_GRADE
        WHERE CLASS_NO=(SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME='피부생리학')
        AND STUDENT_NO=(SELECT STUDENT_NO FROM TB_STUDENT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) WHERE STUDENT_NAME='김명훈'
                        AND DEPARTMENT_NAME='의학과')
        AND TERM_NO='200501';
        
    --8. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오.
    DELETE FROM TB_GRADE
    WHERE STUDENT_NO IN (
        SELECT STUDENT_NO
        FROM TB_STUDENT
        WHERE ABSENCE_YN='Y'
    );
    SELECT * FROM TB_GRADE
    WHERE STUDENT_NO IN (
        SELECT STUDENT_NO
        FROM TB_STUDENT
        WHERE ABSENCE_YN='Y'
    );
