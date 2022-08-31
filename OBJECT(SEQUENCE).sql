/*
    <시퀀스 SEQUENCE>
    자동을 번호를 발생시켜주는 역할을 하는 객체 (자동번호 부여기)
    정수값을 자동을 순차적으로 발생시켜줌 (연속된 숫자로)
    EX)주차번호 ,회원번호 ,사번, 게시글번호 등
    -> 순차적으로 겹치지 않는 숫자로 채변할때 사용할 예정임
    
    1. 시퀀스 객체 생성구문
        [표현법]
        CREATE SEQUENCE 시퀀스명
        START WITH 시작숫자 => 생략가능 , 자동으로 발생시킬 시작점(DEFAULT 값은 1)
        INCREMENT BY 증가값 => 생략가능 , 한번 시퀸스 증가할때마다 몇씩 증가할건지 결정(DEFAULT값은 1)
        MAXVALUE 최대값 => 생략가능 , 최대값 지정
        MINVALUE 최소값 => 생략가능 , 최소값 지정
        CYCLE/NOCYCLE => 생략가능 , 값의 순환 여부를 결정
        CACHE 바이트크기 / NOCACHHE => 생략가능 캐시메모리 여부 지정 기본값은 20BYTE
        
        캐시메모리
        시퀀스로부터 미리 발생될 값들을 생성해서 저장해 두는 공간.
        매번 호출할때마다 새로이 번호를 생성하는 것보단 캐시메모리에 미리 생성된 값을 가저다 쓰면 훨씬 빠르게 사용 가능.
        접속이 끊기고 재접속시 기존에 생성된 값들은 날라가기 때문에 조심해야된다.
*/
CREATE SEQUENCE SEQ_TEST;


-- 현재 접속한 계정이 소유하고있는 시퀀스에 대한 정보 확인.

SELECT * FROM USER_SEQUENCES;
/*-
SEQUENCE_NAME
MIN_VALUE
MAX_VALUE
INCREMENT_BY
CYCLE_FLAG
ORDER_FLAG
CACHE_SIZE <-- DB에 연결이 끊기면 초기화된다.
LAST_NUMBER <-- 중요ㅛ중요 

*/

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. 시퀀스 사용구문
    시퀀스명.CURRVAL: 현재 시퀀스의 값 (마지막으로 성공적으로 발생된 NEXTVAL)
    시퀀스명.NEXTVAL : 현재 시퀀스의 값을 증가시키고, 그 증가된 시퀀스의 값
                    == 시퀀스.CURRVAL + INCREMENT BY 값만큼 증가된값.
    단 시퀀스 생성후 첫 NEXTVAL 은 START WITH로 지정된 시작값으로 발생함.
    
    
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--에러발생 시퀀스가 실행되고 한번이라도 NEXTVAL이 실행되지 않는 이상 CURRENTVAL을 실행 할 수 없다.
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- MAX값에 도달한뒤 한번더 NEXTVAL을 호출하면 에러나고 실행이 되지않는다.

SELECT * FROM USER_SEQUENCES;--LAST NUMBER 는 315가찍히네?
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;--이건 310;

/*
    3. 시퀀스 변경
    [표현법]
    ALTER  SEQUENSE 시퀸스명
        INCREMENT BY 증가값 => 생략가능 , 한번 시퀸스 증가할때마다 몇씩 증가할건지 결정(DEFAULT값은 1)
        MAXVALUE 최대값 => 생략가능 , 최대값 지정
        MINVALUE 최소값 => 생략가능 , 최소값 지정
        CYCLE/NOCYCLE => 생략가능 , 값의 순환 여부를 결정
        CACHE 바이트크기 / NOCACHHE => 생략가능 캐시메모리 여부 지정 기본값은 20BYTE
    
    START WITH은 변경불가 => 바꾸고 싶다면 삭제하고 다시 생성해야됨.

*/

ALTER SEQUENCE SEQ_EMPNO
    INCREMENT BY 10
    MAXVALUE 400;
 SELECT * FROM USER_SEQUENCES;--320 이 찍히는걸 보면 다음에 올 숫자일듯
 SELECT SEQ_EMPNO.CURRVAL FROM DUAL;-- 시퀀스 의 현재 값은 변경되지않음
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

--SEQUENCE 삭제하기
DROP SEQUENCE SEQ_EMPNO;


---------------------------
--매번 새로운 사번이 발생되는 시퀀스 생성(SEQ_EID)
CREATE SEQUENCE SEQ_EID
    START WITH 300
    INCREMENT BY 1
    MAXVALUE 400;
    
--사원이 추가될때 실행할 INSERT 문

INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL,'민경민','958252-1234567','J1','S1',SYSDATE);

SELECT * FROM EMPLOYEE ORDER BY EMP_ID;
INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL,'민경민2','958252-1234567','J1','S1',SYSDATE); --301로저장되는것



--- 시퀀스는 INSERT문의 PK 값에 넣을때 가장 많이 사용된다.

/*
    사용 할 수 없는 구문
    1. VIEW의 SELECT문
    2. DISTINCT 포함된 SELECT문
    3. GROUP BY HAVING ORDER BY 가 있는 SELECT문
    4. SELECT, DELETE, UPDATE의 서브쿼리
    5. CREATE TABLE, ALTER TABLE 명령의 DEFAULT값


*/