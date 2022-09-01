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
    NCODE KH.NATIONAL.NATIONAL_CODE%TYPE; -- NATIONAL�� �̹� ����Ŭ���� ����ϴ� Ű����� ������ ����
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

---4 CASE �񱳴���� WHEN ����񱳰�1 THEN �����1 WHEN ����񱳰�2 THEN �����2 ELSE ����� 3 END; -> 
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT * INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID= &���;
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ���'
                WHEN 'D2' THEN 'ȸ����'
                WHEN 'D3' THEN '��������'
                WHEN 'D4' THEN '����������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '�ؿܿ�����'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME||'�μ���'||DNAME||'�Դϴ�.');
END;
/

-------------------------------------------------------------------------------
--�ݺ���
/*
    1) BASIC LOOP��
    [ǥ����]
    LOOP
        �ݺ������� ������ ����;
        
        * �ݺ����� ���������� �ִ� ����
    END LOOP;
    
    * �ݺ����� ���������� �ִ� ���� (2����)
    
    1)IF ���ǽ� THEN EXIT; END IF;
    2) EXIT WHEN ���ǽ�;
*/
-- 1~5���� ���������� 1�� �����ϴ� ���� ���.

DECLARE
    
    I NUMBER:= 1;
    
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I+1;
        
        EXIT WHEN I=6;
    END LOOP;
END;
/

/*
    2) FOR LOOP��
    FOR ���� IN �ʱⰪ ... ������
    LOOP
        �ݺ������� ������ ����;
        
    END LOOP;
*/
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/


CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
    START WITH 1
    INCREMENT BY 2
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;--�������� REPLACE���ȵ�
    
    
BEGIN 
    FOR I IN 1..500
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL,SYSDATE);
    END LOOP;
    
    
    
END;
/


SELECT * FROM TEST;


--3) WHELE LOOP��

/*

    [ǥ����]
    WHILE �ݺ����� ����� ����
    LOOP
        ���������� ����
    END LOOP;
    
*/
DECLARE
    I NUMBER:=1;
    
BEGIN
    WHILE I<1000    
    LOOP DBMS_OUTPUT.PUT_LINE(I);
    I:=I+1;
    END LOOP;
END;
/

/*
    ����ó����
    �����߿� �߻��ϴ� ������ ����
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������;
        WHEN ���ܸ�2 THEN ����ó������;
        WHEN ���ܸ�3 THEN ����ó������;
        .....
        WHEN OTERS THEN ����ó������
        
        * �ý��ۿ���(����Ŭ���� �̸������ص� ���� ��20��)
        --NO_DATA_FOUND: SELECT ���൵ ���°��
        --TOO_MANY_ROWS: SELECT ����� �������ΰ��
        --ZERO_DIVIDE : 0���� ������
        --DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ����Ǿ�����;
*/
--����ڰ� �Է��� ���� ������ ������ ����� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 1000/&����;
    DBMS_OUTPUT.PUT_LINE(RESULT);
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE ('������ ����� 0�� ����Ҽ� �����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE ('������ ���� ����');    
END;
/
--UNIQUE �������� ����.

BEGIN UPDATE EMPLOYEE
        SET EMP_ID=&���
        WHERE EMP_NAME='������';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
     
BEGIN
    SELECT
        EMP_ID,EMP_NAME
        INTO EID,ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID=&������;
    
    DBMS_OUTPUT.PUT_LINE('���ӻ�� : '||EID );
    DBMS_OUTPUT.PUT_LINE('�����̸� : '||ENAME );
EXCEPTION
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ��� ������ ��ȸ �Ǿ����ϴ�.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�.');
END;
/
--ORA-01422: exact fetch returns more than requested number of rows
--> TOO_MANY_ROWS
--ORA-06512: at line 6 01403. 00000 -  "no data found"
-->NO_DATE_FOUND

---------------------------------�ǽ�����------------------------------------------
--1) ����� ������ ���ϴ� PL/SQL�� �ۼ�, ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���.
-- ��¹� �޿� ����̸� ���� 
--NVL����
DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.EMP_NAME%TYPE;
    YSAL NUMBER;
BEGIN
    SELECT EMP_NAME,SALARY,SALARY*(NVL(BONUS,0)+1)*12 AS ����
        INTO ENAME,SAL,YSAL
    FROM EMPLOYEE
    WHERE EMP_ID=&���;
    
    DBMS_OUTPUT.PUT_LINE('����� '||ENAME);
    DBMS_OUTPUT.PUT_LINE('���� '||SAL);
    DBMS_OUTPUT.PUT_LINE('���� '||YSAL);
    
    
END;
/
--���ǹ� ����
    DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.EMP_NAME%TYPE;
    BNS EMPLOYEE.BONUS%TYPE;
    YSAL NUMBER;
BEGIN
    SELECT EMP_NAME,SALARY,BONUS
        INTO ENAME,SAL,BNS
    FROM EMPLOYEE
    WHERE EMP_ID=&���;
    
    IF BNS IS NULL THEN YSAL := 12*SAL;
        ELSE YSAL := SAL*12*(1+BNS);
        END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� '||ENAME);
    DBMS_OUTPUT.PUT_LINE('���� '||SAL);
    DBMS_OUTPUT.PUT_LINE('���� '||YSAL);    
END;
/
--2) ������ ¦���� ���
--2-1) FOR LOOP �̿�
BEGIN
FOR J IN 2..9 
    LOOP
    IF MOD(J,2)=0 THEN
        DBMS_OUTPUT.PUT_LINE(J||'��');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(J||'*'||I||'='||I*J);
            END LOOP;
            
        END IF;
END LOOP;
END;
/
    
--2-2) WHILE LOOP ���
DECLARE
    I NUMBER :=2 ;
    J NUMBER :=1;
BEGIN
    WHILE I<10
        LOOP
            IF MOD(I,2)=0
                THEN
                WHILE J<10
                    LOOP
                        DBMS_OUTPUT.PUT_LINE(I||'*'||J||'='||I*J);
                        J:=J+1;
                    END LOOP;
                    
                J:=1;
            END IF;
            I:=I+1;
        END LOOP ;
END;
/

-- �ܼ� ������ ���� �����ؼ� ���
DECLARE 
    INUM NUMBER:=2;
BEGIN
FOR J IN 1..4 
    LOOP
        DBMS_OUTPUT.PUT_LINE(INUM||'��');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(INUM||'*'||I||'='||I*INUM);
            END LOOP;      
        DBMS_OUTPUT.PUT_LINE('');
    INUM:=INUM+2;
END LOOP;
END;
/

--EXIT Ȱ�� �غ���
DECLARE 
    INUM NUMBER:=2;
BEGIN

FOR J IN 1..4 
    LOOP
        DBMS_OUTPUT.PUT_LINE(INUM||'��');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(INUM||'*'||I||'='||I*INUM);
            EXIT WHEN INUM*I=12;
            END LOOP;
            
        DBMS_OUTPUT.PUT_LINE('');
    INUM:=INUM+2;
END LOOP;
END;
/
--���� �̿��� ��ø ������ ���������� 
DECLARE 
    INUM NUMBER:=2;
BEGIN
<<LOOP_FOR>>
FOR J IN 1..4 
    LOOP
        DBMS_OUTPUT.PUT_LINE(INUM||'��');
        FOR I IN 1..9
            LOOP
            DBMS_OUTPUT.PUT_LINE(INUM||'*'||I||'='||I*INUM);
            EXIT LOOP_FOR WHEN INUM*I=64;
            END LOOP;
            
        DBMS_OUTPUT.PUT_LINE('');
    INUM:=INUM+2;
END LOOP;
END;
/


--CONTINUE Ȱ�� �� �ɷ�����;
BEGIN
FOR J IN 2..9 
    LOOP
    IF MOD(J,2)=1 THEN
    CONTINUE;
    END IF;
        DBMS_OUTPUT.PUT_LINE(J||'��');
        FOR I IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE(J||'*'||I||'='||I*J);
            END LOOP;
    END LOOP;
END;
/


SELECT
    EMP_NAME,
    EMP_ID,
    SUM(SALARY) OVER (PARTITION BY DEPT_CODE)
FROM EMPLOYEE

-- PARTITION BY �� �̿��ϸ�
-- ���������� ������� �ʾ� ����ϴ�.
