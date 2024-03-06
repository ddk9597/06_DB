-- 서브쿼리 실습문제

-- 1. 전지연 사원이 속해 있는 부서원들을 조회하시오
-- 단, 전지연은 제외
-- 사번 사원명 전화번호 고용일 부서명
SELECT EMP_ID 사번, EMP_NAME 이름, PHONE 전화번호, 
			 HIRE_DATE 고용일 , DEPT_TITLE 부서명
FROM EMPLOYEE e 
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE DEPT_CODE = (
	SELECT DEPT_CODE 
	FROM EMPLOYEE
	WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연';

-- 2. 고용일이 2000 년도 이후인 사원들 중 급여가 가장 높은 사원의
-- 사번, 사원명, 전화번호, 급여, 직급명 조회

-- 1). 고용일 이 2000년도 이후인 사원 조회
-- 2). 이 중 급여가 가장 높은 사람 조회
SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME 
FROM EMPLOYEE 
JOIN JOB USING (JOB_CODE)
WHERE SALARY = (
	SELECT MAX(SALARY)
	FROM EMPLOYEE
	WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000
	);

-- 3. 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회하기
-- 		노옹철 제외
--    사번, 이름, 부서코드, 직급코드, 부서명, 직급명

-- 1) 노옹철의 부서 코드 조회
-- 2) 같은 부서 사람 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE,
			 DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING (JOB_CODE)
WHERE (JOB_CODE, DEPT_CODE) = (
	SELECT JOB_CODE, DEPT_CODE
	FROM EMPLOYEE
	WHERE EMP_NAME='노옹철'
		)
AND EMP_NAME!='노옹철';


-- 4. 2000 년도에 입사한 사원과 부서, 직급이 같은 사원을 조회
-- 사번, 이름, 부서코드, 직급코드, 고용일

-- 1) 기준 : 2000년도에 입사한 사람 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE 
FROM EMPLOYEE e 
JOIN JOB USING(JOB_CODE)
WHERE (DEPT_CODE, JOB_CODE) IN (
	SELECT DEPT_CODE, JOB_CODE 
	FROM EMPLOYEE e2 
	JOIN JOB USING(JOB_CODE)
	WHERE EXTRACT (YEAR FROM HIRE_DATE) = 2000
	);

-- 관계연산자, IN을 사용하는 경우의 차이 알아보기


-- 5. 77년생 여자 사원과 동일한 부서이면서 동일한 사수를 가지고 있는 사원을 조회
-- 사번, 이름, 부서코드, 사수번호, 주민번호, 고용일

-- 1) 77년생 여자 사원 부서 조회
-- 2) 77년생 여자 사원 사수 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (
	SELECT DEPT_CODE, MANAGER_ID
	FROM EMPLOYEE 
	WHERE SUBSTR(EMP_NO, 1, 2) = '77'
	AND   SUBSTR(EMP_NO, 8, 1) = '2');


-- 6. 부서별 입사일이 가장 빠른 사원의 
-- 사번, 이름, 부서명(NULL이면 '소속 없음'), 직급명, 입사일을 조회하고
-- 입사일이 빠른 순번으로 조회
-- 퇴사한 직원은 제외하고 조회

-- 1) 입사일 순으로 테이블 조정
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE, '무소속'),
			 JOB_NAME, HIRE_DATE 
FROM EMPLOYEE e 
JOIN JOB USING(JOB_CODE)
WHERE HIRE_DATE IN (
	SELECT MIN(HIRE_DATE)
	FROM EMPLOYEE
	WHERE ENT_YN != 'Y'
	GROUP BY DEPT_CODE)
ORDER BY HIRE_DATE ;

-- 7. 직급별 나이가 가장 어린 직원의
-- 사번, 이름, 직급명, 나이, 보너스 포함 연봉을 조회
-- 나이 순으로 내림차순 
-- 연봉은 L124,800,000로 출력

-- 1) 그룹별로 가장 어린 사원 뽑기(SUB)(주민번호 앞 2자리 가장 높은 사람)
-- 2) 줄 세우기(MAIN)

SELECT EMP_NAME
FROM EMPLOYEE e 
WHERE EMP_NAME = (
	SELECT EMP_NAME 
	FROM EMPLOYEE
	WHERE MIN(EXTRACT (YEAR FROM EMP_NO))
)
GROUP BY DEPT_CODE 
ORDER BY ;

-- EMP_NO의 1~2 자리 숫자가 가장 큰 사람이 나이가 제일 어린 사람
SELECT EMP_NAME, SALARY*12 연봉, JOB_NAME,
	EXTRACT(YEAR FROM SYSDATE)-(1900 + MAX(SUBSTR(EMP_NO,1,2)))나이
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
GROUP BY EMP_NAME, SALARY, JOB_NAME;

SELECT EXTRACT (YEAR FROM SYSDATE)
FROM DUAL;