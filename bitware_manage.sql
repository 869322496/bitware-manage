/*
Navicat MySQL Data Transfer

Source Server         : bitware-manage
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : bitware_manage

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-01-08 17:14:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', '请假类型', 'LeaveType', '1');
INSERT INTO `dictionary` VALUES ('2', '审核流程', 'AuditType', '1');
INSERT INTO `dictionary` VALUES ('3', '假单状态', 'LeaveStatus', '1');

-- ----------------------------
-- Table structure for dictionary_item
-- ----------------------------
DROP TABLE IF EXISTS `dictionary_item`;
CREATE TABLE `dictionary_item` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dictionary_id` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `order_no` int(11) DEFAULT 0 COMMENT '排序',
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dictionary_item
-- ----------------------------
INSERT INTO `dictionary_item` VALUES ('1', 'SickLeave', '病假', '1', null, '1', null);
INSERT INTO `dictionary_item` VALUES ('2', 'CompassionateLeave', '事假', '1', null, '0', null);
INSERT INTO `dictionary_item` VALUES ('3', 'MarriageLeave', '婚假', '1', null, '3', null);
INSERT INTO `dictionary_item` VALUES ('4', 'FuneralLeave', '丧假', '1', null, '4', null);
INSERT INTO `dictionary_item` VALUES ('5', 'MaternityLeave', '产假', '1', null, '5', null);
INSERT INTO `dictionary_item` VALUES ('6', 'AnnualLeave', '年休假', '1', null, '2', null);
INSERT INTO `dictionary_item` VALUES ('7', 'PublicLeave', '公假', '1', null, '6', null);
INSERT INTO `dictionary_item` VALUES ('8', 'DepartmentAudit', '部门审核', '2', null, '0', null);
INSERT INTO `dictionary_item` VALUES ('9', 'CompanyReview', '公司复核', '2', null, '1', null);
INSERT INTO `dictionary_item` VALUES ('10', 'LeaveStatusDepartmentAudit', '部门初审中', '3', null, '0', '0');
INSERT INTO `dictionary_item` VALUES ('11', 'LeaveStatusCompanyReview', '公司复核中', '3', null, '1', '1');
INSERT INTO `dictionary_item` VALUES ('12', 'LeaveStatusRefuse', '已拒绝', '3', null, '3', '9');
INSERT INTO `dictionary_item` VALUES ('13', 'LeaveStatusAgree', '已通过', '3', null, '2', '10');

-- ----------------------------
-- Table structure for leave
-- ----------------------------
DROP TABLE IF EXISTS `leave`;
CREATE TABLE `leave` (
  `id` varchar(50) NOT NULL DEFAULT '0',
  `user_id` varchar(25) DEFAULT NULL COMMENT '请假人',
  `leave_type` varchar(50) DEFAULT NULL COMMENT '请假类型',
  `title` varchar(255) DEFAULT NULL COMMENT '请假标题',
  `begin_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL COMMENT '原因详情',
  `order_no` varchar(255) DEFAULT NULL COMMENT '请假编号',
  `create_time` datetime DEFAULT NULL,
  `status` int(4) DEFAULT 0 COMMENT '0 部门初审中 1 公司复核中   9已拒绝 10已通过',
  `img` text DEFAULT NULL,
  `date_type` varchar(255) DEFAULT '' COMMENT '上午下午全天 AM/PM/ALL',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of leave
-- ----------------------------
INSERT INTO `leave` VALUES ('39535ce0-8a5f-4801-be12-59bca4e246ff', '141', 'CompassionateLeave', '测试请假2', '2020-01-07 12:00:00', '2020-01-07 23:59:59', '4214214', 'QJ1578386026762', '2020-01-07 16:33:46', '1', '[{\"sourceFileUrl\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background.jpg\",\"thumbnailFile\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background_thumbnails.jpg\"}]', 'PM');
INSERT INTO `leave` VALUES ('ff353442-6a18-4946-8b35-c9e740cc2714', '141', 'CompassionateLeave', '测试请假1', '2020-01-07 16:33:18', '2020-01-15 16:33:18', '14124214', 'QJ1578386004578', '2020-01-07 16:33:24', '0', '[{\"sourceFileUrl\":\"/20200107/8062d77f-084c-470a-af81-0da205486e7b-background.jpg\",\"thumbnailFile\":\"/20200107/8062d77f-084c-470a-af81-0da205486e7b-background_thumbnails.jpg\"}]', 'ALL');

-- ----------------------------
-- Table structure for leave_audit
-- ----------------------------
DROP TABLE IF EXISTS `leave_audit`;
CREATE TABLE `leave_audit` (
  `auditor` varchar(255) DEFAULT '' COMMENT '审核人',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT '部门审核/公司复核等关联字典',
  `status` tinyint(4) DEFAULT 0 COMMENT '0 未审核 1通过 2拒绝',
  `reason` varchar(255) DEFAULT '' COMMENT '拒绝理由',
  `leave_id` varchar(255) NOT NULL DEFAULT '' COMMENT '请假单ID',
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`type`,`leave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of leave_audit
-- ----------------------------
INSERT INTO `leave_audit` VALUES (null, 'CompanyReview', '0', null, '39535ce0-8a5f-4801-be12-59bca4e246ff', null);
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', null, '39535ce0-8a5f-4801-be12-59bca4e246ff', '2020-01-08 12:13:47');
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', null, 'ff353442-6a18-4946-8b35-c9e740cc2714', null);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuID` varchar(50) DEFAULT NULL,
  `logdate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `logValue` varchar(255) NOT NULL,
  `userID` varchar(50) NOT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `detail` longtext DEFAULT NULL,
  `log_level` varchar(10) DEFAULT NULL,
  `logModule` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36784 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` varchar(36) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `is_independent` tinyint(4) NOT NULL,
  `org_type` varchar(36) DEFAULT NULL,
  `path` longtext DEFAULT NULL,
  `remark` longtext DEFAULT NULL,
  `order_no` int(11) NOT NULL,
  `customer_id` varchar(50) NOT NULL,
  `is_delete` tinyint(4) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `attr1` varchar(100) DEFAULT NULL,
  `attr2` varchar(100) DEFAULT NULL,
  `attr3` varchar(100) DEFAULT NULL,
  `attr4` varchar(100) DEFAULT NULL,
  `attr5` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization
-- ----------------------------

-- ----------------------------
-- Table structure for organization_auth
-- ----------------------------
DROP TABLE IF EXISTS `organization_auth`;
CREATE TABLE `organization_auth` (
  `org_id` varchar(36) NOT NULL,
  `resource_id` varchar(36) NOT NULL,
  PRIMARY KEY (`org_id`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_auth
-- ----------------------------

-- ----------------------------
-- Table structure for org_type
-- ----------------------------
DROP TABLE IF EXISTS `org_type`;
CREATE TABLE `org_type` (
  `code` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of org_type
-- ----------------------------

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `menu_icon` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  `enabled` tinyint(4) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', '首页', '1', '', '', 'menu', '10', '0', '1', '2020-01-06 15:42:32', null);
INSERT INTO `resource` VALUES ('10', '导航', null, null, null, 'menu', 'menu_root', '0', '1', '2020-01-06 14:30:18', null);
INSERT INTO `resource` VALUES ('11', '部门审核请假权限', null, null, null, 'func', '13', '0', '1', '2020-01-08 12:18:10', 'DepartmentAudit');
INSERT INTO `resource` VALUES ('12', '公司审核请假权限', null, null, null, 'func', '13', '1', '1', '2020-01-08 12:18:10', 'CompanyReview');
INSERT INTO `resource` VALUES ('13', '请假审核权限', null, null, null, 'func', '16', '0', '1', '2020-01-08 16:22:04', 'LeaveAuditPermesion');
INSERT INTO `resource` VALUES ('14', '角色管理', null, 'fa fa-home', '/sys/role-permission', 'menu', '15', '4', '1', '2020-01-08 16:15:56', null);
INSERT INTO `resource` VALUES ('15', '系统设置', null, 'anticon-setting', null, 'menu', '10', '5', '1', '2020-01-08 14:15:23', null);
INSERT INTO `resource` VALUES ('16', '所有权限', null, null, null, 'func', 'func_root', '0', '1', '2020-01-08 16:21:56', null);
INSERT INTO `resource` VALUES ('2', '请假管理', '1', 'anticon-edit', null, 'menu', '10', '0', '1', '2020-01-06 14:29:24', null);
INSERT INTO `resource` VALUES ('3', '请假统计分析', '1', null, '/leave/leave-statistical-analysis', 'menu', '2', '0', '1', '2020-01-06 14:13:24', null);
INSERT INTO `resource` VALUES ('4', '请假处理', '1', null, '/leave/leave-process', 'menu', '2', '1', '1', '2020-01-06 19:51:35', null);
INSERT INTO `resource` VALUES ('5', '请假上报', '1', null, '/leave/leave-report', 'menu', '2', '2', '1', '2020-01-06 14:13:59', null);
INSERT INTO `resource` VALUES ('6', '我的请假', '1', null, '/leave/leave-detail', 'menu', '2', '3', '1', '2020-01-06 17:03:02', null);
INSERT INTO `resource` VALUES ('7', '列表页', '1', 'anticon-appstore', null, 'menu', '10', '0', '1', '2020-01-06 14:29:25', null);
INSERT INTO `resource` VALUES ('8', '表格列表', null, null, '/pro/list/table-list', 'menu', '7', '0', '1', '2020-01-06 14:15:37', null);
INSERT INTO `resource` VALUES ('9', '基础列表', '1', null, '/pro/list/articles', 'menu', '8', '0', '1', '2020-01-06 14:16:35', null);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `remark` longtext DEFAULT NULL,
  `order_no` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '部门管理', '1', '0', 'DepartmentManager');
INSERT INTO `role` VALUES ('2', '公司管理', '1', '1', 'CompanyManager');
INSERT INTO `role` VALUES ('3', '员工', '1', '2', 'Staff');

-- ----------------------------
-- Table structure for role_auth
-- ----------------------------
DROP TABLE IF EXISTS `role_auth`;
CREATE TABLE `role_auth` (
  `role_id` varchar(36) NOT NULL,
  `resource_id` varchar(36) NOT NULL,
  PRIMARY KEY (`role_id`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_auth
-- ----------------------------
INSERT INTO `role_auth` VALUES ('1', '1');
INSERT INTO `role_auth` VALUES ('1', '10');
INSERT INTO `role_auth` VALUES ('1', '11');
INSERT INTO `role_auth` VALUES ('1', '14');
INSERT INTO `role_auth` VALUES ('1', '15');
INSERT INTO `role_auth` VALUES ('1', '2');
INSERT INTO `role_auth` VALUES ('1', '3');
INSERT INTO `role_auth` VALUES ('1', '4');
INSERT INTO `role_auth` VALUES ('1', '5');
INSERT INTO `role_auth` VALUES ('1', '6');
INSERT INTO `role_auth` VALUES ('1', '8');
INSERT INTO `role_auth` VALUES ('1', '9');
INSERT INTO `role_auth` VALUES ('3', '1');
INSERT INTO `role_auth` VALUES ('3', '10');
INSERT INTO `role_auth` VALUES ('3', '2');
INSERT INTO `role_auth` VALUES ('3', '5');
INSERT INTO `role_auth` VALUES ('3', '6');
INSERT INTO `role_auth` VALUES ('3', '7');
INSERT INTO `role_auth` VALUES ('3', '8');
INSERT INTO `role_auth` VALUES ('3', '9');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(255) NOT NULL,
  `user_account` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(255) DEFAULT 0,
  `is_enable` tinyint(255) DEFAULT 1,
  `org_id` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('12341', 'admin1', '庄伟', '111111', '2020-01-15 10:28:35', null, '2', null, '0', '1', null, null, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('141', 'admin', '冯晓旭', '111111', '2020-01-04 22:14:21', '2020-01-04 22:14:23', null, null, '0', '1', null, null, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('512', 'luzixun', '卢子逊', '111111', '2020-01-30 17:01:08', '2020-02-08 17:01:10', null, null, '0', '1', null, null, 'http://www.bit-ware.com.cn/image/bitwarelog.png');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` varchar(36) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('12341', '2');
INSERT INTO `user_role` VALUES ('141', '1');
INSERT INTO `user_role` VALUES ('512', '3');