/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:03:09
*/

SET FOREIGN_KEY_CHECKS=0;

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
