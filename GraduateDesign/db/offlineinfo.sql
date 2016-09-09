/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:03:15
*/

SET FOREIGN_KEY_CHECKS=0;

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
