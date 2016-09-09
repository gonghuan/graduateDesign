/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:03:30
*/

SET FOREIGN_KEY_CHECKS=0;

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
