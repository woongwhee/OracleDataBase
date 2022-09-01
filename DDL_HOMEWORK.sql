/*
    [DDL]
*/
--1. TB_CATEGORY 생성
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);
--2. TB_CLASS_TYPE 생성
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3. TB_CATEGORY.NAME에 PK부여

ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);
--4. TB_CLASS_TYPE.NAME에 NOT NULL부여
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;
--5. 두컬럼의 NO의 크기를 10으로 NAME의 크기를 20으로 바꿈
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);
--6. 컬럼의이름을 CATGORY_ 혹은 CLASS_TYPE_ 로바꾼다.
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;

--7. 두 PK의 제약조건명을 PK_컬럼명으로 바꿔라
    --1. 제약조건명을 조회해서 얻는다.
SELECT * FROM ALL_CONSTRAINTS WHERE  TABLE_NAME='TB_CATEGORY';
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007052 TO PK_CATEGORY;
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME='TB_CLASS_TYPE';
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007051 TO PK_CLASS_TYPE;

--8. INSERT문을 수행해라
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;

--9. TB_DEPARTMENT.CATEGORY 칼럼의 


ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY 
    FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY (CATEGORY_NAME); 

--10. 춘 기술대학교 학생들의 정보맊이 포함되어 있는 학생일반정보 VIEW 를 맊들고자 핚다. 아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오.
CREATE VIEW VW_학생일반정보 as
    SELECT
        student_no as 학번,
        student_name as 학생이름,
        student_address as 주소
    FROM TB_STUDENT;
SELECT * FROM VW_학생일반정보;

/*11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행핚다.
이를 위해 사용핛 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 맊드시오.
이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT
맊을 핛 경우 학과별로 정렬되어 화면에 보여지게 맊드시오.)*/
CREATE VIEW VW_지도면담 AS
    SELECT
        STUDENT_NAME,
        DEPARTMENT_NAME,
        PROFESSOR_NAME
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO=PROFESSOR_NO;

SELECT * FROM VW_지도면담;


--12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW 를 작성해 보자
CREATE VIEW VW_학과별학생수 AS
    SELECT
        DEPARTMENT_NAME,
        COUNT(STUDENT_NO) AS STUDENT_COUNT --VIEW는 이름을 지정하지 않으면 오류가 난다.
    FROM TB_DEPARTMENT
    LEFT JOIN TB_STUDENT USING (DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_학과별학생수;
--13. 위에서 생성핚 학생일반정보 View 를 통해서 학번이 A213046 인 학생의 이름을 본인 이름으로 변경하는 SQL 문을 작성하시오.

UPDATE VW_학생일반정보
        SET 학생이름= '진웅휘'
        WHERE 학번='A213046';

SELECT * FROM VW_학생일반정보;
SELECT * FROM TB_STUDENT; 
--TB_STUDENT 의 데이터도 수정되어버렸다.
--14. 13 번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW 를 어떻게 생성해야 하는지 작성하시오.
CREATE VIEW VW_학생일반정보2 as
    SELECT
        student_no as 학번,
        student_name as 학생이름,
        student_address as 주소
    FROM TB_STUDENT
    CONSTRAINT WITH READ ONLY;

UPDATE VW_학생일반정보2
        SET 학생이름= '민경민'
        WHERE 학번='A213046';
--cannot perform a DML operation on a read-only view
--정답 뷰를 생성할때 CONSTRAINT WITH READ ONLY 로 제약조건을 추가해 읽기만 가능하게 할 수 있다.

/*15. 춘 기술대학교는 매년 수강신청 기갂맊 되면 특정 인기 과목들에 수강 신청이 몰려
문제가 되고 있다. 최근 3 년을 기준으로 수강인원이 가장 맋았던 3 과목을 찾는 구문을
작성해보시오 과목번호 과목이름 누적수강생수(명)*/
SELECT
    D.*
FROM(
    SELECT 
        CLASS_NO,
        CLASS_NAME,
        COUNT(*)
    FROM TB_GRADE
    JOIN TB_CLASS USING (CLASS_NO)
    --WHERE TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(TERM_NO,1,4))<=3;진짜 최근 3년 조건
    WHERE TERM_NO>= (SELECT MAX(TERM_NO)-403 FROM TB_GRADE)
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY 3 DESC)D
WHERE ROWNUM<4;

