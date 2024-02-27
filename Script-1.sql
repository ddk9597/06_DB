/* SELECT (조회)
 * 
 * - 지정된 테이블에서 원하는 데이터를 선택해서 조회하는 SQL
 * 
 * - 작성된 구문에 맞는 행, 열 데이터가 조회됨
 *  -> 조회된 결과 행의 집합 == RESULT SET (결과 집합)
 * 
 * - RESULT SET은 0행 이상이 포함될 수 있다
 *  -> 조건에 맞는 행이 없을 수도 있기 때문에...
 * */


/* [SELECT 작성법 - 1(기초)]
 * 
 * SELECT 컬럼명, 컬럼명, ...
 * FROM 테이블명;
 * 
 * -> 지정된 테이블 모든 행에서 
 *   컬럼명이 일치하는 컬럼 값 조회
 * */


-- EMPLOYEE 테이블에서
-- 모든 행의 사번(EMP_ID), 이름(EMP_NAME), 급여(SALARY) 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;



-- EMPLOYEE 테이블에서
-- 모든 행의 이름(EMP_NAME), 입사일(HIRE_DATE) 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;


-- EMPLOYEE 테이블의 모든 행, 모든 컬럼 조회

-- asterisk (*) : 모든, 포함하다를 나타내는 기호
SELECT * FROM EMPLOYEE;



-- DEPARTMENT 테이블의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- DEPARTMENT 테이블의 모든 데이터 조회
SELECT * FROM DEPARTMENT;


--------------------------------------------------------------

/* 컬럼 값 산술 연산 */

-- 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값

-- SELECT문 작성 시
-- 컬럼명에 산술 연산을 직접 작성하면
-- 조회 결과(RESULT SET)에 연산 결과가 반영되어 조회된다!

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여, 급여 + 100만 조회
SELECT EMP_NAME, SALARY, SALARY + 1000000
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 모든 사원의 사번, 이름, 연봉(급여 * 12) 조회
SELECT EMP_ID, EMP_NAME, SALARY * 12
FROM EMPLOYEE;

------------------------------------------------------------

/* SYSDATE, SYSTIMESTAMP */
-- (시스템이 나타내고 있는) 현재 시간

-- SYSDATE      : 현재 시간( 년,월,일,시,분,초 )조회
-- SYSTIMESTAMP : 현재 시간( 년,월,일,시,분,초,ms + 지역(local) ) 조회


/* DUAL(DUmmy tAbLe) 테이블 */
-- 가짜 테이블(임시 테이블)
-- 실존하는 테이블이 아님
-- 테이블 데이터가 아닌 단순 데이터 조회 시 사용
SELECT SYSDATE, SYSTIMESTAMP 
FROM DUAL;


/* 날짜 데이터 연산하기 (+, - 만 가능!) */
-->  +1  == 1일 추가
-->  -1  == 1일 감소
--> 일 단위로 계산

-- 어제, 현재 시간, 내일, 모레 조회
SELECT SYSDATE - 1, SYSDATE, SYSDATE + 1 , SYSDATE + 2
FROM DUAL;


/* 알아 두면 도움 많이됨!! */
-- 현재 시간, 한 시간 후, 1분 후, 10초 후 조회
SELECT SYSDATE,
		SYSDATE + 1/24,
		SYSDATE + 1/24/60,
		SYSDATE + 1/24/60/60 * 10
FROM DUAL;


/* 날짜끼리 연산하기 */

-- 1. 날짜 - 날짜 == 일단위 숫자로
-- -> 1 == 1일차이
-- -> 1.5 === 1일 12시간 차이

-- TO_DATE('문자열', '패턴') :
-- '문자열'을 '패턴' 형태로 해석해서 DATE 타입으로 변경하는 함수

-- '' : 문자열 리터럴 표기법. "" 아님!!!
SELECT '2024-02-26', TO_DATE('2024-02-26', 'YYYY-MM-DD')
FROM DUAL;

-- 오늘 - 어제 == 1;
SELECT TO_DATE('2024-02-26', 'YYYY-MM-DD') - TO_DATE('2024-02-25', 'YYYY-MM-DD')
FROM DUAL;

-- 현재시간 - 어제 == 정수1(하루)	+ 남은 차이 소수로 표현 : 일단위 연산
SELECT SYSDATE - TO_DATE('2024-02-25', 'YYYY-MM-DD')
FROM DUAL;

-- EMPLOYEE 테이블에서 모든 사원의 이름, 입사일, 근무일수(현재시간 - 입사일)

SELECT EMP_NAME, HIRE_DATE , SYSDATE - HIRE_DATE 
FROM EMPLOYEE ;

-- CEIL(숫자) : 올림처리
-- 내가 몇일째 살고 있는지?
SELECT SYSDATE - TO_DATE('1995-10-26', 'YYYY-MM-DD') AS 생후n일,
((SYSDATE - TO_DATE('1995-10-26', 'YYYY-MM-DD'))/365 ) AS 만나이,
CEIL((SYSDATE - TO_DATE('1995-10-26', 'YYYY-MM-DD'))/365 ) AS 올림나이,

FROM DUAL;

------------------------------------------------------------

/* 컬럼명 별칭 지정하기 */

-- 별칭 지정 방법
-- 1) 컬럼명 AS 별칭   :  문자O, 띄어쓰기 X, 특수문자 X
-- 2) 컬럼명 AS "별칭" :  문자O, 띄어쓰기 O, 특수문자 O
-- 3) 컬럼명 별칭      :  문자O, 띄어쓰기 X, 특수문자 X
-- 4) 컬럼명 "별칭"    :  문자O, 띄어쓰기 O, 특수문자 O

-- "" 의미 ("" 사이 글자 그대로 인식해라)
-- 1) 대/소문자 구분
-- 2) 특수문자, 띄어쓰기 인식
-- 3) ORACLE 에서 문자열은 '' 

/* ++ 개발 언어별 "" 사용법
 * 
 * HTML, JS 	: STRING == ''
 * JAVJA    	: STRING != '' (CHAR)
 * DB(ORACLE) : "" 글자 그대로 인식. (TEXT)
 * 
 *  */


SELECT SYSDATE - TO_DATE('1995-10-26', 'YYYY-MM-DD') AS 생후n일,
((SYSDATE - TO_DATE('1995-10-26', 'YYYY-MM-DD'))/365 ) AS 만나이,
CEIL((SYSDATE - TO_DATE('1995-10-26', 'YYYY-MM-DD'))/365 ) AS 올림나이,
TO_DATE('1997-05-15', 'YYYY-MM-DD') + 10000 AS "!나이"
FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사번, 사원이름, 급여, 연봉(급여*12) 조회
-- 단, 컬럼명은 위에 작성된 그대로 조회

SELECT EMP_ID  AS 사번,
EMP_NAME  AS 이름,
SALARY   급여,
SALARY * 12 "연봉(급여*12)"

FROM EMPLOYEE ;

-- -----------------------------------------------------------------------

/* 연결 연산자(||) */
-- 오라클 DB에서는 연산자를 기호로 안씀(단어 그대로 쓴다)
-- 여기서 ||는 문자열 이어쓰기(+로 연결이 안됨)

SELECT EMP_ID || EMP_NAME 

FROM EMPLOYEE ;

-----------------------------------------------------------------------

/* 컬럼명 자리에 리터럴 직접 작성 */

SELECT EMP_NAME , SALARY, '원'
FROM EMPLOYEE;

-- 조회 결과(RESULT SET)의 모든 행에 컬럼명 자리에 작성한 리터럴 값이 추가된다!!

-----------------------------------------------------------------------

/* DISTINCT (별개의, 전혀 다른..) */

-- 조회 결과 집합(RESULT SET)에서
-- 지정된 컬럼의 값이 중복되는 경우 이를 한번만 표현

-- EMPLOYEE 테이블에서 모든 사원의 부서 코드 조회

SELECT DEPT_CODE, EMP_NAME 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원이 있는 부서 코드만 조회

SELECT * FROM DEPARTMENT; -- 이 회사의 모든 부서 조회(사원 유무 관계 없이)

SELECT DISTINCT DEPT_CODE 
FROM EMPLOYEE; -- 중복 없이 하나씩만 나오게끔

-- EMPLOYEE 테이블에서 존재하는 직급 코드의 종류를 조회
SELECT DISTINCT  JOB_CODE 
FROM EMPLOYEE;


-----------------------------------------------------------------

/* ++ 절의 종류
 * 1. SELECT
 * 2. FROM + JOIN
 * 3. WHERE
 * 4. GROUP BY
 * 5. HAVING
 * 6. ORDER BY 
 * */

/******************/
/**** WHERE 절 ****/
/******************/

-- 테이블에서 조건을 충족하는 행을 조회할 때 사용
-- WHERE절에는 조건식(true/false)만 작성

-- 비교 연산자 : >, <, >=, <=, = (같다), !=, <> (같지 않다)
-- 논리 연산자 : AND, OR, NOT


/* [SELECT 작성법 - 2]
 * 
 * SELECT 컬럼명, 컬럼명, ...
 * FROM 테이블명
 * WHERE 조건식;
 * 
 * -> 지정된 테이블 모든 행에서 
 *   컬럼명이 일치하는 컬럼 값 조회
 * */

-- EMPLOYEE 테이블에서 
-- 급여가 300만원을 초과하는 사원의 사번, 이름, 급여, 부서코드 조회
/*작성 순서*/
/*3*/SELECT EMP_ID "사번", EMP_NAME "이름", SALARY "급여", DEPT_CODE "부서코드"
/*1*/FROM EMPLOYEE e 
/*2*/WHERE SALARY > 3000000; 

/* 1. FROM  절에 지정된 테이블에서  
 * 2. WHERE 절로 지정된 테이블에서 행을 먼저 추림
 * 3. SELECT절로 추려진 결과 행들 중에서 원하는 컬럼만 조회    */

-- EMPLOYEE 테이블에서 연봉이 5천만원 이하인 사원의 
-- 사번, 이름, 연봉 조회

SELECT EMP_ID "사번", EMP_NAME "이름", SALARY*12 "연봉"
FROM EMPLOYEE e 
WHERE SALARY*12 <= 50000000;

-- EMPLOYEE 테이블에서 
-- 부서 코드가 'D9'이 아닌 사원의 
-- 이름, 부서코드, 전화번호 조회

SELECT EMP_NAME 이름, DEPT_CODE 부서코드, PHONE 전화번호
FROM EMPLOYEE 
WHERE DEPT_CODE != 'D9';

-- 전체 사원24명인데 왜 D9 3명 제외한 21명이 아닌 18명만 나오지?
-- > DEPT_CODE가 NULL(없는) 사원이 존재하기 때문!

----------------
/* NULL 비교하기*/
----------------

-- 컬럼명 = NULL / 컬럼명 !=NULL   -->안된다
	--> =, !=, < 등의 비교 연산자는 값을 비교하는 연산자!!
	--> ORACLE DB 에서 NULL은 값이 아님. "저장된 값이 없다" 라는 의미!
	--> SELECT = NULL -> 값이 NULL 인 컬럼을 찾아와라. 값이 없는 것이 아니라! 값이 NULL 인 것을 찾아와라!
	--> 빈칸 감지하는 함수를 쓴다

-- 컬럼명 IS NULL			 : 컬럼 값이 존재하지 않음
-- 컬럼명 IS NOT NULL : 컬럼 값이 존재함

-- EMPLOYEE 테이블에서 DEPT_CODE 없는 사원만 조회
SELECT EMP_NAME , DEPT_CODE 
FROM EMPLOYEE e 
WHERE DEPT_CODE IS NULL; --> 2행

-- EMPLOYEE 테이블에서 DEPT_CODE 있는 사원만 조회
SELECT EMP_NAME , DEPT_CODE 
FROM EMPLOYEE e 
WHERE DEPT_CODE IS NOT NULL; --> 21행

---------------------------------------------------------------------------------

/* 논리연산 AND, OR */

-- EMPLOYEE 테이블에서
-- 부서 코드가 'D6'인 사원 중
-- 급여가 300만원 초과하는 사원의
-- 이름, 부서코드, 급여를 조회

SELECT EMP_NAME, DEPT_CODE , SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE ='D6' AND SALARY > 3000000 ;



-- EMPLOYEE 테이블에서 급여가 300만 이상, 500만 이하인 사원의
-- 사번, 이름, 급여 조회

SELECT EMP_ID , EMP_NAME , SALARY 
FROM	 EMPLOYEE
WHERE	 SALARY >= 3000000
AND 	 SALARY <= 5000000; --> 6행

-- EMPLOYEE 테이블에서 급여가 300만 이하, 500만 이하인 사원 제외한 모든 사원의
-- 사번, 이름, 급여 조회

SELECT EMP_ID , EMP_NAME , SALARY 
FROM	 EMPLOYEE
WHERE	 SALARY < 3000000
OR 	 	 SALARY > 5000000;	--> 17행

/************************/
/* 컬럼명 BETWEEN A AND B*/
/************************/
-- 컬럼의 값이 A 이상 B 이하면 TRUE

-- EMPLOYEE 테이블에서 급여가 300만 이상, 500만 이하인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID , EMP_NAME , SALARY 
FROM	 EMPLOYEE
WHERE	 SALARY BETWEEN 3000000 AND 5000000; --> 6행

/* 컬럼명 NOT BETWEEN A AND B*/
-- 컬럼의 값이 A 이상 B 이하면 FALSE
	--> A미만 또는 B초과시 TRUE
-- EMPLOYEE 테이블에서 급여가 300만 이하, 500만 이하인 사원 제외한 모든 사원의
-- 사번, 이름, 급여 조회

SELECT EMP_ID , EMP_NAME , SALARY 
FROM	 EMPLOYEE
WHERE	 SALARY NOT BETWEEN  3000000 AND 5000000;	--> 17행

/* BETWEEN 사용처 */
-- 게시판 하부 페이지 조회
-- 특정한 범위 내의 값을 조회할때 씀

/* 날짜도 범위 비교 가능(날짜끼리만 비교하기) */
-- EMPLOYEE 테이블에서
-- 입사일이 '2000-01-01' 부터 '2000-12-31' 인 사원의 
-- 이름, 입사일 조회

SELECT 	EMP_NAME 이름, HIRE_DATE 입사일
FROM 	 	EMPLOYEE
WHERE  	HIRE_DATE 
BETWEEN TO_DATE('2000-01-01', 'YYYY-MM-DD') 
AND 		TO_DATE('2000-12-31', 'YYYY-MM-DD');

-------------------------------------------------------------------------

-- EMPLOYEE 테이블에서 부서 코드가 'D5', 'D6', 'D9'인 사원의
-- 이름, 부서코드, 급여 조회

SELECT EMP_NAME , DEPT_CODE , SALARY 
FROM   EMPLOYEE
WHERE  DEPT_CODE = 'D5'
OR	   DEPT_CODE = 'D6'
OR	   DEPT_CODE = 'D9'; --> 12행

-------------------------------------------------------------------------

/*****************************/
/* 컬럼명  IN(값1,값2,값3, ...) */
/*****************************/

-- 컬럼의 값이 ()안의 값과 일치하면 TRUE

/*********************************/
/* 컬럼명  NOT IN(값1,값2,값3, ...) */
/*********************************/

-- 컬럼의 값이 ()안의 값과 일치하면 FALSE
	--> 컬럼의 값이 () 내 값과 일치하지 않으면 TRUE

-- EMPLOYEE 테이블에서 부서 코드가 'D5', 'D6', 'D9'인 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME , DEPT_CODE , SALARY 
FROM   EMPLOYEE
WHERE  DEPT_CODE IN('D5', 'D6', 'D9'); -->12행

-- EMPLOYEE 테이블에서 부서 코드가 'D5', 'D6', 'D9'가 아닌 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME , DEPT_CODE , SALARY 
FROM   EMPLOYEE
WHERE  DEPT_CODE NOT IN('D5', 'D6', 'D9'); --> 9행
--> NULL인 사원 2명 제외

-- EMPLOYEE 테이블에서 부서 코드가 'D5', 'D6', 'D9'가 아닌 사원의
-- 이름, 부서코드, 급여 조회
-- 부서 없는(NULL)인 사원 포함해서
SELECT EMP_NAME , DEPT_CODE , SALARY 
FROM   EMPLOYEE
WHERE  DEPT_CODE NOT IN('D5', 'D6', 'D9') 
OR 		 DEPT_CODE IS NULL; --> 11행


----------------------------------------------------------------

/*  **** LIKE ****
 * 
 * - 비교하려는 값이 특정한 패턴을 만족 시키면(TRUE) 조회하는 연산자
 * 
 * [작성법]
 * WHERE 컬럼명 LIKE '패턴'
 * 
 * - LIKE 패턴( == 와일드 카드  ) 
 * 
 * '%' (포함)
 * - '%A' : 문자열이 앞은 어떤 문자든 포함되고 마지막은 A
 * 			-> A로 끝나는 문자열
 * - 'A%' : A로 시작하는 문자열
 * - '%A%' : A가 포함된 문자열
 *  
 * 
 * '_' (글자 수)
 * - 'A_' : A 뒤에 아무거나 한 글자만 있는 문자열
 *          (AB ,A1, AQ, A가)
 * 
 * - '___A' : A 앞에 아무거나 3글자만 있는 문자열
 */

-- EMPLOYEE 테이블에서 성이 '전' 씨인 사원의 사번, 이름 조회

SELECT EMP_ID , EMP_NAME 
FROM EMPLOYEE
WHERE EMP_NAME LIKE'전%'; -- 전형돈 전지연

-- EMPLOYEE 테이블에서 이름이 '수' 로 끝나는 사원의 사번, 이름 조회
SELECT EMP_ID , EMP_NAME 
FROM 	 EMPLOYEE
WHERE  EMP_NAME LIKE'%수'; -- 방명수

-- EMPLOYEE 테이블에서 이름에 '하' 가 포함되는 사원의 사번, 이름 조회
SELECT EMP_ID , EMP_NAME 
FROM 	 EMPLOYEE
WHERE  EMP_NAME LIKE'%하%'; -- 정중하 하이유 하동운 유하진

-- EMPLOYEE 테이블에서 이름이 '전' 시작, '돈' 끝나는 사원의 사번, 이름 조회
SELECT EMP_ID , EMP_NAME 
FROM 	 EMPLOYEE
WHERE  EMP_NAME LIKE'전%돈'; -- 전형돈

-- EMPLOYEE 테이블에서
-- 전화변호가 '010'으로 시작하는 사원의 이름, 전화번호 조회

SELECT EMP_NAME , PHONE  
FROM EMPLOYEE 
WHERE PHONE LIKE '010%'; -- %버전

SELECT EMP_NAME, PHONE  
FROM EMPLOYEE 
WHERE PHONE LIKE '010________'; -- _ 버전

-- EMPLOYEE 테이블에서
-- EMAIL의 아이디 (@ 앞의 글자)의 글자 수가 5글자인 사원의
-- 이름, EMAIL 조회

SELECT EMP_NAME , EMAIL 
FROM EMPLOYEE 
WHERE EMAIL LIKE '_____@%'; -- _,와일드카드(%)같이 사용

-- EMPLOYEE 테이블에서
-- 이메일의 아이디 중 '_' 앞 쪽 글자의 수가 3글자인 사원의
-- 사번, 이름, 이메일 조회

SELECT EMP_ID , EMP_NAME , EMAIL 
FROM EMPLOYEE 
WHERE EMAIL LIKE '____%'; 

-- 왜 안되는거야?
--> 기준이되는 _ 가 LIKE 와일드카드 _의 표기법이 동일하여 구분되지 않음
--> 모든 _가 와일드카드로 인식되고 있다.

--> 해결 방법 : LIKE의 ESCAPE 옵션 사용하기
--> ESCAPE 옵션 : 와일드 카드의 의미를 벗어나 단순 문자열로 인식
-->   적용 범위 : 특수문자 뒤 한 글자
SELECT EMP_ID , EMP_NAME , EMAIL 
FROM EMPLOYEE 
WHERE EMAIL LIKE '___._%' ESCAPE'.';
--> ESCAPE 문자는 아무거나 사용 가능. 지금은 .으로 사용

----------------------------------------------------------------
----------------------24.02.27.(화).-----------------------------

/* **** ORDER BY 절 ****
 * 
 * - SELECT문의 조회 결과(RESULT SET)를 정렬할 때 사용하는 구문
 * 
 * - *** SELECT구문에서 제일 마지막에 해석된다! ***
 * 
 * [작성법]
 * 3: SELECT 컬럼명 AS 별칭, 컬럼명, 컬럼명, ...
 * 1: FROM 테이블명
 * 2: WHERE 조건식
 * 4: ORDER BY 컬럼명 | 별칭 | 컬럼 순서 [오름/내림 차순] 
 * 	        [NULLS FIRST | LAST]
 * 
 *  ++ 별칭 : WHERE 절에서는 사용 불가하나
 * 					 ORDERBY 절에서는 사용 가능
 * */

-- EMPLOYEE 테이블에서 모든 사원의 이름, 급여 조회
-- 급여 오름차순으로 정렬

/*해석 순서*/
/*2*/SELECT EMP_NAME 이름 , SALARY 급여 
/*1*/FROM EMPLOYEE
/*3*/ORDER BY 급여 ASC; -- ASC(ASCENDING) : 오름차순

-- EMPLOYEE 테이블에서 모든 사원의 이름, 급여 조회
-- 급여 내림차순으로 정렬

/*해석 순서*/
/*2*/SELECT EMP_NAME 이름 , SALARY 급여 
/*1*/FROM EMPLOYEE
/*3*/ORDER BY 급여 DESC; -- DESC(DESCENDING) : 내림차순

-- EMPLOYEE 테이블에서 
-- 부서 코드가 'D5','D6','D9'인 사원의
-- 사번, 이름, 부서코드를 부서코드 오름차순으로 조회

SELECT EMP_ID , EMP_NAME , DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE ; -- ASC는 기본값. 생략 가능함

/* 컬럼 순서를 이용해 정렬하기 */

-- EMPLOYEE 테이블에서 급여가 300만 이상, 600만 이하인 사원의
-- 사번, 이름, 급여를 이름 내림차순 조회

SELECT EMP_ID, EMP_NAME, SALARY 
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000
ORDER BY 2 DESC ; -- 정렬순서로 기준을 잡는 것은 바람직하지 않음

/* ORDER BY 절에 수식 넣기 */
-- EMPLOYEE 테이블에서 이름, 연봉을 연봉 내림차순으로 조회

SELECT EMP_NAME, SALARY*12 연봉
FROM EMPLOYEE
ORDER BY SALARY*12 DESC ; -- 대부분 SELECT 절에 작성된 컬럼 그대로 따라 적음




