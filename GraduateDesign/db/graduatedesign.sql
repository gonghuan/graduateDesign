/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:02:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for appraise
-- ----------------------------
DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise` (
  `GoodsId` bigint(12) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `AppMark` int(4) NOT NULL,
  `AppContent` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`GoodsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appraise
-- ----------------------------

-- ----------------------------
-- Table structure for buygoodsinfo
-- ----------------------------
DROP TABLE IF EXISTS `buygoodsinfo`;
CREATE TABLE `buygoodsinfo` (
  `GoodsId` bigint(12) NOT NULL,
  `BuyUserName` varchar(50) NOT NULL,
  `SailUserName` varchar(50) NOT NULL,
  `GoodsName` varchar(50) NOT NULL,
  `BuyPrice` decimal(12,0) NOT NULL,
  `BuyCount` int(4) NOT NULL,
  `BuyTime` datetime NOT NULL,
  `SendAddress` varchar(250) NOT NULL,
  `SendFashion` varchar(50) NOT NULL,
  `isSucc` bit(1) NOT NULL,
  PRIMARY KEY (`GoodsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of buygoodsinfo
-- ----------------------------

-- ----------------------------
-- Table structure for goodsinfo
-- ----------------------------
DROP TABLE IF EXISTS `goodsinfo`;
CREATE TABLE `goodsinfo` (
  `GoodsId` bigint(12) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `GoodsName` varchar(50) NOT NULL,
  `GoodsDescription` varchar(250) DEFAULT NULL,
  `BeginPrice` decimal(12,0) NOT NULL,
  `ImagePath` varchar(100) DEFAULT NULL,
  `Amount` int(4) NOT NULL,
  `BeginTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `UserId` bigint(12) unsigned zerofill NOT NULL,
  PRIMARY KEY (`GoodsId`),
  KEY `foreignKey1` (`UserId`),
  CONSTRAINT `foreignKey1` FOREIGN KEY (`UserId`) REFERENCES `userinfo` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodsinfo
-- ----------------------------
INSERT INTO `goodsinfo` VALUES ('000000000001', '正宗宜兴紫砂壶', null, '1000', null, '1', '2015-03-28 18:24:56', '2015-03-31 18:25:07', '100000000000');
INSERT INTO `goodsinfo` VALUES ('000000000002', 'iphone4', '全新', '700', 'goodsTmp/1428490680682.jpg', '2', '2015-03-31 00:00:00', '2015-04-03 00:00:00', '100000000000');
INSERT INTO `goodsinfo` VALUES ('000000000003', 'iphone4S', '保证全新', '1200', 'goodsTmp/1428490680682.jpg', '4', '2015-04-01 00:00:00', '2015-04-04 00:00:00', '100000000000');
INSERT INTO `goodsinfo` VALUES ('000000000004', 'spark大数据处理：技术、应用与性能优化', '', '15', 'goodsTmp/1429505558115.jpg', '2', '2015-04-20 00:52:30', '2015-04-24 00:52:32', '100000000000');

-- ----------------------------
-- Table structure for leavewords
-- ----------------------------
DROP TABLE IF EXISTS `leavewords`;
CREATE TABLE `leavewords` (
  `GoodsId` bigint(12) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Content` varchar(250) NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`GoodsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of leavewords
-- ----------------------------

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `newsId` bigint(12) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `time` date NOT NULL,
  `context` varchar(500) NOT NULL,
  `href` varchar(500) NOT NULL,
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('000000000001', '2015-04-09', '英格兰足球队败仗纪念碑伦敦拍卖 拍得60万英镑', 'http://www.paiorg.com/app/252-view-39142.shtml');
INSERT INTO `news` VALUES ('000000000002', '2015-04-07', '中国在线拍卖发展渐趋成熟', 'http://www.paiorg.com/app/252-view-39146.shtml');
INSERT INTO `news` VALUES ('000000000003', '2015-04-11', '刘益谦王薇夫妇现身佳士得 3.48亿港元全球最贵唐卡正式交接', 'http://www.paiorg.com/app/252-view-39158.shtml');
INSERT INTO `news` VALUES ('000000000004', '2015-04-02', '美国稀有钱币收藏或刷新拍卖纪录', 'http://www.paiorg.com/app/252-view-39104.shtml');
INSERT INTO `news` VALUES ('000000000005', '2015-04-10', '从2015(上海)第十三届投资理财金融博览会看： 艺术品移动电商路在何方', 'http://auction.meishujia.cn/?act=app&appid=8&mid=39878&p=view');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `noticeId` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `time` date NOT NULL,
  `context` varchar(500) NOT NULL,
  `href` varchar(500) NOT NULL,
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES ('00000001', '2015-04-11', '在线拍卖网预期开始运营时间为2015年6月28日', '#');
INSERT INTO `notice` VALUES ('00000004', '2015-04-11', '拍卖会名称：房地产-四川国联拍卖有限公司', 'http://www.caa123.org.cn/frontAfficheNoticeAction.do?method=queryAfficheNoticeDetails&keys=87393');

-- ----------------------------
-- Table structure for offlineinfo
-- ----------------------------
DROP TABLE IF EXISTS `offlineinfo`;
CREATE TABLE `offlineinfo` (
  `id` bigint(12) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `previewName` varchar(100) NOT NULL,
  `previewBegin` date NOT NULL,
  `previewEnd` date NOT NULL,
  `previewProvince` varchar(30) NOT NULL,
  `previewLocate` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `time` datetime NOT NULL,
  `locate` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of offlineinfo
-- ----------------------------
INSERT INTO `offlineinfo` VALUES ('000000000002', '谷云轩2015年春季艺术品拍卖会', '2015-04-17', '2015-04-17', '福建', '厦门磐基皇冠假日酒店三楼宴会厅（厦门市嘉禾路199号）', '谷云轩2015年春季艺术品拍卖会', '2015-04-18 16:00:00', '厦门磐基皇冠假日酒店三楼宴会厅（厦门市嘉禾路199号）');

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `id` int(8) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sex` char(1) NOT NULL,
  `nation` varchar(10) NOT NULL,
  `origin` varchar(20) NOT NULL,
  `birthday` date NOT NULL,
  `IsMarried` char(1) NOT NULL,
  `identification` varchar(20) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  `entry` date NOT NULL,
  `department` varchar(50) NOT NULL,
  `position` varchar(50) NOT NULL,
  `priority` int(1) unsigned NOT NULL,
  `imagePath` varchar(500) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('00000001', '贡欢', '男', '汉', '江苏 镇江', '1993-10-05', '否', '321181199310057476', '18233562573', '东北大学秦皇岛分校', '2014-10-01', '董事会', '董事长', '1', 'abc', '1131474643@qq.com', 'gh123456');
INSERT INTO `staff` VALUES ('00000002', '郑冰', '男', '汉', '江苏 镇江', '1992-10-22', '否', '321181199310057476', '18233563106', '东北大学秦皇岛分校41106班', '2014-10-31', '系统管理部', '部门经理', '1', '../staffImg/1429192082248.jpg', '1234567890@qq.com', 'zb123456');

-- ----------------------------
-- Table structure for tempgoods
-- ----------------------------
DROP TABLE IF EXISTS `tempgoods`;
CREATE TABLE `tempgoods` (
  `GoodsId` bigint(12) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `GoodsName` varchar(50) NOT NULL,
  `GoodsDescription` varchar(250) DEFAULT NULL,
  `BeginPrice` decimal(12,0) NOT NULL,
  `ImagePath` varchar(100) DEFAULT NULL,
  `Amount` int(4) NOT NULL,
  `BeginTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `UserId` bigint(12) unsigned zerofill NOT NULL,
  PRIMARY KEY (`GoodsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tempgoods
-- ----------------------------

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `UserId` bigint(12) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Telephone` varchar(50) NOT NULL,
  `eMail` varchar(50) NOT NULL,
  `TruName` varchar(50) NOT NULL,
  `Address` varchar(250) NOT NULL,
  `PostBoy` varchar(20) NOT NULL,
  `PassHint` varchar(250) DEFAULT NULL,
  `ImagePath` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000000015 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('100000000000', '海贼王殿下', 'gh123456', '18233562573', '1131474643@qq.com', '贡欢', '东北大学秦皇岛分校41103班', '066004', '真名加123456', 'tmp/1429600442469.jpg');
INSERT INTO `userinfo` VALUES ('1000000000014', '玄霄', 'xx123456', '18233561234', '1234567890@qq.com', '云天河', '东北大学秦皇岛分校', '066004', '姓名+123456', null);
