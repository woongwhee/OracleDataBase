/*
    <SUBQUERY ��������>
    
    �ϳ��� �ֵ� SQL(SELCT, CREATE ,INSERT, UPDET, ....) �ȿ� ���Ե� �� �ϳ��� SELECT ��.
    
    ���� SQL���� ���ؼ� '����' ������ �ϴ� SELECT��.
    ->�ַ� ������(WHERE, HAVING)�ȿ��� ���δ�.
    ->()�ȿ� ���δ�.

*/
---���ö����� ���� �μ��� �����.
--1)���ö ����� �μ�ã��
SELECT
    dept_code
FROM EMPLOYEE
WHERE EMP_NAME='���ö';
--D9
--2) 1���� ã�� �μ��ڵ�� ��ġ�ϴ� ������� ã��
SELECT
    *
FROM EMPLOYEE
WHERE DEPT_CODE='D9';    
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE=(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME ='���ö');
--������������ �̿��ϸ� �����ϰ� �����ִ�.
SELECT
    EMP_ID,
    emp_name,
    job_code,
    SALARY
FROM EMPLOYEE
WHERE SALARY>(SELECT AVG(SALARY) FROM EMPLOYEE);
--������ļ���������� �Ѵ� �巡���ؼ� �����ϸ� ������� �����ִ�.
/*
    �������� ����
    ���������� ������ ������� �����̳Ŀ� ���� ���е�
    -������ (���Ͽ�)�������� : ���������� ������ ������� ������ 1���϶� (��ĭ�� �÷������� ���ö�)
    -������(���Ͽ�)�������� (������)���߿� ��������: �������� ���������� 1��¥���϶�
    ������ ���߿� : ���������� ������ ������� ������ �������϶�.(FROM���� �������)
    ���������� ���п����� ��밡���� �����ڰ� �޶���.   
*/

/*
    �ܴܼ�������(single row subquery):������� ������ 1���϶�
    �Ϲݿ����� ��밡�� (=,!=,>,<)

*/
--�������� ��ձ޿� ���� ���� �޴� ������� ����� �����ڵ� �޿���ȸ
    SELECT 
        emp_name, 
        job_code,
        salary
    FROM EMPLOYEE
    WHERE SALARY< (SELECT AVG(salary)FROM EMPLOYEE);
    

--�����޿��� �޴� ������� ��� ����� �����ڵ� �޿� �Ի��� ��ȸ
    SELECT
        emp_id,
        emp_name,
        job_code,
        hire_date
    FROM EMPLOYEE
    WHERE SALARY=(SELECT min(salary)FROM EMPLOYEE);

--���ö�� �޿����� ���޴� ������� ��� �̸� �μ��ڵ� �޿� ��ȸ
    SELECT
        EMP_NAME,
        JOB_CODE,
        SALARY
    FROM EMPLOYEE
    WHERE SALARY<(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='���ö');
    SELECT
        EMP_NAME,
        SALARY-(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME ='���ö') --��Ģ���굵 �ȴ�.
    FROM EMPLOYEE;
-- ���ö���� ���޴� ������� �̸� �μ��� �޿���ȸ
      SELECT
        EMP_NAME,
        JOB_CODE,
        SALARY,
        DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
    WHERE SALARY>(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='���ö');
    
    --�μ��� �޿� ���� ����ū �μ� �ϳ����� ��ȸ �μ��ڵ� �μ��� �޿�����,
    SELECT
        DEPT_CODE,
        DEPT_TITLE,
        SUM(SALARY)
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
    GROUP BY DEPT_CODE ,DEPT_TITLE
    HAVING SUM(SALARY)=(SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);
    --��ġ�Ǵ� �÷��̶� �׷����� Ȯ���� �������������� ����� ������.
    /*
    ������ ��������(MULTI ROW SUBQUERY)
        ���������� ��ȸ ������� �������� ��� ����Ѵ�.
        - IN() �������� :�������� ������߿� �ϳ��� ��ġ�ϴ� ���� �ִٸ� /NOT IN ���ٸ�
        
        - > ANY() ��������: �������� ������߿� "�ϳ���"Ŭ��� ��  �������� ������߿��� �������� ������ Ŭ���
        - < ANY() ��������:�������� ������߿� "�ϳ���"������� ��  �������� ������߿��� ����ū�� ������ �������
        
        - > ALL()�������� : �������� ������� ��� ������ Ŭ���
                        �￩������ ������߿��� ���� ū ������ Ŭ��� 
    */
--���μ��� �ְ�޿��� �޴� ����� �̸� , �����ڵ� , �޿� ��ȸ

--1)���μ����� �ְ�޿� ��ȸ(������ , ���Ͽ�)
    (SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE);

--2) ���޿��� �������� ����� ��ȸ
    SELECT
        EMP_NAME,
        JOB_CODE,
        SALARY
    FROM EMPLOYEE
    WHERE SALARY IN (SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE);
    
--�Ƹ� �׷캰�� ��ġ�ϴ� ���� ������ �ű�� ��ġ�ϴ� ����� ��ġ�ϸ� �̾ƸԴ´ٴ� ���ε�? GROUPBY�� �Ϲ� �÷��� ��������ϴϱ�

---------------------------------------------------------------------
--������ �Ǵ� ���缮 ����� ���� �μ��� ������� ��ȸ�Ͻÿ�(����� ,�μ��ڵ� , �޿�)
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE IN (
SELECT dept_code FROM EMPLOYEE WHERE EMP_NAME IN('������','�����')
);
--�̿��� �Ǵ� �ϵ���� ���� ������ ������� ��ȸ�Ͻÿ�(�����, �����ڵ� �μ��ڵ� �޿�)
SELECT
    emp_name,
    dept_code,
    job_code
FROM EMPLOYEE
WHERE JOB_CODE IN(
    SELECT
        job_code
    FROM EMPLOYEE
    WHERE EMP_NAME IN ('�̿���','�ϵ���')
);
--�븮�ε� ����޿����� ���̹޴� ������� ��ȸ(�̸� ��� ���� �޿�)
    SELECT 
        emp_name,
        emp_id,
        dept_CODE,
        salary
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    WHERE JOB_NAME = '�븮' AND SALARY >ANY(SELECT salary
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    WHERE JOB_NAME='����');


-- ���� �����ӿ��� "��� " ��� ���������� �޿����ٵ� �� ���� �޴� ���� ��ȸ(
--���,�̸� ���޸� ,�޿�)
    SELECT
        EMP_ID,
        EMP_NAME,
        JOB_NAME,
        SALARY
    FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    WHERE JOB_NAME='����' 
    AND SALARY >ALL(SELECT SALARY FROM EMPLOYEE E
    JOIN JOB J ON J.JOB_CODE=E.JOB_CODE WHERE JOB_NAME='����');
    SELECT
        EMP_ID,
        EMP_NAME,
        JOB_NAME,
        SALARY
        FROM EMPLOYEE E,JOB J
        WHERE J.JOB_CODE=E.JOB_CODE 
        AND J.JOB_NAME='����'
        AND SALARY > (SELECT 
        MAX(SALARY) FROM EMPLOYEE E,JOB J 
        WHERE E.JOB_CODE =J.JOB_CODE AND JOB_NAME ='����' GROUP BY J.JOB_CODE,JOB_NAME );
   
    SELECT
        EMP_NAME,
        JOB_NAME
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    ORDER BY 2;
        
    --���߿� ��������
    --Į���� ������ ���������?
    --������ ����� ���� �μ��ڵ� ���� �����ڵ忡 �ش�Ǵ� ����� ��ȸ(�����, �μ��ڵ� ,�����ڵ�, �����)
    --
    
    
    SELECT 
        emp_name,
        dept_code,
        job_code,
        hire_date
    FROM EMPLOYEE
    WHERE (DEPT_CODE,JOB_CODE) IN(SELECT DEPT_CODE,JOB_CODE FROM EMPLOYEE WHERE EMP_NAME='������'
    );
    --4) ������ ���߿� ���������� �ٲٱ�
    --[ǥ����] (���� ��� �÷�1, ���� ��� �÷�2)=���� �� 1, ���� ��2=>�������� �������� ����
    
    -- �ڳ��� ����� ���� �����ڵ� ������������ ���� ������� ��� �̸� �����ڵ� ������ ��ȸ
    SELECT 
        emp_name,
        emp_id,
        job_code,
        manager_id
    FROM EMPLOYEE
    WHERE (MANAGER_ID,JOB_CODE) IN(SELECT MANAGER_ID,JOB_CODE FROM EMPLOYEE WHERE EMP_NAME='�ڳ���');
    
    --���� ���� ��ȸ����� ������ �������ΰ��
    --�����޺� �ּұ޿��� �޴� ����� ��ȸ(���,�̸� , �����ڵ�,�޿�)
   SELECT
        emp_id,
        emp_name,
        job_code,
        salary
    FROM EMPLOYEE
    --WHERE (JOB_CODE,SALARY) = (('J2',3700000));
    WHERE (JOB_CODE,SALARY) IN (('J2',3700000), ('J1',	8000000),('J3'	,3400000),('J5'	,2200000),('J6',2000000),('J7',	1380000),('J4',1550000));
    
    
    SELECT
        emp_id,
        emp_name,
        job_code,
        salary
    FROM EMPLOYEE
    WHERE (JOB_CODE,SALARY) IN (
        SELECT
            job_code,
        MIN(SALARY
        )
    FROM EMPLOYEE
    GROUP BY JOB_CODE);    
    
   
--���μ��� �ְ�޿��� �޴� ����� ��ȸ (��� ,�̸� ,�μ� �ڵ�,�޿�)
--�μ������� ��� �����̶�� �μ��� �����ؼ� ��ȸ
    SELECT
        nvl(dept_code,'����')as �μ�,
        emp_id,
        emp_name,
        salary
    FROM EMPLOYEE
    WHERE (NVL(DEPT_CODE,'����'),SALARY) IN(SELECT NVL(DEPT_CODE,'����'), MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE)
    ORDER BY 1;
    
    
    /*
    
        5. �ζ��� �� (INLINE VIEW)
        FROM���� ���������� �����ϴ°�
    */
--BONUS ���� ������ 3õ���� �̻��� ������� ���,�̸�,���ʽ����� ����,�μ��ڵ带 ��ȸ.
    SELECT
        emp_id,
        emp_name,
        salary*(nvl(bonus,0)+1)*12 "���ʽ����� ����"
    FROM EMPLOYEE
    WHERE (SALARY*(NVL(BONUS,0)+1)*12)>=30000000;
    --�ζ��κ並 ����� ����� ��󳻱�
    SELECT
        EMP_NAME
    FROM( 
        SELECT
            emp_id,
            emp_name,
            salary*(nvl(bonus,0)+1)*12 "���ʽ����� ����",
            dept_code
        FROM EMPLOYEE
        WHERE (SALARY*(NVL(BONUS,0)+1)*12)>=30000000
        ) B
    WHERE B.DEPT_CODE IS NULL;
-- �ζ��κ並 �ַ� ����ϴ� ��
-- TOP- N �м� : �����ͺ��̽� �� �ִ� �ڷ��� �ֻ��� N�� �ڷḦ �������� ����ϴ� ���.


--�������߿� �޿��� ������� ���� 5��(����,�����,�޿�)
--*ROWNUM :����Ŭ���� �������ִ� Į��, ��ȸ�� ������� 1���� ������ �ο����ִ� Į��
    
SELECT
    ROWNUM,
    emp_name,
    salary
FROM EMPLOYEE
WHERE ROWNUM<=5
ORDER BY SALARY DESC;
--�ذܶ��� : ORDER BY�� ������ ���̺��� ������ ROWNUM������ �ο��� 5������� �߸�.
SELECT
    ROWNUM,
    EMP_NAME,
    SALARY
FROM (
    SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
WHERE ROWNUM<=5;

--�� �μ��� ��ձ޿��� ���� 3���� �μ��� �μ��ڵ� ��ձ޿��� ��ȸ

SELECT 
    ROWNUM,
    --D.�μ�,
    --��ձ޿�
    --FLOOR(AVG(SALARY)) �Լ��� �ν��� ������ ����
    --"FLOOR(AVG(SALARY))" �÷��� ��ü�� ���������� �ν��ϴ� ������ ""�� �����൵ ���ڿ��� ��ȯ�� ����� �����ϴ�.
    D.* --�̰͵� �ȴٰ�?
FROM(
    SELECT
        NVL(DEPT_CODE,'����') AS �μ�,
        FLOOR(AVG(SALARY)) AS ��ձ޿�
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY 2 DESC
    ) D
WHERE ROWNUM<=3;
    
--ROWNUM�� �÷��� �̿��ؼ� ������ �ű���ִ�.
--�ٸ� ������ �����������·� ������ �ű�� ORDER BY�� WHERE������ �ʰ� ����Ǳ⶧���� ������ �ǹ̰� ���Եȴ�.
--�� ������ ������ �ű�⸦ �ؾ��Ѵ�. ->�켱������ �ζ��κ��  ORDER BY ������ �ϰ�,������������ ������ ���δ�.


-- ���� �ֱٿ� �Ի��� 5�� ��ȸ(�����,�޿� , �Ի���)
--�Ի��� ���� �̷�~����(��������),���� �ο��� 5��

SELECT
    ROWNUM,
    D.*
FROM(
    SELECT emp_name,salary,hire_date
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
    )D
WHERE ROWNUM<=5;


--SUBCURRY�� ������

/*
    6. ���� �ű�� �Լ�(WINDOW FUNCTION)
    
    RANK() OVER(���� ����): ���� 1���� 3�̶�� �ϸ� ���������� 4�� �ϰڴ�
    DENSE_RANK() OVER (���� ����): ����1���⤿ 3�̶���ϸ� �� ���������� 2���ϰڴ�
    
    ���ı��� : ORDER BY (���ı��� �÷���,��������,��������),NULLS FIRST /NULLS LAST�»��Ұ�
    SELECT�������� �������.
*/

-->>������� �޿��� ������� ������ �Ű� ����� , �޿� ,����, ��ȸ :RANK() OVER

SELECT
    EMP_NAME,
    SALARY,
    RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-->>������� �޿��� ������� ������ �Ű� ����� , �޿� ,����, ��ȸ :DENSE_RANK() OVER
SELECT
    EMP_NAME,
    SALARY,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;

--WINDOW FUNCTION�� WHERE������ ����ϸ� ���Ұ�
SELECT
    EMP_NAME,
    SALARY,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE
WHERE DENSE_RANK() OVER(ORDER BY SALARY DESC)<5;--
--> �ζ��κ並 ����� ��ȸ

SELECT
    e.*
FROM(
    SELECT
        emp_name,
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS "����"
    FROM EMPLOYEE
    )E
WHERE ����>=10 ;





