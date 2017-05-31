-----------------------------------------------
-- 20170531
-- Initialize
----------------------------------------------- 

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `itemNo` int(7) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `itemId` char(8) NOT NULL COMMENT '���� ������ȣ\n�׷� 2,2,2 + ���� 2 ',
  `itemNm` varchar(45) NOT NULL,
  `itemNmKor` varchar(45) NOT NULL,
  `sku` char(11) NOT NULL COMMENT 'â����ġ ������ȣ\n',
  `vendorId` int(7) NOT NULL,
  `price` decimal(15,0) NOT NULL,
  `curCd` char(3) NOT NULL,
  `priceMeta` decimal(15,0) NOT NULL,
  `priceFactory` decimal(15,0) NOT NULL,
  `priceCenter` decimal(15,0) NOT NULL,
  `priceClient` decimal(15,0) NOT NULL,
  `serviceHour` decimal(15,2) NOT NULL,
  `moqVendor` int(11) NOT NULL COMMENT 'minimum order quantity �Ǹ�,���� ����',
  `moqCenter` int(11) NOT NULL COMMENT 'minimum order quantity �Ǹ�,���� ����',
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
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1101, 'KDE4213XF', '�귯�ø��� ����(�ݵ�)', 120000, 144000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1102, 'Prop_1865CW', '18��ġ �����緯(����ġ)', 55000, 73000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1103, 'Prop_1865CCW', '18��ġ �����緯(����ġ)', 55000, 73000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1104, 'MotorMount', '���͸���Ʈ(��Ÿ)', 30000, 44000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1105, '25piFolding', '25���� ������ǰ(��Ÿ)', 58000, 72000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1107, 'Motor carbon plate(old)', '���͸���Ʈ �÷���Ʈ', 7000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1109, 'Tube 25pi 364mm', '25���� ī��Ʃ�� 364mm', 14000, 18000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1110, 'Self tightening adapter(CW)', '���� Ÿ��Ʈ�� �����(����ġ)', 9000, 11000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1111, 'Self tightening adapter(CCW)', '���� Ÿ��Ʈ�� �����(����ġ)', 9000, 11000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1112, 'Holed line(Service)', '��ź�� ���Ͷ���', 23000, 30000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1113, 'Motor carbon plate(new)', '���͸���Ʈ �÷���Ʈ', 7000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1201, 'A1 Top plate(Carbon)', 'ž �÷���Ʈ(A1)', 320000, 360000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1202, 'Battery tray', '���͸� Ʈ����(22Ah)', 20000, 24000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1203, 'Pushlock Button', 'Ǫ���� ��ư', 10920, 14400,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1204, 'Pushlock plate(Carbon)', 'Ǫ���� �÷���Ʈ', 8000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1205, 'StandOff(20mm)', '���ĵ���� 20mm', 800, 1000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1206, 'StandOff(60mm)', '���ĵ���� 60mm', 1600, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1207, 'StandOff(70mm)', '���ĵ���� 70mm', 2000, 2500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1208, 'StandOff(5mm)', '���ĵ���� 5mm', 300, 500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1210, 'B1 Top plate(Carbon)', 'ž �÷���Ʈ(B1)', 240000, 270000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1211, 'StandOff(35mm) Dummy', '', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1212, 'GPS mount', 'GPS ����Ʈ', 10000, 12000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1213, 'GPS direction mount(Carbon)', 'GPS �𷺼� ����Ʈ', 10000, 12000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1402, 'Canopy holder(m3)', 'ĳ���� Ȧ��(m3)', 7000, 8000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1403, 'Canopy holder(m4)', 'ĳ���� Ȧ��(m4)', 7000, 8000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1404, 'Arm holder mount', '�� Ȧ�� ����Ʈ(�˷�̴�)', 16000, 20000,0.3);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1405, 'Arm holder', '25���� Ʃ��Ȧ��(�ö�ƽ)', 1000, 1200,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1406, 'A1 Base plate(carbon)', '���̽� �÷���Ʈ(A1)', 320000, 360000,4);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1407, 'Lidar cover plate(carbon)', '���̴� Ŀ�� �÷���Ʈ', 5000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1408, '25pi tube 300mm (carbon)', '25���� ī��Ʃ�� 300mm', 12000, 15000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1409, '25pi tube 264mm (carbon)', '25���� ī��Ʃ�� 264mm', 12000, 15000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1410, '25mm clamp(aluminium)', '25���� Ŭ����(���ް�)', 3000, 4000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1411, 'StandOff(25mm)', '���ĵ���� 25mm', 800, 1000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1412, 'StandOff(35mm)', '���ĵ���� 35mm', 1000, 1200,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1413, 'StandOff(40mm)', '���ĵ���� 40mm', 1200, 1400,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1414, 'Power Holder(complex)', '�Ŀ�Ȧ�� ���̽� �÷���Ʈ (3D)', 3000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1415, 'Power holder plate(carbon)', '�Ŀ�Ȧ�� ž �÷���Ʈ', 1500, 2000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1416, 'Rubber Cap (25pi)', '25���� ����ĸ(����ĸ)', 200, 500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1417, 'Hour meter(LE8N-BV)', '����ð���(A1)', 30000, 36000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1419, '20pi clamp', '20���� Ŭ����(���ް�)', 2700, 3100,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1420, 'B1 Base plate(carbon)', '���̽� �÷���Ʈ(B1)', 240000, 280000,4);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1421, '20pi tube 210mm', '20���� ī��Ʃ�� 210mm', 14000, 19000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1422, '20pi tube 237mm', '20���� ī��Ʃ�� 237mm', 15000, 20000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1423, 'StandOff(15mm)', '���ĵ���� 15mm', 1000, 1500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1424, 'Rubber Cap (20pi)', '20���� ����ĸ(����ĸ)', 1000, 1500,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1425, 'Hour meter(RL-HM010A)', '����ð���(B1)', 35000, 40000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1426, 'Elbow clamp(20-25)', '�ٺ� Ŭ���� 20-25', 35000, 45000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1501, 'A1 Cover plate (carbon)', 'Ŀ�� �÷���Ʈ(A1)', 200000, 220000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1503, 'Hour meter plate (carbon)', '����ð��� Ŀ�� �÷���Ʈ', 2500, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1504, 'A1 sign aluminium', '������ ����ǥ����(A1)', 1500, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1505, 'B1 sign aluminium', '������ ����ǥ����(B1)', 1500, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1601, 'Landing - LEG', '���� �ٸ���(�˷�̴�)', 100000, 130000,2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1602, 'Landing S', '���� ������� ��(�˷�̴�)', 15000, 20000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1603, 'Landing L', '���� �����(�˷�̴�)', 15000, 20000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1604, 'Landing Tank(L)', '���� ������ ������(�˷�̼�Ʈ)', 18000, 21000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1605, 'Pump plate(carbon)', '���� �÷���Ʈ(A1)', 7000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1606, 'Pump', '����(A1)', 45000, 55000,0.3);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1607, 'Rubber Cap(16pi)', '16���� ����ĸ(����ĸ)', 200, 300,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1608, 'Landing - LEG(Carbon)', '�����ٸ�(ī��)', 50000, 65000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1609, 'Landing Tank(S)', '���� ������ ������(�˷�̼�Ʈ)', 7000, 9000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1610, '20pi tube 600mm', '20���� ī��Ʃ�� 600mm', 30000, 40000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1611, 'Tank cage (A1)', '��ũ ������(A1)', 210000, 260000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1612, 'Tank cage (B1)', '��ũ ������(B1)', 210000, 260000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1651, 'Rod-C-20x600', '20���� ī��Ʃ�� 600mm', 30000, 40000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1652, 'Rod-C-20x264', '20���� ī��Ʃ�� 264mm', 15000, 19000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1653, 'Rod-C-20x296', '20���� ī��Ʃ�� 296mm', 16000, 20000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1654, 'Rod-C-25x264', '25���� ī��Ʃ�� 264mm', 12000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1655, 'Rod-C-25x296', '25���� ī��Ʃ�� 296mm', 15000, 19000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1656, 'Rod-C-20x210', '20���� ī��Ʃ�� 210mm', 13000, 17000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1657, 'Rod-C-20x237', '20���� ī��Ʃ�� 237mm', 14000, 18000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1658, 'Rod-C-20x319', '20���� ī��Ʃ�� 319mm', 17500, 23000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1659, 'Rod-C-20x652', '20���� ī��Ʃ�� 652mm', 32000, 42000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1701, 'CanopyA1-body', 'ĳ���� �ٵ�(A1)', 120000, 140000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1702, 'CanopyA1-cap', 'ĳ���� �Ѳ�(A1)', 30000, 40000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1703, 'CanopyA1-Hinge(Plastic)', 'ĳ���� ��ø(A1) �ö�ƽ', 1000, 1200,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1704, 'Canopy-Hinge(Steel)', 'ĳ���� ��ø(B1) ö��', 1000, 2000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1705, 'pipe holder(16pi)', '16���� Ʃ��Ȧ��(�ö�ƽ)', 400, 600,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1706, 'CanopyB1-body', 'ĳ���� �ٵ�(B1)', 130000, 150000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(1707, 'CanopyB1-cap', 'ĳ���� �Ѳ�(B1)', 40000, 50000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3101, 'ESC', '���ӱ�(60A)', 70000, 80000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3103, 'PDB', '���� �й躸��(320A)', 40000, 50000,3);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3104, 'Power wire(Black)', '������(PDB/��)', 5000, 5000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3105, 'Power wire(Red)', '������(PDB/��)', 5000, 5000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3106, 'Power Module', '�Ŀ����(A1)', 12000, 15000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3108, 'Servo-Y-cable', '���� Y���̺�', 1200, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3109, 'm3-pressed', '�������� M3', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3110, 'A1 ESC plate(carbon)', '���ӱ� �÷���Ʈ(A1)', 110000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3111, 'USB+Telemetry cable', '�����ͳͽ� ���̺�(��Ʈ)', 2000, 3000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3112, 'StandOff(5mm) - pla', '���ĵ���� 5mm(�ö�ƽ)', 90, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3113, 'StandOff(7mm) - pla', '���ĵ���� 7mm(�ö�ƽ)', 100, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3114, 'Plastic bolt 25mm', 'm3 25mm (�ö�ƽ)', 120, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3115, 'Heat sink cutting', '�濭�� ���� ����', 300, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3116, 'B1 ESC plate(carbon)', '���ӱ� �÷���Ʈ(B1)', 95000, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3202, 'Pump BEC(12v)', '���� BEC(5V)', 22000, 27000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3203, 'Rx BEC(5v)', '���ű� BEC(5V)', 18000, 23000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3204, 'Pump ESC', '���� ���ӱ�(A1)', 19000, 24000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3205, 'Pump Power Cable', '������ (����)', 7000, 9000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3301, 'Switch mount(aluminium)', '����ġ ����Ʈ(alloy)', 24000, 30000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3302, 'Switch button', '�Ŀ� ��ư', 800, 1000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3303, 'Indicator LED(set)', '�ε������� LED(1��)', 8000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3304, 'Tail LED(L)', '���� ����(A1)', 6000, 8000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3305, 'RGB led board', 'LED ����(RGB)', 8000, 10000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3306, 'Servo cable(100mm)', '���� ���̺�(100mm)', 500, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3309, 'Tail LED(S)', '���� ����(B1)', 5500, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3402, 'Teensy3.2', 'ƾ�� �ڷ���Ʈ��', 50000, 60000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3405, 'Battery 1700mAh', '1.7Ah ���͸� (�۽ű�)', 14000, 20000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3406, 'Radio Battery charge wire', '������ (�۽ű�)', 4000, 5000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3407, 'radio case(DWALT)', '������ ������', 42000, 45000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3408, 'radio case sponge', '������(������ ������)', 15000, 18000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3409, 'Taranis X9D plus', '�۽ű� (Ÿ��Ͻ�)', 300000, 350000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3410, 'X8R receiver', '���ű� (X8R)', 47000, 53000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3411, 'Receiver antenna', '���ű� ���׳�', 5000, 7000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3412, 'Battery 2500mAh', '2.5Ah ���͸�(�۽ű�)', 13800, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3413, 'Battery 1000mAh', '1Ah ���͸�(�۽ű�)', 5520, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3501, 'Power-Supply', '������ �������ޱ�', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3502, 'Graupner charger', '�׶����� ������', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3503, 'Assembly kit(aluminium) top', '������ ���� ŰƮ(����)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3504, 'Assembly kit(aluminium) back', '������ ���� ŰƮ(�޸�)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3505, 'Charger Hole cap', '������ Ȧ ĸ', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3506, '22000mAh battery charge wire(black)', '22Ah ���͸� ������(��)', 5000, 7000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(3507, '22000mAh battery charge wire(red)', '22Ah ���͸� ������(��)', 5000, 7000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6101, 'Spray folding parts(old)', '16���� �������� ������ǰ(����)', 42000, 49000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6102, 'elbow clamp(16-16)', '�ٺ� Ŭ���� 16-16', 20000, 24000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6103, 'Teejet Knozzle (body+cap)', '���� �ٵ�', 24000, 28000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6104, 'Teejet Knozzle filter', '���� ����(�Ÿ���)', 3600, 4200,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6105, 'Teejet Knozzle tip', '���� ��(110��)', 10000, 12000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6106, 'Tube 16pi 320mm', '16���� ī��Ʃ�� 320mm', 9000, 12000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6107, 'Tube 16pi 280mm', '16���� ī��Ʃ�� 280mm', 9000, 12000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6108, 'Tube 16pi 330mm', '16���� ī��Ʃ�� 330mm', 9000, 12000,0.5);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6109, 'Fitting-T black-8mm', '���� T 8mm', 1000, 1500,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6110, 'Fitting-T white-8mm', '���� �̰�T 8mm-1/4��ġ', 1300, 2000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6111, 'Fitting valve blue-8mm', '���� ��� 8mm', 3600, 4200,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6112, '16pi clamp', '16���� Ŭ����(���ް�)', 2500, 3000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6113, '25-16 clamp', '�ٺ� Ŭ���� 25-16', 35000, 45000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6114, 'Tank Tie A1', '��ũ Ÿ��(�������) A1', 7000, 10000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6115, 'Spray folding parts(new)', '16���� �������� ������ǰ(����)', 65000, 75000,1);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6116, 'elbow clamp(20-20)', '�ٺ� Ŭ���� 20-20', 20000, 25000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6117, 'Tarot 16pi folding Black', 'Ÿ�� 16���� ����(����)', 1000, 1400,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6118, 'Spray knozzle plate(carbon)', '�������� ���� �÷���Ʈ', 2000, 3000,0.2);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6120, 'Tank Tie (B1-front)', '��ũ Ÿ��(�������) B1 �ո�', 9000, 11000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6121, 'Tank Tie (B1-top)', '��ũ Ÿ��(�������) B1 ����', 10000, 12000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6122, 'Spray Bent Tube 16mm ', '16���� �������� ��Ʈ Ʃ��', 45000, 55000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6201, 'Seeder (Body)', '���������� �ٵ�', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6202, 'HS5464WP Servo', '���������� ����', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6203, 'Servo Set Screw Shaft Coupler (1/4inch, 24tooth)', '���������� Ŀ�÷�', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6204, 'Servo Shaft (Alloy)', '���� ����Ʈ', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6205, 'Solid tank holder (front)', '�ָ��� ��ũ Ȧ��(�ո�)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6206, 'Solid tank holder (back)', '�ָ��� ��ũ Ȧ��(�޸�)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6207, 'Solid tank holder (side)', '�ָ��� ��ũ Ȧ��(����)', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6208, 'Tank', '���������� ��ũ', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6301, '������ ������� ������ü', '������ ������� ������ü', 0, 0,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(6302, '������ ������', '������ ������', 5000000, 5000000,0);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(7101, 'Pixhawk', '�Ƚ�ȣũ(�ݵ�)', 660000, 800000,4);
insert into item(itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour) values(7102, 'GPS', 'GPS', 120000, 140000,2);
