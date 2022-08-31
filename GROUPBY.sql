/*
    <GROUP BY ��>
    
    �׷��� ������ ������ ������ �� �ִ� ���� - > �׷��Լ��� ���� ����.
    �ش� ���õ� ���غ��� �׷��� ������ ����.
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
    
    [ǥ����]
    GROUP BY ������ �����̵� Į��.
*/

SELECT DEPT_CODE, SUM(SALARY) -- 4
FROM EMPLOYEE -- 1
WHERE 1=1 -- 2
GROUP BY DEPT_CODE -- 3
ORDER BY DEPT_CODE -- 5
;

-- D1�μ��� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE ='D1';

-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿� ���� �޿����� ������������ �����ؼ� ��ȸ.
SELECT 
    dept_code,
    sum(salary) AS "�޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY �޿� DESC;

-- �� ���޺��� �����ڵ� , �� �޿��� �� , ����� , ���ʽ��� �޴� �����, ��ձ޿� , �ְ�޿�, �ּұ޿�.
-- JOB�ڵ캰�� ������������
SELECT
    JOB_CODE,
    SUM(SALARY),
    COUNT(*),
    COUNT(BONUS),
    FLOOR(AVG(SALARY)),
    MAX(SALARY),
    MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- �� �μ��� �μ��ڵ� , ����� , ���ʽ��� �޴� ����� , ����� �ִ� ����� , ��ձ޿�
-- �μ��� ������������
SELECT 
    dept_code AS "�μ��ڵ�",
    COUNT(*) AS "�����",
    COUNT(BONUS) AS "���ʽ��� �޴� �����",
    COUNT(MANAGER_ID) AS "����� �ִ� �����",
    FLOOR(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- ���� �� �����
--  SUBSTR(EMP_NO,8,1) == 1 ,2
SELECT
    DECODE(SUBSTR(EMP_NO,8,1) ,'1','��','2','��') AS "����",
    COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);

-- ���� �������� ����, ��ձ޿� , �����
-- CASE WHEN�������� ����, ���� 
-- ��ձ޿��� "��"
SELECT  
    CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '����'
         WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '����'
    END AS "����",
    FLOOR(AVG(SALARY)) || '��' AS "��ձ޿�",
    COUNT(*) AS "�����"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);    

-- �� �μ��� ��ձ޿��� 300������ �̻��� �μ��鸸 ��ȸ.
SELECT 
    dept_code,
    FLOOR(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- ������. 
/*
    <HAVING ��>
    �׷쿡 ���� ������ �����ϰ����Ҷ� ���Ǵ� ����
    (�ַ� �׷��Լ��� ������ ��������) => GROUP BY ���� �Բ� ���δ�.
*/
SELECT 
    dept_code,
    FLOOR(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING FLOOR(AVG(SALARY)) >= 3000000;

-- �� ���޺��� �� �޿����� 1000���� �̻��� ���� �ڵ� , �޿� ������ȸ.
SELECT
    job_code,
    SUM(salary)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;
-- �� ���޺��� �޿� ����� 300�����̻��� �����ڵ� , ��ձ޿�, �����, �ְ�޿�, �ּұ޿�
SELECT -- 5
    job_code,
    FLOOR(AVG(SALARY)) AS "��ձ޿�",
    COUNT(*) AS "�����",
    MAX(SALARY) AS "�ְ�޿�",
    MIN(SALARY) AS "�ּұ޿�"
FROM EMPLOYEE -- 1
WHERE 1=1 -- 2
GROUP BY JOB_CODE -- 3
HAVING FLOOR(AVG(SALARY)) >= 3000000 --4
ORDER BY DEPT_CODE -- 6
; 

-- �� �μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ.
SELECT
    dept_code,
    COUNT(BONUS) AS "���ʽ��޴� �����"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-- �� �μ��� ��� �޿��� 350���� ������ �μ����� ��ȸ.
SELECT
    dept_code,
    FLOOR(AVG(SALARY)) AS "��ձ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) <= 3500000;
------------------------------------------------------------------
/*
    <SELECT�� ���� �� �������>
    5. SELECT ��ȸ�ϰ��� �ϴ� �÷���� ���� / * / ���ͷ� / �������� / �Լ��� AS ��Ī
    1. FROM ��ȸ�ϰ����ϴ� ���̺�� / DUAL(�������̺�)
    2. WHERE ���ǽ�(�׷��Լ� X)
    3. GROUP BY �׷� ���ؿ� �ش��ϴ� Į����/ �Լ���
    4. HAVING �׷��Լ��Ŀ� ���� ���ǽ�
    6. ORDER BY [���ı��ؿ��ش��ϴ� �÷��� / ��Ī/ Į���Ǽ���] [ASC/DESC] [NULLS FIRST/NULLS LAST]
*/
-------------------------------------------------------------------
/*
    <���� ������ SET OPERATOR>
    
    ���� ���� �������� ������ �ϳ��� ���������� ����� ������.
    
    - UNION(������) : �� �������� ������ ������� ���� �� �ߺ��Ǵ� �κ��� �ѹ��� ���� �ߺ��� �����Ѱ� => OR
    - UNION ALL : �� �������� ������ ������� ���� �� �ߺ� ���Ÿ� ���� ���� ��.
                  => ������ + ������
    
    - INTERSECT(������) : �� �������� ������ ������� �ߺ��� �κ� => AND
    - MINUS(������) : ���� ������ ��������� ���� ������ ������� �� ������ �κ�.
                     -> ���� ������ ����� - ������1
                    
    �������� : �� �������� ����� ���ļ� �Ѱ��� ���̺�� ������� �ϱ� ������ 
              �� �������� SELECT�� �κ��� ���ƾ��Ѵ� -> ��, ��ȸ�� Į���� �����ؾ���.  
*/
-- 1. UNION : �� �������� ������ ������� �������� �ߺ��� ��������.

-- �μ��ڵ尡 D5�̰ų��Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ( ���, ����� , �μ��ڵ� , �޿�) 

-- �μ��ڵ尡 D5�� ����鸸��ȸ
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6�� ��ȸ.

-- �޿��� 300���� �ʰ��� �����
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY >= 3000000; -- 8���� �μ��ڵ尡 D5�� ����� 2�� ����.


SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- �μ��ڵ尡 D5�̰ų� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' OR SALARY > 3000000 -- 12��
-- �����ڵ尡 J6�̰ų� �Ǵ� �μ��ڵ尡 D1�� �������ȸ
UNION
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' OR DEPT_CODE ='D1'; -- 7�� 

-- 2. UNION ALL : �������� ��������� ���ؼ� �����ִ� ������(�ߺ����Ÿ� ����!)
-- ���� �ڵ尡 J6�̰ų� �Ǵ� �μ��ڵ尡 D1�� ����� ��ȸ (��� ,�����, �μ��ڵ� ,�����ڵ�)

-- 1. �ߺ����������ʰ�, ��ü�����ȸ
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE ='J6' -- 6���� ����� ��� ���� �μ��ڵ尡 D1�� ����� 2
UNION ALL
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; -- 3���ְ� J6�� ����� 2��
-- 3. INTERSECT : ������ , ���� ��������� �ߺ��� ������� ��ȸ (AND)
-- 2. �ߺ��� ����� ��ȸ.
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE ='J6' -- 6���� ����� ��� ���� �μ��ڵ尡 D1�� ����� 2
INTERSECT
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'; -- 3���ְ� J6�� ����� 2��

-- 4. MINUS : ������ , �������� ����� ���� ���� ����� �� ������.
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE ='J6' -- 6���� ����� ��� ���� �μ��ڵ尡 D1�� ����� 2
MINUS
SELECT 
    emp_id,
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE DEPT_CODE ='D1'
ORDER BY DEPT_CODE NULLS LAST;
    
   





















