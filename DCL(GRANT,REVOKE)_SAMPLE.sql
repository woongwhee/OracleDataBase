--1.CREATE TABLE ���� �ο��ޱ���

CREATE TABLE TEST (
    TEST_ID NUMBER(10)
);--insufficient privileges ���� �����

--2.CREATE TABLE ���� �� �ο�������
CREATE TABLE TEST (
    TEST_ID NUMBER(10)
);
---no privileges on tablespace 'SYSTEM'
--TABLESPACE : ���̺���� ���ִ� ����
--SAMPLE�������� TABLESPACE�� ���� �Ҵ���� �ʾ���

--3. TABLESPACE�� �Ҵ������
CREATE TABLE TEST (
    TEST_ID NUMBER
);

--�� ���̺���������� �ο��ްԵǸ�
--������ �����ϰ� �ִ� ���̺���� ����(SELECT,INSERT,UPDATE ..DML)�ϴ°��� ��������.

INSERT INTO TEST VALUES(1);

SELECT * FROM TEST;
-- 4. �丸���
CREATE VIEW VW_TEST AS
    SELECT * FROM TEST;
    --"insufficient privileges" ���� �����
    
--���� �ο� ������
CREATE VIEW VW_TEST AS
    SELECT * FROM TEST;--�����Ϸ�
    
    
--5. SAMPLE�������� KH������ ���̺� �����ؼ� ��ȸ�� ����.
SELECT * FROM EMPLOYEE;--�̷�������
SELECT * FROM KH.EMPLOYEE; --KH���ٱ����� ������
--SELECT ON �ο�������
SELECT * FROM KH.EMPLOYEE;--���ٰ���
    
--6. SAMPLE�������� KH ������ DEPARTMENT ���̺� �����ؼ� �� �����غ���.
INSERT INTO KH.DEPARTMENT VALUES('D0','ȸ���','L2'); --���Ѿ�� �߻�


--���Ѻο���
INSERT INTO KH.DEPARTMENT VALUES('D0','ȸ���','L2'); 
--�ٸ� ���̺� ���� ��������� COMMIT�� ���� �ʴ´ٸ� Ȯ�ε��� �ʰ� ������� ���� ������ ����
--7. SAMPLE�� ���̺� ���� ������ ������
CREATE TABLE TEST2 (
    TEST_ID NUMBER
);--"insufficient privileges" ������ ���ѱ�� Ȯ�� �� �� �ִ�.