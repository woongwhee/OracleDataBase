/*
    TCL(TRANSACTION LANGUAGE) : 트랜잭션 제어 언어
    
    트랜젝션 
    - 데이터베이스의 논리적 작업 단위
    - 데이터의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 처리
        => COMMIT(확정) 하기 전까지의 변경사항들을 하나의 트랜잭션으로 담겠다.
    - 트랜잭션의 대상이 되는 SQL문 : INSERT , UPDATE , DELETE
    
    *트랜잭션 종류
    -COMMIT; (진행): 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다는것을 의미
                    실제 DB에 반영시킨후 트랜잭션은 비워짐 -> 확정
    -ROLLBACK(실행시) : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하지 않겠다는 것을 의미
                        트랜잭션에 담겨있는 변경사항도 다 삭제한 후 마지막 COMMIT 시점으로 돌아감.
    -SAVEPOINT 포인트명: (실행시) : 현재 이 시점에 임시저장점을 정의해둠.
    -ROLLBACK TO 포인트명 : (실행시): 전체 변경사항들을 삭제(마지막 COMMIT시점까지 돌려놓음) 하는것이 아니라
                                    해당 포인트 지점까지의 트랜잭션을 롤백함

*/




SELECT * FROM EMP_01;
DELETE FROM EMP_01
    WHERE EMP_ID=217;
DELETE FROM EMP_01
    WHERE EMP_ID=216;
ROLLBACK;

--------------------------------------------------------------------------------

--사번이 200번인 사원삭제
DELETE FROM EMP_01
    WHERE EMP_ID=200;

INSERT INTO EMP_01 VALUES(800,'홍길동','총무부');

SELECT * FROM EMP_01;

COMMIT; 
ROLLBACK; --돌아오지 않는다.
--트랜잭션의 대상이 되는 SQL문중에 남아있는게 없기때문
--------------------------------------------------------------------------------
--EMP_01테이블에서 사번이 217 216 214 사원만 삭제

DELETE FROM EMP_01
    WHERE EMP_ID IN(217,216,214);
SAVEPOINT DEDE;

DELETE FROM EMP_01
    WHERE EMP_ID = 218;
INSERT INTO EMP_01 VALUES (800,'민경민','인사부');
SELECT * FROM EMP_01;--19개남음

ROLLBACK TO DEDE;
SELECT * FROM EMP_01;--20개남음 세이브 포인트 시점까지 롤백됨
ROLLBACK;
SELECT * FROM EMP_01; --23개남음 세이브포인트 전에도 트랜잭션에 남아있으면 롤백시킴
/*

    주의사항)
    DDL 구문을 실행하느 순간
    기조 트랜잭션에 있던 모던 변경상흘 무조건 실제DB에 반영 시컨후 DDL수행됨
    
    =>즉 DDL수행전 병경사항중 정확히 픽스르 하고 DDL을 실행한다
    */
--------------------------------------------------------------------------------
/*
--비밀번호 변경 처리(비밀번호를 변경해주는 트랜직션)
    비지니스 로직
    1. 아이디, 비밀번호 입력해서 본인임을 확인.
    2. 기존의 비밀번호, 새로운 비밀번호를 입력.
    3. 기존의 비밀번호와 새로운 비밀번호가 다르다면 변경
*/
--1. 아이디와 비밀번호 입력해서 본인임을 확인
SELECT MEMBER_ID,MEMBER_PWD
FROM MEMBER
WHERE MEMBER_IDE='사용자가 입력한 아이디' AND MEMBER_PWD ='사용자가 입력한 비밀번호';
--2. 기존의 비밀번호,새로운 비밀번호를 입력.

--3. 기존의 비밀번호와 새로운 비밀번호가 다르다면 변경
UPDATE MEMBER
    SET MEMBER_PWD='새로운 비밀번호'
    WHERE MEMBER_ID='아이디' AND
    MEMBER_PWD='기존의 비밀번호'
    AND '기존의 비밀번호'!= '새로운 비밀번호'; -- 없어도됨.
    COMMIT;




    

