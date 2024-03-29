/*
    * SUBQUERY (서브쿼리)
    - 하나의 SQL문 안에 포함된 또다른 SQL문
    - 메인쿼리(기존쿼리)를 위해 보조 역할을 하는 쿼리문
    -- SELECT, FROM, WHERE, HAVING 절에서 사용가능
    -- 어디서나 사용 가능

*/  

-- 서브쿼리 예시 1.
-- 부서코드가 노옹철사원과 같은 소속의 직원의 
-- 이름, 부서코드 조회하기

-- 1) 사원명이 노옹철인 사람의 부서코드 조회
SELECT DEPT_CODE "부서코드", EMP_NAME 이름 
FROM EMPLOYEE e 
WHERE EMP_NAME = '노옹철';

-- 2) 부서코드가 D9인 직원을 조회
SELECT DEPT_CODE "부서코드", EMP_NAME 이름 
FROM EMPLOYEE e 
WHERE DEPT_CODE ='D9';

-- 3) 부서코드가 노옹철사원과 같은 소속의 직원 명단 조회   
--> 위의 2개의 단계를 하나의 쿼리로!!! --> 1) 쿼리문을 서브쿼리로!!
SELECT DEPT_CODE "부서코드", EMP_NAME 이름 
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE "부서코드"
										FROM EMPLOYEE
										WHERE EMP_NAME = '노옹철');

-- () 안의 서브쿼리가 먼저 해석됨
                   
                   
                   
-- 서브쿼리 예시 2.
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 
-- 사번, 이름, 직급코드, 급여 조회

-- 1) 전 직원의 평균 급여 조회하기
SELECT AVG(SALARY)
FROM EMPLOYEE e ;


-- 2) 직원들중 급여가 3047663원 이상인 사원들의 사번, 이름, 직급코드, 급여 조회

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY >= 3047663;


-- 3) 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원 조회
--> 위의 2단계를 하나의 쿼리로 가능하다!! --> 1) 쿼리문을 서브쿼리로!!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)FROM EMPLOYEE);
	
                 


-------------------------------------------------------------------

/*  서브쿼리 유형

    - 단일행 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 1개일 때 
    	--> 1행 1열
    
    - 다중행 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 여러개일 때
    	--> N행 1열
    	
    - 다중열 서브쿼리 : 서브쿼리의 SELECT 절에 자열된 항목수가 여러개 일 때
    	--> 1행N열
    	
    - 다중행 다중열 서브쿼리 : 조회 결과 행 수와 열 수가 여러개일 때 
    	--> N행N열
    	
    - 상관 서브쿼리 : 서브쿼리가 만든 결과 값을 메인 쿼리가 비교 연산할 때 
                  메인 쿼리 테이블의 값이 변경되면 서브쿼리의 결과값도 바뀌는 서브쿼리
                     
    - 스칼라 서브쿼리 : 상관 쿼리이면서 결과 값이 하나인 서브쿼리
    
   * 서브쿼리 유형에 따라 서브쿼리 앞에 붙은 연산자가 다름
    
*/


-- 1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
--    서브쿼리의 조회 결과 값의 개수가 1개인 서브쿼리
--    단일행 서브쿼리 앞에는 비교 연산자 사용
--    <, >, <=, >=, =, !=/^=/<>


-- 전 직원의 급여 평균보다 많은 급여를 받는 직원의 
-- 이름, 직급, 부서, 급여를 직급 순으로 정렬하여 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY 
FROM EMPLOYEE
	JOIN JOB USING (JOB_CODE)
	LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY > 
	( SELECT AVG(SALARY)
		FROM EMPLOYEE e 
	) 
ORDER BY JOB_CODE ASC;


-- 가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급명, 부서코드, 급여, 입사일을 조회
SELECT EMP_ID , EMP_NAME , JOB_NAME, DEPT_CODE , SALARY , HIRE_DATE 
FROM EMPLOYEE
NATURAL JOIN JOB -- 자연 조인(컬럼명, 타입 일치하는 컬럼끼리 연결) 
WHERE SALARY 
=( SELECT MIN(SALARY)
	 FROM EMPLOYEE e 
 );
                 
-- 노옹철 사원의 급여보다 많이 받는 직원의 
-- 사번, 이름, 부서, 직급, 급여를 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
FROM EMPLOYEE
NATURAL JOIN JOB 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY >
 	(SELECT SALARY
	 FROM EMPLOYEE
	 WHERE EMP_NAME = '노옹철');
        
 
-- 부서별(부서가 없는 사람 포함) 급여의 합계 중 가장 큰 부서의
-- 부서명, 급여 합계를 조회 

-- 1) 부서별 급여 합 중 가장 큰값 조회
SELECT MAX( SUM(SALARY) )
FROM EMPLOYEE e 
GROUP BY DEPT_CODE ;


-- 2) 부서별 급여합이 17700000인 부서의 부서명과 급여 합 조회
SELECT DEPT_TITLE
FROM EMPLOYEE e 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = 17700000 

-- 3) >> 위의 두 서브쿼리 합쳐 부서별 급여 합이 큰 부서의 부서명, 급여 합 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE e 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = 
	(SELECT MAX( SUM(SALARY) )
	 FROM EMPLOYEE e 
	 GROUP BY DEPT_CODE );
                      
-- 부서별 인원 수가 3명 이상인 부서의
-- 부서명, 인원 수 조회
-- 1) 부서별 인원수가 3명 이상인 부서 조회
SELECT NVL(DEPT_TITLE, '없음')"부서 명", COUNT(*)"인원 수"
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING COUNT(*) >= 3;

-- 부서별 인원수가 가장 적은 부서의 부서명, 인원 수 조회
SELECT NVL(DEPT_TITLE, '없음')"부서 명", COUNT(*)"인원 수"
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING COUNT(*) = 
	(SELECT MIN(COUNT (*))
	 FROM EMPLOYEE e 
	 GROUP BY DEPT_CODE);

                      

-------------------------------------------------------------------------

-- 2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
--    서브쿼리의 조회 결과 값의 개수가 여러행일 때 

/*
    >> 다중행 서브쿼리 앞에는 일반 비교연산자 사용 x
    
    - IN / NOT IN : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면
                    혹은 없다면 이라는 의미(가장 많이 사용!)
                    IN(서브쿼리 작성) 
    - > ANY, < ANY : 여러개의 결과값 중에서 한개라도 큰 / 작은 경우
                     가장 작은 값보다 큰가? / 가장 큰 값 보다 작은가?
    - > ALL, < ALL : 여러개의 결과값의 모든 값보다 큰 / 작은 경우
                     가장 큰 값 보다 큰가? / 가장 작은 값 보다 작은가?
    - EXISTS / NOT EXISTS : 값이 존재하는가? / 존재하지 않는가?
    
*/

-- 부서별 최고 급여를 받는 직원의 
-- 이름, 직급, 부서, 급여를 부서 순으로 정렬하여 조회
-- 1) 부서 별 최고 급여
SELECT MAX(SALARY)
FROM EMPLOYEE e 
GROUP BY DEPT_CODE ;
-- 2) 부서 별 최고 급여 받는 직원 조회
SELECT EMP_NAME, DEPT_CODE  
FROM EMPLOYEE e 
WHERE SALARY IN 
 (SELECT MAX(SALARY)
 	FROM EMPLOYEE
 	GROUP BY DEPT_CODE); -- IN 내부 서브쿼리 결과 7행(다중행 서브쿼리)
 	
-- 사수에 해당하는 직원에 대해 조회 
--  사번, 이름, 부서명, 직급명, 구분(사수 / 직원)

-- 1) 사수에 해당하는 사원 번호 조회
SELECT DISTINCT (MANAGER_ID)
FROM EMPLOYEE 
WHERE MANAGER_ID IS NOT NULL;

-- 2) 직원의 사번, 이름, 부서명, 직급 명	 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE e 
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE);

-- 3) 사수에 해당하는 직원에 대한 정보 추출 조회 (이때, 구분은 '사수'로)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사수' "구분"
FROM EMPLOYEE e 
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN 
	(SELECT DISTINCT (MANAGER_ID)
	 FROM EMPLOYEE 
	 WHERE MANAGER_ID IS NOT NULL);


-- 4) 일반 직원에 해당하는 사원들 정보 조회 (이때, 구분은 '사원'으로)
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사원' "구분"
FROM EMPLOYEE e 
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN 
	(SELECT DISTINCT (MANAGER_ID)
	 FROM EMPLOYEE 
	 WHERE MANAGER_ID IS NOT NULL);

            
-- 5) 3, 4의 조회 결과를 하나로 합침 -> SELECT절 SUBQUERY
-- * SELECT 절에도 서브쿼리 사용할 수 있음
-- * 집합연산자(UNION, UNION ALL) 이용
-- 방법1. 집합연산자 사용
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사수' "구분"
FROM EMPLOYEE e 
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN 
	(SELECT DISTINCT (MANAGER_ID)
	 FROM EMPLOYEE 
	 WHERE MANAGER_ID IS NOT NULL)

	UNION

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '사원' "구분"
FROM EMPLOYEE e 
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN 
	(SELECT DISTINCT (MANAGER_ID)
	 FROM EMPLOYEE 
	 WHERE MANAGER_ID IS NOT NULL);

-- 방법2. 선택함수(CASE)
SELECT 
	EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, 
	CASE 
		WHEN EMP_ID IN (
			SELECT DISTINCT MANAGER_ID
			FROM EMPLOYEE
			WHERE MANAGER_ID IS NOT NULL
		)
		THEN '사수'
		ELSE '사원'
	END "구분"
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
ORDER BY EMP_ID;


-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ANY 혹은 < ANY 연산자를 사용하세요

-- > ANY, < ANY : 여러개의 결과값 중에서 하나라도 큰 / 작은 경우
--                     가장 작은 값보다 큰가? / 가장 큰 값 보다 작은가?

-- 1) 직급이 대리인 직원들의 사번, 이름, 직급명, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY 
FROM EMPLOYEE e 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';


-- 2) 직급이 과장인 직원들 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY 
FROM EMPLOYEE e 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';


-- 3) 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원
-- 3-1) MIN을 이용하여 단일행 서브쿼리를 만듦.
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY 
FROM EMPLOYEE e 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND   SALARY > 
		( SELECT MIN(SALARY) 
			FROM EMPLOYEE e 
			JOIN JOB USING(JOB_CODE)
			WHERE JOB_NAME = '과장');


-- 3-2) ANY를 이용하여 과장 중 가장 급여가 적은 직원 초과하는 대리를 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY 
FROM EMPLOYEE e 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
AND   SALARY > ANY
		( SELECT SALARY 
			FROM EMPLOYEE e 
			JOIN JOB USING(JOB_CODE)
			WHERE JOB_NAME = '과장');



-- 차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의 직원
		--> 모든 차장보다 많이 받는 과장
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, > ALL 혹은 < ALL 연산자를 사용하세요

-- > ALL, < ALL : 여러개의 결과값의 모든 값보다 큰 / 작은 경우
--                     가장 큰 값 보다 크냐? / 가장 작은 값 보다 작냐?

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE e 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='과장'
AND SALARY > ALL (
	SELECT SALARY
	FROM EMPLOYEE
	JOIN JOB USING(JOB_CODE)
	WHERE JOB_NAME = '차장');
                      
                      
-- 서브쿼리 중첩 사용(응용편!)


-- LOCATION 테이블에서 NATIONAL_CODE가 KO인 경우의 LOCAL_CODE와
-- DEPARTMENT 테이블의 LOCATION_ID와 동일한 DEPT_ID가 
-- EMPLOYEE테이블의 DEPT_CODE와 동일한 사원을 구하시오.

-- 1) LOCATION 테이블을 통해 NATIONAL_CODE가 KO인 LOCAL_CODE 조회
SELECT LOCAL_CODE
FROM LOCATION 
WHERE NATIONAL_CODE = 'KO';


-- 2)DEPARTMENT 테이블에서 위의 결과와 동일한 LOCATION_ID를 가지고 있는 DEPT_ID를 조회
SELECT DEPT_ID
FROM DEPARTMENT
WHERE LOCATION_ID = (
	SELECT LOCAL_CODE
	FROM LOCATION 
	WHERE NATIONAL_CODE = 'KO'); -- 5행. 다중행 서브쿼리

-- 3) 최종적으로 EMPLOYEE 테이블에서 위의 결과들과 동일한 DEPT_CODE를 가지는 사원을 조회

SELECT EMP_NAME, DEPT_CODE 
FROM EMPLOYEE 
WHERE DEPT_CODE IN (
	SELECT DEPT_ID
	FROM DEPARTMENT
	WHERE LOCATION_ID = (
		SELECT LOCAL_CODE
		FROM LOCATION 
		WHERE NATIONAL_CODE = 'KO')
);


-----------------------------------------------------------------------

-- 3. 다중열 서브쿼리 (단일행 = 결과값은 한 행) (1행 N열)
--    서브쿼리 SELECT 절에 나열된 컬럼 수가 여러개 일 때

-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는
-- 사원의 이름, 직급, 부서, 입사일을 조회        

-- 1) 퇴사한 여직원 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN ='Y'
AND SUBSTR(EMP_NO,8,1)='2';


-- 2) 퇴사한 여직원과 같은 부서, 같은 직급 (다중 열 서브쿼리)
-- 단일행 서브쿼리 이용 시
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE e 
WHERE DEPT_CODE = (
	SELECT DEPT_CODE
	FROM EMPLOYEE
	WHERE ENT_YN ='Y'
	AND SUBSTR(EMP_NO,8,1)='2')

AND JOB_CODE = (
	SELECT JOB_CODE
	FROM EMPLOYEE
	WHERE ENT_YN ='Y'
	AND SUBSTR(EMP_NO,8,1)='2');

-- 다중열 서브쿼리
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE e 
WHERE (DEPT_CODE, JOB_CODE) = (
	SELECT DEPT_CODE, JOB_CODE
	FROM EMPLOYEE
	WHERE ENT_YN = 'Y'
	AND SUBSTR(EMP_NO, 8, 1)='2'
);

-- 값 하나씩 비교가 아니라 묶음 전체의 값이 같은지 비교하는 것!!



-------------------------- 연습문제 -------------------------------
-- 1. 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회하시오. (단, 노옹철 사원은 제외)
--    사번, 이름, 부서코드, 직급코드, 부서명, 직급명

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE (DEPT_TITLE, JOB_NAME) = (
	SELECT DEPT_TITLE, JOB_NAME
	FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
	JOIN JOB USING(JOB_CODE)
	WHERE EMP_NAME = '노옹철')
AND EMP_NAME != '노옹철';



-- 2. 2000년도에 입사한 사원의 부서와 직급이 같은 사원을 조회하시오
--    사번, 이름, 부서코드, 직급코드, 고용일

SELECT EMP_ID , EMP_NAME , DEPT_CODE , JOB_CODE , HIRE_DATE 
FROM EMPLOYEE  
WHERE (DEPT_CODE, JOB_CODE) = (
	SELECT DEPT_CODE, JOB_CODE
	FROM EMPLOYEE
	WHERE EXTRACT (YEAR FROM HIRE_DATE) = 2000);




-- 3. 77년생 여자 사원과 동일한 부서이면서 동일한 사수를 가지고 있는 사원을 조회하시오
--    사번, 이름, 부서코드, 사수번호, 주민번호, 고용일     
                  
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (
	SELECT DEPT_CODE, MANAGER_ID
	FROM EMPLOYEE
	WHERE SUBSTR(EMP_NO,1,2) = '77'
	AND 	SUBSTR(EMP_NO,8,1) = '2');


----------------------------------------------------------------------

-- 4. 다중행 다중열 서브쿼리
--    서브쿼리 조회 결과 행 수와 열 수가 여러개 일 때

-- 본인 직급의 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요 TRUNC(컬럼명, -4)    

-- 1) 급여를 200, 600만 받는 직원 (200만, 600만이 평균급여라 생각 할 경우)
SELECT EMP_ID, EMP_NAME , DEPT_CODE , JOB_CODE 
FROM EMPLOYEE 
WHERE SALARY IN (2000000, 6000000);

-- 2) 직급별 평균 급여
SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
FROM EMPLOYEE e 
GROUP BY JOB_CODE ;

-- 3) 본인 직급의 평균 급여를 받고 있는 직원
SELECT EMP_ID, EMP_NAME , DEPT_CODE , JOB_CODE 
FROM EMPLOYEE e
WHERE ( JOB_CODE, SALARY)IN(
	SELECT JOB_CODE, TRUNC(AVG(SALARY), -4)
	FROM EMPLOYEE
	GROUP BY JOB_CODE );

SELECT EMP_NAME, TRUNC((SALARY), 2)
FROM EMPLOYEE e ;
 
                

-------------------------------------------------------------------------------
-- ****************************상관 서브쿼리, 상호연관 서브쿼리***************************** --

-- 5. 상(호연)관 서브쿼리
--    상관 쿼리는 메인쿼리가 사용하는 테이블값을 서브쿼리가 이용해서 결과를 만듦
--    메인쿼리의 테이블값이 변경되면 서브쿼리의 결과값도 바뀌게 되는 구조임

-- *************&&&&&&*****중요함*********&&&&&&&&*********
-- 상관쿼리는 먼저 메인쿼리 한 행을 조회하고
-- 해당 행이 서브쿼리의 조건을 충족하는지 확인하여 SELECT를 진행함

-- 연습문제
-- 직급별 급여 평균보다 급여를 많이 받는 직원의 
-- 이름, 직급코드, 급여 조회
SELECT JOB_CODE, AVG(SALARY) 
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT JOB_CODE, EMP_NAME, SALARY 
FROM EMPLOYEE;

-- 1) 메인 쿼리 한 행의 값을 서브쿼리로 전달
-- 2) 서브쿼리에서 전달받은 메인쿼리의 값을 이용, SELECT 수행
-- 		SELECT 결과를 다시 메인쿼리로 반환
-- 3) 메인쿼리에서 반환받은 값을 이용해 해당 행의 결고 포함 여부를 결정
--    RESULT SET에 적용

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE MAIN
WHERE SALARY > (
	SELECT AVG(SALARY)
	FROM EMPLOYEE SUB
	WHERE SUB.JOB_CODE = MAIN.JOB_CODE /* 메인쿼리에게 받은 행의 값 */
	
	-- MAIN에게 전달 받은 JOB_CODE 직급의 평균 급여를 조회
);

-- 부서별 입사일이 가장 빠른 사원의
--    사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고
--    입사일이 빠른 순으로 조회하세요
--    단, 퇴사한 직원은 제외하고 조회하세요

-- 1) 입사일이 가장 빠른 사원의 입사일 찾기
-- 특정 부서에서 입사일이 가장 빠른 사람 찾기
SELECT MIN(HIRE_DATE) 
FROM EMPLOYEE e 
WHERE DEPT_CODE = 'D1';

SELECT EMP_ID , EMP_NAME , DEPT_CODE , NVL(DEPT_TITLE, '소속 없음'),
			 JOB_NAME, HIRE_DATE
FROM EMPLOYEE MAIN
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE HIRE_DATE = (
	/* 메인 쿼리에서 전달 받은 행의 컬럼 값 중
	 * DEPT_CODE 값을 이용해
	 * 해당 부서에서 가장 빠른 입사일을 조회
	 * */
	SELECT MIN(HIRE_DATE)
	FROM EMPLOYEE SUB
	WHERE NVL(SUB.DEPT_CODE, '소속 없음') = NVL(MAIN.DEPT_CODE, '소속 없음')
		--> NULL은 비교가 불가능하기 때문에
		-- NVL을 이용해서 NULL이 아닌 비교 가능한 값으로 변경
	AND ENT_YN != 'Y' 
		--> 메인쿼리에 작성할 경우 결과값에서 ENT_YN 값이 Y인 사람 제외하기만 함.
		--  그 사람 다음 순번으로 입사한 사람 포함시키지 않기때문에
		--  서브쿼리에서 미리 적용시켜야 한다.
	)
ORDER BY HIRE_DATE;

-- 사수가 있는 직원의 사번, 이름, 부서명, 사수사번 조회

SELECT EMP_ID, EMP_NAME , DEPT_TITLE, MANAGER_ID 
FROM EMPLOYEE MAIN
LEFT JOIN DEPARTMENT ON ( DEPT_CODE = DEPT_ID)
WHERE EXISTS (
	SELECT EMP_ID
	FROM EMPLOYEE SUB
	WHERE SUB.EMP_ID = MAIN.MANAGER_ID );


-- WHERE EXISTS(서브쿼리)
	--> 서브쿼리 결과(RESULT SET)에 행이 존재한다면 TRUE, 
	--	없으면 FALSE	

----------------------------------------------------------------------------------

-- 6. 스칼라 서브쿼리 (SELECT 절에 작성하는 단일행 서브쿼리)
--    SELECT절에 사용되는 서브쿼리 결과로 1행만 반환
--    SQL에서 단일 값을 가르켜 '스칼라'라고 함

-- 각 직원들이 속한 직급의 급여 평균 조회
SELECT EMP_NAME, JOB_CODE, JOB_CODE||'의 평균 급여',
		(SELECT FLOOR(AVG(SALARY))
		 FROM EMPLOYEE SUB
		 WHERE SUB.JOB_CODE = MAIN.JOB_CODE) "평균 급여"
FROM EMPLOYEE MAIN ;

-- 모든 사원의 사번, 이름, 관리자사번, 관리자명을 조회
-- 단 관리자가 없는 경우 '없음'으로 표시
-- (스칼라 + 상관 쿼리)

SELECT EMP_ID , EMP_NAME , NVL(MANAGER_ID, '없음'),
 NVL( (SELECT EMP_NAME 
			 FROM EMPLOYEE SUB
			 WHERE SUB.EMP_ID = MAIN.MANAGER_ID
			 ), '없음')"관리자명"
FROM EMPLOYEE MAIN; 


-----------------------------------------------------------------------


-- 7. 인라인 뷰(INLINE-VIEW)
--    FROM 절에서 서브쿼리를 사용하는 경우로
--    서브쿼리가 만든 결과의 집합(RESULT SET)을 테이블 대신에 사용한다.
--	  --> 테이블을 입맛대로 조절 가능

-- (VIEW : 조회만 가능한 가상 테이블)

-- 인라인뷰를 활용한 TOP-N분석
-- 전 직원 중 급여가 높은 상위 5명의
-- 순위, 이름, 급여 조회

-- 1) 전 직원 급여 내림차순으로 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE e 
ORDER BY SALARY DESC ;

-- 2) ROWNUM : 행 번호를 나타내는 가상 컬럼
	--> SELECT절 해석되는 당시의 행 번호를 기입한다!!!

SELECT ROWNUM, EMP_NAME
FROM EMPLOYEE 
WHERE ROWNUM <= 5;

-- 3) ROWNUM 이용하여 급여 상위 5명 조회하기
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE e 
ORDER BY SALARY DESC ;
--> SELECT 절이 ORDER BY절 보다 먼저 해석되어
--	ROWNUM 순서가 급여내림차순이 아닌 조회된 행 순서로 지정됨
-- INLINE-VIEW를 이용해 문제 해결 가능함

SELECT ROWNUM, EMP_NAME,SALARY 
FROM ( 
	/* 급여 내림차순으로 정렬 된 EMPLOYEE 테이블 조회 */
	SELECT EMP_NAME, SALARY
	FROM EMPLOYEE e 
	ORDER BY SALARY DESC --> 조회 결과가 메인 쿼리의 테이블 역할을 한
			)
WHERE ROWNUM<= 5;

-- * ROWNUM 사용 시 주의사항 *
-- ROWNUM을 WHERE절에 사용할 때
-- 항상 범위에 1부터 연속적인 범위가 포함되어야 한다
-- 1부터 시작하고 연속될 것
SELECT ROWNUM, EMP_NAME, SALARY 
FROM  (SELECT EMP_NAME, SALARY
	   FROM EMPLOYEE
	   ORDER BY SALARY DESC)
--WHERE ROWNUM = 1; -- 1행만 조회
--WHERE ROWNUM = 2; -- 2행만 조회 --> 실패
--WHERE ROWNUM BETWEEN 2 AND 10; --> 실패
WHERE ROWNUM BETWEEN 1 AND 10; --> 1부터 포함해야된다!

-- 급여 평균이 3위 안에 드는 부서의 부서코드와 부서명, 평균급여를 조회
															/* INLINE-VIEW에 표시된 컬럼명 사용 */
SELECT ROWNUM, DEPT_CODE, DEPT_TITLE, "평균 급여"
FROM(
	/* 인라인 뷰 */
	SELECT DEPT_CODE, DEPT_TITLE, FLOOR(AVG(SALARY))"평균 급여"
	FROM EMPLOYEE
	LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
	GROUP BY DEPT_CODE, DEPT_TITLE 
	ORDER BY "평균 급여" DESC
)
WHERE ROWNUM <= 3;


------------------------------------------------------------------------

-- 8. WITH
--    서브쿼리에 이름을 붙여주고 사용시 이름을 사용하게 함
--    인라인뷰로 사용될 서브쿼리에 주로 사용됨
--    실행 속도도 빨라진다는 장점이 있다. 

-- 
-- 전 직원의 급여 순위 
-- 순위, 이름, 급여 조회
-- 1~ 10위만 조회

SELECT ROWNUM 급여순위, 이름, 급여 
FROM (
	SELECT EMP_NAME 이름, SALARY 급여
	FROM EMPLOYEE
	ORDER BY SALARY DESC)
WHERE ROWNUM<= 10;

-- WITH 사용 하기

WITH TOP_SALARY -- 서브쿼리 이름 지정
AS(	SELECT EMP_NAME 이름, SALARY 급여
		FROM EMPLOYEE
		ORDER BY SALARY DESC 
	)

SELECT ROWNUM 순위, 이름, 급여 
FROM TOP_SALARY
WHERE ROWNUM <= 10;
-- 하나의 SQL 안에서만 사용 가능 
--> (;기준으로 SQL 종료되면 다음 SQL에는 사용 불가)


--------------------------------------------------------------------------


-- 9. RANK() OVER / DENSE_RANK() OVER

-- 급여를 많이 받는 순으로 조회

SELECT EMP_NAME, SALARY 
FROM EMPLOYEE e 
ORDER BY SALARY DESC ;

-- RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원 수 만큼 건너뛰고 순위 계산
--               EX) 공동 1위가 2명이면 다음 순위는 2위가 아니라 3위
SELECT EMP_NAME, SALARY,
	RANK() OVER(ORDER BY SALARY DESC) "급여 순위"
FROM EMPLOYEE e ;


-- DENSE_RANK() OVER : 동일한 순위 이후의 등수를 이후의 순위로 계산
--                     EX) 공동 1위가 2명이어도 다음 순위는 2위

SELECT EMP_NAME, SALARY,
	DENSE_RANK() OVER(ORDER BY SALARY DESC) "급여 순위"
FROM EMPLOYEE e ;



/* -----------------------------------------------------------------------

-- SELECT 관련 KEY POINT !! --

/* 1. 테이블 구조 파악
 * 
 * 2. SELECT 해석 순서
 *   + 별칭 사용이 가능한 부분
 *    EX) ORDER BY 절에서는 SELECT절에서 해석된 별칭 사용 가능
 * 	  EX) 인라인뷰에서 지정된 별칭을 메인쿼리에서도 똑같이 사용해야된다
 * 		EX) 해석 순서에 따라. FROM 내의 INLINE-VIEW에 작성된 별칭은
 * 				메인쿼리 내 어디서든 사용 가능함
 * 
 * 순서
 * 5 	SELCET
 * 1 	FROM + JOIN 테이블 선택
 * 2 	WHERE 			 행 선택
 * 3 	GROUP BY		 그룹화
 * 4 	HAVING			 그룹 조건
 * 6 	ORDER BY		 정렬 조건
 * 
 * 
 * 3. 여러 테이블을 이용한 SELECT 진행 시
 *    컬럼명이 겹치는 경우 이를 해결하는 방법
 * 	
 *    EX) 셀프 조인 -> 테이블별로 별칭 지정
 *    EX) 상관 쿼리 -> 테이블별로 별칭 지정
 *    EX) 다른 테이블이여도 컬럼명이 같을 때
 * 				-> 테이블별로 별칭 지정
 * 				-> 테이블명.컬럼명 형식으로 작성
 * 
 *  4. 조회하려는 데이터 (목적, 요구사항)을 확실하게 파악
 * 		 --> 글을 잘 읽어라...
 * */



