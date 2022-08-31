/*
    DDL(DATA DEFINITION LANGUAGE):������ ���Ǿ��
    ����Ŭ���� �����ϴ� ��ü(OBJECT)��
    ������ �����(CREAT), ������ �����ϰ�(ALTER),���� ��ü�� ����(DROP) �ϴ� ��ɹ�.
    ��, ���� ��ü�� �����ϴ� ���� DB������ , �����ڰ� �����
    ����Ŭ������ ��ü(DB)�� �̷�� ��������
    ���̺�(TABLE),�����(USER), �Լ�(FUNCTION),��(VIEW),������(SEQUENCE),
    �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER), ���ν���(PROCEDURE), ���Ǿ�(SYNONYM)
*/

/*
    <CREAT TABLE>
    ���̺� : ��(ROW),��(COLUM)���� �����Ǵ� �⺻���� �����ͺ��̽� ��ü ������ �ϳ�.
        ��� �����ʹ� ���̺��� ���ؼ� �����(�����͸� �����ϰ��� �϶�� ������ ���̺��� ��������)
        
        [ǥ����]
        CREATE TABLE ���̺�� (
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ......
        )
        <�ڷ���>
        --����(CHAR(ũ��)/VARCHAR2(ũ��)):ũ��� BYTE������ . (����,����,Ư������->���ڴ� 1BYTE),
            CHAR (����Ʈ��):�ִ� 2000BYTE ���� ���� ����
                            ��������(�ƹ��� ���� ���� ���͵� �������� ä���� ó�� �Ҵ��� ũ�⸦ ������)
                            �ַ� ���� ���� ���ڼ��� ������ ���� ��� ���
                            EX)���� :M/F, �ֹι�ȣ : 14����
            VARCHAR2(����Ʈ��): �ִ� 4000BYTE���� ���� ����
                                ��������(�������� ���� ��� �� ��� ���� ���� ũ�Ⱑ �پ���.)
                                VAR�� '����',2�� 2�踦 �ǹ��Ѵ�.
                                �ַε��� ���� ���ڼ��� �������� ���� ��� ���
                                EX)�̸�, ���̵�,��й�ȣ ����.
            ����(NUMBER):����/�Ǽ� ������� NUMBER�ϳ�
            ��¥(DATE): ��/��/��/��/��/�� �������� �ð� ����.

*/

--ȸ���鿡 ������ ���̵� ��й�ȣ �̸� ������� �� ������� ���̺� MEMBER����

CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
);
--���̺� Ȯ�� ���
--1)������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� ���̺�
SELECT *
FROM USER_TABLES;
--2)�����ǿ��� Ȯ���ϱ�.
--3)

--������� Į������ Ȯ�� ��

SELECT *
FROM USER_TAB_COLUMNS;
--USER_TAB_COLUMNS: ���� �� ����� ������ ������ �ִ� ���̺��� ��� �÷������� ��ȸ�� �� �ִ� �ý��� ���̺�.
--�÷��� �ּ��ޱ�(COMENT)
/*
    [ǥ����]
    COMMENT ON COLUMN ���̺�� . �÷���  IS '�ּ�����'
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
--ȸ����й�ȣ 
--ȸ���̸�
--�������
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '�������';

SELECT *
FROM MEMBER;
/*--������ �߰�
--INSERT(DML):�����͸� �߰��Ҽ��ִ� ����.
--�������� �߰� (���� �������� �߰�),�߰��� ���� ���(���� ���� �߿�)
    [ǥ����]
    INSERT INTO ���̺�� VALUES(ù��° Į���� ��,�ι�° Į���� ��, ....)

*/
INSERT INTO MEMBER VALUES('user01','password01','�ΰ��','1990-10-06');
INSERT INTO MEMBER VALUES('user02','password02','�̰��','1996-12-16');
INSERT INTO MEMBER VALUES('user03','password03','����','1992-11-30');
INSERT INTO MEMBER VALUES('user04','password04','�Ű��','2000-10-06');

INSERT INTO MEMBER VALUES(NULL,NULL,NULL,SYSDATE);
INSERT INTO MEMBER VALUES('user03','password03','����','1992-11-30');

--NULL���̳� �ߺ��Ȱ��� ��ȿ���� ���� ���̴�.
--��ȿ�� �����Ͱ��� �����ϱ� ���ؼ� ���������̶����� �ɾ������.
--���������� ���� �������� ���Ἲ ������ ��������.
--�������� :���̺��� ���鶧 �������� �Ŀ� ���� �߰� ����.


/*
    <�������� CONSTRAINTS>
    
    -���ϴ� �����Ͱ��� ����,�����ϱ� ���ؼ� Ư�� COLUMN���� �����ϴ� ����
    (������ ���Ἲ ������ ��������)
    -���� ������ �ο��� �÷��� ���� �������� ������ �ִ��� ������ �ڵ����� �˻��� ����.
    -����: NOT NULL, UNIQUE,CHECK,PRIMARY KEY,FOREIGN KEY
    

    - �÷��� ���������� �ο��ϴ� ��� :�÷����� ��� /���̺� ���� ���.   
*/

    /*
        1. NOT NULL��������: �ش��÷��� �ݵ�� ���� �����ؾߵɶ� ���
        -> NULL���� ���ͼ��� �ȵǴ� �÷��� �ο��ϴ� ��������
            ���� ������ NULL���� ������� �ʵ��� �����ϴ� ��������
        ���ǻ��� :�÷����� ��Ĺۿ� �ȵ�.
        
        --�÷��������: �÷��� �ڷ��� �������� =?> ���������� �ο��ϰ��� �ϴ� �÷��ڿ� ��ٷ� ���
        2.    
            
            
    */
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENTER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

INSERT INTO MEM_NOTNULL values ( 1,'user01','pass01','��ΰ�','��','010-4121-5555','alsrudals@iei.or.kr');
INSERT INTO MEM_NOTNULL VALUES(2,NULL,NULL,NULL,NULL,NULL,NULL);--cannot insert NULL
-->NOTNULL�������ǿ� ����
INSERT INTO MEM_NOTNULL VALUES(2,'user01','pass01','�����',NULL,NULL,NULL);
/*
    2.UNIQUE ��������
    �÷��� �ߺ����� �����ϴ� ��������.
    ���� ������ ������ �ش� Į�����߿� �ߺ��� ���� �ִ� ��� �߰��� ������ �����ʰԲ� �����Ŵ
    �÷��������/���̺������

*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE , --������ �޸����� ���޾� ���డ��
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER VARCHAR2(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    /*,UNIQUE(MEM_ID)*/
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;--���̺��� ������Ű�� Ű����

INSERT INTO MEM_UNIQUE VALUES( '1','USER01','PASS01','����','��','010-3338-6666'
,'email@gmail.com');
INSERT INTO MEM_UNIQUE VALUES( '2','USER01','PASS02','�����','��','010-2338-6666'
,'gemail@mail.com');
--unique constraint (DDL.SYS_C007046) violated
--������ ������ �ι� �����������, unique �������ǿ� ���� �Ǿ����Ƿ� insert ������
--DDL.SYS_C007046�� �ش��ϴ� �÷��� ���� Ȯ���ҷ��� ���̺� ���� Ȯ���ؾߵȴ�.
-->�������� �ο��� �������� �� �����ϴ� ǥ����
/*
    -> �÷����� ���
    CREATE TABLE ���̺�� (
        �÷��� �ڷ��� ��������1 ��������2,
        �÷��� �ڷ��� CONSTRAINT�������Ǹ� ��������,
        �÷��� �ڷ���
    );
    ->���̺��� ���
    CREATE TABLE ���̺�� (
        �÷��� �ڷ��� ��������1 ��������2,
        �÷��� �ڷ��� ��������1,
        �÷��� �ڷ���,
        CONSTRAINT �������Ǹ� ��������(�÷���)
    );
*/

CREATE TABLE MEM_CON_NN(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    EMAIL VARCHAR2(30) NOT NULL
--    CONSTRAINT ID_UQ UNIQUE(MEM_ID)
    );
    
INSERT INTO MEM_CON_NN VALUES(
'1','USER01','PASS01','����','��'
,'email@gmail.com'
);--�ѹ��� �����ϸ� ���� ������ �������� �ڵ尡 ���.
--ORA-00001: unique constraint (DDL.MEM_ID_UQ) violated
INSERT INTO MEM_CON_NN VALUES(
'1','USER02','PASS01','����','��'
,'email@gmail.com'    );
INSERT INTO MEM_CON_NN VALUES(
'1','USER03','PASS01','����','��'
,'email@gmail.com'    );
/*
    1. CHECK ��������
        �÷��� ��ϵɼ� �ִ� ���� ���� ������ ������ �� �ִ�.
        EX)���� �� �� �� �����Բ� �ϰ�ʹ�,
        [ǥ����]

*/

CREATE TABLE MEM_MEMCHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30) NOT NULL,
    MEM_DATE DATE NOT NULL
--    CONSTRAINT ID_UQ UNIQUE(MEM_ID)
    );
    
    
INSERT INTO MEM_MEMCHECK VALUES( '2','USER01','PASS01','����','��','010-3333-4444'
,'email@gmail.com',SYSDATE
);
INSERT INTO MEM_MEMCHECK VALUES( '2','USER01','PASS01','����','��','010-3333-4444'
,'email@gmail.com',SYSDATE
);

--���� üũ ���������� �ɰ� D�ȿ� NULL�� ���� ��� ���������� INSERT����

--�߰������� NULL���� ����� ���� �ϰ�ʹٸ� NOTNULL�������ǵ� ���� �ɾ��ָ��

/*
    DEFAULT ����
        Ư�� Į���� ���� ���� ���� �⺻�� ���� ����
        �����������ƴ�
        EX) ȸ�������� �÷��� ȸ�������� ����� ������ ����ϰ� �ʹ�. ->DEFAULT ������ SYSDATE �������
    
*/

DROP TABLE MEM_MEMCHECK;
CREATE TABLE MEM_MEMCHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_GENDER CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --> DEFAULT ���������� �ݵ�� ���� �ɾ�ߵ�
    );
    
INSERT INTO MEM_MEMCHECK VALUES
( '2','user3','PASS01','����','��','010-3333-4444','1@2',SYSDATE);
SELECT * FROM MEM_MEMCHECK;

/*
INSERT INTO MEM_CHECK (�÷��� ����)VALUES (���鳪��)
*/
INSERT INTO MEM_MEMCHECK (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME) VALUES (
    '3','UESR02','PWPW','�ƾ�');--�˾Ƽ� SYSDATE�� �ʱ�ȭ �Ǿ���.

/*
    PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ����� ������ �����ϰ� �ĺ��Ҽ� �ִ� Į���� �ο��ϴ� ��������.
    => �� ����� ������ ���ִ� �ĺ��� �� ����
        ��) ���,�μ����̵�,�����ڵ�,ȸ����ȣ..
    =>�ĺ����� ���� :�ߺ��Ǿ�� �ȵ�, ���� ������ �ȵ� => NOT NULL +UNIQUE
    
    ���ǻ��� : �� ���̺�� �Ѱ��� Į������ �⺻Ű�� ���� ����.
*/  
DROP TABLE MEM_PRIMARYKEY1;
CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_GENDER CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
);

INSERT INTO MEM_PRIMARYKEY1 VALUES(
 '2','user3','PASS01','����','��','010-3333-4444','1@2',SYSDATE
);
INSERT INTO MEM_PRIMARYKEY1 VALUES(
 '2','user3','PASS01','����','��','010-3333-4444','1@2',SYSDATE
);--���� ��ħ
INSERT INTO MEM_PRIMARYKEY1 VALUES(
 NULL,'user3','PASS01','����','��','010-3333-4444','1@2',SYSDATE
);--�Է¾��ؼ� ����Ұ�
DROP TABLE MEM_PRIMARYKEY2;
CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ2 UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_GENDER2 CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO)
);

--name already used by an existing constraint
--�������Ǹ��� �ٸ����̺� �ִ��� �ߺ��ɼ����� ����
--���÷��� ��� �ѹ��� PRIMARY KEY �� ���� ���� => ���̺��� ������θ� ����.
CREATE TABLE MEM_PRIMARYKEY3(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEM_PK_GENDER2 CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT MEM_PK3 PRIMARY KEY(MEM_NO,MEM_ID)-->����Ű.
);

INSERT INTO MEM_PRIMARYKEY3 (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (
1,'U1','P1','���');
INSERT INTO MEM_PRIMARYKEY3 (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (
1,'U2','P1','���');
--����Ű�ϰ�� 2Ű�� �� ��ġ�ؾ� �������ǿ� �����
INSERT INTO MEM_PRIMARYKEY3 (MEM_NO,MEM_ID,MEM_PWD,MEM_NAME ) VALUES (
1,NULL,'P1','���');
--����Ű�� ��� 2Ű�� �ϳ��� NULL�̸� �������ǿ� �����

/*
    5. FOREIGN KEY(�ܷ�Ű)
        �ش�Į���� �ٸ����̺� �����ϴ� ���� ���;� �ϴ� �÷�
        �÷��� �ο��ϴ� ��������
        => �ٸ����̺�(�θ����̺�)�� �����Ѵ� ��� ǥ��
        �� ������ �ٸ����̺� �� �����ϴ� �ִ� ���� ���ü��ִ�.
        EX) KH ��������
            EMPLOYEE ���̺�(�ڽ����̺�)<=========DEPARTMENT ���̺�(�θ����̺�)
            DEPT_CODE                           DEPT_ID
            =>DEPT_CODE���� DEPT_ID�� �����ϴ� ���鸸 ���� ���ֵ�.
            
            =?FORIGN KEY �������� (==�����)���� �ٸ� ���̺�� ���踦 �����Ҽ��ִ�.(==JOIN)
            
            [ǥ����]
            >�÷����� ���
            �÷��� �ڷ��� CONSTRAINT �������Ǹ� REFERENCES ������ ���̺�� (������ Į����)
            >���̺��� ���
            CONSTRAINT �������Ǹ� FOREIGN KEY(�÷���) REFERENCES ������ ���̺��(������ Į����)
            
            ������ ���̺� == �θ����̺�
            ���������Ѱ� : CONSTRAINT �������Ǹ� , ������ �÷��� (�ι�� ��� �ش��)
            -> �ڵ������� ������ ���̺��� PRIMARY KEY�� �ش�Ǵ� �÷��� ������ �÷������� ����.
            
            ���ǻ��� : ������ �÷�Ÿ�԰� �ܷ�Ű�� ������ �÷�Ÿ���� ���ƾ��Ѵ�.
            

*/


/*
    �θ����̺�
    ȸ���� ��޿� ���� ���̺� (����ڵ� ,��޸�)�����ϴ� ���̺�

*/
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY, --����ڵ� /���ڿ� ('G1''G2''G3'...)
    GRADE_NAME VARCHAR(20) NOT NULL -- ��޸� //���ڿ�(�Ϲ�ȸ�� ���ȸ�� Ư��ȸ��)
);
INSERT INTO MEM_GRADE VALUES( 'G1','�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES( 'G2','���ȸ��');
INSERT INTO MEM_GRADE VALUES( 'G3','Ư��ȸ��');

SELECT * 
FROM MEM_GRADE;
--ȸ�������� ��� �ڽ����̺� ����


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),
    GENDER CHAR(3)  CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --���̺� ���
);
DROP TABLE MEM;
SELECT *
FROM MEM;

INSERT INTO MEM VALUES(
 '1','user1','PASS02','�ű��','G3','��','010-3233-4454','2@22',SYSDATE
);
INSERT INTO MEM VALUES(
 '2','user3','PASS01','����','G1','��','010-3333-4444','1@2',SYSDATE
);
INSERT INTO MEM VALUES(
 '3','user4','PASS02','���','G2','��','010-3333-4454','1@22',SYSDATE
);

SELECT 
MEM_NAME,
GRADE_NAME
FROM MEM
JOIN MEM_GRADE ON (GRADE_ID=GRADE_CODE);

INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GENDER,GRADE_ID) VALUES (
    '4','USER33','1Q2W3E','�����','��','G4'
);--parent key not found
--�θ�Ű�� ��ġ���� ������ �ȵȴ�
INSERT INTO MEM(MEM_NO,MEM_ID,MEM_PWD,MEM_NAME,GENDER,GRADE_ID) VALUES (
    '5','USER33','1Q2W3E','�����','��',NULL
);--NULL���� ������ ��

--���� ) �θ����̺��� ���� �����ȴٸ�?
DELETE FROM MEM_GRADE
WHERE GRADE_CODE='G1';
-- child record found
-- �ڽ� ���̺��� �ش� ���� �����ؼ� ������̱� ������ �����Ҽ� ����.

DROP TABLE MEM;--�ڽ����̺� ������ ������ �����ϴ�.

/*
    �ڽ� ���̺� ������(==�ܷ�Ű ���������� �ο�������)
    �θ����̺��� �����Ͱ� �����Ǿ����� �ڽ����̺��� ��F�� ó������ �ɼ��� �������ټ��ִ�.
    FOREIGN KEY �����ɼ�
        - ON DELETE SET NULL : �θ����͸� �����Ҷ� �����͸� ����ϴ� �ڽ� �����͸� NULL�� �ٲٰڴ�.
        - ON DELETE CASECADE : �θ����͸� �����ҋ� �ش� �����͸� ����ϴ� �ڽĵ����͸� ���� �����ϰڴ�.
        - ON DELETE RESTRICTED : �������� -> �⺻�ɼ�

*/

-- ONDELETE SET NULL

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL,
    GENDER CHAR(3)  CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --���̺� ���
);

INSERT INTO MEM VALUES(
 '1','user1','PASS02','�ű��','G3','��','010-3233-4454','2@22',SYSDATE
);
INSERT INTO MEM VALUES(
 '2','user3','PASS01','����','G1','��','010-3333-4444','1@2',SYSDATE
);
INSERT INTO MEM VALUES(
 '3','user4','PASS02','���','G2','��','010-3333-4454','1@22',SYSDATE
);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';--�ڽ����̺��� G1�̸�� NULL�� ����Ǿ���.


CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE ,
    GENDER CHAR(3)  CHECK (GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --���̺� ���
);
SELECT * FROM MEM;
DELETE FROM MEM_GRADE WHERE GRADE_CODE = 'G2';--�ڽ����̺��� G2�� ������ ���� ��� �����ȴ�.
--���ι���
--��ü ȸ���� ȸ����ȣ ���̵� ��й�ȣ �̸� ��޸���ȸ
SELECT
    mem_no,
    mem_id,
    mem_pwd,
    mem_name,
    grade_name
FROM MEM
LEFT JOIN MEM_GRADE ON GRADE_CODE=GRADE_ID;
SELECT
    mem_no,
    mem_id,
    mem_pwd,
    mem_name,
    grade_name
FROM MEM,MEM_GRADE
WHERE GRADE_CODE=GRADE_ID(+);

--���� �ܷ�Ű�� �����Ǿ������ʾƵ� JOIN�̰�����
--�� �� �÷��� ������ �ǹ��� �����Ͱ� ����־�� ��. (�ڷ����� ���� ������� �ǹ̵� ����ؾ���.
---------------------------------------------
--����ڰ��� KH�� ����

/*
SUBQUALY�� �̿��� INSERTE ���̺� ���� (���̺� ������ ����)

���� SQL �� (SELECT, CREATE , INNSERT,UPDATE...)�� �����ϴ� ������ �������� ������������
    [ǥ����]
    CREATE TABLE ���̺��
    AS��������;
*/
CREATE TABLE EMPLOYEE_COPY
AS(
    SELECT *
    FROM EMPLOYEE
);
--�÷��� �ڷ��� NOT NULL ���������� ����� �����.
--PRIMARY KEY ���������� ����� ���簡 �ȵ�.
-->���������� ���� ���̺��� ������ ��� ���������� ��� NOT NULL �������Ǹ� ����ȴ�
SELECT * FROM EMPLOYEE_COPY;
SELECT * FROM EMPLOYEE;
CREATE TABLE BLANK_EMPLOYEE AS(
SELECT * FROM EMPLOYEE
WHERE 1=0);--1=0�� FALSE���ǹ��� 1=1�� TRUE;
-->�̸��̿��� Į���� ������ �����ؿü��ִ�.
SELECT* FROM BLANK_EMPLOYEE;

--��ü������� 300�����̻��� ������� ��� �̸� �μ��ڵ� �޿� ���� Į��
--EMPLOYEE_COPY3
CREATE TABLE EMPLOYEE_COPY3 AS(
    SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
    FROM EMPLOYEE
    WHERE SALARY>=3000000
    
);
--2. ��ü ������� ��� ����� �޿� ���� ��ȸ ����� ������ ���̺� ����
---EMPLOYEE_COPY4
DROP TABLE EMPLOYEE4;
CREATE TABLE EMPLOYEE_COPY4 AS(
SELECT EMP_ID,EMP_NAME,SALARY,SALARY*12 AS annual_income
FROM EMPLOYEE);
--���������� SELECT���� ������� �Ǵ� �Լ����� ����Ȱ�� �ݵ�� ��Ī�� �ٿ�����.
