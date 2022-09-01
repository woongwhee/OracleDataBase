/*
    [DDL]
*/
--1. TB_CATEGORY ����
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);
--2. TB_CLASS_TYPE ����
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3. TB_CATEGORY.NAME�� PK�ο�

ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);
--4. TB_CLASS_TYPE.NAME�� NOT NULL�ο�
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;
--5. ���÷��� NO�� ũ�⸦ 10���� NAME�� ũ�⸦ 20���� �ٲ�
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);
--6. �÷����̸��� CATGORY_ Ȥ�� CLASS_TYPE_ �ιٲ۴�.
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;

--7. �� PK�� �������Ǹ��� PK_�÷������� �ٲ��
    --1. �������Ǹ��� ��ȸ�ؼ� ��´�.
SELECT * FROM ALL_CONSTRAINTS WHERE  TABLE_NAME='TB_CATEGORY';
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007052 TO PK_CATEGORY;
SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME='TB_CLASS_TYPE';
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007051 TO PK_CLASS_TYPE;

--8. INSERT���� �����ض�
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;

--9. TB_DEPARTMENT.CATEGORY Į���� 


ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY 
    FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY (CATEGORY_NAME); 

--10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� ����. �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
CREATE VIEW VW_�л��Ϲ����� as
    SELECT
        student_no as �й�,
        student_name as �л��̸�,
        student_address as �ּ�
    FROM TB_STUDENT;
SELECT * FROM VW_�л��Ϲ�����;

/*11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� ��������.
�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT
���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)*/
CREATE VIEW VW_������� AS
    SELECT
        STUDENT_NAME,
        DEPARTMENT_NAME,
        PROFESSOR_NAME
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO=PROFESSOR_NO;

SELECT * FROM VW_�������;


--12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����
CREATE VIEW VW_�а����л��� AS
    SELECT
        DEPARTMENT_NAME,
        COUNT(STUDENT_NO) AS STUDENT_COUNT --VIEW�� �̸��� �������� ������ ������ ����.
    FROM TB_DEPARTMENT
    LEFT JOIN TB_STUDENT USING (DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_�а����л���;
--13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ���� �̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.

UPDATE VW_�л��Ϲ�����
        SET �л��̸�= '������'
        WHERE �й�='A213046';

SELECT * FROM VW_�л��Ϲ�����;
SELECT * FROM TB_STUDENT; 
--TB_STUDENT �� �����͵� �����Ǿ���ȴ�.
--14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW �� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.
CREATE VIEW VW_�л��Ϲ�����2 as
    SELECT
        student_no as �й�,
        student_name as �л��̸�,
        student_address as �ּ�
    FROM TB_STUDENT
    CONSTRAINT WITH READ ONLY;

UPDATE VW_�л��Ϲ�����2
        SET �л��̸�= '�ΰ��'
        WHERE �й�='A213046';
--cannot perform a DML operation on a read-only view
--���� �並 �����Ҷ� CONSTRAINT WITH READ ONLY �� ���������� �߰��� �б⸸ �����ϰ� �� �� �ִ�.

/*15. �� ������б��� �ų� ������û ��A�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
������ �ǰ� �ִ�. �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������
�ۼ��غ��ÿ� �����ȣ �����̸� ������������(��)*/
SELECT
    D.*
FROM(
    SELECT 
        CLASS_NO,
        CLASS_NAME,
        COUNT(*)
    FROM TB_GRADE
    JOIN TB_CLASS USING (CLASS_NO)
    --WHERE TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-TO_NUMBER(SUBSTR(TERM_NO,1,4))<=3;��¥ �ֱ� 3�� ����
    WHERE TERM_NO>= (SELECT MAX(TERM_NO)-403 FROM TB_GRADE)
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY 3 DESC)D
WHERE ROWNUM<4;

