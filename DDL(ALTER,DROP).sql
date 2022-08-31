/*
    DDL: ������ ���� ���
    
    ��ü���� ���Ӱ� ����(CREATE),�����ϰ� ,�����ϴ� ����
    
    1.ALTER
    ��ü�� ������ �����ϴ� ����.
    
    <���̺� ����>
    [ǥ����]
    ALTER TABLE ���̺�� ������ ����;
    
    -������ ����
    1)�÷��߰� /���� /����
    2)�������� �߰�/����=> ������ �Ұ�(�����ϰ����Ѵٸ� ������ ������ �߰�)
    3)���̺�� /Į����/�������Ǹ� ����
*/
--1. Į�� �߰�/����/����
    --ADD Į���� �ڷ��� DEFAULT �⺻��(DEFAULT ��������)

SELECT * FROM DEPT_COPY;
--CNAME Į���߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(2);
--���ο� �÷��� ��������� �⺻������ NULL������ ä����
--LNAME Į�� �߰� DEFUALT ����
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
CONSTRNT
--���ο� Į���� �߰��ϰ� �⺻������ �ѱ��� �߰���
   
    --MODIFY
        --MODIFY Į���� �ٲ� �ڷ���
        --MODIFY Į���� DEFAULT �ٲܱ⺻��
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
--���� �����ϰ����ϴ� �÷��� �̹� ����ִ� ���� ������ �ٸ� Ÿ�����δ� ������ �Ұ�����
-- DEPT_COPY���̺� DEPT_ID�� NUMBER�� �����ϰ����Ѵٸ� ������ �����̴�
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;    
--"column to be modified must be empty to change datatype"
--���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ� ���� ��ġ�ϴ� �÷��̰ų� Ȥ�� �����ִ� �÷�, 
--�׸��� �� ū����Ʈ�� �ڷ������θ� ���氡����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1);
--cannot decrease column length because some value is too big ����� 

/*���� -> ����(X)
    ����->������ ���(X)
    ����->���� (O)
    ����->������ Ȯ��(O)
*/
--�ѹ��� ������ Į�� �ڷ��� ����
--DEPT_TITLE�� ������ Ÿ���� VARCHAR2(40)����
--LOCATION_ID�� ������Ÿ�Ԥ��� VARCHAR2(2)��
--LNAMEĮ���� �⺻���� '�̱�'
SELECT * FROM DEPT_COPY;
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATTION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '�̱�';
--�÷����� DROM COLUMN �÷���
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;
--DDL ���� ������ �Ұ��� �ϴ�.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
--cannot drop all columns in a table"
--�� DROP COLUMN�� �ϱ����ؼ��� �ּ��� COLUMN�� �ϳ��� �����ؾߵȴ�.

/*
    2)�������� �߰�/ ����
        �������� �߰�
        -PRIMARY KEY : ADD PRIAMRY KEY(�÷���)
        -FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ������ ���̺��[(������ �÷���)]
        -UNIQUE : ADD UNIQUE(�÷���)
        -CHECK : ADD CHECK(�÷��� ���� ��������)
        -NOT NULL : MODIFY �÷��� NOT NULL;
        
        ������ ���������� �����ʹٸ�
        CONSTRAINT �������Ǹ� �տ��ٺ���
            -> �����̰�������
            ->���ǻ��� : ���� ������ ������ �̸����� �ο���.
          */
          /*  
        DEPT_COPY ���̺�κ���
        DEPT_ID �÷��� PRIMARY _KEY  �������� �߰�
        DEPT_TITLE �÷��� UNIQUE ���������߰�
        LNAMEĮ���� NOT NULL �������� �߰�
    
*/
    ALTER TABLE DEPT_COPY
        ADD PRIMARY KEY (DEPT_ID)
        ADD CONSTRAINT DCOPY_UNIQUE UNIQUE (DEPT_TITLE)
        MODIFY LNAME NOT NULL;
/*
    �������� ����
    
*/
--DEPT_COPY���̺�κ��� PK�� �ش��ϴ� ������ ����
    ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007295;
    ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UNIQUE;
    ALTER TABLE DEPT_COPY MODIFY LNAME NULL;
    
--3) �÷��� /�������Ǹ� / ���̺�� ����
/*�÷�����
    RENAME COLUMN �����÷��� TO �ٲ� �÷���
  */  
  ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
    
    --�������Ǹ� ���� RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
    --DEPT COPY�� SYS_C007286�� DCOPY_DI_NN
    ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007286 TO DCOPY_DI_NN;
    
    --���̺� �� ���� : RENAME �������̺�� TO �ٲ� ���̺��( �������̺�� ��������)
    ALTER TABLE DEPT_COPY RENAME TO DEPT_COFFE;
    ALTER TABLE DEPT_COFFE RENAME TO DEPT_COPY;

/*
    2.DROP
    ��ü�� �����ϴ� ����
    [ǥ����]
    DROP TABLE �����ϰ����ϴ� ���̺��̸�

*/            
 --FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ������ ���̺��[(������ �÷���)]
    DROP TABLE EMP_NEW;
    --�θ����̺��� �����ϴ� ��쿡�� ����� ���� ���� ����
    --�θ����̺��� ����� ��� �׽�Ʈ
    CREATE TABLE DEPT_TEST
        AS SELECT * FROM DEPARTMENT;
    --DEPT_TEST �� DEPT_ID�� PRIMARY_KEY �߰� 
    ALTER TABLE DEPT_COPY ADD PRIMARY_KEY(DEPT_ID);
    ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007304 TO DCOPY_ID_PK;
    --EMPLOYEE_COPY3�� �ܷ�Ű(DEPT_CODE)�� �߰�(�ܷ�Ű�̸� ECOPY_FK)
    ALTER TABLE EMPLOYEE_COPY3 
        ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_COPY(DEPT_ID);
    -- �̶� �θ����̺��� DEPT_TEST���̺� , DEPT_ID�� ����
    DROP TABLE DEPT_COPY;--unique/primary keys in table referenced by foreign keys
    --�����־ �θ����̺��� ������������
 
--�θ����̺� ���� 


    


--1.�ڽ����̺��� ���� �������� ���̺� �����Ѵ�.
DROP TABLE EMPLOYEE_COPY3;
DROP TABLE DEPT_COPY;
COMMIT;

--2. �θ����̺� �����ϵ� �¹����մ� �ܷ�Ű �������ǵ� �Բ� �����Ѵ�
DROP TABLE DEPT_COPY CASCADE CONSTRAINT;