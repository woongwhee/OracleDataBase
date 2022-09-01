/*
    <PROCEDURE>
    PL/SQL ������ �����ؼ� �̿��ϴ� ��ü
    �ʿ��Ҷ����� ���� �ۼ��� PL/SQL���� ���ϰ� ȣ�� �����ϴ�.
    
    ���ν��� �������
    [ǥ����]
    CREATE PROCEDURE ���ν�����[(�Ű�����)]
    IS 
        BEGIN
        �����ڵ�
        END;
*/

-----EMPLOYEE ���̺��� ��� Į���� ������ COPYTABLE ����
---PRO_TEST
CREATE TABLE PRO_TEST AS
    SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE DELETE_DATA
    IS 
    BEGIN
        DELETE FROM PRO_TEST;
        COMMIT;
    END;
/
SELECT * FROM USER_PROCEDURES;

EXEC DELETE_DATA;
SELECT * FROM PRO_TEST;
ROLLBACK;


----���ν����� �Ű����� �ֱ�
-- IN : ���ν��� ����� �ʿ��� ���� "�޴�"���� (�ڹٿ��� ������ �Ű������� ����)
-- OUT: ȣ���Ѱ����� �ǵ��� "�ִ�" ���� (�����)

CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP(
   EID IN EMPLOYEE.EMP_ID%TYPE, 
   ENAME OUT EMPLOYEE.EMP_NAME%TYPE, 
   SAL OUT EMPLOYEE.SALARY%TYPE,
   BNS OUT EMPLOYEE.BONUS%TYPE )
IS
    EMP_DD VARCHAR2(20);
    BEGIN
        SELECT
            EMP_NAME,SALARY,BONUS, EMP_NAME||EMP_NAME
            INTO ENAME,SAL,BNS, EMP_DD
        FROM EMPLOYEE
        WHERE EMP_ID=EID;
        
    END;
/
--> IN ������ ���� OUT������ ������ ��ߵȴ�.
VAR EMP_NAME VARCHAR2(20);
VAR SALARY NUMBER;
VAR BONUS NUMBER;
EXEC PRO_SELECT_EMP(205,:EMP_NAME,:SALARY,:BONUS);
PRINT EMP_NAME;
PRINT SALARY;
PRINT BONUS;
/*
    ���ν��� ����
    1. ó���ӵ��� ����(ȿ�������� �ۼ��ߴٴ� �����Ͽ�)
    2. �뷮 �ڷ�ó���� ������
    EX) DB���� ��뷮�� �����͸� SELECT������ �޾ƿͼ� �ڹٿ��� �۾��ϴ°�� VS
        DB���� ��뷮 �����͸� SELECT���� �ڹٷ� �ѱ��� �ʰ� ���� ó���ϴ� ���, DB���� ó���ϴ°� ������ �� ����.
        (�ڹٷ� �����͸� �ѱ涧 ��Ʈ��ũ ����� �߻��ϱ� ������)
    ���ν��� ����
    1. DB�ڿ��� ���� ����ϱ� ������ DB�� ���ϸ� �ְԵ�.(�����ϸ� �ȵ�)
    2. ������ ���鿡�� �ڹ��� �ҽ��ڵ�, ����Ŭ �ڵ带 ���ÿ� ��������ϱ� ��ƴ�.
    
    ����)
    �ѹ��� ó���Ǵ� �����ͷ��� ���� ������ �䱸�ϴ� ó���� ��ü�� �ڹٺ��ٴ� DB�󿡼� ó���ϴ°��� �����������鿡�� �������̰�
    �ҽ�����(��������)���鿡�� �ڹٷ� ó���ϴ� ���� �� ����.
*/
------------------------------------------------------------------------------------------------------------------------------

/*
    <FUNCTION>
    ���ν����� ���������� �������� ��ȯ(����)���� �� ����
    FUNCTION �������
    [ǥ����]
    CREATE [OR REPLACE] FUNCTION ���ν�����[(�Ű�����)]
    RETURN �ڷ���
    IS
    [DECLARE]
    BEGIN
        ����κ�
    END;
    /
    
*/

CREATE OR REPLACE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN VARCHAR2
IS
    RESULT VARCHAR2(1000);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_STR);
    RESULT := '<'||V_STR||'>';
    RETURN RESULT;
END;
/

SELECT MYFUNC('�ΰ��') FROM DUAL;

-- EMP_ID�� ���޹޾� ������ ����ؼ� ������ִ� �Լ������

CREATE OR REPLACE FUNCTION YSAL(EID VARCHAR2) RETURN NUMBER
IS 
    YSALA NUMBER;
BEGIN
    SELECT 
        SALARY*12*(NVL(BONUS,0)+1)
    INTO YSALA
    FROM EMPLOYEE
    WHERE EMP_ID=EID;
    RETURN YSALA;
END;
/
    
    SELECT 
        EMP_NAME AS �̸�, 
        YSAL(EMP_ID) AS ����
    FROM EMPLOYEE;
COMMIT;


SELECT YSAL((&��� )) FROM DUAL;

SELECT  YSAL((SELECT EMP_ID FROM EMPLOYEE WHERE EMP_NAME=&����� ))AS ���� FROM DUAL;
--&���� ���ڿ��� ������ ��������ǥ�� ''�߰��� ��ߵȴ�.

SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE=&�����; 






