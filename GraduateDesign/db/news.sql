/*
Navicat MySQL Data Transfer

Source Server         : Graduate
Source Server Version : 50525
Source Host           : 127.0.0.1:3306
Source Database       : graduatedesign

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2015-04-22 10:03:03
*/

SET FOREIGN_KEY_CHECKS=0;

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
