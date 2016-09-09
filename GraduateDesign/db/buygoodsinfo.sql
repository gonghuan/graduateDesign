/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:02:43
*/

SET FOREIGN_KEY_CHECKS=0;

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
