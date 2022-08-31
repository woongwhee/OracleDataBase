/*
    DML (DATA MANIPULATION LANGUAGE)
    
    ������ ���۾��
    
    ���̺� ���ο� �����͸� ���� �ϰų�(INSERT)
    ������ �����͸� �����ϰų�(UPDATE)
    �����ϴ� ����(DELETE)
    
*/

/*
    1.INSERT: ���̺� ���ο� ���� �߰��ϴ� ����
    [ǥ����]
    INSERT INTO �迭
    
    CASE 1: INSERT INTO ���̺�� VALUES (��1,��2,��3)
    => �ش� ���̺� ��� �÷��� ���� �߰��ϰ��� �Ҷ� ����ϴ� ���
    ���ǻ��� : �÷��� ����, �ڷ��� , ������ ���缭 VALUES ��ȣ�ȿ� ���� �����ؾ���.
    -�����ϰ� ���� ���� ��� : NOT ENOUGH VALUE ����
    -���� �� ���� �����ϴ� ��� : TOO MANY VALUES ����
    
*/
--EMPLOYEE ���̺� ��� ���� �߰�
INSERT INTO EMPLOYEE VALUES (
223,'�ΰ��','990512-1234567','alsrudals@iei.or.kr','01041213393','D1','J1','S2',5000000,0.25,201,
SYSDATE,NULL,DEFAULT
);

SELECT * FROM EMPLOYEE;

/*
    CASE 2 : INSERT INTO ���̺��(Į����1,Į����2,Į����3) VALUES (��1,��2,��3);
    -> �ش� ���̺� Ư��Į���� ������ �� Į���� �߰��� ���� �����ϰ��� �ҋ� ���.
        �� �� ������ �߰��Ǳ� ������ ������ �ȵ� �÷��� �⺻������  NULL���� ��.
        -��, DEFAULT ������ �Ǿ��ִ� ��� �⺻���� ��.
        
        ���ǻ���: NOT NULL ���������� �ɷ��ִ� Į���� �ݵ�� ���� ���� �����ؾ���.(PRIMARY KEY����������).
                �ٸ� DEFAULT ������ �Ǿ��ִٸ� NOT NULL�̶�� �ص� ���� ���ص���.

*/
INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES (224,'����','980508-1234567','D2','J2','S5',SYSDATE);
/*
    CASE 3 : INSERT INTO ���̺��(��������)
        =>���������� ��ȸ�� ������� ��°�� INSERT �ϴ� ����
        �� �������� �ѹ��� INSERT�Ҽ��ִ�.    
*/

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);
--��ü ������� ��� �̸� �μ����� ��ȸ�� ����� EMP01���̺� ��°�� �߰�
INSERT INTO EMP_01 
(
    SELECT
        emp_id,
        emp_name,
        dept_title
    FROM EMPLOYEE_COPY
    LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
);
/*
    INSERT ALL �迭
        �ΰ��̻��� ���̺� ���� INSERT �Ҷ� ���
        ���� : �׶� ���Ǵ� ���������� �����ؾ� �Ѵ�.
        1)INSERT ALL
            INTO ���̺��1 VALUES()
            INTO ���̺��2 VALUES()
            ��������;
        


*/
--���ο� ���̺� �����
--ù���� ���̺� : �޿��� 300������ �ӻ��� ������� ��� , ����� ,���޸� ������ ���̺�
-- ���̺�� : EMP_JOB /EMP_ID, EMP_NAME,JOB_NAME

CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(30)
);

--�ι�° ���̺� : �޿��� 300���� �̻��� ������� ��� ,����� �μ��� ������ ���̺�
--���̺�� :EMP_DEPT / EMP_ID, EMP_NAME DEPT_TITLE
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(30)
);


INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_TITLE)
    INTO EMP_JOB VALUES(EMP_ID,EMP_NAME,JOB_NAME)
        SELECT 
        EMP_ID,EMP_NAME,JOB_NAME,DEPT_TITLE
        FROM EMPLOYEE
        LEFT JOIN JOB USING (JOB_CODE)
        LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
        WHERE SALARY>3000000;
        
/*
   2) INSERT ALL
        WHEN ����1 THEN
            INTO ���̺�� 1 VALUES(Į����1,Į����2)
        WHEN ����2 THEN
            INTO ���̺�� 2 VALUES (Į����1,Į����2)

        TJQMZNJFL
*/


--������ ����ؼ� �� ���̺� �� INSERT
--���ο� �׽�Ʈ�� ���̺� ����
--2010�⵵ �������� ���� �Ի��� ��������� ��� ����� �Ի��� �޿��� ��� ���Ը� EMP_OLD
    CREATE TABLE EMP_OLD
    AS SELECT
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
        FROM EMPLOYEE
        WHERE 1=0;
--2010�⵵ �������� ���� �Ի��� ��������� ��� ����� �Ի��� �޿��� ��� ���Ը� EMP_NEW
CREATE TABLE EMP_NEW
    AS SELECT
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
        FROM EMPLOYEE
        WHERE 1=0;
        
        
        SELECT 
            
            EMP_ID,
            EMP_NAME,
            HIRE_DATE,
            SALARY
        FROM EMPLOYEE
        WHERE HIRE_DATE<'2010/01/01';
--        WHERE HIRE_DATE>='2010/01/01'
        
        
        INSERT ALL
            WHEN HIRE_DATE<'2010/01/01' THEN
                INTO EMP_OLT VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
            WHEN HIRE_DATE>='2010/01/01' THEN
                INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
        SELECT
            emp_id,
            emp_name,
            hire_date,
            salary
        FROM EMPLOYEE;


/*
    2.UPDATE
    ���̺� ��ϵ� ������ �����͸� '����'�ϴ� ����
    [ǥ����]
    UPDATE ���̺��
    SET �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�(������ ���氡��)
    WHERE ���� ���������ϳ� �����ϸ� ��� ���� ���� �� �ٲ��.
    

*/
    UPDATE EMPLOYEE_COPY
        SET EMP_ID=EMP_ID+10;
--�̷��� �ϰ� ������ �����ϳ�[?        
    CREATE TABLE DEPT_COPY
        AS SELECT * FROM DEPARTMENT;
    --DEPT_COPY TABLE���� D9�� �μ����� ���� ��ȹ�����μ���
    UPDATE DEPT_COPY
    SET DEPT_TITLE ='������ȹ��'
    WHERE DEPT_ID='D9';
    --��ä ���� ��� DEPT_TITLE �� ������ȹ������ �����Ǿ�����
    
    ROLLBACK; --������׿� ���ؼ� �ǵ����� ��ɾ� : ROLLBACK;
    
    SELECT
        *
    FROM DEPT_COPY;
    
    
    --���纻 ���̺�
    --EMPLOYEE ���̺�� ���� EMP_ID,EMP_NAME , DEPT_CODE,SALARY,BONUS(������ ����)
        
    --EMP_SALARY
        CREATE TABLE EMP_SALARY
            AS SELECT  emp_id,emp_name,dept_code,salary,bonus
                FROM EMPLOYEE;
        SELECT * FROM EMP_SALARY;
    --���ö �޿��� 1000��������
        UPDATE EMP_SALARY
            SET SALARY=10000000
            WHERE EMP_NAME='���ö';
    --������ �޿��� 7000000 ���ʽ� 0.2�κ���
        UPDATE EMP_SALARY
            SET SALARY=7000000,
                BONUS=0.2
            WHERE EMP_NAME='������';
    --��ü����� �޿��� ������ 20���� �λ��� �޾� ����
        UPDATE EMP_SALARY
            SET SALARY=SALARY*1.2;
        --EMAIL �ּ� @GAMAIL.COM���� ����
        CREATE TABLE EMP_EMAIL
            AS SELECT  emp_id,emp_name,email
                FROM EMPLOYEE;
        SELECT * FROM EMP_email;
        UPDATE EMP_EMAIL
            SET EMAIL= CONCAT(RPAD(EMAIL,INSTR(EMAIL,'@')),'gmail.com');
    /*
        UPDATE�ÿ� �������� ��� : ���������� ������ ��������� ������ �����κ��� �����ϰڴ�.
        -CREATE �ÿ� �������� ��� : ���������� ������ ����� ���̺� ���鶧 �־�����ڴ�.
        -INSERT �ÿ� �������� ��� : ���������� ������ ����� �ش� ���̺� �����ϰڴ�.
        
        [ǥ����]
        UPDATE ���̺��
        SET �÷��� = (��������)
        WHERE ����;

    */
        -- EMP_SALARY ���̺� �ΰ�� ����� �μ��ڵ带 ������ ����� �μ��ڵ�� ����
        -- �ΰ�� ����� �μ��ڵ� =D1 , ������ ����� �μ��ڵ� D9
        
    UPDATE EMP_SALARY
        SET DEPT_CODE=(
                    SELECT 
                        DEPT_CODE 
                    FROM EMP_SALARY
                    WHERE EMP_NAME='������'
            )
        WHERE EMP_NAME='�ΰ��';
        
     SELECT * FROM EMP_SALARY;
            
        --�ڸ�� ����� �޿���,���ʽ��� ����� ����� �޿��� ���ʽ� ������ ����
    UPDATE EMP_SALARY
        SET (SALARY,BONUS) = (--IN �� �ƴ϶� =���� �����ϳ�?
                    SELECT
                        SALARY,
                        BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME='�����'
                )
        WHERE EMP_NAME='����';
    
    --UPDATE ���ǻ���: ������ ���õ� ��������� ���Ѿߵȴ�.
    
    --EMPLOYEE ���̺��� ������ ����� ����� 200���� ����
    UPDATE EMPLOYEE
        SET EMP_ID=200
        WHERE EMP_NAME='������'; --unique constraint (KH.EMPLOYEE_PK) violated
    UPDATE EMPLOYEE
        SET EMP_ID=NULL
        WHERE EMP_ID=200; --PK �� NOT NULL���� �����.
    -- ��� ��������� Ȯ������ ��ɾ� : COMMIT;
    -- ����Ŭ���� DB�� �����ϰ� �ڹٿ��� �ٷΕ��پ��� ���� ���ٰ� ���ð�
    --�׋� COMMIT�� ���ָ�ȴ�.
    COMMIT;
    
    
    
    /*
        ���̺� ��ϵ� �����͸� "��"������ �����ϴ� ����.
        [ǥ����]
        
        DELETE FROM ���̺� ��
        WHERE ����; ---WHERE ��������. ������ ����� ����
           
    */
    --EMPLOYEE�࿡�� ��� �� ����
    
    DELETE FROM EMPLOYEE;
    SELECT * FROM EMPLOYEE;
    ROLLBACK;-->���������� Ŀ���� ����
    
    -- EMPLOYEE ���̺��� �ΰ�� ���2 ����� ������ �����
    DELETE FROM EMPLOYEE
    WHERE (EMP_NAME='�ΰ��'OR EMP_NAME='����');
    --DELETE �Ҷ� OR�� �߸����� �߸����󰥼��� ������ ��ȣ�� ��������
    
    --DEPARTMET ���̺�κ��� DEPT_ID �� D1�� �μ� ����
    DELETE FROM DEPARTMENT
    WHERE DEPT_ID='D1';
    --���࿡ EMPLOYEE ���̺��� DEPT_CODE�÷����� �ܷ�Ű�� �����ϰ� �������
    --������ ���� �ʾ������̴�, ������ �Ǿ��ٴ� ���� �� �ܷ�Ű�� ����ϰ� ���� �ʴ�.
    
    
    /*
        TRUNCATE : ���̺��� ��ü ���� ��� �����Ҷ� ����ϴ� ����(����)
                    DELETE�������� ����ӵ��� ����
                    ������ �������� �Ұ�
                    ROLLBACK�� �Ұ�����
        [ǥ����]
        TRUNCATE TABLE ���̺��;
        
        DELETE ������ ��
            TRUNCATE TABLE ���̺��         DELETE TABLE ���̺��
            ---------------------------------------------------
            ������ ���� ���� �Ұ� (WHERE X)   Ư���������ð���(WHERE O)
            ����ӵ��� ����                    ����ӵ��� ����
            ROLLBACK �Ұ�                    ROLLBACK ����
    
    */
    
    SELECT * FROM EMP_SALARY;
    DELETE FROM EMP_SALARY;
    ROLLBACK;
    TRUNCATE TABLE EMP_SALARY;--�߷Ƚ��ϴٶ�� ���̳����� ������?
    
    
    
    
    
    
    
    