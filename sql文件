/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50132
Source Host           : localhost:3306
Source Database       : sssp

Target Server Type    : MYSQL
Target Server Version : 50132
File Encoding         : 65001

Date: 2019-08-02 15:12:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_class`
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `major_id` int(6) DEFAULT NULL,
  `class_name` varchar(30) DEFAULT NULL,
  `class_date` date DEFAULT NULL,
  `class_time` varchar(30) DEFAULT NULL,
  `class_address` varchar(30) DEFAULT NULL,
  `class_delete` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_major_id_01` (`major_id`),
  CONSTRAINT `FK_major_id_01` FOREIGN KEY (`major_id`) REFERENCES `t_major` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_class
-- ----------------------------
INSERT INTO `t_class` VALUES ('1', '1', '物联网01班', '2019-08-08', '50', '19楼1教室', '0');
INSERT INTO `t_class` VALUES ('2', '2', '商务外语1班', '2019-08-07', '60', '19楼2教室', '0');

-- ----------------------------
-- Table structure for `t_depart`
-- ----------------------------
DROP TABLE IF EXISTS `t_depart`;
CREATE TABLE `t_depart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `createtime` date DEFAULT NULL,
  `del` int(14) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_depart
-- ----------------------------
INSERT INTO `t_depart` VALUES ('1', '教学部', '2018-06-27', '0');
INSERT INTO `t_depart` VALUES ('2', '就业部', '2018-06-27', '0');

-- ----------------------------
-- Table structure for `t_emp`
-- ----------------------------
DROP TABLE IF EXISTS `t_emp`;
CREATE TABLE `t_emp` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `no` varchar(20) DEFAULT NULL,
  `pass` varchar(200) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `did` int(11) DEFAULT NULL COMMENT '外键  部门ID',
  `flag` int(11) DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `del` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DID` (`did`),
  CONSTRAINT `FK_DID` FOREIGN KEY (`did`) REFERENCES `t_depart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_emp
-- ----------------------------
INSERT INTO `t_emp` VALUES ('1', 'qf000001', null, '张三', '1', '1', '男', 'zhansgan@163.com', '222321', '110', '2018-03-03', '4354.jpg', '0');

-- ----------------------------
-- Table structure for `t_item`
-- ----------------------------
DROP TABLE IF EXISTS `t_item`;
CREATE TABLE `t_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `count` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `uint` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_item
-- ----------------------------
INSERT INTO `t_item` VALUES ('1', '1', '老王', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('2', '1', '老王', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('3', '1', '老王', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('4', '1', '老王', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('5', '123', '测试1', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('6', '2342', '小白', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('7', '11', '111', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('8', '11', '111', '隔壁的', '一个');
INSERT INTO `t_item` VALUES ('9', '11', '111', '隔壁的', '一个');

-- ----------------------------
-- Table structure for `t_loginlog`
-- ----------------------------
DROP TABLE IF EXISTS `t_loginlog`;
CREATE TABLE `t_loginlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) DEFAULT NULL,
  `no` varchar(20) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_loginlog
-- ----------------------------
INSERT INTO `t_loginlog` VALUES ('1', '117.159.15.221', 'admin', '2018-07-12 14:04:49', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('2', '117.159.15.221', 'admin', '2018-07-12 16:02:08', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('3', '117.159.15.221', 'admin', '2018-07-12 16:05:00', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('4', '117.159.15.221', 'admin', '2018-07-12 16:13:30', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('5', '117.159.15.221', 'admin', '2018-07-12 16:14:36', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('6', '117.159.15.221', 'admin', '2018-07-12 16:23:53', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('7', '117.159.15.221', 'admin', '2018-07-12 16:25:51', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('8', '117.159.15.221', 'admin', '2018-07-12 16:27:00', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('9', '117.159.15.221', 'admin', '2018-07-12 16:53:44', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('10', '117.159.15.221', 'admin', '2018-07-12 17:01:38', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('11', '117.159.15.221', 'admin', '2018-07-12 17:04:31', '河南省信阳市');
INSERT INTO `t_loginlog` VALUES ('55', '117.159.15.221', 'admin', '2018-07-14 16:03:21', '河南省信阳市');

-- ----------------------------
-- Table structure for `t_major`
-- ----------------------------
DROP TABLE IF EXISTS `t_major`;
CREATE TABLE `t_major` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `major_name` varchar(20) DEFAULT NULL,
  `major_time` varchar(20) DEFAULT NULL,
  `major_date` date DEFAULT NULL,
  `major_type` int(6) DEFAULT NULL,
  `major_delete` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_major_id` (`major_type`),
  CONSTRAINT `FK_major_id` FOREIGN KEY (`major_type`) REFERENCES `t_majortype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_major
-- ----------------------------
INSERT INTO `t_major` VALUES ('1', '物联网', '40', '2019-08-02', '1', '0');
INSERT INTO `t_major` VALUES ('2', '商务外语', '200', '2019-08-08', '2', '0');

-- ----------------------------
-- Table structure for `t_majortype`
-- ----------------------------
DROP TABLE IF EXISTS `t_majortype`;
CREATE TABLE `t_majortype` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `majortype` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_majortype
-- ----------------------------
INSERT INTO `t_majortype` VALUES ('1', '精品');
INSERT INTO `t_majortype` VALUES ('2', '业余');
INSERT INTO `t_majortype` VALUES ('3', '普通');

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `no` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `cardno` varchar(20) DEFAULT NULL,
  `school` varchar(50) DEFAULT NULL,
  `education` varchar(20) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL COMMENT '外键 和班级主键有关系',
  `flag` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `del` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_class_id` (`class_id`),
  CONSTRAINT `FK_student_class_id` FOREIGN KEY (`class_id`) REFERENCES `t_class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('1', 'qf000002', '小王', '男', '1998-03-20', '321721199803203212', '郑州大学', '本科', '1', '1', 'zhansgan@163.com', '222321', '110', '2018-03-03', 'photos\\e49c64f2-0df8-464c-93ad-7ab95fb7867e_cw1.jpg', null);
