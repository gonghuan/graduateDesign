/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:03:22
*/

SET FOREIGN_KEY_CHECKS=0;

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
