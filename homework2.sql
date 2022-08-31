--SELECT BASIC
--1
SELECT
    DEPARTMENT_NAME,
    CATEGORY
FROM TB_DEPARTMENT;
--2.
SELECT
    DEPARTMENT_NAME||'�� ������'||CATEGORY||'�� �Դϴ�.'
FROM TB_DEPARTMENT;
--
--3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
--���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
--ã�� ������ ����
SELECT
    STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO =(SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='������а�')
     AND ABSENCE_YN='Y';
     
--4.A513079, A513090, A513091, A513110, A513119 ��ã�� ����
SELECT
    STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

--5 . ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT
    department_name,
    category
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;
--6. ����ã��
SELECT
    professor_name
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;
--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT
    student_name
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;
--8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT 
    class_no
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;
--9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT 
    DISTINCT(CATEGORY)
FROM TB_DEPARTMENT;
--10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT
    STUDENT_NO,
    STUDENT_NAME,
    STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN='N' AND SUBSTR(STUDENT_NO,1,2)='A2' AND STUDENT_ADDRESS LIKE '%����%';


--Additional SELECT 
--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--( ��, ����� "�й�", "�̸�", "���г⵵" ��ǥ�õǵ��� ����.)
SELECT
    STUDENT_NO AS �й�,
    STUDENT_NAME AS �̸�,
    ENTRANCE_DATE AS ���г⵵
FROM TB_STUDENT
WHERE DEPARTMENT_NO=002
ORDER BY 3;

--
/*
2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
--?? �̸��� 2���� 5�����ϼ����־
*/
SELECT
    PROFESSOR_NAME,
    PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE NOT PROFESSOR_NAME LIKE '___';
/*
3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ����������
�������.)
*/
    SELECT
        PROFESSOR_NAME �����̸�,
        100+TO_CHAR(SYSDATE,'YY')-TO_NUMBER(SUBSTR(PROFESSOR_SSN,1,2)) AS ����
               
    FROM TB_PROFESSOR
    WHERE SUBSTR(PROFESSOR_SSN,8,1) IN (1,3)
    ORDER BY ���� ASC;
 /*   
4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
�̸� �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
*/
    SELECT
        SUBSTR(PROFESSOR_NAME,2) AS �̸�
    FROM TB_PROFESSOR;
    
/*
5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�? �̶�, 
19 �쿡 �����ϸ� ����� ���� ���� ������ �A������
*/

SELECT
    STUDENT_NAME
FROM TB_STUDENT
--WHERE 100+TO_CHAR(SYSDATE,'YY')-TO_NUMBER(SUBSTR(STUDENT_SSN,1,2))>20;
WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE,TO_DATE(SUBSTR(STUDENT_SSN,1,2),'RR'))/12)>18;


/*
6. 2020 �� ũ���������� ���� �����ΰ�?
*/
SELECT
    TO_CHAR(TO_DATE('2020/12/25'),'DAY')
FROM DUAL;

/*7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
�� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'), 
TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����
     TO_DATE('99/10/11','YY/MM/DD'), : 1999�� 
     TO_DATE('49/10/11','YY/MM/DD'), : 2049��
     TO_DATE('49/10/11','RR/MM/DD'), : 1949��
     TO_DATE('99/10/11','RR/MM/DD') :1999��
     
     =>���� 2099 2049 2049 1999
*/
SELECT
    TO_DATE('99/10/11','YY/MM/DD'),
     TO_DATE('49/10/11','YY/MM/DD'),
     TO_DATE('49/10/11','RR/MM/DD'),
     TO_DATE('99/10/11','RR/MM/DD')
FROM DUAL;

/*
8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
�̠� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT
    STUDENT_NO,
    STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

/*
9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
�ڸ������� ǥ������.
*/

SELECT
    ROUND(AVG(POINT),1)
FROM TB_GRADE
GROUP BY STUDENT_NO
HAVING STUDENT_NO ='A517178';
/*
10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
��µǵ��� �Ͻÿ�.
*/


