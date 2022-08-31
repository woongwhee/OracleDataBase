/*
    <������ SEQUENCE>
    �ڵ��� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü (�ڵ���ȣ �ο���)
    �������� �ڵ��� ���������� �߻������� (���ӵ� ���ڷ�)
    EX)������ȣ ,ȸ����ȣ ,���, �Խñ۹�ȣ ��
    -> ���������� ��ġ�� �ʴ� ���ڷ� ä���Ҷ� ����� ������
    
    1. ������ ��ü ��������
        [ǥ����]
        CREATE SEQUENCE ��������
        START WITH ���ۼ��� => �������� , �ڵ����� �߻���ų ������(DEFAULT ���� 1)
        INCREMENT BY ������ => �������� , �ѹ� ������ �����Ҷ����� � �����Ұ��� ����(DEFAULT���� 1)
        MAXVALUE �ִ밪 => �������� , �ִ밪 ����
        MINVALUE �ּҰ� => �������� , �ּҰ� ����
        CYCLE/NOCYCLE => �������� , ���� ��ȯ ���θ� ����
        CACHE ����Ʈũ�� / NOCACHHE => �������� ĳ�ø޸� ���� ���� �⺻���� 20BYTE
        
        ĳ�ø޸�
        �������κ��� �̸� �߻��� ������ �����ؼ� ������ �δ� ����.
        �Ź� ȣ���Ҷ����� ������ ��ȣ�� �����ϴ� �ͺ��� ĳ�ø޸𸮿� �̸� ������ ���� ������ ���� �ξ� ������ ��� ����.
        ������ ����� �����ӽ� ������ ������ ������ ���󰡱� ������ �����ؾߵȴ�.
*/
CREATE SEQUENCE SEQ_TEST;


-- ���� ������ ������ �����ϰ��ִ� �������� ���� ���� Ȯ��.

SELECT * FROM USER_SEQUENCES;
/*-
SEQUENCE_NAME
MIN_VALUE
MAX_VALUE
INCREMENT_BY
CYCLE_FLAG
ORDER_FLAG
CACHE_SIZE <-- DB�� ������ ����� �ʱ�ȭ�ȴ�.
LAST_NUMBER <-- �߿���߿� 

*/

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. ������ ��뱸��
    ��������.CURRVAL: ���� �������� �� (���������� ���������� �߻��� NEXTVAL)
    ��������.NEXTVAL : ���� �������� ���� ������Ű��, �� ������ �������� ��
                    == ������.CURRVAL + INCREMENT BY ����ŭ �����Ȱ�.
    �� ������ ������ ù NEXTVAL �� START WITH�� ������ ���۰����� �߻���.
    
    
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--�����߻� �������� ����ǰ� �ѹ��̶� NEXTVAL�� ������� �ʴ� �̻� CURRENTVAL�� ���� �� �� ����.
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- MAX���� �����ѵ� �ѹ��� NEXTVAL�� ȣ���ϸ� �������� ������ �����ʴ´�.

SELECT * FROM USER_SEQUENCES;--LAST NUMBER �� 315��������?
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;--�̰� 310;

/*
    3. ������ ����
    [ǥ����]
    ALTER  SEQUENSE ��������
        INCREMENT BY ������ => �������� , �ѹ� ������ �����Ҷ����� � �����Ұ��� ����(DEFAULT���� 1)
        MAXVALUE �ִ밪 => �������� , �ִ밪 ����
        MINVALUE �ּҰ� => �������� , �ּҰ� ����
        CYCLE/NOCYCLE => �������� , ���� ��ȯ ���θ� ����
        CACHE ����Ʈũ�� / NOCACHHE => �������� ĳ�ø޸� ���� ���� �⺻���� 20BYTE
    
    START WITH�� ����Ұ� => �ٲٰ� �ʹٸ� �����ϰ� �ٽ� �����ؾߵ�.

*/

ALTER SEQUENCE SEQ_EMPNO
    INCREMENT BY 10
    MAXVALUE 400;
 SELECT * FROM USER_SEQUENCES;--320 �� �����°� ���� ������ �� �����ϵ�
 SELECT SEQ_EMPNO.CURRVAL FROM DUAL;-- ������ �� ���� ���� �����������
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

--SEQUENCE �����ϱ�
DROP SEQUENCE SEQ_EMPNO;


---------------------------
--�Ź� ���ο� ����� �߻��Ǵ� ������ ����(SEQ_EID)
CREATE SEQUENCE SEQ_EID
    START WITH 300
    INCREMENT BY 1
    MAXVALUE 400;
    
--����� �߰��ɶ� ������ INSERT ��

INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL,'�ΰ��','958252-1234567','J1','S1',SYSDATE);

SELECT * FROM EMPLOYEE ORDER BY EMP_ID;
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL,'�ΰ��2','958252-1234567','J1','S1',SYSDATE); --301������Ǵ°�



--- �������� INSERT���� PK ���� ������ ���� ���� ���ȴ�.

/*
    ��� �� �� ���� ����
    1. VIEW�� SELECT��
    2. DISTINCT ���Ե� SELECT��
    3. GROUP BY HAVING ORDER BY �� �ִ� SELECT��
    4. SELECT, DELETE, UPDATE�� ��������
    5. CREATE TABLE, ALTER TABLE ����� DEFAULT��


*/