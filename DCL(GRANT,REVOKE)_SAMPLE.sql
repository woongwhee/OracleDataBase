--1.CREATE TABLE 권한 부여받기전

CREATE TABLE TEST (
    TEST_ID NUMBER(10)
);--insufficient privileges 권한 불충분

--2.CREATE TABLE 권한 을 부여받은후
CREATE TABLE TEST (
    TEST_ID NUMBER(10)
);
---no privileges on tablespace 'SYSTEM'
--TABLESPACE : 테이블들이 모여있는 공간
--SAMPLE계정에는 TABLESPACE가 아직 할당되지 않았음

--3. TABLESPACE를 할당받은후
CREATE TABLE TEST (
    TEST_ID NUMBER
);

--위 테이블생성권한을 부여받게되면
--계정이 소유하고 있는 테이블들을 조작(SELECT,INSERT,UPDATE ..DML)하는것이 가능해짐.

INSERT INTO TEST VALUES(1);

SELECT * FROM TEST;
-- 4. 뷰만들기
CREATE VIEW VW_TEST AS
    SELECT * FROM TEST;
    --"insufficient privileges" 권한 불충분
    
--권한 부여 받은후
CREATE VIEW VW_TEST AS
    SELECT * FROM TEST;--생성완료
    
    
--5. SAMPLE계정에서 KH계정의 테이블에 접근해서 조회해 보기.
SELECT * FROM EMPLOYEE;--이럼사용못함
SELECT * FROM KH.EMPLOYEE; --KH접근권한이 없엇임
--SELECT ON 부여받은후
SELECT * FROM KH.EMPLOYEE;--접근가능
    
--6. SAMPLE계정에서 KH 계정의 DEPARTMENT 테이블에 접근해서 행 삽입해보기.
INSERT INTO KH.DEPARTMENT VALUES('D0','회계부','L2'); --권한없어서 발생


--권한부여후
INSERT INTO KH.DEPARTMENT VALUES('D0','회계부','L2'); 
--다른 테이블에 대한 변경사항은 COMMIT을 하지 않는다면 확인되지 않고 적용되지 않음 되지는 않음
--7. SAMPLE의 테이블 생성 권한을 뺏은후
CREATE TABLE TEST2 (
    TEST_ID NUMBER
);--"insufficient privileges" 권한이 빼앗긴걸 확인 할 수 있다.