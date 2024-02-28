-- 1. 영문학과(코드 002) 학생들의 학번, 이름, 입학년도 구함
-- 입학년도 빠른 순으로 표시
-- 헤더는 학번, 이름, 입학년도로 표시

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, 
			 TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
FROM TB_STUDENT
ORDER BY 입학년도 ASC;

-- 2. 이름이 세 글자가 아닌 교수 두명
-- 그들의 이름, 주민번호 조회하는 SQL 작성

SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;


-- 3. 남자 교수들의 이름과 나이를 나이 오름차순으로 조회
-- 교수 중 2000년 이후 출생자는 없음
-- 출력헤더는 "교수이름"
-- 나이는 만으로 계산
-- ++++++ 한번 더 보기 +++++++
SELECT PROFESSOR_NAME,
			 FLOOR(MONTHS_BETWEEN( SYSDATE,
			 TO_DATE(19 || SUBSTR(PROFESSOR_SSN,1,6),'YYYYMMDD') )/12) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 나이 ASC;



-- 4. 교수들의 이름 중 성을 제외한 이름만조회하시오.
-- 	  출력 헤더는 "이름" 이 찍히도록 한다.
--		(성이 2글자인 교수는 없다고 가정)
SELECT SUBSTR(PROFESSOR_NAME, 2,2)
FROM TB_PROFESSOR ;


-- 5. 재수생 입학자 학번, 이름 조회
-- (19살에 입학하면 재수를 하지 않은 것임)
-- 입학일자 - 생일 > 19 인 사람 조회

SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT
WHERE EXTRACT (YEAR FROM ENTRANCE_DATE) - TO_NUMBER (19||SUBSTR(STUDENT_SSN, 1, 2)) > 19 ;

-- 6. 2000년도 이후 입학자들은 학번이 A로 시작함
-- 2000년도 이전 학번 학생들의 학번과 이름 조회

SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT 
WHERE STUDENT_NO NOT LIKE 'A%';





