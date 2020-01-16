/*
Navicat MySQL Data Transfer

Source Server         : bitware-manage
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : bitware_manage

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-01-16 18:32:49
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `dictionary_item` VALUES ('1', 'SickLeave', '病假', '1', null, '1', '1');
INSERT INTO `dictionary_item` VALUES ('2', 'CompassionateLeave', '事假', '1', null, '0', '1');
INSERT INTO `dictionary_item` VALUES ('3', 'MarriageLeave', '婚假', '1', null, '3', '0');
INSERT INTO `dictionary_item` VALUES ('4', 'FuneralLeave', '丧假', '1', null, '4', '0');
INSERT INTO `dictionary_item` VALUES ('5', 'MaternityLeave', '产假', '1', null, '5', '0');
INSERT INTO `dictionary_item` VALUES ('6', 'AnnualLeave', '年休假', '1', null, '2', '1');
INSERT INTO `dictionary_item` VALUES ('7', 'PublicLeave', '公假', '1', null, '6', '0');
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
INSERT INTO `leave` VALUES ('0b679239-11a2-43f8-846f-b0e1462de6e8', '141', 'PublicLeave', '1141', '2020-01-13 00:00:00', '2020-01-14 23:59:59', '3123', 'QJ1578670242418', '2020-01-10 23:30:42', '0', '[]', 'ALL');
INSERT INTO `leave` VALUES ('39535ce0-8a5f-4801-be12-59bca4e246ff', '141', 'CompassionateLeave', '测试请假2', '2020-01-07 12:00:00', '2020-01-07 23:59:59', '4214214', 'QJ1578386026762', '2020-01-07 16:33:46', '10', '[{\"sourceFileUrl\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background.jpg\",\"thumbnailFile\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background_thumbnails.jpg\"}]', 'PM');
INSERT INTO `leave` VALUES ('66040ef1-b201-4c47-b2dd-47e916fb0762', '12341', 'CompassionateLeave', 'test', '2020-01-08 00:00:00', '2020-01-09 23:59:59', '111', 'QJ1578820158523', '2020-01-12 17:09:18', '10', '[]', 'ALL');
INSERT INTO `leave` VALUES ('8882aca4-3dc3-4c8c-bde3-65c5ffeffde8', '512', 'AnnualLeave', '1', '2019-07-16 00:00:00', '2019-07-18 23:59:59', '11', 'QJ1578669429609', '2020-01-10 23:17:26', '10', '[]', 'ALL');
INSERT INTO `leave` VALUES ('89afd90c-7125-4200-8ba5-b6f388db7886', '512', 'MarriageLeave', '11', '2020-01-13 00:00:00', '2020-01-14 23:59:59', '1231', 'QJ1578668857146', '2020-01-10 23:07:37', '10', '[]', 'ALL');
INSERT INTO `leave` VALUES ('96431f73-a14a-47a2-805d-19a8dd97e914', '512', 'CompassionateLeave', '请假测试中', '2020-01-10 00:00:00', '2020-01-10 12:00:00', '111', 'QJ1578548999283', '2020-01-09 13:49:59', '9', '[{\"sourceFileUrl\":\"/20200109/061c2191-f474-43d3-b600-01bb374c1286-background.jpg\",\"thumbnailFile\":\"/20200109/061c2191-f474-43d3-b600-01bb374c1286-background_thumbnails.jpg\"}]', 'AM');
INSERT INTO `leave` VALUES ('9f31fa33-9817-40c2-9962-aff427918442', '512', 'CompassionateLeave', '删除测试', '2020-01-15 00:00:00', '2020-01-30 23:59:59', '421412', 'QJ1578897049954', '2020-01-13 14:30:49', '1', '[{\"sourceFileUrl\":\"/20200113/4a5f1ba5-6b09-4a36-95e5-2b607eda1d4a-背景.jpg\",\"thumbnailFile\":\"/20200113/4a5f1ba5-6b09-4a36-95e5-2b607eda1d4a-背景_thumbnails.jpg\"}]', 'ALL');
INSERT INTO `leave` VALUES ('c6c0b343-c1d3-415e-8d56-c08ac1208410', '141', 'SickLeave', '14', '2020-01-15 00:00:00', '2020-01-15 12:00:00', '111', 'QJ1578669965420', '2020-01-10 23:26:15', '0', '[]', 'AM');
INSERT INTO `leave` VALUES ('ce1b2934-2ef6-4056-8f57-e162bb5d4be3', '141', 'CompassionateLeave', '11', '2020-01-09 00:00:00', '2020-01-09 12:00:00', '211', 'QJ1578529783027', '2020-01-09 08:29:43', '9', '[{\"sourceFileUrl\":\"/20200109/4c47f5d8-c525-4eac-8503-207419e8b981-background.jpg\",\"thumbnailFile\":\"/20200109/4c47f5d8-c525-4eac-8503-207419e8b981-background_thumbnails.jpg\"},{\"sourceFileUrl\":\"/20200109/e869306c-1216-49c9-9ca7-5a47a2b34e45-1575596580(1).png\",\"thumbnailFile\":\"/20200109/e869306c-1216-49c9-9ca7-5a47a2b34e45-1575596580(1)_thumbnails.png\"}]', 'AM');

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
  PRIMARY KEY (`type`,`leave_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of leave_audit
-- ----------------------------
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', '1', '早日康复', '39535ce0-8a5f-4801-be12-59bca4e246ff', '2020-01-09 09:07:47');
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', '1', '42', '66040ef1-b201-4c47-b2dd-47e916fb0762', '2020-01-12 17:09:37');
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', '1', '111', '8882aca4-3dc3-4c8c-bde3-65c5ffeffde8', '2020-01-12 16:55:48');
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', '1', '4124', '89afd90c-7125-4200-8ba5-b6f388db7886', '2020-01-12 16:55:53');
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', '1', '2', '912e4882-3dd8-488f-8a26-82de5f14d652', '2020-01-11 00:23:13');
INSERT INTO `leave_audit` VALUES (null, 'CompanyReview', '0', null, '9f31fa33-9817-40c2-9962-aff427918442', null);
INSERT INTO `leave_audit` VALUES (null, 'CompanyReview', '0', '1', 'd102be3d-2e88-4cbf-be27-0af13ba2860a', null);
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', null, '0b679239-11a2-43f8-846f-b0e1462de6e8', null);
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', null, '30f8d7ba-6dc6-46d2-8818-39d288931746', null);
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', null, '3711d1e2-3e64-4a99-aa37-9ecf650de2bd', null);
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', '注意身体', '39535ce0-8a5f-4801-be12-59bca4e246ff', '2020-01-08 12:13:47');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', '1', '66040ef1-b201-4c47-b2dd-47e916fb0762', '2020-01-12 17:09:34');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', '111', '8882aca4-3dc3-4c8c-bde3-65c5ffeffde8', '2020-01-12 16:55:44');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', '412', '89afd90c-7125-4200-8ba5-b6f388db7886', '2020-01-12 16:55:51');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', '2', '912e4882-3dd8-488f-8a26-82de5f14d652', '2020-01-11 00:23:10');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '2', null, '96431f73-a14a-47a2-805d-19a8dd97e914', '2020-01-09 13:50:28');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', '`11', '9f31fa33-9817-40c2-9962-aff427918442', '2020-01-13 14:31:02');
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', null, 'c6c0b343-c1d3-415e-8d56-c08ac1208410', null);
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '2', '别闹了 天天请假？', 'ce1b2934-2ef6-4056-8f57-e162bb5d4be3', '2020-01-09 08:49:03');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', '1', '多减减肥', 'd102be3d-2e88-4cbf-be27-0af13ba2860a', '2020-01-09 09:18:49');
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', null, 'd4fc2335-7cd2-4809-8c30-c1db3b4b8fd9', null);
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', '1', 'db82668c-1412-4f3c-9bd1-3b588b9bbbd1', null);
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', null, 'e40e1ec6-70b2-40eb-940b-8238ac221410', null);
INSERT INTO `leave_audit` VALUES (null, 'DepartmentAudit', '0', '1', 'ff353442-6a18-4946-8b35-c9e740cc2714', null);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36784 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`org_id`,`resource_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  `path` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', '首页', '1', '', '', 'menu', '10', '0', '1', '2020-01-06 15:42:32', null, null);
INSERT INTO `resource` VALUES ('10', '导航', null, null, null, 'menu', 'menu_root', '0', '1', '2020-01-06 14:30:18', null, null);
INSERT INTO `resource` VALUES ('11', '部门审核请假权限', null, null, null, 'func', '13', '0', '1', '2020-01-08 12:18:10', 'DepartmentAudit', null);
INSERT INTO `resource` VALUES ('12', '公司审核请假权限', null, null, null, 'func', '13', '1', '1', '2020-01-08 12:18:10', 'CompanyReview', null);
INSERT INTO `resource` VALUES ('13', '请假审核权限', null, null, null, 'func', '16', '0', '1', '2020-01-08 16:22:04', 'LeaveAuditPermesion', null);
INSERT INTO `resource` VALUES ('14', '角色管理', null, 'fa fa-home', '/sys/role-permission', 'menu', '15', '4', '1', '2020-01-08 16:15:56', null, null);
INSERT INTO `resource` VALUES ('15', '系统设置', null, 'anticon-setting', null, 'menu', '10', '5', '1', '2020-01-08 14:15:23', null, null);
INSERT INTO `resource` VALUES ('16', '所有权限', null, null, null, 'func', 'func_root', '0', '1', '2020-01-08 16:21:56', null, null);
INSERT INTO `resource` VALUES ('17', '用户管理', null, null, '/sys/user-manage', 'menu', '15', '1', '1', '2020-01-12 18:22:00', null, null);
INSERT INTO `resource` VALUES ('2', '请假管理', '1', 'anticon-edit', null, 'menu', '10', '0', '1', '2020-01-06 14:29:24', null, null);
INSERT INTO `resource` VALUES ('3', '请假一览', '1', null, '/leave/leave-statistical-analysis', 'menu', '2', '0', '1', '2020-01-09 09:27:06', null, null);
INSERT INTO `resource` VALUES ('4', '请假处理', '1', null, '/leave/leave-process', 'menu', '2', '1', '1', '2020-01-06 19:51:35', null, null);
INSERT INTO `resource` VALUES ('5', '请假上报', '1', null, '/leave/leave-report', 'menu', '2', '2', '1', '2020-01-06 14:13:59', null, null);
INSERT INTO `resource` VALUES ('6', '我的请假', '1', null, '/leave/my-leave', 'menu', '2', '3', '1', '2020-01-09 08:17:38', null, null);
INSERT INTO `resource` VALUES ('7', '列表页', '1', 'anticon-appstore', null, 'menu', '10', '0', '1', '2020-01-06 14:29:25', null, null);
INSERT INTO `resource` VALUES ('8', '表格列表', null, null, '/pro/list/table-list', 'menu', '7', '0', '1', '2020-01-06 14:15:37', null, null);
INSERT INTO `resource` VALUES ('9', '基础列表', '1', null, '/pro/list/articles', 'menu', '8', '0', '1', '2020-01-06 14:16:35', null, null);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`role_id`,`resource_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_auth
-- ----------------------------
INSERT INTO `role_auth` VALUES ('1', '10');
INSERT INTO `role_auth` VALUES ('1', '11');
INSERT INTO `role_auth` VALUES ('1', '14');
INSERT INTO `role_auth` VALUES ('1', '15');
INSERT INTO `role_auth` VALUES ('1', '17');
INSERT INTO `role_auth` VALUES ('1', '2');
INSERT INTO `role_auth` VALUES ('1', '3');
INSERT INTO `role_auth` VALUES ('1', '4');
INSERT INTO `role_auth` VALUES ('1', '5');
INSERT INTO `role_auth` VALUES ('1', '6');
INSERT INTO `role_auth` VALUES ('2', '10');
INSERT INTO `role_auth` VALUES ('2', '11');
INSERT INTO `role_auth` VALUES ('2', '12');
INSERT INTO `role_auth` VALUES ('2', '14');
INSERT INTO `role_auth` VALUES ('2', '15');
INSERT INTO `role_auth` VALUES ('2', '17');
INSERT INTO `role_auth` VALUES ('2', '2');
INSERT INTO `role_auth` VALUES ('2', '3');
INSERT INTO `role_auth` VALUES ('2', '4');
INSERT INTO `role_auth` VALUES ('2', '5');
INSERT INTO `role_auth` VALUES ('2', '6');
INSERT INTO `role_auth` VALUES ('3', '10');
INSERT INTO `role_auth` VALUES ('3', '2');
INSERT INTO `role_auth` VALUES ('3', '5');
INSERT INTO `role_auth` VALUES ('3', '6');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(255) NOT NULL,
  `user_account` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL COMMENT '入职时间',
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
INSERT INTO `user` VALUES ('0a92e243-aa15-4827-b8f0-e853fae42056', 'sunshuzhen', '孙树振', '2018-07-14 00:00:00', '111111', '2020-01-15 09:24:50', null, null, null, '0', '1', null, '18654956485', 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('12341', 'zhuangwei', '庄伟', '2020-01-09 08:24:52', '111111', '2020-01-15 10:28:35', null, 'bitware@163.com', null, '0', '1', null, null, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('141', 'admin', '冯晓旭', '2015-01-01 08:25:08', '111111', '2020-01-04 22:14:21', '2020-01-04 22:14:23', 'bitware@163.com', null, '0', '1', null, null, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('314cf740-9787-4948-aaab-a3175131793d', 'yangxiaowang', '杨晓旺', '2020-01-09 08:20:10', '111111', '2020-01-16 08:20:13', null, '86@qq.com', null, '0', '1', null, '18655484956', 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('512', 'luzixun', '卢子逊', '2018-07-15 00:00:00', '111111', '2020-01-30 17:01:08', '2020-02-08 17:01:10', 'bitware@163.com', null, '0', '1', null, null, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('589bc825-0470-40de-a89b-42a979b4c27a', 'liqian', '李乾', '2018-07-15 00:00:00', '111111', '2020-01-15 09:23:12', null, '2@qq.com', null, '0', '1', null, '16544845954', 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('6d703fe0-28dd-49ca-8356-ba40723e1745', 'lijian', '李健', '2019-07-15 00:00:00', '111111', '2020-01-12 21:56:44', null, '1241@qq.com', null, '0', '1', null, '19745124111', 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('c1a0b20c-20cc-4e4d-95f9-3bd997598a5a', 'liubin', '刘斌', '2016-01-15 00:00:00', '111111', '2020-01-15 09:26:09', null, '123@163.com', null, '0', '1', null, '17484854848', 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('ee2d3963-1111-4a27-b4f8-e0d0cd5d7db5', 'zhangqiuju', '张秋菊', '2019-07-15 00:00:00', '111111', '2020-01-12 21:53:56', null, null, null, '0', '1', null, '15545485748', 'http://www.bit-ware.com.cn/image/bitwarelog.png');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` varchar(36) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('0a92e243-aa15-4827-b8f0-e853fae42056', '3');
INSERT INTO `user_role` VALUES ('12341', '1');
INSERT INTO `user_role` VALUES ('141', '2');
INSERT INTO `user_role` VALUES ('314cf740-9787-4948-aaab-a3175131793d', '3');
INSERT INTO `user_role` VALUES ('512', '3');
INSERT INTO `user_role` VALUES ('589bc825-0470-40de-a89b-42a979b4c27a', '3');
INSERT INTO `user_role` VALUES ('6d703fe0-28dd-49ca-8356-ba40723e1745', '3');
INSERT INTO `user_role` VALUES ('c1a0b20c-20cc-4e4d-95f9-3bd997598a5a', '3');
INSERT INTO `user_role` VALUES ('ee2d3963-1111-4a27-b4f8-e0d0cd5d7db5', '3');
