-- : 한 줄 주석 ctrl /
/* 범위 주석 crrl shift / */

/* SQL 1개 실행은 : CTRL + ENTER
 * SQL 여러개 실행 : 블럭처리 + ALT + X 
 * */
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; -- 접속 방법 변경


-- 계정 생성하기 
CREATE USER KH_KCH IDENTIFIED BY KH1234;

-- 생성된 계정에 접속, 기본 자원 관리 권한 추가
GRANT CONNECT, RESOURCE TO KH_KCH;

-- 객체 생성 공간 할당 : 데이터를 저장할 공간 용량 부여
ALTER USER KH_KCH
DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;