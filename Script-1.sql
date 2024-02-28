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

/* ORDER BY 절에 별칭 적용하기 */
--> SELECT절 해석 이후 ORDER BY절 해석되기 때문에
--> SELECT절에서 사용된 별칭을 ORDER BY절에서 사용할 수 있음
-- ++ 앞에서 해석되면 뒤에서 사용 가능함

-- EMPLOYEE 테이블에서 이름, 연봉을 연봉 내림차순으로 조회
SELECT EMP_NAME 이름, SALARY*12 연봉
FROM EMPLOYEE
ORDER BY 연봉 DESC ; -- 대부분 SELECT 절에 작성된 컬럼 그대로 따라 적음

/* WHERE절 별칭 사용 불가 확인*/

SELECT EMP_NAME, DEPT_CODE 부서코드
FROM EMPLOYEE
WHERE 부서코드 = 'D6' ;
 --> ORA-00904: "부서코드": 부적합한 식별자
 -->"부서코드" 컬럼이 존재하지 않음
 --> 발생 이유 : 해석 순서가 FROM, WHERE, SELECT순으로 해석되기에
 -- 					WHERE 해석 시에는 SELECT의 내용 컴파일러(?)가 아직 모름


------------------------------------------


/* NULLS FIRST/LAST 옵션 적용하기 */
-- 모든 사원의 이름, 전화번호 조회
-- 오름차순 + NULLS FIRST(NULL인 경우 제일 위에)
SELECT EMP_NAME , PHONE 
FROM EMPLOYEE
ORDER BY PHONE NULLS FIRST ;

-- 오름차순 + NULLS LAST(NULL인 경우 제일 아래)
SELECT EMP_NAME , PHONE 
FROM EMPLOYEE
ORDER BY PHONE /*NULLS LAST*/ ; -- NULLS LAST는 DEFAULT 값. 생략 가능

-- 내림차순 + NULLS FIRST(NULL인 경우 제일 위에)
SELECT EMP_NAME , PHONE 
FROM EMPLOYEE
ORDER BY PHONE DESC NULLS FIRST ;

--> 정렬기준 -> NULL 위치 순서대로 해석

/************** 정렬 중첩 ***************/
-- 먼저 작성된 정렬 기준을 깨지 않고 
-- 다음 작성된 정렬 기준을 적용.

-- EMPLOYEE 테이블에서
-- 이름, 부서코드, 급여를
-- 부서코드 오름차순, 급여 내림차순으로 조회

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE, SALARY DESC ;

-- EMPLOYEE 테이블에서 이름, 부서코드, 직급 코드를 
-- 부서코드 오름차순, 직급코드 내림차순, 이름 오름차순으로 정렬 조회

SELECT EMP_NAME 이름, DEPT_CODE 부서코드, JOB_CODE 직급코드 
FROM EMPLOYEE
ORDER BY 부서코드 , 직급코드 DESC, 이름 ; 



-- 함수 : 컬럼값 | 지정된값을 읽어 연산한 결과를 반환하는 것

-- 단일행 함수 : N개의 행의 컬럼 값을 전달하여 N개의 결과가 반환

-- 그룹 함수  : N개의 행의 컬럼 값을 전달하여 1개의 결과가 반환
--			  (그룹의 수가 늘어나면 그룹의 수 만큼 결과를 반환)

-- 함수는 SELECT절, WHERE절, ORDER BY절
--      GROUP BY절, HAVING절에서 사용 가능



/********************* 단일행 함수 *********************/


-- < 문자열 관련 함수 >

-- Length(문자열|컬럼명): 문자열의 길이 반환
SELECT 'HELLO WORLD', LENGTH('HELLO WORLD') FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 이메일, 이메일 길이 조회
-- 단, 이메일 길이가 12 이하인 행만 이메일 길이 오름차순 조회

SELECT EMP_NAME, EMAIL, LENGTH(EMAIL) "이메일 길이"
FROM EMPLOYEE 
WHERE LENGTH(EMAIL) <= 12
ORDER BY "이메일 길이";

----------------------------------------------

-- INSTR(문자열 | 컬럼명, '찾을 문자열' [, 찾을 시작 위치 [, 순번]]) 
-- 찾을 시작 위치부터 지정된 순번째 찾은 문자열의 시작 위치를 반환

-- 문자열에서 맨 앞에있는 'B'의 위치를 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B') 
FROM DUAL; -- 3. (INDEX로 나오는것 아님! 몇 번째에 위치해 있는지)

-- 문자열에서 5번부터 검색 시작해서 처음 찾은 'B'의 위치 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B', 5) 
FROM DUAL; 

-- 문자열에서 5번부터 검색 시작해서 두번째로 찾은 'B'의 위치 조회
SELECT 'AABAACAABBAA', INSTR('AABAACAABBAA', 'B', 5, 2) 
FROM DUAL; 

----------------------------------------------

-- SBSTR(문자열 | 컬럼명, 시작위치 [,길이])

-- 문자열을 시작 위치부터 지정된 길이 만큼 잘라내서 반환
-- 길이 미작성 시 시작 위치 부터 끝까지 잘라내서 반환

-- 시작위치, 잘라낼 길이 지정
SELECT SUBSTR('ABCDEFG', 2, 3) 
FROM DUAL; --2번부터 시작해서, 3칸을 잘라 골라내겠다.

-- 시작위치 지정, 잘라낼 길이 미지정 --> 시작위치부터 끝까지 SELECT 됨
SELECT SUBSTR('ABCDEFG', 4) FROM DUAL; 

--[INSTR || SUBSTR]

-- EMPLOYEE 테이블에서
-- 사원명, 이메일 아이디(@ 앞에까지 문자열)을
-- 이메일 아이디 오름차순으로 조회

SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "이메일 아이디"
FROM EMPLOYEE
ORDER BY "이메일 아이디" ;

-------------------------------------------------------------

-- TRIM([ [옵션] 문자열 | 컬럼명 FROM ] 문자열 | 컬럼명)
-- 주어진 문자열의 앞쪽|뒤쪽|양쪽에 존재하는 지정된 문자열을 제거

-- 옵션 : LEADING(앞쪽), TRAILING(뒤쪽), BOTH(양쪽, 기본값)

-- 문자열 공백 제거

SELECT '   기  준   ', 
	TRIM(LEADING  ' ' FROM '   기  준   '), -- 앞쪽 공백 제거
	TRIM(TRAILING ' ' FROM '   기  준   '), -- 뒷쪽 공백 제거
	TRIM(BOTH     ' ' FROM '   기  준   ')  -- 양쪽 공백 제거
FROM DUAL;

-- 특정 문자열 제거하기
SELECT '###기  준###', 
	TRIM(LEADING  '#' FROM '###기  준###'), -- 앞쪽 공백 제거
	TRIM(TRAILING '#' FROM '###기  준###'), -- 뒷쪽 공백 제거
	TRIM(BOTH     '#' FROM '###기  준###')  -- 양쪽 공백 제거
FROM DUAL;


-------------------------------------------------------

-- REPLACE(문자열 | 컬럼명, 찾을 문자열, 바꿀 문자열)

SELECT * FROM NATIONAL;

SELECT NATIONAL_CODE, REPLACE(NATIONAL_NAME,'한국', '대한민국')
FROM "NATIONAL" ;

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------

-- <숫자 관련 함수> --

-- [나머지]
-- MOD(숫자 | 컬럼명, 나눌 값) : 나머지
SELECT MOD(105, 100) FROM DUAL;

--[절대값]
-- ABS(숫자 | 컬럼명) : 절대값
SELECT ABS(10), ABS(-10) FROM DUAL;

-- [올림 CEIL, 내림FLOOR] 
-- CEIL | FLOOR (숫자 \ 컬럼명) : 정수 단위로 올림, 내림
SELECT CEIL(1.1), FLOOR(1.3) FROM DUAL;

-- [반올림]
-- ROUND(숫자 | 컬럼명 [, 소수점 위치]) : 반올림
-- 소수점 위치 지정 x : 소수점 첫째 자리에서 반올림 -> 정수 표현
-- 소수점 위치 지정 O
 -- 1) 양수 : 지정된 위치의 소수점 자리까지 표현
 -- 2) 음수 : 지정된 위치의 정수 자리까지 표현

SELECT 123.456,
	ROUND (123.456),	    -- 123	
	ROUND	(123.456, 1),   -- 123.5
	ROUND	(123.456, 2),   -- 123.46
	ROUND (123.456, -1),  -- 120
	ROUND (123.456, -2)   -- 100
FROM DUAL;

-- [버림(잘라내기)]
-- TRUNC(숫자 | 컬럼명[,소수점 위치]) : 버림(잘라내기)
SELECT -123.5,
	TRUNC(-123.5),	 -- -123(소수점 .5 버림)
	FLOOR(-123.5)		 -- -124(내림!)
FROM DUAL;

-----------------------------------------------------------------------------
-------------------------<날짜 관련 함수>----------------------------------------
-----------------------------------------------------------------------------

-- SYSDATE : 현재시간
-- SYSTIMESTAMP : 현재시간(밀리초, 표준시간 포함)
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;


-- MONTH_BETWEEN(날짜, 날자) : 두 날짜 사이의 개월 수를 반환
--> 반환 값 중 정수 부분은 차이 나는 개월 수
SELECT MONTHS_BETWEEN('2024-03-28', SYSDATE) 
FROM DUAL;
--> ORACLE은 자료형이 맞지 않은 상황이라도 
--  작성된 값의 형태가 요구하는 자료형의 형태를 띄고 있으면
--  자동으로 형변환(PARSING)을 진행한다!!!

-- EX) '2024-03-27' -> TO_DATE('2024-03-27', 'YYYY-MM-DD') 자동으로 실행됨!!!

-- EMPLOYEE 테이블에서
-- 모든 사원의 사번, 이름, 입사일, N년차 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE,
CEIL( MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12 ) ||'년차' 연차
FROM EMPLOYEE ;

-- MONTHS_BETWEEN()은 윤년(2월 29일이 포함된 해) 계산이 자동으로 수행
--> YEAR, MONTH 단위 계산 시 더 정확한 값을 얻어낼 수 있다!!!

-- ADD_MONTH(날짜, 숫자) : 날짜를 숫자만큼의 개월 수를 더하여 반환
--> 달마다 다른 일수를 알아서 계산함

SELECT SYSDATE,	 		 			-- 2월 27일
	SYSDATE + 29,			 			-- 3월 27일
	SYSDATE + 29 + 31, 			-- 4월 27일
	ADD_MONTHS(SYSDATE, 1), -- 3월 27일
	ADD_MONTHS(SYSDATE, 2)	-- 4월 27일
FROM DUAL;

-- LAST_DAY(날짜) : 해당 월의 마지막 날짜를 반환
SELECT LAST_DAY(SYSDATE) FROM DUAL; 

-- 다음 달 마지막 날짜
SELECT LAST_DAY(ADD_MONTHS(SYSDATE, 1)) FROM DUAL; 

-- 다음 달의 첫째 날짜와 마지막 날짜 구하기
SELECT LAST_DAY(SYSDATE) + 1 "다음달 첫 날"	,
		   LAST_DAY(ADD_MONTHS(SYSDATE, 1)) "다음달 마지막 날"
FROM DUAL;


-- EXTRACT(YEAR | MONTH | DAY FROM 날짜)
-- EXTRACT : 뽑아내다, 추출하다
-- 지정된 날짜의 년 | 월 | 일을 추출하여 정수로 반환
SELECT EXTRACT(YEAR FROM SYSDATE) 년,
			 EXTRACT(MONTH FROM SYSDATE) 월,
			 EXTRACT(DAY FROM SYSDATE) 일
FROM DUAL;

-- EMPLOYEE 테이블에서 2000년대에 입사한 사원의
-- 사번, 이름, 입사일을 이름 오름차순으로 조회

SELECT EMP_ID , EMP_NAME , HIRE_DATE 
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000
ORDER BY EMP_NAME ;

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------

-- <형변환(Parsing) 함수>

-- 문자열(CHAR, VARCHAR2) <-> 숫자(NUMBER)
-- 문자열(CHAR, VARCHAR2) <-> 날짜(DATE)
-- 숫자(NUMBER) --> 날짜(DATE)
-- 날짜는 숫자가 될 수 없다!!

/* TO_CHAR(날짜 | 숫자 [, 포맷]) : 문자열로 변환 // 문자(글자 하나)가 아님
 * 
 * 숫자 -> 문자열
 * 포맷 
 * 1) 9 : 숫자 한 칸을 의미, 오른쪽 정렬
 * 2) 0 : 숫자 한 칸을 의미, 오른쪽 정렬, 빈 칸에 0을 추가
 * 3) L : 현재 시스템이나 DB에 설정된 나라의 화폐 기호
 * 4) , : 숫자의 자릿수 구분
 * */

SELECT 1234, TO_CHAR(1234) FROM DUAL; 

--[9 사용 자리 표현]
SELECT 1234, TO_CHAR(1234, '99999999') FROM DUAL;
--> 9를 8개 써서 8자리로 표현, 앞4자리는 공백

--[0 사용 자리 표현 + 0으로 채우기]
SELECT 1234, TO_CHAR(1234, '00000000') FROM DUAL;
--> 0을 8개 써서 8자리로 표현, 앞4자리는 0으로 채워짐

--[문제상황]
/* 숫자 -> 문자열 변환시 문제상황 */
SELECT 1234, TO_CHAR(1234, '000') FROM DUAL;
--> 포맷에 지정된 칸 수가 숫자의 전체 길이보다 적으면 #으로 변환되어 출력

-- 화폐기호 + 자릿수 구분
SELECT TO_CHAR(123456789, 'L999999999'),
			 TO_CHAR(123456789, '$999999999'), 
			 TO_CHAR(123456789, '$999,999,999') 
FROM DUAL;


-- 모든 사원의 연봉 조회
SELECT EMP_NAME,
TO_CHAR(SALARY*12,'L999,999,999') 연봉
FROM EMPLOYEE;


------------------------------------------------

/* 날짜 -> 문자열
 * 
 * YY    : 년도(짧게) EX) 23
 * YYYY  : 년도(길게) EX) 2023
 * 
 * RR    : 년도(짧게) EX) 23
 * RRRR  : 년도(길게) EX) 2023
 * 
 * MM : 월
 * DD : 일
 * 
 * AM/PM : 오전/오후 --> 입력한 시간에 따라서 알아서 정해짐
 * 
 * HH   : 시간 (12시간)
 * HH24 : 시간 (24시간)
 * MI   : 분
 * SS   : 초
 * 
 * DAY : 요일(전체) EX) 월요일, MONDAY
 * DY  : 요일(짧게) EX) 월, MON
 * */

-- 현재 날짜 ->'2024-02-27'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;

-- 현재 날짜 -> '2024-02-07 화요일'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; 

-- 현재 날짜 -> '24.02.27.(화)12:11:20'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YY.MM.DD(DY)AM HH:MI:SS') FROM DUAL;

-- /, (), :, . -> 일반적으로 날짜 표기 시 사용하는 기호로.
-- 패턴으로 인식되어 오류가 발생하지 않음!!

-- 현재 날짜  -> 2024년 02월 27일 오후 12시 15분 30초

SELECT TO_CHAR(SYSDATE, 'YYYY년 MM월 DD일 PM HH시 MI분 SS초')
FROM DUAL;
--> 년,월,일 같은 한글 또는 날짜와 관련 없는 문자는 패턴이 아니므로 오류 발생
--> 원하는 패턴의 구성 문자를 ""로 감싸면 사용 가능
---> "" : ""내부의 글자 있는 그대로 인식함

SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" PM HH"시" MI"분" SS"초"')
FROM DUAL;

-------------------------------------------------------------------------

-- TO_DATE(문자열 | TNTWK[, 포맷])
-- 문자열 또는 숫자를 날짜 형식으로 변환

SELECT TO_DATE('2024-03-04') 
FROM DUAL;
-- ''안의 문자열이 날짜를 표현하는 형식이면 포맷 지정 없이 바로 변경 가능.

SELECT TO_DATE('04-03-2024','DD-MM-YYYY')
FROM DUAL;
--> ''안의 문자열을 임의로 지정한 상태라면 추가적으로 인식시킬 필요 있음.

SELECT TO_DATE('02월 27일 화요일 12시 24분', 'MM"월" DD"일" DAY HH"시" MI"분"')
FROM DUAL;

-- 숫자 -> 날짜
SELECT TO_DATE(20240227,'YYYYMMDD') FROM DUAL;


/*** 연도 패턴  Y, R 차이점 ***/

-- 연도가 두자리만 작성되어있는 경우
-- 50 미만 : Y,R 둘 다 누락된 연도 앞부분에 현재 세기(21C == 2000년대) 추가
-- 50 이상 : Y : 현재 세기(2000년대) 추가
--		    R : 이전 세기(1900년대) 추가

-- 50 미만 확인
SELECT
	TO_DATE('49-11-25', 'YY-MM-DD') "YY", -- 2049
	TO_DATE('49-11-25', 'RR-MM-DD') "RR"  -- 2049
FROM DUAL;

-- 50 이상
SELECT
	TO_DATE('59-11-25', 'YY-MM-DD') "YY", -- 2059
	TO_DATE('59-11-25', 'RR-MM-DD') "RR"  -- 1959 
FROM DUAL;

-- 연도는 4자리 꽉꽉 쓰는게 좋다..

-----------------------------------------------------------

-- TO_NUMBER(문자열 [,패턴) : 문자열 -> 숫자 변환
SELECT TO_NUMBER('$1,500', '$9,999')
FROM DUAL;

-----------------------------------------------------------

-- <NULL 처리 연산> : IS NULL, IS NOT NULL

-- <NULL 처리 함수 NVL((NULLVALUE)>
-- NVL(컬럼명, 컬럼 값이 NULL일 경우 변경할 값)
-- 지정된 컬럼 값이 NULL일 경우 변경

-- EMPLOYEE 테이블에서
-- 사번, 이름, 전화번호 조회
-- 전화번호가 없으면(NULL)'없음'으로 조회

SELECT EMP_ID, EMP_NAME, 
			 NVL(PHONE, '없음') "전화번호" 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 사번, 이름, 보너스 조회
-- 보너스가 없으면(NULL)'없음'으로 조회

SELECT EMP_ID , EMP_NAME , 
			 NVL(BONUS, 0) 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 이름, 급여, 성과급(급여*보너스)
-- 성과급이 없으면 0으로 표시

SELECT EMP_NAME , SALARY , 
			 SALARY * NVL(BONUS, 0 )"성과급"

FROM EMPLOYEE;
--> NULL과 산술연산하면 값은 무조건 NULL이 나온다

----------------------------------------------

-- NVL2(컬럼명, NULL이 아닌 경우 변경할 값, NULL인 경우 변경할 값)

-- EMPLOYEE 테이블에서
-- 사번, 이름, 전화번호 조회
-- 전화번호 없으면 '없음'
-- 전화번호 있으면 '010********' 형식으로 변경해서 조회

SELECT EMP_ID, EMP_NAME , 
				NVL2(PHONE,
						 RPAD( SUBSTR(PHONE, 1, 3), LENGTH(PHONE), '*' ),
						 '없음')
FROM EMPLOYEE;

----------------------------------------------------------------------

-- <선택 함수 DECODE, CASE>
-- 여러 가지 경우에 따라 알맞은 결과를 선택하는 함수
-- (if, switch문과 비슷)

-- DECODE(컬럼명 | 계산식, 조건1, 결과1, 조건2, 결과2, ... [,아무것도 만족 X])                          

-- 컬럼명 | 계산식의 값이 일치하는 조건이 있으면
-- 해당 조건 오른쪽에 작성된 결과가 반환된다.

--> 나누어 떨어지는 값을 구할 때 사용함

-- EMPLOYEE 테이블에서 
-- 모든 사원의 이름, 주민등록번호, 성별 조회

SELECT EMP_NAME , EMP_NO,
			 DECODE( SUBSTR(EMP_NO,8,1), '1', '남자', '2', '여자' ) 성별
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 직급코드가 'J7'인 직원은 급여 + 급여의 10%
-- 직급코드가 'J6'인 직원은 급여 + 급여의 15%
-- 직급코드가 'J5'인 직원은 급여 + 급여의 20%
-- 나머지 직급코드의 직원은 급여 + 급여의 5%  지급
-- 사원명, 직급코드, 기존급여, 지급급여 조회

SELECT EMP_NAME , JOB_CODE , SALARY,
			 DECODE(JOB_CODE,
			 				'J7', SALARY * 1.1 ,
			 				'J6', SALARY * 1.15,
			 				'J5', SALARY * 1.2 ,
			 							SALARY * 1.05) "지급 급여"
FROM EMPLOYEE;


---------------------------------------------------

-- CASE 
--	  WHEN 조건1 THEN 결과1
--	  WHEN 조건2 THEN 결과2
--	  WHEN 조건3 THEN 결과3
--	  ELSE 결과
-- END

-- DECODE는 계산식|컬럼 값이 딱 떨어지는 경우에만 사용 가능.
-- CASE는 계산식|컬럼 값을 범위로 지정할 수 있다. 

-- EMPLOYEE 테이블에서 사번, 이름, 급여, 구분을 조회		 // FROM, SELECT
-- 구분은 받는 급여에 따라 초급, 중급, 고급으로 조회   		 // 
-- 급여 500만 이상 = '고급'
-- 급여 300만 이상 ~ 500만 미만 = '중급'
-- 급여 300미만 = '초급'
-- 단, 부서코드가 D6, D9인 사원만 직급코드 오름차순으로 조회


SELECT EMP_ID, EMP_NAME , SALARY,
CASE
	WHEN SALARY >= 5000000 THEN '고급'
	WHEN SALARY >= 3000000 THEN '중급'
	ELSE 												'초급'
END 구분

FROM EMPLOYEE 
WHERE DEPT_CODE IN('D6', 'D9')
ORDER BY JOB_CODE;
--> SELECT 절에 작성된 컬럼이 아니라고 해서 ORDER BY절에서 사용 못하는것 아님


-------------------------------------------------------------

/************* 그룹 함수 *************/

--  N개의 행의 컬럼 값을 전달하여 1개의 결과가 반환
--	(그룹의 수가 늘어나면 그룹의 수 만큼 결과를 반환)

-- SUM(숫자가 기록된 컬럼명) : 그룹의 합계를 반환

-- 모든 사원의 급여 합

SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 부서 코드가 D6인 사원들의 급여 합

/*3*/SELECT SUM(SALARY) 			-- 3) SALARY 컬럼 값의 합을 조회
/*1*/FROM EMPLOYEE						-- 1) EMPLOYEE 테이블 23행 중
/*2*/WHERE DEPT_CODE = 'D6';  -- 2) DEPT_CODE가 'D6'인 행만 모아서

-- 2000년 이후 입사자들의 급여 합

SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000 ;

-----------------------

-- AVG(숫자만 기록된 컬럼) : 그룹의 평균

-- 모든 사원의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 평균 급여 소수점 내림 처리
SELECT FLOOR( AVG(SALARY) )
FROM EMPLOYEE;

/* 그룹 함수는 여러 개를 동시에 조회할 수 있다 */
-- (조회 결과가 사각형 형태의 테이블 모양이면 조회 가능함)
SELECT SUM(SALARY),
			 FLOOR( AVG (SALARY) ) 
FROM EMPLOYEE;

---------------------------
-- MAX(컬럼명) : 최대값
-- MIN(컬럼명) : 최소값

-- 날짜 대소 비교 : 과거 < 미래
-- 문자열 대소 비교 : 유니코드순서  (문자열 순서  A < Z)

SELECT MIN(HIRE_DATE), MAX(HIRE_DATE),
			 MIN(EMP_NAME),	 MAX(EMP_NAME)

FROM EMPLOYEE;


--------------------------------------------

-- COUNT(* | [DISTINCT] 컬럼명) : 조회된 행의 개수를 반환
-->(엑셀 COUNTA)

-- COUNT(*) : 조회된 모든 행의 개수를 반환

-- COUNT(컬럼명) : 지정된 컬럼 값이 NULL이 아닌 행의 개수를 반환
-- 					(NULL인 행 미포함)

-- COUNT(DISTINCT 컬럼명) : 
	-- 지정된 컬럼에서 중복 값을 제외한 행의 개수를 반환
	-- EX) A A B C D D D E : 5개 (중복은 한 번만 카운트)


-- EMPLOYEE 행의 전체 개수
SELECT COUNT(*)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서 코드가 'D5'인 사원의 수
SELECT COUNT(*)  
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6행

-- 전화번호가 있는 사원의 수 V1
SELECT COUNT(*)
FROM EMPLOYEE
WHERE PHONE IS NOT NULL; -- 20행

-- 전화번호가 있는 사원의 수 V2
SELECT COUNT(PHONE)
FROM EMPLOYEE; 					-- 20행
--> NULL이 아닌 행의 수만 카운트

-- EMPLOYEE 테이블에 존재하는 부서코드의 수를 조회
-- EMPLOYEE 테이블에 부서코드가 몇 종류?
SELECT DEPT_CODE FROM EMPLOYEE ;

SELECT DISTINCT(DEPT_CODE) FROM EMPLOYEE; --> 7행

SELECT COUNT( DISTINCT(DEPT_CODE) ) FROM EMPLOYEE; --> NULL 제외 6

-- EMPLOYEE 테이블에 존재하는 남자 사원의 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE (SUBSTR(EMP_NO, 8, 1) = 1);

-- EMPLOYEE 테이블에 존재하는 여자 사원의 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE (SUBSTR(EMP_NO, 8, 1) = 2);

-- EMPLOYEE 테이블에 존재하는 여자, 남자 사원의 수 동시에 출력
SELECT 
	COUNT( DECODE(SUBSTR(EMP_NO, 8, 1), '2', '여자', NULL) ) 여자,
	COUNT( DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', NULL) ) 남자
FROM EMPLOYEE;

-- EMPLOYEE 테이블에 존재하는 여자, 남자 사원의 수 (SUM 버전)
SELECT 
	SUM ( DECODE(SUBSTR(EMP_NO, 8, 1), '2', '1', 0 ) ) 여자,
	SUM ( DECODE(SUBSTR(EMP_NO, 8, 1), '1', '1', 0 ) ) 남자
FROM EMPLOYEE;

