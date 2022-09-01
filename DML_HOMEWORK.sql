--1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
INSERT INTO TB_CLASS_TYPE VALUES('01','�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('02','��������');
INSERT INTO TB_CLASS_TYPE VALUES('03','�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('04','���缱��');
INSERT INTO TB_CLASS_TYPE VALUES('05','������');
COMMIT;
--2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�.�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)

CREATE TABLE TB_NOMAL_STUDENT_INFO AS
    SELECT
        STUDENT_NO,
        STUDENT_NAME,
        STUDENT_ADDRESS
    FROM TB_STUDENT;
SELECT * FROM TB_NOMAL_STUDENT_INFO;
/*
3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� ����.
�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ�
�ۼ��Ͻÿ�)
*/

CREATE TABLE TB_������а� AS
    SELECT
        STUDENT_NO,
        STUDENT_NAME,
        '19'||SUBSTR(STUDENT_SSN,1,2) AS BRT_YEARS,
        PROFESSOR_NAME
    FROM TB_STUDENT S
    JOIN TB_PROFESSOR P ON COACH_PROFESSOR_NO=PROFESSOR_NO
    JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
    WHERE DEPARTMENT_NAME= '������а�';
SELECT * FROM TB_������а�;
--4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� ����)
    UPDATE TB_DEPARTMENT
            SET CAPACITY=ROUND(CAPACITY*1.1);
          
--5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ�����. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�

UPDATE TB_STUDENT
    SET student_address='����� ���α� ���ε� 181-21'
    WHERE STUDENT_NO='A413042' AND STUDENT_NAME='�ڰǿ�';
SELECT * FROM TB_STUDENT WHERE STUDENT_NO='A413042' AND STUDENT_NAME='�ڰǿ�';    
    
/*6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ��
�����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
(��. 830530-2124663 ==> 830530 )    */
    
UPDATE TB_STUDENT
    SET STUDENT_SSN = SUBSTR(STUDENT_SSN,1,6);
SELECT * FROM TB_STUDENT;

/*
    7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������
    �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش�
    ������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�
*/

    UPDATE TB_GRADE
        SET POINT=3.5
        WHERE CLASS_NO=(SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME='�Ǻλ�����')
        AND STUDENT_NO=(SELECT STUDENT_NO FROM TB_STUDENT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) WHERE STUDENT_NAME='�����'
                        AND DEPARTMENT_NAME='���а�')
        AND TERM_NO='200501';
        
        SELECT * 
        FROM TB_GRADE
        WHERE CLASS_NO=(SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME='�Ǻλ�����')
        AND STUDENT_NO=(SELECT STUDENT_NO FROM TB_STUDENT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) WHERE STUDENT_NAME='�����'
                        AND DEPARTMENT_NAME='���а�')
        AND TERM_NO='200501';
        
    --8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.
    DELETE FROM TB_GRADE
    WHERE STUDENT_NO IN (
        SELECT STUDENT_NO
        FROM TB_STUDENT
        WHERE ABSENCE_YN='Y'
    );
    SELECT * FROM TB_GRADE
    WHERE STUDENT_NO IN (
        SELECT STUDENT_NO
        FROM TB_STUDENT
        WHERE ABSENCE_YN='Y'
    );
