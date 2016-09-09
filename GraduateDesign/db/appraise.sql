/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:02:35
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
