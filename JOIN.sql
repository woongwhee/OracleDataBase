/*
    <JOIN>
    
    �ΰ� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ���� => SELECT�� �̿�
    ��ȸ ����� �ϳ��� �����(RESULT SET)���� ����.
    
    JOIN�� �ϴ� ���� ? 
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����.
    ��������� ������̺�, ���������� �������̺� , ��� -> �ߺ��� �ּ�ȭ��Ű������.
    => �� , JOIN ������ �̿��ؼ� ������ ���̺� ���� "����"�� �ξ ���� ��ȸ�ؾ���.
    => ��, ������ JOIN�� �ϴ°��� �ƴ϶� ���̺� ���� "�����"�� �ش�Ǵ� Į���� ��Ī���Ѽ� ��ȸ�ؾ���.
    
    ������ �з� : JOIN�� ũ�� "����Ŭ ���뱸��" �� ANSI(�̱� ���� ǥ�� ��ȸ)���� ���� ��������.
    
    ����� �з�
            ����Ŭ ���� ����                  |            ANSI ����(����Ŭ + �ٸ� DBMS)
            �����(EQUAL JOIN)             |      ��������(INNER JOIN)  -> JOIN USING/ON
            ----------------------------------------------------------------------------
            ��������                        |       �ܺ�����(OUTER JOIN) -> JOIN USING            
            LEFT OUTER JOIN                |       ���� �ܺ�����(LEFT OUTER JOIN)            
            RIGHT OUTER JOIN               |       ������ �ܺ� ����(RIGHT OUTER JOIN
                                                    ��ü �ܺ� ����(FULL OUTER JOIN) : ����Ŭ���� ���Ұ�.
    -------------------------------------------------------------------------------------------
            ī�׽þ� ��(CARTESIAN PRODUCT)   |       ���� ����(CROSS JOIN)
    ----------------------------------------------------------------------------------------
            ��ü ����(SELF JOIN)
            �� ����(NON EQUAL JOIN)
    --------------------------------------------------------------------------------------
                                    ���� ����(���̺� 3���̻� ����)
    
*/
-- ������̺��� �μ� ����� �˰�������?
-- 1�ܰ� ������̺��� �μ��ڵ� ��ȸ
SELECT 
    emp_id,
    emp_name,
    dept_code
FROM EMPLOYEE; 

SELECT
    DEPT_ID,
    DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ��� ,����� , �����ڵ������ �˶� ���� ����� �˾Ƴ����� �Ѵٸ�?
SELECT 
    emp_id,
    emp_name,
    job_code
FROM EMPLOYEE;

SELECT
    JOB_CODE,
    JOB_NAME
FROM JOB;

--> ���������ؼ� ������� �ش�Ǵ� Į���鸸 ����� ��Ī��Ű�� �ϳ��� RESULTSET���� ��ȸ����������.

/*
    1. �����(EQUAL JOIN) / ��������(INNER JOIN)
    �����Ű���� �ϴ� Į���� ���� "��ġ�ϴ� ��鸸" ���εǼ� ��ȸ.
    (== ��ġ���� �ʴ� ������ ������� ����)
    => ����񱳿����� = ("��ġ�Ѵ�"��� ������ ������)
    
    [ǥ����]
    �����(����Ŭ����)
    SELECT ��ȸ�ϰ����ϴ� �÷���� ����
    FROM �����ϰ����ϴ� ���̺��� ����
    WHERE ������ Į���� ���� ������ ����( = )
    
    ��������(ANSI����) : ON ����
    SELECT ��ȸ�ϰ����ϴ� Į����鳪��
    FROM �����ϰ����ϴ� ���̺�� 1�� ����
    JOIN �����ϰ����ϴ� ���̺�� 1���� ���� ON (������ Ŀ���� ���� ���������� (=))
    
    �������� (ANSI����) : USING ����=> ��,  ������ Į������ �����Ѱ�쿡�� ��.
    SELELCT ��ȸ�ϰ��� �ϴ� Į����� ����
    FROM �����ϰ����ϴ� ���̺�� 1��������
    JOIN ������ ���̺�� 1���� ���� USING(������ Į���� 1������)
    
    + ���࿡ ������ Į������ �����ѵ� USING������ ������� �ʴ°�� �ݵ��,
    ��������� ���̺�� OR ���̺��� ��Ī�� �ۼ��ؼ� ������̺��� Į������ �˷������.
*/

-- ����Ŭ ���뱸��

-- 1) ��ü ������� ��� ,����� , �μ��ڵ� , �μ������ �˾ƺ���.
-- FROM ���� ��ȸ�ϰ����ϴ� ���̺���� ,�� �̿��ؼ� �����ϰ�
-- WHERE ���� ��Ī��ų �÷��� ���� ������ ����
SELECT
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ���� �ʴ� �����͵��� ��ȸ���� ����(NULL)
--> �ΰ� �̻��� ���̺��� �����Ҷ� ��ġ�ϴ°��� ���� ���� ������� ���ܵǾ���.
SELECT
    emp_id,
    emp_name,
    e.job_code,
    job_name
FROM EMPLOYEE e , JOB j -- �� ���̺��� ��Ī�� �ٿ��� ����ϴ� ����� ����.
WHERE e.JOB_CODE = j.JOB_CODE; --
-- colum ambiguously defined -> Ȯ���� � ���̺��� Į�������� �� ����������.

-- ANSI����.
-- FROM�� �ڿ� �������̺��� 1���� ����.
-- �� �ڿ� JOIN ������ ���� ��ȸ�ϰ����ϴ� ���̺� ���, ���� ��Ī��ų �÷��� ���� ���ǵ� ���� ���.
-- USING ���� / ON ����.

SELECT
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- INNER�� ��������.

SELECT
    emp_id,
    emp_name,
    job_code,
    job_name
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
-- USING���� : �÷����� ������ ��쿡�� ��� ����, ������ �÷��� �ϳ������ָ� �˾Ƽ� ��Ī������(AMBIGUIOUSLY �߻�X)

SELECT
    emp_id,
    emp_name,
    E.job_code,
    job_name
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

-- [����] �ڿ�����(NATURAL JOIN) : ����� ����� �ϳ�
-- => ������ Ÿ�԰� �̸��� ���� Į���� ���� �������� �̿��ϴ� ���.
SELECT 
    emp_id,
    emp_name,
    job_code,
    job_name
FROM EMPLOYEE
NATURAL JOIN JOB;
-- �ΰ��� ���̺��� �����ߴµ� ,�����Ե� �ΰ��� ���̺� ��ġ�ϴ� Į���� �� �ϳ� �����ϰ� �����ؼ� ������.
-- -> �ڿ������� �����ν� �˾Ƽ� ��Ī�Ǽ� ���ε�.

-- ������ �븮�� ������� ������ ��ȸ(���, �����, �e�� , ���޸�)
SELECT
    emp_id,
    emp_name,
    salary,
    job_name
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '�븮';

-- ANSI�������� ���.
SELECT
    E.emp_id,
    E.emp_name,
    E.salary,
    J.job_name
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '�븮';

SELECT
    emp_id,
    emp_name,
    salary,
    job_name
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';
--------------------------------------------------------------------------------
-- 1. �μ��� �λ�������� ������� ��� ,����� ,���ʽ��� ��ȸ.
--> ����Ŭ���뱸��
SELECT 
    emp_id,
    emp_name,
    bonus
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE ='�λ������';
--> ANSI����
SELECT 
    emp_id,
    emp_name,
    bonus
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';
-- 2. �μ��� �ѹ��ΰ� �ƴ� ������� ���, ����� , �޿� , �Ի�����ȸ.
--> ����Ŭ���뱸��
SELECT 
    emp_id,
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '�ѹ���';
--> ANSI����
SELECT 
    emp_id,
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���';
-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ� , �μ��� ��ȸ
--> ����Ŭ���뱸��
SELECT
    emp_id,
    emp_name,
    bonus,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL;
--> ANSI����
SELECT
    emp_id,
    emp_name,
    bonus,
    dept_title
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;
--4. �Ʒ��� �� ���̺� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME)��ȸ
SELECT * FROM DEPARTMENT; --LOCATION_ID
SELECT * FROM LOCATION; -- LOCATION_CODE
--> ����Ŭ���뱸��
SELECT 
    dept_id,
    dept_title,
    local_code,
    local_name
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
--> ANSI����
 SELECT 
    dept_id,
    dept_title,
    local_code,
    local_name
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- �����/ �������� : ��ġ���� ���� ���� ���ܵǰ� ��ȸ����.

---------------------------------------------------------------------------

-- ��ü ������� ����� , �޿� ,�μ���
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- DEPT_CODE�� NULL�� �θ��� ����� ��ȸ���� ����.

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    
    ���̺��� JOIN�ÿ� "��ġ���� �����൵" ���Խ�����.
    ��, �ݵ�� LEFT/ RIGHT�� �����ؾ��Ѵ�.=> �����̵Ǵ� ���̺��� �������ش�.
    
    ��ġ�ϴ��� + �����̵Ǵ� ���̺��� �������� ��ġ���� �ʴ� �൵ ���Խ��Ѽ���ȸ������
*/
-- 1) LEFT OUTER JOIN : �� ���̺��߿� ���� ����� ���̺��� �������� JOIN.
--                      �� , ���� �Ǿ��� ���� ���� ����� ���̺��� �����ʹ� ������ ��ȸ.

-- ANSI����
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- EMPLOYEE���̺��� �������� ��ȸ�߱� ������ , EMPLOPYEE�� �����ϴ� �����ʹ� ��ġ�ϵ� ��ġ���� �ʵ� �� ��ȸ�ϰԲ��Ѵ�.

-- ����Ŭ ���뱸��
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- ���� �������� ���� ���̺��� �÷����� �ƴ�, �ݴ� ���̺��� �÷��� (+)�� �ٿ��ش�.

-- 2) RIGHT OUTER JOIN : �� ���̺��� ������ ����� ���̺��� �������̺� ��ڴ�.
--                       �� , �����Ǿ��� ������ ����� ���̺����ʹ� ��� �������ڴ�.

-- ANSI
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE 
RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ����Ŭ ���뱸��
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL OUTER JOIN : �����̺��� ��� ������ȸ
-- ��ġ�ϴ� ��� + LEFT OUTER JOIN ���� ���Ӱ� �߰����� + RIGHT OUTER JOIN ���� ���Ӱ��߰��� ���
-- ANSI
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- ����Ŭ���뱸��
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);
-- ����Ŭ���뱸�� ������ FULL OUTER JOIN�� ���Ұ�
/*
    3. ī�׽þ��� ��(CARTESIAN PRODUCT) / ��������(CROSS JOIN)
    
    ��� ���̺��� �� ����� ���μ��� ���ε� ������ ��ȸ��(������)
    �� ���̺� ����� ��� ������ ����� ������ ��µ�.
    
    --> ���� N�� , M���� ���� ���� �����͵��� ī�׽þȰ��ǰ���� N*M��
    --> ��� ����� ���� �� ������ ��ȸ�ϰڴ�.
    --> ����� �����͸� ���(�������� ������ ����) 
    
*/
SELECT 
    emp_name,
    dept_title
FROM EMPLOYEE, DEPARTMENT;

SELECT 
    e1.emp_name,
    e2.emp_name
FROM EMPLOYEE E1, EMPLOYEE E2;--���� ���̺� ������ ���ٰ����ε�?
--ANSI ����
SELECT  
    emp_name,
    dept_title
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;
--ī�׽þ��� ���� ��� : WHERE���� ����ϴ� ���� ������ �߸��Ǿ��ų�, �ƿ� ������� �߻���.
/*
    4. �� ����(NON-EQUAL JOIN)
    '='�� ������� �ʴ� ���ǹ� -> �ٸ� �񱳿����ڸ� �Ἥ �����ϰڴ�(<,>,<=,>=,BETWEEN AND)
    => ������ �÷� ������ ��ġ�ϴ� ��찡 �ƴ϶� "����"�� ���ԵǴ� ��� ��Ī�ؼ� ��ȸ�ϰڴ�. 
*/
-->����� �޿� �޿����
--> ����Ŭ���뱸��
SELECT
    EMP_NAME,
    E.SALARY,
    S.SAL_LEVEL
FROM EMPLOYEE E, SAL_GRADE S
--WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
WHERE SALARY>MIN_SAL AND SALARY<MAX_SAL;    

SELECT
    EMP_NAME,
    SALARY,
    S.SAL_LEVEL
    FROM EMPLOYEE E
    --JOIN SAL_GRADE S ON( SALARY>=MIN_SAL AND SALARY<=MAX_SAL);
    JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
-- USING������ ����ο����� �÷����� ������ ��츸 ��밡���ϴ�. ������ �����ο����� ON������ ����Ѵ�.

/*
    5. ��ü����(SELF JOIN)
    ���� ���̺��� ���� �ϴ� ���
*/
--����Ŭ
SELECT
    e.emp_name as �̸�,
    e.emp_id,
    s.emp_name as �����,
    e.manager_id,
    S.emp_id
FROM EMPLOYEE E,EMPLOYEE S
WHERE E.MANAGER_ID=S.EMP_ID;
--�̷��� ������ϸ� ����� ���� ������� ��� ����� �����ʴ´� ������ ����� ���� ������� �������ߵ�
SELECT
    e.emp_name as �̸�,
    e.emp_id,
    s.emp_name as �����,
    e.manager_id,
    S.emp_id
FROM EMPLOYEE E,EMPLOYEE S
WHERE E.MANAGER_ID=S.EMP_ID(+);

--ANSI
SELECT
    e.emp_name as �̸�,
    NVL(M.emp_name,'����') as ����̸�    
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID=M.EMP_ID);

/*
    ��������
    1:1��Ī�̾ƴ϶� 3���̻��� ���̺��� ��Ī�ؼ� ��ȸ�ϰڴ�.
    ���μ����� �߿��ϴ�.
    ������ �Ǵ� ���̺��� �տ� �ۼ��ؾߵ�

*/

--��� ����� �μ��� ���޸�
--ORACLE
SELECT
    emp_name,
    emp_id,
    dept_title,
    job_name
FROM JOB J,DEPARTMENT D,EMPLOYEE E
WHERE E.JOB_CODE=J.JOB_CODE(+) AND DEPT_CODE=DEPT_ID(+) ;--������ ������� ������̵ǳ�?
--ANSI
SELECT
    EMP_NAME,
    emp_id,
    dept_title,
    job_name
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
LEFT JOIN JOB USING (JOB_CODE);
--����?
--??
----??







