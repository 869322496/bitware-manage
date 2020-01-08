/*
 Navicat Premium Data Transfer

 Source Server         : bendi
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : bitware_manage

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 08/01/2020 22:37:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
CREATE TABLE `dictionary_item`  (
  `id` int(11) NOT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dictionary_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_no` int(11) NULL DEFAULT 0 COMMENT '排序',
  `data` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dictionary_item
-- ----------------------------
INSERT INTO `dictionary_item` VALUES (1, 'SickLeave', '病假', '1', NULL, 1, NULL);
INSERT INTO `dictionary_item` VALUES (2, 'CompassionateLeave', '事假', '1', NULL, 0, NULL);
INSERT INTO `dictionary_item` VALUES (3, 'MarriageLeave', '婚假', '1', NULL, 3, NULL);
INSERT INTO `dictionary_item` VALUES (4, 'FuneralLeave', '丧假', '1', NULL, 4, NULL);
INSERT INTO `dictionary_item` VALUES (5, 'MaternityLeave', '产假', '1', NULL, 5, NULL);
INSERT INTO `dictionary_item` VALUES (6, 'AnnualLeave', '年休假', '1', NULL, 2, NULL);
INSERT INTO `dictionary_item` VALUES (7, 'PublicLeave', '公假', '1', NULL, 6, NULL);
INSERT INTO `dictionary_item` VALUES (8, 'DepartmentAudit', '部门审核', '2', NULL, 0, NULL);
INSERT INTO `dictionary_item` VALUES (9, 'CompanyReview', '公司复核', '2', NULL, 1, NULL);
INSERT INTO `dictionary_item` VALUES (10, 'LeaveStatusDepartmentAudit', '部门初审中', '3', NULL, 0, '0');
INSERT INTO `dictionary_item` VALUES (11, 'LeaveStatusCompanyReview', '公司复核中', '3', NULL, 1, '1');
INSERT INTO `dictionary_item` VALUES (12, 'LeaveStatusRefuse', '已拒绝', '3', NULL, 3, '9');
INSERT INTO `dictionary_item` VALUES (13, 'LeaveStatusAgree', '已通过', '3', NULL, 2, '10');

-- ----------------------------
-- Table structure for leave
-- ----------------------------
DROP TABLE IF EXISTS `leave`;
CREATE TABLE `leave`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `user_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假人',
  `leave_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假标题',
  `begin_time` datetime(0) NULL DEFAULT NULL,
  `end_time` datetime(0) NULL DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原因详情',
  `order_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假编号',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `status` int(4) NULL DEFAULT 0 COMMENT '0 部门初审中 1 公司复核中   9已拒绝 10已通过',
  `img` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `date_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上午下午全天 AM/PM/ALL',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of leave
-- ----------------------------
INSERT INTO `leave` VALUES ('39535ce0-8a5f-4801-be12-59bca4e246ff', '141', 'CompassionateLeave', '测试请假2', '2020-01-07 12:00:00', '2020-01-07 23:59:59', '4214214', 'QJ1578386026762', '2020-01-07 16:33:46', 1, '[{\"sourceFileUrl\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background.jpg\",\"thumbnailFile\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background_thumbnails.jpg\"}]', 'PM');
INSERT INTO `leave` VALUES ('ff353442-6a18-4946-8b35-c9e740cc2714', '141', 'CompassionateLeave', '测试请假1', '2020-01-07 16:33:18', '2020-01-15 16:33:18', '14124214', 'QJ1578386004578', '2020-01-07 16:33:24', 0, '[{\"sourceFileUrl\":\"/20200107/8062d77f-084c-470a-af81-0da205486e7b-background.jpg\",\"thumbnailFile\":\"/20200107/8062d77f-084c-470a-af81-0da205486e7b-background_thumbnails.jpg\"}]', 'ALL');

-- ----------------------------
-- Table structure for leave_audit
-- ----------------------------
DROP TABLE IF EXISTS `leave_audit`;
CREATE TABLE `leave_audit`  (
  `auditor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '审核人',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '部门审核/公司复核等关联字典',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '0 未审核 1通过 2拒绝',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '拒绝理由',
  `leave_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '请假单ID',
  `time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`type`, `leave_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of leave_audit
-- ----------------------------
INSERT INTO `leave_audit` VALUES (NULL, 'CompanyReview', 0, NULL, '39535ce0-8a5f-4801-be12-59bca4e246ff', NULL);
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, NULL, '39535ce0-8a5f-4801-be12-59bca4e246ff', '2020-01-08 12:13:47');
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, 'ff353442-6a18-4946-8b35-c9e740cc2714', NULL);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logdate` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `logValue` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `log_level` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logModule` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36784 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for org_type
-- ----------------------------
DROP TABLE IF EXISTS `org_type`;
CREATE TABLE `org_type`  (
  `code` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_independent` tinyint(4) NOT NULL,
  `org_type` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `path` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `remark` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `order_no` int(11) NOT NULL,
  `customer_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_delete` tinyint(4) NOT NULL,
  `update_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `attr1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `attr2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `attr3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `attr4` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `attr5` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for organization_auth
-- ----------------------------
DROP TABLE IF EXISTS `organization_auth`;
CREATE TABLE `organization_auth`  (
  `org_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`org_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_no` int(11) NULL DEFAULT NULL,
  `enabled` tinyint(4) NOT NULL,
  `update_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `path` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', '首页', '1', '', '', 'menu', '10', 0, 1, '2020-01-06 15:42:32', NULL, NULL);
INSERT INTO `resource` VALUES ('10', '导航', NULL, NULL, NULL, 'menu', 'menu_root', 0, 1, '2020-01-06 14:30:18', NULL, NULL);
INSERT INTO `resource` VALUES ('11', '部门审核请假权限', NULL, NULL, NULL, 'func', '13', 0, 1, '2020-01-08 12:18:10', 'DepartmentAudit', NULL);
INSERT INTO `resource` VALUES ('12', '公司审核请假权限', NULL, NULL, NULL, 'func', '13', 1, 1, '2020-01-08 12:18:10', 'CompanyReview', NULL);
INSERT INTO `resource` VALUES ('13', '请假审核权限', NULL, NULL, NULL, 'func', '16', 0, 1, '2020-01-08 16:22:04', 'LeaveAuditPermesion', NULL);
INSERT INTO `resource` VALUES ('14', '角色管理', NULL, 'fa fa-home', '/sys/role-permission', 'menu', '15', 4, 1, '2020-01-08 16:15:56', NULL, NULL);
INSERT INTO `resource` VALUES ('15', '系统设置', NULL, 'anticon-setting', NULL, 'menu', '10', 5, 1, '2020-01-08 14:15:23', NULL, NULL);
INSERT INTO `resource` VALUES ('16', '所有权限', NULL, NULL, NULL, 'func', 'func_root', 0, 1, '2020-01-08 16:21:56', NULL, NULL);
INSERT INTO `resource` VALUES ('2', '请假管理', '1', 'anticon-edit', NULL, 'menu', '10', 0, 1, '2020-01-06 14:29:24', NULL, NULL);
INSERT INTO `resource` VALUES ('3', '请假统计分析', '1', NULL, '/leave/leave-statistical-analysis', 'menu', '2', 0, 1, '2020-01-06 14:13:24', NULL, NULL);
INSERT INTO `resource` VALUES ('4', '请假处理', '1', NULL, '/leave/leave-process', 'menu', '2', 1, 1, '2020-01-06 19:51:35', NULL, NULL);
INSERT INTO `resource` VALUES ('5', '请假上报', '1', NULL, '/leave/leave-report', 'menu', '2', 2, 1, '2020-01-06 14:13:59', NULL, NULL);
INSERT INTO `resource` VALUES ('6', '我的请假', '1', NULL, '/leave/leave-detail', 'menu', '2', 3, 1, '2020-01-06 17:03:02', NULL, NULL);
INSERT INTO `resource` VALUES ('7', '列表页', '1', 'anticon-appstore', NULL, 'menu', '10', 0, 1, '2020-01-06 14:29:25', NULL, NULL);
INSERT INTO `resource` VALUES ('8', '表格列表', NULL, NULL, '/pro/list/table-list', 'menu', '7', 0, 1, '2020-01-06 14:15:37', NULL, NULL);
INSERT INTO `resource` VALUES ('9', '基础列表', '1', NULL, '/pro/list/articles', 'menu', '8', 0, 1, '2020-01-06 14:16:35', NULL, NULL);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `order_no` int(11) NOT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '部门管理', '1', 0, 'DepartmentManager');
INSERT INTO `role` VALUES ('2', '公司管理', '1', 1, 'CompanyManager');
INSERT INTO `role` VALUES ('3', '员工', '1', 2, 'Staff');

-- ----------------------------
-- Table structure for role_auth
-- ----------------------------
DROP TABLE IF EXISTS `role_auth`;
CREATE TABLE `role_auth`  (
  `role_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_auth
-- ----------------------------
INSERT INTO `role_auth` VALUES ('1', '10');
INSERT INTO `role_auth` VALUES ('1', '11');
INSERT INTO `role_auth` VALUES ('1', '14');
INSERT INTO `role_auth` VALUES ('1', '15');
INSERT INTO `role_auth` VALUES ('1', '2');
INSERT INTO `role_auth` VALUES ('1', '4');
INSERT INTO `role_auth` VALUES ('1', '5');
INSERT INTO `role_auth` VALUES ('1', '6');
INSERT INTO `role_auth` VALUES ('2', '10');
INSERT INTO `role_auth` VALUES ('2', '12');
INSERT INTO `role_auth` VALUES ('2', '14');
INSERT INTO `role_auth` VALUES ('2', '15');
INSERT INTO `role_auth` VALUES ('2', '2');
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
CREATE TABLE `user`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `last_login_date` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_delete` tinyint(255) NULL DEFAULT 0,
  `is_enable` tinyint(255) NULL DEFAULT 1,
  `org_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('12341', 'admin1', '庄伟', '111111', '2020-01-15 10:28:35', NULL, 'bitware.163@.com', NULL, 0, 1, NULL, NULL, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('141', 'admin', '冯晓旭', '111111', '2020-01-04 22:14:21', '2020-01-04 22:14:23', 'bitware.163@.com', NULL, 0, 1, NULL, NULL, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('512', 'luzixun', '卢子逊', '111111', '2020-01-30 17:01:08', '2020-02-08 17:01:10', 'bitware.163@.com', NULL, 0, 1, NULL, NULL, 'http://www.bit-ware.com.cn/image/bitwarelog.png');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('12341', '2');
INSERT INTO `user_role` VALUES ('141', '1');
INSERT INTO `user_role` VALUES ('512', '3');

SET FOREIGN_KEY_CHECKS = 1;
