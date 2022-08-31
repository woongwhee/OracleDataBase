
/*
    <INDEX>
    å���� �������� ����
    
    ���� ������ ���ٸ� ���� ���ϴ� é��, Į���� ����ִ��� ���å�� �ϳ��ϳ� �Ⱦ������.
    
    ���������� ���̺��� JOIN Ȥ�� ���������� �����͸� ��ȸ(SELECT)�Ҷ�,
    �ε����� �����ٸ� ���̺��� ��� �����͸� �ϳ��� ������ (FULL SCAN)���� ���ϴ� �����͸� �����ð���.
    
    �������� �ε��� ������ �صθ� ��� ���̺��� ������ �ʰ� ���� ���ϴ� ���Ǹ� ������ �����ü� ��������.
    
    �ε����� Ư¡
    
    - �ε����� ������ Į���� �����͵��� ������ '��������'���� ���Ĥ��Ͽ� Ư���޸𸮰����� ������ �ּҿ� �Բ� �����Ŵ
    => �� �޸𸮿� ������ �����Ѵ�.
    
*/

SELECT * FROM USER_INDEXES;--PK������ �ڵ����� �ε����� �����ȴ�.

-- ���� ������ �ε����� �ε����� ����� �÷��� Ȯ���غ�����
SELECT * FROM USER_IND_COLUMNS;


--�����ȹȮ��.

SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
WHERE EMP_NAME='������';
--0.022��

SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
WHERE EMP_ID='201';
--0.003�� ���� ��������

---SELECT���� 2�������ϸ� 0.001�ʷ� �ٲ��

--�ε��� �������
--[ǥ����]
--CREATE INDEX �ε����� ON ���̺��(�÷���);
CREATE INDEX EMPLOYEE_EMP_NAME ON EMPLOYEE(EMP_NAME);
SELECT * FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
WHERE EMP_NAME='������';
--0.002�� !!

--�����Ѱ��� ���̺� 100���ǿ��� 10���Ǹ� ��ȸ�Ҷ� 10~15������ �����͸� ��ȸ�Ҷ� ȿ���� ���ٳ׿�~
-- �츮�� �ε����� ����� ���������� �ش� �÷��� ����ص� �ε����� ������� �ʴ� ��쵵����
-- �ش� �ε����� Ż�� ��Ż���� ��Ƽ�������� �Ǵ��ϴ�.'



---�ε��� ����
DROP INDEX EMPLOYEE_EMP_NAME;



-- �����÷��� �ε����� �ο� �� �� ����.
CREATE INDEX EMPLOYEE_EMP_NAME_DEPE_CODE ON EMPLOYEE(EMP_NAME,DEPT_CODE);
--�ϳ��� INDEXȭ�Ǿ������� Ż���� �ִ�.

SELECT * FROM EMPLOYEE
WHERE EMP_NAME='�ڳ���' AND DEPT_CODE='D5'; -- FULLSCAN��

DROP INDEX EMPLOYEE_EMP_NAME_DEPE_CODE ;
CREATE USER INDEXTEST IDENTIFIED BY KH;
GRANT CONNECT, RESOURCE TO INDEXTEST;

/*
    �ε����� ȿ�������� �������ؼ�?
    �������� �������� ����, �������� ���� ȣ��Ǹ�, �ߺ����� ���� �÷��� ��������.
    => �� , PK�÷��� ���� ȿ���� ����.
    
    1) �������� ���� �����ϴ� �÷�
    2) �׻� = ���� �񱳵Ǵ� �÷�
    3) �ߺ��Ǵ� �����Ͱ� �ּ����� �÷�(==�������� ����.)
    4) ORDER BY ���� ���� ���Ǵ� �÷�
    5) JOIN �������� ���� ���Ǵ� �÷�.
*/



