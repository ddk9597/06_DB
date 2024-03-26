CREATE TABLE MINI_SHOP_AND_OFFICE(
	PORPERTIES_NO NUMBER,
	LOCATION_TITLE VARCHAR2(20),
	ADDRESS_NO VARCHAR2(20),
	SHOP_NAME VARCHAR2(50),
	CATEGORY VARCHAR2(50),
	CONTACT_INFO VARCHAR2(100),
	FLOOR VARCHAR2(50),
	PY NUMBER,
	PREMIUM NUMBER,
	DEPOSIT NUMBER,
	RENT NUMBER,
	ADMIN_COST NUMBER,
	NOTE VARCHAR2(1000)

);
DROP TABLE MINI_SHOP_AND_OFFICE;


SELECT *
FROM MINI_SHOP_AND_OFFICE
WHERE PORPERTIES_NO = 143;

SELECT DISTINCT  LOCATION_TITLE
FROM MINI_SHOP_AND_OFFICE 
ORDER BY LOCATION_TITLE ASC ;

-- 전체 매물 수 30개
SELECT COUNT (*)
FROM MINI_SHOP_AND_OFFICE;

-- 상가 개수 26개
SELECT COUNT (*)
FROM MINI_SHOP_AND_OFFICE
WHERE CATEGORY = '상가'
OR 	  CATEGORY ='상가 및 사무실';

-- 사무실 개수 17개
SELECT COUNT (*)
FROM MINI_SHOP_AND_OFFICE
WHERE CATEGORY = '사무실'
OR 	  CATEGORY ='상가 및 사무실';

--

INSERT INTO MINI_SHOP_AND_OFFICE VALUES (1, '강일동', '675-1', '조이점핑', '상가', '임차인 010 6404 9613', '4', 20, 0, 2000, 105, 0, '고정주차1, 손님주차3시간 무료, 시설인수 안한다면 권리금 500');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (2, '길동', '453', '공실', '상가 및 사무실', '관리인(010 9368 7969)', '-1', 38, 0, 3000, 220, 40, '냉난방기 제공, 내부 남녀구분화장실, 지하1층 전용출입구 및 샤워시설 있음');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (3, '길동', '453', '공실', '상가 및 사무실', '관리인(010 9368 7969)', '2', 31.5, 0, 5000, 410, 30, '냉난방기제공, 내부 남녀구분 화장실');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (4, '길동', '453', '공실', '상가 및 사무실', '관리인(010 9368 7969)', '3~11', 31.5, 0, 5000, 320, 30, '냉난방기제공, 내부 남녀구분 화장실');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (5, '길동', '416-6', '공실', '상가 및 사무실', '관리인(010 2608 6255), 임대인(010 5914 2873)', '6', 38, 0, 4000, 310, 55, '602호, 2개호실임대가능(79.75평,9천,640,111), 관리비 1월부터 평당12000(현재8천)');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (6, '길동', '416-6', '공실', '상가 및 사무실', '관리인(010 2608 6255), 임대인(010 5914 2873)', '6', 42, 0, 5000, 330, 61, '603호, 2개호실임대가능(79.75평,9천,640,111), 관리비 1월부터 평당12000(현재8천)');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (7, '길동', '373-28', '중화호반닭갈비', '상가', '임차인(010 8726 9667), 임대인(010 7256 7707)', '1', 27, 4000, 3000, 240, 5, '천장에어컨2대, 닭갈비업체시 노하우전수 가능, 상호승계불가, 월매출1500');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (8, '길동', '383-9', '탑바리스타아카데미', '상가 및 사무실', '임차인(010 9166 7150), 임대인(010 3111 9722)', '2', 38, 10000, 3000, 220, 20, '주차1, 룸3, 손님용주차 추가 가능');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (9, '길동', '389-5', '공실', '상가 및 사무실', '관리실(02 482 2226)', '7', 53, 0, 10000, 400, 150, '주차타워(승용차만 가능), 1대제공, 엘베 있음, 병원만 가능(유방외과선호),현재 비뇨,산부, 신경, 치과,
내과, 정형, 안과, 피부, 정신, 한의원, 이비인, 통증의학, 정형, 방광내시경');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (10, '길동', '389-9', '공실', '사무실', '임대인(010 4690 1925)', '2', 13, 0, 1000, 120, 20, '202호, 간판설치 불가, 화장실 복도 남녀공용, 사무실로만 가능');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (11, '길동', '389-2', '뼈찜감자탕', '상가', '임차인(010 2636 6023)', '1', 15, 10000, 5000, 290, 18, '임대인 모름, 천장에어컨2대, 노출천장.주차 가능');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (12, '길동', '378-5', '공실', '상가', '임대인(010 2212 1985)', '1', 30, 0, 20000, 800, 50, '음식점 불가');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (13, '길동', '390-6', '공실', '상가', '임대인(010 6210 0837)', '1', 21, 0, 8000, 550, 40, '음식점, 주차불가, 7월초 부터 입주 가능, 총3개호실로 구분 임차 가능(2개: 6000/400/30 1개:3000/200/15)');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (14, '길동', '431', '공실', '상가 및 사무실', '임대인(010 5222 3045)', '3', 50, 0, 4000, 380, 80, '일반 사무실 및 병의원 가능, 기계식주차(suv가능)');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (15, '길동', '431', '공실', '상가 및 사무실', '임대인(010 5222 3045)', '4', 50, 0, 4000, 380, 80, '일반 사무실 및 병의원 가능, 기계식주차(suv가능)');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (16, '길동', '431', '공실', '상가 및 사무실', '임대인(010 5222 3045)', '6', 50, 0, 4000, 380, 80, '일반 사무실 및 병의원 가능, 기계식주차(suv가능)');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (17, '길동', '431', '공실', '상가 및 사무실', '임대인(010 5222 3045)', '8', 50, 0, 4000, 380, 80, '일반 사무실 및 병의원 가능, 기계식주차(suv가능)');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (18, '길동', '391-2', '공실', '상가 및 사무실', '임대인(010 8885 0592)', '5', 40, 0, 3000, 180, 43, '주차1, 층공용 구분화장실, 사무실 병의원가능, 룸2');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (19, '노고산동', '19-50', '공실', '상가 및 사무실', '사장 0502-4365-3296, 010.5233.2628.', '1', 60, 0, 10000, 770, 0, '주차5, 식당불가, ');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (20, '노고산동', '40-1', '공실', '사무실', '관리인 0502-0486-7829', '3', 56, 0, 5000, 330, 70, '주차1, 엘베유');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (21, '노고산동', '56-14', '공실', '상가', '상가임차인 0502-0269-6825', '1', 15, 2500, 2500, 160, 20, '주차확인, 엘베유');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (22, '노고산동', '106-7', '공실', '사무실', '관리인 0502-0753-3077', '11', 45, 0, 3000, 250, 50, '주차1, 엘베유');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (23, '노고산동', '54-29', '공실', '사무실', '관리인 0502-0121-8811, 010.3242.2348.', '4', 18, 0, 3000, 200, 15, '주차불가, 엘베유');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (24, '노고산동', '57-18', '공실', '상가', '사장 0502-4798-3924, 010.2369.7890.', '2', 15, 0, 2000, 120, 28, '202호, 엘베유, 주차확인, 업종제한없음');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (25, '논현동', '77-8', '공실', '상가', '임대인(010-4047-2333)', '-1', 35, 0, 7700, 763, 99, '주식회사 예인미술소유');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (26, '논현동', '77-8', '공실', '상가', '임대인(010-4047-2333)', '2', 30, 0, 5600, 560, 80, '권리금 1억');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (27, '논현동', '77-8', '공실', '상가', '임대인(010-4047-2333)', '3', 23, 0, 4700, 458, 58, '주식회사 예인미술소유');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (28, '논현동', '77-8', '공실', '상가', '임대인(010-4047-2333)', '4', 15, 0, 3600, 356, 45, '임대인: 신규임차인이 철거하는대신 권리금 조정 요구');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (29, '대현동', '37-12', '공실', '상가', '관리인 0502-4103-3767', '1', 7, 0, 4000, 200, 5, '101호, 주차확인, 엘베유,');
INSERT INTO MINI_SHOP_AND_OFFICE VALUES (30, '대현동', '37-12', '공실', '상가', '관리인 0502-4103-3767', '-1', 26.2, 0, 3000, 180, 20, 'b01호, 주차확인, 엘베유');

COMMIT;
