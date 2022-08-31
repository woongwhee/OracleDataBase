/*
    DCL(DATA CONTROL LANGUAGE)
    ������ ���� ���.
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ���ϴ� ���
    
    -���Ѻο�(GRANT)
        �ý��۱���: Ư�� DB�� �����ϴ� ���� ��ü���� ������ �� �ִ¤� ����
        ��ü ���ٱ��� : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
    
    -�ý��� ����
        [ǥ����]
        GRANT ����1, ����2,.... TO ������
        
        -�ý��� ������ ����
        CREATE SESSION : ������ ������ �� �ִ� ����. 
        CREATE TABLE : ���̺��� ������ �� �ִ� ����.
        CREATE VIEW : �並 ���� �� �� �ִ� ����.
        CREATE SEQUENCE : �������� ������ �� �ִ� ����.
        CREATE USER : ������ ���� �� �� �ִ� ����.
    
    
*/

--1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

--2. SAMPLE������ �����ϱ� ���� CREATE SESSION ���Ѻο�
GRANT CREATE SESSION TO SAMPLE;

--3. SAMPLE�� TABLE�� �����Ҽ��ִ� CREATE TABLE �� �ο��Ѵ�.
GRANT CREATE TABLE TO SAMPLE;
--4. SAMPLE ������ TABLESPACE �� �Ҵ��� �ֱ� (SAMPLE ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-- QUQTA : �� -> �����ִ�. �Ҵ��Ѵ�.
-- 2M: 2MAGA BYTE

--5. SAMPLE ������ VIEW�����Ҽ��ִ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;

--6. SAMPLE ������ KH.EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο�.
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;



/*
    -��ü����
    Ư����ü���� ������ �� �ִ� ����
    ���� : SELECT, INSERT , UPDATE, DELETE => DML
    
    [ǥ����]
    GRANT ���� ���� ON Ư����ü TO ������
    
    ��������
    SELECT : TABLE, VIEW, SEQUENCE
    INSERT : TABLE, VIEW
    UPDATE : TABLE, VIEW
    DELETE : TABLE, VIEW
*/

--7. SAMPLE������ KH.DEPARTMENT ���̺� ���� ���� �� �� �ִ� ���� �ο�.

GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

/*
    <�� ROLE>
    Ư�� ���ѵ��� �ϳ��� �������� ��� ������.
    
    CONNECT : CREATE SESSION(������ ���̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE , SELECT , INSERT
            (Ư�� ��ü���� ���� �� ���� �� �� �ִ� ����.)    
*/
------------------------------------------------------------------------------------------
/*
    <���� ȸ�� REVOKE>
    [ǥ����]
    REVOKE ����1, ����2 FROM ������;
    
    ������ ������ ����ϴ� ��ɾ�
*/

--8. SAMPLE���� ���̺��� �����Ҽ� �ִ� ������ �����.

REVOKE CREATE TABLE FROM SAMPLE;


------------------DCL �ǽ�����----------------

-- ����ڿ��� �ο��� ���� :CONNECT RESOURCE
-- ���� ����ڴ� : MYMY
CREATE USER MYMY IDENTIFIED BY MYMY;

GRANT CONNECT,RESOURCE TO MYMY;
