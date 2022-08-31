--Procedural Language extension to SQL
-- PK ���������̾���
SELECT * FROM USER_MOCK_DATA;
SELECT COUNT(*)FROM USER_MOCK_DATA;

-- ID �÷��˻� 222
SELECT * FROM USER_MOCK_DATA WHERE ID= '222'; -- OPTION FULL CARDINALITY 8 COST 136
-- EMAIL �÷� �˻� 
-- �̸����� �̸��� kbresland@comsenz.com
SELECT * FROM USER_MOCK_DATA WHERE EMAIL='stattoolr@digg.com'; -- OPTION FULL CARDINALITY 5 COST 136;

SELECT * FROM USER_MOCK_DATA WHERE GENDER='Male';-- OPTION FULL CARDINALITY 25918 ���� ������ COST 137;
--FIRST_NAME�� LIKE ���
SELECT FIRST_NAME FROM USER_MOCK_DATA WHERE FIRST_NAME LIKE 'R%'; -- OPTION FULL CARDINALITY 2929 ���� ������ COST 136;

------------------------------------------------------------------------------------------------------------------------
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT PK_MOCK_DATA_ID PRIMARY KEY(ID);
-- PK�������� �߰���
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT UQ_MOCK_DATA_EMAIL UNIQUE(EMAIL);
-- UNQIE(EMAIL)
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;
CREATE INDEX UQ_USER_MOCK_DATA_GENDER ON USER_MOCK_DATA(GENDER);
-----------------------------
SELECT * FROM USER_MOCK_DATA WHERE ID=22222; --OPTION BY INDEX ROWID CARDINALITY 5 COST;
SELECT * FROM USER_MOCK_DATA WHERE EMAIL='stattoolr@digg.com'; --OPTION BY INDEX ROWID CARDINALITY 1 COST 2;

SELECT * FROM USER_MOCK_DATA WHERE GENDER='Male';--OPTION BY INDEX ROWID CARDINALITY 25918 COST 63 ;
--���� �ణ ���Ơ���

CREATE INDEX UQ_USER_MOCK_DATA_FIRST_NAME ON USER_MOCK_DATA(FIRST_NAME);
SELECT * FROM
USER_MOCK_DATA
WHERE FIRST_NAME LIKE 'R%'; --OPTION RANGE SCAN CARDINALITY 25918 63
--�Ϲ� �����͸� ����Ҷ� ȿ���� �������� Ȯ���� ü���� �ȵȴ�.
--������ ��ȹ������ ���� Ȯ���غ� �ʿ� �ִ�.

/*
    
    [�ε��� ����]
    
    1)WHERE ���� �ε��� �÷��� ���� �ξ� ������ ���� �����ϴ�.
    2)ORDER BY ������ ����� �ʿ䰡 ����(�̹� ������ �Ǿ��ִ�.)
        ����) ORDER BY ���� �޸𸮸� ���� ��ƸԴ� �۾���
    3)MIN,MAX���� ã���� ����ӵ��� �ſ����(���ĵǾ��ֱ⋚��)
    
    [�ε����� ����]
    
    1) DML������� <- INSERT DELETE UPDATE
    2) INDEX�� �̿��� INDEX-SCAN ���� �ܼ���  FULLSCAN�� �� �����Ҷ��� ����
    3) �ε����� �������� ��������� ��ƸԴ´�.

*/











