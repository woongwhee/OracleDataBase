--Procedural Language extension to SQL
-- PK 제약조건이없음
SELECT * FROM USER_MOCK_DATA;
SELECT COUNT(*)FROM USER_MOCK_DATA;

-- ID 컬럼검색 222
SELECT * FROM USER_MOCK_DATA WHERE ID= '222'; -- OPTION FULL CARDINALITY 8 COST 136
-- EMAIL 컬럼 검색 
-- 이메일의 이름이 kbresland@comsenz.com
SELECT * FROM USER_MOCK_DATA WHERE EMAIL='stattoolr@digg.com'; -- OPTION FULL CARDINALITY 5 COST 136;

SELECT * FROM USER_MOCK_DATA WHERE GENDER='Male';-- OPTION FULL CARDINALITY 25918 행의 개수다 COST 137;
--FIRST_NAME에 LIKE 사용
SELECT FIRST_NAME FROM USER_MOCK_DATA WHERE FIRST_NAME LIKE 'R%'; -- OPTION FULL CARDINALITY 2929 행의 개수다 COST 136;

------------------------------------------------------------------------------------------------------------------------
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT PK_MOCK_DATA_ID PRIMARY KEY(ID);
-- PK제약조건 추가후
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT UQ_MOCK_DATA_EMAIL UNIQUE(EMAIL);
-- UNQIE(EMAIL)
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;
CREATE INDEX UQ_USER_MOCK_DATA_GENDER ON USER_MOCK_DATA(GENDER);
-----------------------------
SELECT * FROM USER_MOCK_DATA WHERE ID=22222; --OPTION BY INDEX ROWID CARDINALITY 5 COST;
SELECT * FROM USER_MOCK_DATA WHERE EMAIL='stattoolr@digg.com'; --OPTION BY INDEX ROWID CARDINALITY 1 COST 2;

SELECT * FROM USER_MOCK_DATA WHERE GENDER='Male';--OPTION BY INDEX ROWID CARDINALITY 25918 COST 63 ;
--아주 약간 좋아젔다

CREATE INDEX UQ_USER_MOCK_DATA_FIRST_NAME ON USER_MOCK_DATA(FIRST_NAME);
SELECT * FROM
USER_MOCK_DATA
WHERE FIRST_NAME LIKE 'R%'; --OPTION RANGE SCAN CARDINALITY 25918 63
--일반 데이터를 사용할때 효율이 좋아질지 확실히 체감이 안된다.
--때문에 계획설명을 통해 확인해볼 필요 있다.

/*
    
    [인덱스 장점]
    
    1)WHERE 절에 인덱스 컬럼을 사용시 훨씬 빠르게 연산 가능하다.
    2)ORDER BY 연산을 사용할 필요가 없음(이미 정렬이 되어있다.)
        참고) ORDER BY 절은 메모리를 많이 잡아먹는 작업임
    3)MIN,MAX값을 찾을때 연산속도가 매우빠름(정렬되어있기떄문)
    
    [인덱스의 단점]
    
    1) DML에취약함 <- INSERT DELETE UPDATE
    2) INDEX를 이용한 INDEX-SCAN 보다 단순한  FULLSCAN이 더 유리할때가 있음
    3) 인덱스가 많을수록 저장공간을 잡아먹는다.

*/











