/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:02:50
*/

SET FOREIGN_KEY_CHECKS=0;

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
