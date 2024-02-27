-- 1.  학과 이름과 계열 조회
-- 출력 헤터는 학과명, 계열로 표시하도록 한다.

SELECT DEPARTMENT_NAME 학과명 , CATEGORY 계열
FROM TB_DEPARTMENT ;

-- 2. 학과의 학과 정원을 다음과 같은 형태로 조회
-- 학과별 정원
-- 국어국문학과의 정원은 20명 입니다
-- 영어영문학과의 정원은 36명 입니다...

SELECT DEPARTMENT_NAME||'의 정원은 ' 
		 ||CAPACITY || '명 입니다'"학과별 정원" 

FROM TB_DEPARTMENT ;



-- 3. 국어국문학과에 다니는 여학생 중 현재 휴학 중인 여학생 조사
-- 국문학과의 학과 코드는 001

SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001'
	AND ABSENCE_YN = 'Y'
	AND SUBSTR (STUDENT_SSN , 8, 1)= '2';

-- 4.
-- 대출 도서 장기 연체자들을 찾아 이름을 게시
-- 대상자의 학번이 다음과 같을 때 ,대상자를 찾는 적절한 SQL구문 작성
-- A513079, A513090, A513091, A513110, A513119
--> 특징 : 7자리
--			  앞 A513___까지는 같음

SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '%079'
	 OR STUDENT_NO LIKE '%090'
	 OR STUDENT_NO LIKE '%091' 
 	 OR STUDENT_NO LIKE '%110' 
 	 OR STUDENT_NO LIKE '%119';

-- 5. 입학 정원이 20명 이상, 30명 이하인 학과들의 학과 이름과 계열 조회
 	
SELECT DEPARTMENT_NAME , CATEGORY 
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20
	AND CAPACITY <= 30;
	
-- 6. 총장 제외 모든 교수들이 소속 학과를 가지고 있음
-- 		총장의 이름을 알아내라

SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7. 수강신청시 선수과목 여부 확인을 위해 선수과목이 존재하는 과목 번호 조회

SELECT CLASS_NO 
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 8. 계열 조회
SELECT DISTINCT (CATEGORY )
FROM TB_DEPARTMENT td ;

-- 9. 02학번 전주 거주자들의 모임 만드려고 함.
-- 현재 휴학한 사람들은 제외한 재학중인 학생들의 
-- 학번, 이름, 주민번호 조회 구문 작성
SELECT STUDENT_NO , STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN != 'Y'
AND   STUDENT_ADDRESS LIKE '%전주%'
AND 	TO_CHAR(ENTRANCE_DATE, 'YYYY' ) = '2002';