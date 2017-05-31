-----------------------------------------------
-- 20170531
-- Initialize
----------------------------------------------- 

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `itemNo` int(7) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `itemId` char(8) NOT NULL COMMENT '자재 고유번호\n그룹 2,2,2 + 순번 2 ',
  `itemNm` varchar(45) NOT NULL,
  `itemNmKor` varchar(45) NOT NULL,
  `sku` char(11) NOT NULL COMMENT '창고위치 관리번호\n',
  `vendorId` int(7) NOT NULL,
  `price` decimal(15,0) NOT NULL,
  `curCd` char(3) NOT NULL,
  `priceMeta` decimal(15,0) NOT NULL,
  `priceFactory` decimal(15,0) NOT NULL,
  `priceCenter` decimal(15,0) NOT NULL,
  `priceClient` decimal(15,0) NOT NULL,
  `serviceHour` decimal(15,2) NOT NULL,
  `moqVendor` int(11) NOT NULL COMMENT 'minimum order quantity 판매,포장 단위',
  `moqCenter` int(11) NOT NULL COMMENT 'minimum order quantity 판매,포장 단위',
  `requiredStockCnt` int(11) NOT NULL,
  `defectStockCnt` int(11) NOT NULL,
  `linkItem` varchar(500) NOT NULL,
  `linkInvoice` varchar(500) NOT NULL,
  `note` varchar(500) NOT NULL,
  `insertUserId` varchar(15) NOT NULL,
  `insertDatetime` datetime Default CURRENT_TIMESTAMP,
  `updateUserId` varchar(15) NOT NULL,
  `updateDatetime` datetime Default CURRENT_TIMESTAMP,
  UNIQUE KEY `item_id_UNIQUE` (`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

Truncate table item;
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1101, 'KDE4213XF', '브러시리스 모터(반디)', 120000, 144000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1102, 'Prop_1865CW', '18인치 프로펠러(정피치)', 55000, 73000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1103, 'Prop_1865CCW', '18인치 프로펠러(역피치)', 55000, 73000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1104, 'MotorMount', '모터마운트(메타)', 30000, 44000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1105, '25piFolding', '25파이 폴딩부품(메타)', 58000, 72000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1107, 'Motor carbon plate(old)', '모터마운트 플레이트', 7000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1109, 'Tube 25pi 364mm', '25파이 카본튜브 364mm', 14000, 18000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1110, 'Self tightening adapter(CW)', '셀프 타이트닝 어댑터(정피치)', 9000, 11000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1111, 'Self tightening adapter(CCW)', '셀프 타이트닝 어댑터(역피치)', 9000, 11000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1112, 'Holed line(Service)', '연탄용 모터라인', 23000, 30000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1113, 'Motor carbon plate(new)', '모터마운트 플레이트', 7000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1201, 'A1 Top plate(Carbon)', '탑 플레이트(A1)', 320000, 360000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1202, 'Battery tray', '배터리 트레이(22Ah)', 20000, 24000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1203, 'Pushlock Button', '푸쉬락 버튼', 10920, 14400,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1204, 'Pushlock plate(Carbon)', '푸쉬락 플레이트', 8000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1205, 'StandOff(20mm)', '스탠드오프 20mm', 800, 1000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1206, 'StandOff(60mm)', '스탠드오프 60mm', 1600, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1207, 'StandOff(70mm)', '스탠드오프 70mm', 2000, 2500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1208, 'StandOff(5mm)', '스탠드오프 5mm', 300, 500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1210, 'B1 Top plate(Carbon)', '탑 플레이트(B1)', 240000, 270000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1211, 'StandOff(35mm) Dummy', '', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1212, 'GPS mount', 'GPS 마운트', 10000, 12000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1213, 'GPS direction mount(Carbon)', 'GPS 디렉션 마운트', 10000, 12000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1402, 'Canopy holder(m3)', '캐노피 홀더(m3)', 7000, 8000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1403, 'Canopy holder(m4)', '캐노피 홀더(m4)', 7000, 8000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1404, 'Arm holder mount', '암 홀더 마운트(알루미늄)', 16000, 20000,0.3);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1405, 'Arm holder', '25파이 튜브홀더(플라스틱)', 1000, 1200,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1406, 'A1 Base plate(carbon)', '베이스 플레이트(A1)', 320000, 360000,4);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1407, 'Lidar cover plate(carbon)', '라이다 커버 플레이트', 5000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1408, '25pi tube 300mm (carbon)', '25파이 카본튜브 300mm', 12000, 15000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1409, '25pi tube 264mm (carbon)', '25파이 카본튜브 264mm', 12000, 15000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1410, '25mm clamp(aluminium)', '25파이 클램프(오메가)', 3000, 4000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1411, 'StandOff(25mm)', '스탠드오프 25mm', 800, 1000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1412, 'StandOff(35mm)', '스탠드오프 35mm', 1000, 1200,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1413, 'StandOff(40mm)', '스탠드오프 40mm', 1200, 1400,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1414, 'Power Holder(complex)', '파워홀더 베이스 플레이트 (3D)', 3000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1415, 'Power holder plate(carbon)', '파워홀더 탑 플레이트', 1500, 2000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1416, 'Rubber Cap (25pi)', '25파이 엔드캡(러버캡)', 200, 500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1417, 'Hour meter(LE8N-BV)', '적산시간계(A1)', 30000, 36000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1419, '20pi clamp', '20파이 클램프(오메가)', 2700, 3100,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1420, 'B1 Base plate(carbon)', '베이스 플레이트(B1)', 240000, 280000,4);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1421, '20pi tube 210mm', '20파이 카본튜브 210mm', 14000, 19000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1422, '20pi tube 237mm', '20파이 카본튜브 237mm', 15000, 20000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1423, 'StandOff(15mm)', '스탠드오프 15mm', 1000, 1500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1424, 'Rubber Cap (20pi)', '20파이 엔드캡(러버캡)', 1000, 1500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1425, 'Hour meter(RL-HM010A)', '적산시간계(B1)', 35000, 40000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1426, 'Elbow clamp(20-25)', '앨보 클램프 20-25', 35000, 45000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1501, 'A1 Cover plate (carbon)', '커버 플레이트(A1)', 200000, 220000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1503, 'Hour meter plate (carbon)', '적산시간계 커버 플레이트', 2500, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1504, 'A1 sign aluminium', '농업기계 형식표지판(A1)', 1500, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1505, 'B1 sign aluminium', '농업기계 형식표지판(B1)', 1500, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1601, 'Landing - LEG', '랜딩 다릿발(알루미늄)', 100000, 130000,2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1602, 'Landing S', '랜딩 물통고정 봉(알루미늄)', 15000, 20000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1603, 'Landing L', '랜딩 노즐봉(알루미늄)', 15000, 20000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1604, 'Landing Tank(L)', '랜딩 약제통 고정부(알루미세트)', 18000, 21000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1605, 'Pump plate(carbon)', '펌프 플레이트(A1)', 7000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1606, 'Pump', '펌프(A1)', 45000, 55000,0.3);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1607, 'Rubber Cap(16pi)', '16파이 엔드캡(러버캡)', 200, 300,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1608, 'Landing - LEG(Carbon)', '랜딩다리(카본)', 50000, 65000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1609, 'Landing Tank(S)', '랜딩 약제통 고정부(알루미세트)', 7000, 9000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1610, '20pi tube 600mm', '20파이 카본튜브 600mm', 30000, 40000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1611, 'Tank cage (A1)', '탱크 케이지(A1)', 210000, 260000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1612, 'Tank cage (B1)', '탱크 케이지(B1)', 210000, 260000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1651, 'Rod-C-20x600', '20파이 카본튜브 600mm', 30000, 40000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1652, 'Rod-C-20x264', '20파이 카본튜브 264mm', 15000, 19000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1653, 'Rod-C-20x296', '20파이 카본튜브 296mm', 16000, 20000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1654, 'Rod-C-25x264', '25파이 카본튜브 264mm', 12000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1655, 'Rod-C-25x296', '25파이 카본튜브 296mm', 15000, 19000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1656, 'Rod-C-20x210', '20파이 카본튜브 210mm', 13000, 17000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1657, 'Rod-C-20x237', '20파이 카본튜브 237mm', 14000, 18000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1658, 'Rod-C-20x319', '20파이 카본튜브 319mm', 17500, 23000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1659, 'Rod-C-20x652', '20파이 카본튜브 652mm', 32000, 42000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1701, 'CanopyA1-body', '캐노피 바디(A1)', 120000, 140000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1702, 'CanopyA1-cap', '캐노피 뚜껑(A1)', 30000, 40000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1703, 'CanopyA1-Hinge(Plastic)', '캐노피 경첩(A1) 플라스틱', 1000, 1200,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1704, 'Canopy-Hinge(Steel)', '캐노피 경첩(B1) 철제', 1000, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1705, 'pipe holder(16pi)', '16파이 튜브홀더(플라스틱)', 400, 600,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1706, 'CanopyB1-body', '캐노피 바디(B1)', 130000, 150000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1707, 'CanopyB1-cap', '캐노피 뚜껑(B1)', 40000, 50000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3101, 'ESC', '변속기(60A)', 70000, 80000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3103, 'PDB', '전원 분배보드(320A)', 40000, 50000,3);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3104, 'Power wire(Black)', '전원선(PDB/흑)', 5000, 5000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3105, 'Power wire(Red)', '전원선(PDB/적)', 5000, 5000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3106, 'Power Module', '파워모듈(A1)', 12000, 15000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3108, 'Servo-Y-cable', '서보 Y케이블', 1200, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3109, 'm3-pressed', '압착단자 M3', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3110, 'A1 ESC plate(carbon)', '변속기 플레이트(A1)', 110000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3111, 'USB+Telemetry cable', '메인터넌스 케이블(세트)', 2000, 3000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3112, 'StandOff(5mm) - pla', '스탠드오프 5mm(플라스틱)', 90, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3113, 'StandOff(7mm) - pla', '스탠드오프 7mm(플라스틱)', 100, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3114, 'Plastic bolt 25mm', 'm3 25mm (플라스틱)', 120, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3115, 'Heat sink cutting', '방열판 절단 공임', 300, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3116, 'B1 ESC plate(carbon)', '변속기 플레이트(B1)', 95000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3202, 'Pump BEC(12v)', '펌프 BEC(5V)', 22000, 27000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3203, 'Rx BEC(5v)', '수신기 BEC(5V)', 18000, 23000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3204, 'Pump ESC', '펌프 변속기(A1)', 19000, 24000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3205, 'Pump Power Cable', '전원선 (펌프)', 7000, 9000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3301, 'Switch mount(aluminium)', '스위치 마운트(alloy)', 24000, 30000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3302, 'Switch button', '파워 버튼', 800, 1000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3303, 'Indicator LED(set)', '인디케이터 LED(1쌍)', 8000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3304, 'Tail LED(L)', '테일 램프(A1)', 6000, 8000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3305, 'RGB led board', 'LED 보드(RGB)', 8000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3306, 'Servo cable(100mm)', '서보 케이블(100mm)', 500, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3309, 'Tail LED(S)', '테일 램프(B1)', 5500, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3402, 'Teensy3.2', '틴지 텔레메트리', 50000, 60000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3405, 'Battery 1700mAh', '1.7Ah 배터리 (송신기)', 14000, 20000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3406, 'Radio Battery charge wire', '충전선 (송신기)', 4000, 5000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3407, 'radio case(DWALT)', '조종기 보관함', 42000, 45000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3408, 'radio case sponge', '스폰지(조종기 보관함)', 15000, 18000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3409, 'Taranis X9D plus', '송신기 (타라니스)', 300000, 350000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3410, 'X8R receiver', '수신기 (X8R)', 47000, 53000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3411, 'Receiver antenna', '수신기 안테나', 5000, 7000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3412, 'Battery 2500mAh', '2.5Ah 배터리(송신기)', 13800, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3413, 'Battery 1000mAh', '1Ah 배터리(송신기)', 5520, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3501, 'Power-Supply', '충전기 전원공급기', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3502, 'Graupner charger', '그라프너 충전기', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3503, 'Assembly kit(aluminium) top', '충전기 조립 키트(윗면)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3504, 'Assembly kit(aluminium) back', '충전기 조립 키트(뒷면)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3505, 'Charger Hole cap', '충전기 홀 캡', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3506, '22000mAh battery charge wire(black)', '22Ah 배터리 충전선(흑)', 5000, 7000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3507, '22000mAh battery charge wire(red)', '22Ah 배터리 충전선(적)', 5000, 7000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6101, 'Spray folding parts(old)', '16파이 스프레이 폴딩부품(구형)', 42000, 49000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6102, 'elbow clamp(16-16)', '앨보 클램프 16-16', 20000, 24000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6103, 'Teejet Knozzle (body+cap)', '노즐 바디', 24000, 28000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6104, 'Teejet Knozzle filter', '노즐 필터(거름망)', 3600, 4200,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6105, 'Teejet Knozzle tip', '노즐 팁(110도)', 10000, 12000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6106, 'Tube 16pi 320mm', '16파이 카본튜브 320mm', 9000, 12000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6107, 'Tube 16pi 280mm', '16파이 카본튜브 280mm', 9000, 12000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6108, 'Tube 16pi 330mm', '16파이 카본튜브 330mm', 9000, 12000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6109, 'Fitting-T black-8mm', '휘팅 T 8mm', 1000, 1500,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6110, 'Fitting-T white-8mm', '휘팅 이경T 8mm-1/4인치', 1300, 2000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6111, 'Fitting valve blue-8mm', '휘팅 밸브 8mm', 3600, 4200,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6112, '16pi clamp', '16파이 클램프(오메가)', 2500, 3000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6113, '25-16 clamp', '앨보 클램프 25-16', 35000, 45000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6114, 'Tank Tie A1', '탱크 타이(러버밴드) A1', 7000, 10000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6115, 'Spray folding parts(new)', '16파이 스프레이 폴딩부품(신형)', 65000, 75000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6116, 'elbow clamp(20-20)', '앨보 클램프 20-20', 20000, 25000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6117, 'Tarot 16pi folding Black', '타롯 16파이 폴딩(검정)', 1000, 1400,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6118, 'Spray knozzle plate(carbon)', '스프레이 노즐 플레이트', 2000, 3000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6120, 'Tank Tie (B1-front)', '탱크 타이(러버밴드) B1 앞면', 9000, 11000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6121, 'Tank Tie (B1-top)', '탱크 타이(러버밴드) B1 윗면', 10000, 12000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6122, 'Spray Bent Tube 16mm ', '16파이 스프레이 벤트 튜브', 45000, 55000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6201, 'Seeder (Body)', '입제살포기 바디', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6202, 'HS5464WP Servo', '입제살포기 서보', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6203, 'Servo Set Screw Shaft Coupler (1/4inch, 24tooth)', '입제살포기 커플러', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6204, 'Servo Shaft (Alloy)', '서보 샤프트', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6205, 'Solid tank holder (front)', '솔리드 탱크 홀더(앞면)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6206, 'Solid tank holder (back)', '솔리드 탱크 홀더(뒷면)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6207, 'Solid tank holder (side)', '솔리드 탱크 홀더(옆면)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6208, 'Tank', '입제살포기 탱크', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6301, '순차식 충전기용 전용함체', '순차식 충전기용 전용함체', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6302, '순차식 충전기', '순차식 충전기', 5000000, 5000000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(7101, 'Pixhawk', '픽스호크(반디)', 660000, 800000,4);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(7102, 'GPS', 'GPS', 120000, 140000,2);
