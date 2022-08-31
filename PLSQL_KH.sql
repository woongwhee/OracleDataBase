/*
    <PL/SQL>
    PROCEDURE LANGUAGE EXENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL ���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP,FOR,WHILE) , ����ó������
    �����Ͽ� SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���డ��(BLOCK����)
    
    PL/SQL ����
    - [����� (DECLARE)]: DECLARE�� ����,������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - ����� (EXECUTABLE): BEGIN���� ���� , SQL�� �Ǵ� ���(���ǹ�,�ݺ���)���� ������ ����ϴ� �κ�,
    -[���� ó����](EXCEPTION): EXCEPTION���� ���� ���ܹ߻��� �ذ��ϱ����� ������ �̸� ����� �� �� �ִ� �κ�.
    

*/

/*�����ϰ� ȭ�鿡 HELLO WORLD �� ����ϱ�  */

SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');

END;
/



/*

    1. DECLARE �����
        ������ ����� �����ϴ� ����(����� ���ÿ� �ʱ�ȭ������)
        �Ϲ�Ÿ�Ժ��� ���۷������� ROWŸ�Ժ���
        
        �̹�Ÿ�Ժ��� ����� �ʱ�ȭ 
        [ǥ����]
        ������ [CONSTRANT] W�ڷ��� [:��];
    
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER:=3.14;
BEGIN
    EID:=300;
    ENAME:='�ΰ��';
    
    DBMS_OUTPUT.PUT_LINE('DID:' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME:' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI:' ||PI);

END;
/


/*1-2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (����̺��� ��÷��� ������Ÿ�Ԥ��� ������ ��Ÿ�̕��� ����)
-- ǥ����
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN 
    SELECT
        EMP_ID,EMP_NAME,SALARY
        INTO EID,ENAME,SAL
    FROM EMLOYEE
    WHERE EMP_ID= &���;
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('EID : '||SAL);
END;
/

-------------------------�ǽ�����----------------------------------------

/*
    ���۷��� Ÿ�� ������ EID,ENAMEMJCODE,SAL,DTITLED �� �����ϰ�
    �� �ڷ��� EMPLOYEE(EMP_ID,EMP_NAME,JOB_CODE,SALARY)
        DEPARTMENT(DEPT_TITLE)������
        ����ڰ� �Է��� ����� ����� ���, ����� �����ڵ� �޿� �μ��� ��ȸ�� ������ ��Ƽ� ����ϱ�

*/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT
        EMP_ID,EMP_NAME,JOB_CODE,SALARY,DEPT_TITLE
    INTO EID,ENAME,JCODE,SAL,DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID=&���;
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : '||JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : '||DTITLE);
    
END;
/

/*1-3 ROW Ÿ�� ���� ����
    ���̺��� ���࿡ �ش��ϴ� ��纯���� ���� �� �ִ� ����
    [ǥ����] ������ ���̺��%ROWTYPE;

*/
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT*
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID=&���;
    DBMS_OUTPUT.PUT_LINE('����� :'||E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� :'||E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� :'||NVL(E.BONUS,0)||'%');
 
    

END;
/


------------------------------------------------------------------------------
/*
    2. BEGIN
    <���ǹ�
    1) IF ���ǽ� THEN ���೻��
*/

--��� �Է¹��� �� �ش� ������ ��� �̸� �޿� ���ʽ���(%)�� ���
--�� ���ʽ��� ���� �ʴ� ����� ���ʽ� ����� ���ʽ��� ���޹��� �ʴ� ����Դϴ�.'���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN
    
    SELECT EMP_ID,
        EMP_NAME,
        SALARY,
        NVL(BONUS,0)
    INTO EID,ENAME,SAL,BNS
    FROM EMPLOYEE
    WHERE EMP_ID=&���;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('����� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('���� : '||SAL);
    IF BNS=0 THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : '|| BNS||'%');

END;
/

/*
    2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF: (IF~ELSE)


*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
BEGIN
    
    SELECT EMP_ID,
        EMP_NAME,
        SALARY,
        NVL(BONUS,0)
    INTO EID,ENAME,SAL,BNS
    FROM EMPLOYEE
    WHERE EMP_ID=&���;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('����� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('���� : '||SAL);
    IF BNS=0 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : '|| BNS*100||'%');
    END IF;


END;
/

------------------------------
DECLARE
    --���۷���Ÿ�Ժ���(EID,ENAME,DTITLE,NCODE)
    -- ������ �÷�(EMP_ID,EMP_NAME,DEPT_TITLE,NATIONAL_CODE)
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    DCODE DEPARTMENT.DEPT_ID%TYPE;
    NCODE KH.NATIONAL.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
    -- �Ϲ�Ÿ�Ժ���(TEAM �������ڿ�(10))<=�ؿ���,������

BEGIN
    --����ڰ� �Է��� ����� ����� ��� �̸� �μ��� �ٹ������ڵ� ��ȸ�� ������������
    SELECT
        EMP_ID,EMP_NAME,DEPT_TITLE,NATIONAL_CODE,DCODE
        INTO EID,ENAME,DTITLE,NCODE,DCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
    JOIN LOCATION ON LOCAL_CODE=LOCATION_ID
    JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE EMP_ID=&���;
    
    IF NCODE='KO' 
        THEN TEAM:='������';
    ELSE   
        TEAM:='�ؿ���';
    END IF;
    
    --NCODE ���� KO�ΰ�� TEAM�� �ѱ��� ����
    --�װԾƴҰ�� TEAM�� �ؿ��� ����
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('����̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� :'||DTITLE);
    DBMS_OUTPUT.PUT_LINE('�ٹ������ڵ� : '||NCODE);
    DBMS_OUTPUT.PUT_LINE(TEAM);
END;
/

DECLARE
    --���۷���Ÿ�Ժ���(EID,ENAME,DTITLE,NCODE)
    -- ������ �÷�(EMP_ID,EMP_NAME,DEPT_TITLE,NATIONAL_CODE)
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE JOB.JOB_CODE%TYPE;
    JNAME JOB.JOB_NAME%TYPE;
    -- �Ϲ�Ÿ�Ժ���(TEAM �������ڿ�(10))<=�ؿ���,������

BEGIN
    --����ڰ� �Է��� ����� ����� ��� �̸� �μ��� �ٹ������ڵ� ��ȸ�� ������������
    SELECT
        EMP_ID,EMP_NAME,J.JOB_CODE,JOB_NAME
        INTO EID,ENAME,JCODE,JNAME
    FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE=J.JOB_CODE
    --JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE EMP_ID=&���;
    
    
    --NCODE ���� KO�ΰ�� TEAM�� �ѱ��� ����
    --�װԾƴҰ�� TEAM�� �ؿ��� ����
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('����̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� :'||JCODE);
    DBMS_OUTPUT.PUT_LINE('���޸� : '||JNAME);
    
END;
/

-- 3) IF ���ǽ� THEN ���೻�� ELSIF ���ǽ�2 THEN ���೻�� ...[ELSE] END IF;

--�޿��� 500�̻��̸� ���
--�޿��� 300�̻��̸� �߱�
--�׿� �ʱ�

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT
        EMP_ID,EMP_NAME,SALARY
        INTO EID,ENAME,SAL
    FROM EMPLOYEE
    WHERE EMP_ID=&���;
IF SAL>5000000 THEN GRADE:='���';
ELSIF SAL>3000000 THEN GRADE:='�߱�';
ELSE GRADE:='�ʱ�';
END IF;

    DBMS_OUTPUT.PUT_LINE('ENAME:'||ENAME);
    DBMS_OUTPUT.PUT_LINE('EID:'||ENAME);
    DBMS_OUTPUT.PUT_LINE('SALARY:'||SAL);
    DBMS_OUTPUT.PUT_LINE('GRADE:'||GRADE);
    

END;
/
SELECT * FROM EMPLOYEE;