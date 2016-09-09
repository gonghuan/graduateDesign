/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:03:36
*/

SET FOREIGN_KEY_CHECKS=0;

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
