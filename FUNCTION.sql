/*
    <�Լ� FUNCTION>
    �ڹٷ� ������ �޼ҵ�� ���� ����
    �Ű������� ���޵� ������ �о ����� ����� ��ȯ -> ȣ���ؼ� �� ��
    
    - ������ �Լ� : N���� ���� �о N���� ����� ����(�� �ึ�� �Լ� ���� �� ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о 1���� ����� ���� (�ϳ��� �׷캰�� �Լ� ������ ��� ��ȯ)
    
    ������ �Լ��� �׷� �Լ��� �Բ� ��� �� �� ���� : ��� ���� ������ �ٸ��� ����
*/
-----------------< ������ �Լ� >----------------------------
/*
    <���ڿ��� ���õ� �Լ�>
    LENGTH / LENGTHB
    
    - LENGTH(���ڿ�) : �ش� ���޵� ���ڿ��� ���ڼ� ��ȯ.
    - LENGTHB(���ڿ�) : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ.
    
    ��� ���� ���ڷ� ��ȯ -> NUMBER
    ���ڿ� : ���ڿ� ������ ���ͷ�, ���ڿ��� �ش��ϴ� �÷�
    
    �ѱ� : �� -> '��', '��', '��' => �ѱ��ڴ� 3BYTE���
    ����, ����, Ư������ : �ѱ��ڴ� 1BYTE���
*/
SELECT LENGTH('����Ŭ!'), LENGTHB('����Ŭ!')
FROM DUAL; --> �������̺� : ��������̳� �����÷��� ���� �ѹ��� ����ϰ� ������ ����ϴ� ���̺�

--�̸���, ��� �̸��� �÷���, ���ڼ�, ����Ʈ ���ڼ�
SELECT 
    email,
    length(email),
    lengthb(email),
    emp_name,
    length(emp_name),
    lengthb(emp_name)
FROM EMPLOYEE;

/*
    INSTR
    - INSTR(���ڿ�, Ư������, ã�� ��ġ�� ���� ��, ����) : ���ڿ��κ��� Ư�� ��ġ�� ��ȯ.
    
    ã�� ��ġ�� ���۰�, ������ ���� ����
    ������� NUMBER Ÿ������ ��ȯ.
    
    ã�� ��ġ�� ���۰�(1 / -1)
    1 : �տ������� ã�ڴ�.(������ �⺻��)
    -1 : �ڿ��� ���� ã�ڴ�.
*/
SELECT INSTR('AABAACAABBAA','B')FROM DUAL;
-- ã�� ��ġ , ������ ���� : �⺻������ �տ������� ù��° ������ ��ġ�� �˷���

SELECT INSTR('AABAACAABBAA','B', 1)FROM DUAL;
--���� ������ ����� ��ȯ.

SELECT INSTR('AABAACAABBAA','B', -1)FROM DUAL;
-- �ڿ��� ���� ù��° ������ ��ġ�� �˷���.

SELECT INSTR('AABAACAABBAA','B', -1, 2)FROM DUAL;
-- �ڿ��� ���� �ι�° ��ġ�ϴ� B�� ���� ��ġ���� �տ��� ���� ���� �˷��ذ�.

SELECT INSTR('AABAACAABBAA','B', -1, 0)FROM DUAL;
-- ������ ��� ������ ������ ��� �����߻�.

SELECT INSTR(EMAIL, '@')
FROM EMPLOYEE;

/*
    SUBSTR
    
    ���ڿ����� Ư�� ���ڿ��� �����ϴ� �Լ�
    - SUBSTR(���ڿ�, ó����ġ, ������ ���� ����)
    
    ������� CHARACTERŸ������ ��ȯ(���ڿ�)
    ������ ���� ������ ��������(���������� ���ڿ� ������ ����.)
    ó����ġ�� ������ ���� ���� : �ڿ������� N��° ��ġ�κ��� ���ڸ� �����ϰڴ� ��� ��.
*/
SELECT SUBSTR('SHOWMETHEMONEY',7) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',5, 2) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-8, 3) FROM DUAL;
--THE
SELECT SUBSTR('SHOWMETHEMONEY',-5) FROM DUAL;
--MONEY

--�ֹε�Ϲ�ȣ���� ���� �κ��� �����ؼ� ����(1)����(2)�� üũ.
SELECT 
    emp_name,
    substr(emp_no, 8,1) AS "����"
FROM EMPLOYEE;
--�̸��Ͽ��� ID�κи� �����ؼ� ��ȸ.
SELECT
    emp_name,
    substr(email, 1, INSTR(email, '@')-1) AS "ID"
FROM EMPLOYEE;
--���ڻ���鸸 ��ȸ.
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) ='1';

/*
    LPAD / RPAD
    
    -LPAD/RPAD(���ڿ�, ���������� ��ȯ�� ������ ����(BYTE), �����̰����ϴ� ����)
    : ������ ���ڿ��� �����̰����ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ.
    �ѱ��� ���̴� ��� 2byte�� ���ȴ�.
*/
SELECT LPAD(EMAIL, 16)
FROM EMPLOYEE;
-- �ڹ��� %5s�� ���� ����

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT 
    emp_name,
    emp_no
FROM EMPLOYEE;

-- 1�ܰ� : SUBSTR�Լ��� �̿��ؼ� �ֹι�ȣ �� 8�ڸ��� ����.
SELECT
    emp_name,
    substr(emp_no,1,8) AS �ֹι�ȣ
FROM EMPLOYEE;
-- 2�ܰ� : RPAD�Լ��� ��ø�ؼ� �ֹι�ȣ �ڿ� *���̱�
SELECT
    emp_name,
    RPAD(substr(emp_no,1,8),14, '*') AS �ֹι�ȣ
FROM EMPLOYEE;

SELECT 
    LPAD(substr(phone,4),11,'*') 
FROM EMPLOYEE;

SELECT
    RPAD(substr(hire_date,1,6),8,'?')
FROM EMPLOYEE;

SELECT
    RPAD(substr(hire_date,1,3),5,'?') || substr(hire_date,6,8)
FROM EMPLOYEE;

/*
    LTRIM/RTRIM/TRIM
    
    -LTRIM/RTRIM(���ڿ�,���Ž�Ű���� �ϴ� ����)
    : ���ڿ��� ���� �Ǵ� �����ʿ��� ���Ž�Ű���� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ.
    
    ������� CHARACTER ���·� ����. ���Ž�Ű���� �ϴ� ���� ���� ���� (DEFAULT ' ')
    
*/
SELECT
    LTRIM('               K    H                        '),
    RTRIM('               K    H                        ')
FROM DUAL;
SELECT
    LTRIM(RTRIM('000001234000000','0'),'0')
FROM DUAL;
SELECT 
    LTRIM('123123KH123','123'),
    LTRIM('1231212222ZZ123KH123','123')
FROM DUAL;
--�����ϰ��Ű�� �ϴ� ���ڿ��� ������ �����ִ°� �ƴ϶� ���� �ϳ��ϳ��� �� �����ϸ� �����ִ� ����

/*
    TRIM
    
    -TRIM(BOTH/LEADING/TAILING '�����ϰ����ϴ� ����'FROM '���ڿ�')
    :���ڿ� (����/����/����)�� �ִ� Ư�����ڸ� ������ ������ ���ڿ� ��ȯ
    
    ������� CHARACTER Ÿ�� ��ȯ BOTH/LEADING/TRAILING�� ���� ����(DEFAULT BOTH)

*/
SELECT 
    TRIM(' 'FROM'  12312312312  ')
FROM DUAL;
SELECT
    --TRIM(LEADING '123'FROM '123123Z12ZZ31Z23123')trim set should have only one character"--Ʈ���� 1���ڸ� ���Ű���    
    TRIM('Z'FROM 'ZZ1232131Z123ZZ')
FROM DUAL;    
/*
    LOWER/UPPER/INITCAP
    ���ڿ��� �ҹ���/�빮��/�ձ��ڸ��빮�� ��
    LOWER/UPPER/INITCAP(���ڿ�)
    
*/
SELECT
    LOWER('WELLCOME TO B CLASS'),--wellcome to b class
    UPPER('WELLCOME TO B CLASS'),--WELLCOME TO B CLASS
    INITCAP('WELLCOME TO B CLASS')--Wellcome To B Class ���� ������ ù���ڸ� �빮�ڷ� �����
FROM DUAL;


/*
    CONCAT
    -CONCAT(���ڿ�1, ���ڿ�2)
    : ���޵� ���ڿ� �ΰ��� �ϳ��� ���ڿ��� ���ļ� ��ȯ.
*/

