/*
    OBJECT
    ������ ���̽��� �̷�� ���� ��������
    
    OBJECT����
    - TABLE, USER, VIEW , SEQUENCE, INDEX , FUNCTION , TRIGGER, PROCEDURE
    
    <VIEW ��>
    
    SELECT ���� ������ �� �� �ִ� ��ü
    (���� ���̴� SELECT���� VIEW�� �����صθ� �Ź� �� SELECT���� �ٽ� ����� �ʿ䰡 ����)
    ->��ȸ�� �ӽ����̺� ��������(���ڿ����׷� �ä���)

*/
--�ѱ����� �ٹ��ϴ� ������� ��� �̸� �μ��� �޿� �ݹ������� ���޸� ��ȸ�ϼ���
--ANSI
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE,
    SALARY,
    NATIONAL_NAME AS �ٹ�������,
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
    1. VIEW �������
    [ǥ����]
    CREATE VIEW ���
    AS ��������;
    
 
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
--������ �����?

SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='�ѱ�';
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='�Ϻ�';
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='�߱�';
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME='���þ�';
--�ٹ����� ���þ��� ������� �̸� ��� ���޸� ���ʽ�

SELECT EMP_NAME,EMP_NO,NATIONAL_NAME, JOB_NAME,BONUS FROM VW_EMPLOYEE WHERE NATIONAL_NAME='���þ�';
SELECT EMP_NAME,EMP_NO,NATIONAL_NAME, JOB_NAME,BONUS FROM VW_EMPLOYEE WHERE NATIONAL_NAME='���þ�';
--�信 ���� �÷��� ��ȸ�ϰ��� �ϸ� ���Ӱ� �����ߵ�.


/*
    �������������� �ݵ�� ��Ī������ ����� �ȴ�.
*/
--����� ��� �̸� ���޸� ���� �ٹ������ ��ȸ �ִ� SELECT VIEW�� ����
CREATE OR REPLACE VIEW VW_EMP_JOB AS
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��'),
    FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

--must name this expression with a column alias"
--��Ī������ ���ߴٰ� ������

CREATE OR REPLACE VIEW VW_EMP_JOB AS
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME AS ���޸�,
    DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') AS ����,
    FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) AS �ټӿ���
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

SELECT * FROM VW_EMP_JOB;
SELECT ����,EMP_NAME,�ټӿ���,JOB_NAME FROM VW_EMP_JOB;
--��Ī������ �״�� ��� �;ߵ�




---��Ī�ο��ϴ� �Ǵٸ� ���
--�̹���� ��� ��� �÷��� ���� ��Ī�� ������ �־�� �Ѵ�.
CREATE OR REPLACE VIEW VW_EMP_JOB(���,�̸�,���޸�,����,�ټӳ��)AS
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��'),
    FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

select ���,�̸�,���޸�,����,�ټӳ�� from vw_emp_job;
select ���,�̸�,���޸�,����,�ټӳ�� from vw_emp_job where  �ټӳ��>20;

DROP VIEW VW_EMP_JOB;

SELECT * FROM USER_VIEWS;


--��밡���ϴ�.(������������)
/*
    *INSERT , UPDATE, DELETE
    * ������ �並 �̿��ؼ� DML ��밡�� �並 �����ϴ°� �ƴ� �信 ���� ���̺��� �����ϴ� ����
    ���ǻ��� : �並 ���ؼ� �����ϰ� �ȴٸ� , �����Ͱ� ����ִ� ���̺��� ��������� ����ȴ�.

*/

CREATE VIEW VW_JOB AS
    SELECT * FROM JOB;
    
    SELECT * FROM JOB;
    
INSERT INTO VW_JOB VALUES('J8','����');

SELECT * FROM VW_JOB;
SELECT * FROM JOB;--�����̺��� ���뵵 ����Ǿ���.
--VW_JOB �信 JOB_CODE= J8�� JOB_NAME ='�˹�'�� ������Ʈ
UPDATE VW_JOB
    SET JOB_NAME = '�˹�'
    WHERE JOB_CODE='J8';
DELETE VW_JOB
    WHERE JOB_CODE='J8';
----------------------------
/*
    DML�� ������ ��� : ���������� �̿��ؼ� ������ ���̺��� ������ ó������ �����ϰ��� �� ���.
    
    
    
    1. �信 ���ǵǾ� ���� ���� �÷��� �����ϴ°��.
    2. GROUP BY �Ǿ� �ִ� ���.
    3. JOIN �Ǿ� �ִ� ���.
*/
--1) �信 ���ǵǾ����� ���� �÷��� �����ϴ°��

CREATE OR REPLACE VIEW VW_JOB
    AS SELECT JOB_NAME FROM JOB;

INSERT INTO VW_JOB VALUES('J8','����');--too many values

UPDATE VW_JOB
    SET JOB_NAME = '����'
    WHERE JOB_CODE='J8'; --"%s: invalid identifier"

--2) �信 ���ǵǾ����� ���� �÷��߿� ���̽����̺� �� NOT NULL ���������� ���ǵ� ���
CREATE OR REPLACE VIEW VW_JOB
    AS SELECT JOB_NAME FROM JOB;
INSERT INTO VW_JOB VALUES('����');--cannot insert NULL into ("KH"."JOB"."JOB_CODE")
--VIEW �� PK �� NOTNULL ���������� ���� ���⋚���� �����Ұ�

--UPDATE
UPDATE VW_JOB
    SET JOB_NAME='�˹�'
    WHERE JOB_NAME='����';
--����
ROLLBACK;
--DELETE 
    DELETE VW_JOB
         WHERE JOB_NAME='�븮';
--FOREIN KEY �� �����Ǿ��ִ� ���  �����߻� �����Ǵ°� �´�

--3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵǾ� �ִ� ���� ���.
CREATE OR REPLACE VIEW VW_EMP_SAL
    AS SELECT
        EMP_NO,
        EMP_ID,
        EMP_NAME,
        SALARY,
        JOB_CODE,
        SAL_LEVEL,
        SALARY*12 AS ����
        FROM EMPLOYEE;
SELECT *FROM VW_EMP_SAL;        
INSERT INTO VW_EMP_SAL VALUES(400,'�ΰ��',300000,30000000);--virtual column not allowed here" ����Į���� INSERT�� ��� �� �� ����.
INSERT INTO VW_EMP_SAL (EMP_NO,EMP_ID,EMP_NAME,SALARY,JOB_CODE,SAL_LEVEL)VALUES('997979-1354566','400','�ΰ��',300000,'J7','S1');
--UPDATE �� ���������� �̾� ��� ���Ұ�
--�Լ����� WHERE���� ��밡��

--4) �׷��Լ� Ȥ�� GROUP BY ���� ���Ե� ���
CREATE OR REPLACE VIEW VW_GROUPDEPT
    AS SELECT DEPT_CODE,SUM(SALARY) AS �հ�,FLOOR(AVG(SALARY)) AS ��ձ޿� FROM EMPLOYEE
    GROUP BY DEPT_CODE;
    
SELECT * FROM VW_GROUPDEPT;
--INSERT
INSERT INTO VW_GROUPDEPT VALUES('D3',
33333,55555); --�ȵ�
--UPDATE DELETE ��� ������
UPDATE VW_GROUPDEPT
    SET DEPT_CODE ='D0'
    WHERE �հ�=6986240;
--5) DISTINCT ������ ���Ե� ���.

CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;
--INSERT UPDATE DELETE ���ϴ� ������.

--6) JOIN �� �̿��� ���� ���̺��� ��Ī���� ���� ���.

CREATE OR REPLACE VIEW VW_JOIN
AS SELECT EMP_ID,EMP_NAME,JOB_NAME FROM EMPLOYEE JOIN JOB USING (JOB_CODE);

SELECT * FROM VW_JOIN;

INSERT INTO VW_JOIN VALUES (300,'���','�븮');--�ȵ�
--�̸����� ����
UPDATE VW_JOIN
    SET EMP_NAME = '�ΰ��'
    WHERE EMP_ID = '200';
UPDATE VW_JOIN
    SET JOB_NAME='����'
    WHERE EMP_ID ='200';
UPDATE VW_JOIN
    SET EMP_ID ='200'
    WHERE JOB_NAME='����';
--VIEW�� �������̺��� KEY�� �����ȴ� ������ �������̺� ������Ʈ����
--���������� KEY�� �������� ���� �÷��� ��밡��


--DELETE
DELETE VW_JOIN
    WHERE EMP_ID=200;
    --�ߵ�
DELETE VW_JOIN
    WHERE JOB_NAME='�븮';
    --�ߵ�
ROLLBACK;


/*
   �ɼ�
    1.OR REPLACE : ���� �̸��� �䰡 ������ ��ü�ϰ� ������ ���λ�����.
    2.FORCE/NOFORCE �ɼ�: ���� ���̺��� ��� VIEW�� ���� �����Ҽ� �հ� ���ִ� �ɼ�.
    CREATE OR REPLACE NOFORCE(�⺻��)
*/
CREATE FORCE VIEW V_FORCETEST
    AS SELECT A,B,C FROM NOTHINGTEST;
--�������� �ʴ� ���̺� ���� VIEW�� ������ ����������
SELECT * FROM V_FROCETEST;
--���� �߻� ���̺� �����ϱ� ���� ��ȸ
CREATE TABLE NOTHINGTEST(
    A NUMBER,
    B NUMBER,
    C NUMBER
);

SELECT * FROM V_FROCETEST;

--3.WITH CHECK OPTION
--SELECT ���� WHERE ������ ����� �÷��� �������� ���ϰ� �ϴ� ����
CREATE OR REPLACE NOFORCE VIEW V_CHECKOPTION
AS SELECT EMP_ID,EMP_NAME,SALARY,DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE='D5' WITH CHECK OPTION;
    
UPDATE V_CHECKOPTION
    SET DEPT_CODE='D9'
    WHERE EMP_ID= 215;--����
UPDATE V_CHECKOPTION
    SET SALARY=8000000
    WHERE EMP_ID= 215;--�̰Ƕ� ����
    ROLLBACK;
    
--4)WITH READ ONLY
--VIEW ��ü�� �������� ���ϰ� �����ϴ� �ɼ�.
--���� �̷��� ���̾�
CREATE OR REPLACE VIEW V_READ
    AS SELECT EMP_ID,EMP_NAME,SALARY,DEPT_CODE
    FROM EMPLOYEE WHERE DEPT_CODE='D5'
    WITH READ ONLY;
SELECT * FROM V_READ;

UPDATE V_READ SET SALARY =0 WHERE DEPT_CODE=215;
--Cannot perform a DML operation on a read-only view

