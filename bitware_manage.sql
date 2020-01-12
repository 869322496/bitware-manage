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

 Date: 13/01/2020 00:07:00
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
INSERT INTO `leave` VALUES ('0b679239-11a2-43f8-846f-b0e1462de6e8', '141', 'PublicLeave', '1141', '2020-01-13 00:00:00', '2020-01-14 23:59:59', '3123', 'QJ1578670242418', '2020-01-10 23:30:42', 0, '[]', 'ALL');
INSERT INTO `leave` VALUES ('39535ce0-8a5f-4801-be12-59bca4e246ff', '141', 'CompassionateLeave', '测试请假2', '2020-01-07 12:00:00', '2020-01-07 23:59:59', '4214214', 'QJ1578386026762', '2020-01-07 16:33:46', 10, '[{\"sourceFileUrl\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background.jpg\",\"thumbnailFile\":\"/20200107/3199522a-df9d-4ab4-afec-b7e6a8c7cff7-background_thumbnails.jpg\"}]', 'PM');
INSERT INTO `leave` VALUES ('480c7665-59c4-4d1c-a22c-fee43e01a4a6', '141', 'FuneralLeave', '11', '2020-01-10 12:01:00', '2020-01-10 23:59:59', '111', 'QJ1578671412452', '2020-01-10 23:50:12', 1, '[]', 'PM');
INSERT INTO `leave` VALUES ('66040ef1-b201-4c47-b2dd-47e916fb0762', '12341', 'CompassionateLeave', 'test', '2020-01-08 00:00:00', '2020-01-09 23:59:59', '111', 'QJ1578820158523', '2020-01-12 17:09:18', 10, '[null]', 'ALL');
INSERT INTO `leave` VALUES ('8882aca4-3dc3-4c8c-bde3-65c5ffeffde8', '512', 'AnnualLeave', '1', '2020-01-11 00:00:00', '2020-01-12 23:59:59', '11', 'QJ1578669429609', '2020-01-10 23:17:26', 10, '[null]', 'ALL');
INSERT INTO `leave` VALUES ('89afd90c-7125-4200-8ba5-b6f388db7886', '512', 'MarriageLeave', '11', '2020-01-13 00:00:00', '2020-01-14 23:59:59', '1231', 'QJ1578668857146', '2020-01-10 23:07:37', 10, '[null]', 'ALL');
INSERT INTO `leave` VALUES ('8d6a7321-e323-4e1f-843b-e330c36803a4', '141', 'CompassionateLeave', '上下午重复测试', '2020-01-31 00:00:00', '2020-01-31 12:00:00', '11', 'QJ1578548639876', '2020-01-09 13:44:00', 0, '[{\"sourceFileUrl\":\"/20200109/5f54ddd2-c757-4e5b-9c08-296c6040d074-background.jpg\",\"thumbnailFile\":\"/20200109/5f54ddd2-c757-4e5b-9c08-296c6040d074-background_thumbnails.jpg\"}]', 'AM');
INSERT INTO `leave` VALUES ('96431f73-a14a-47a2-805d-19a8dd97e914', '512', 'CompassionateLeave', '请假测试中', '2020-01-10 00:00:00', '2020-01-10 12:00:00', '111', 'QJ1578548999283', '2020-01-09 13:49:59', 9, '[{\"sourceFileUrl\":\"/20200109/061c2191-f474-43d3-b600-01bb374c1286-background.jpg\",\"thumbnailFile\":\"/20200109/061c2191-f474-43d3-b600-01bb374c1286-background_thumbnails.jpg\"}]', 'AM');
INSERT INTO `leave` VALUES ('c6c0b343-c1d3-415e-8d56-c08ac1208410', '141', 'SickLeave', '14', '2020-01-15 00:00:00', '2020-01-15 12:00:00', '111', 'QJ1578669965420', '2020-01-10 23:26:15', 0, '[]', 'AM');
INSERT INTO `leave` VALUES ('ce1b2934-2ef6-4056-8f57-e162bb5d4be3', '141', 'CompassionateLeave', '11', '2020-01-09 00:00:00', '2020-01-09 12:00:00', '211', 'QJ1578529783027', '2020-01-09 08:29:43', 9, '[{\"sourceFileUrl\":\"/20200109/4c47f5d8-c525-4eac-8503-207419e8b981-background.jpg\",\"thumbnailFile\":\"/20200109/4c47f5d8-c525-4eac-8503-207419e8b981-background_thumbnails.jpg\"},{\"sourceFileUrl\":\"/20200109/e869306c-1216-49c9-9ca7-5a47a2b34e45-1575596580(1).png\",\"thumbnailFile\":\"/20200109/e869306c-1216-49c9-9ca7-5a47a2b34e45-1575596580(1)_thumbnails.png\"}]', 'AM');

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
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', 1, '早日康复', '39535ce0-8a5f-4801-be12-59bca4e246ff', '2020-01-09 09:07:47');
INSERT INTO `leave_audit` VALUES (NULL, 'CompanyReview', 0, NULL, '480c7665-59c4-4d1c-a22c-fee43e01a4a6', NULL);
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', 1, '42', '66040ef1-b201-4c47-b2dd-47e916fb0762', '2020-01-12 17:09:37');
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', 1, '111', '8882aca4-3dc3-4c8c-bde3-65c5ffeffde8', '2020-01-12 16:55:48');
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', 1, '4124', '89afd90c-7125-4200-8ba5-b6f388db7886', '2020-01-12 16:55:53');
INSERT INTO `leave_audit` VALUES ('141', 'CompanyReview', 1, '2', '912e4882-3dd8-488f-8a26-82de5f14d652', '2020-01-11 00:23:13');
INSERT INTO `leave_audit` VALUES (NULL, 'CompanyReview', 0, '1', 'd102be3d-2e88-4cbf-be27-0af13ba2860a', NULL);
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, '0b679239-11a2-43f8-846f-b0e1462de6e8', NULL);
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, '30f8d7ba-6dc6-46d2-8818-39d288931746', NULL);
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, '3711d1e2-3e64-4a99-aa37-9ecf650de2bd', NULL);
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, '注意身体', '39535ce0-8a5f-4801-be12-59bca4e246ff', '2020-01-08 12:13:47');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, '111', '480c7665-59c4-4d1c-a22c-fee43e01a4a6', '2020-01-12 16:55:40');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, '1', '66040ef1-b201-4c47-b2dd-47e916fb0762', '2020-01-12 17:09:34');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, '111', '8882aca4-3dc3-4c8c-bde3-65c5ffeffde8', '2020-01-12 16:55:44');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, '412', '89afd90c-7125-4200-8ba5-b6f388db7886', '2020-01-12 16:55:51');
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, '8d6a7321-e323-4e1f-843b-e330c36803a4', NULL);
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, '2', '912e4882-3dd8-488f-8a26-82de5f14d652', '2020-01-11 00:23:10');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 2, NULL, '96431f73-a14a-47a2-805d-19a8dd97e914', '2020-01-09 13:50:28');
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, 'c6c0b343-c1d3-415e-8d56-c08ac1208410', NULL);
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 2, '别闹了 天天请假？', 'ce1b2934-2ef6-4056-8f57-e162bb5d4be3', '2020-01-09 08:49:03');
INSERT INTO `leave_audit` VALUES ('141', 'DepartmentAudit', 1, '多减减肥', 'd102be3d-2e88-4cbf-be27-0af13ba2860a', '2020-01-09 09:18:49');
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, 'd4fc2335-7cd2-4809-8c30-c1db3b4b8fd9', NULL);
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, '1', 'db82668c-1412-4f3c-9bd1-3b588b9bbbd1', NULL);
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, NULL, 'e40e1ec6-70b2-40eb-940b-8238ac221410', NULL);
INSERT INTO `leave_audit` VALUES (NULL, 'DepartmentAudit', 0, '1', 'ff353442-6a18-4946-8b35-c9e740cc2714', NULL);

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
INSERT INTO `resource` VALUES ('17', '用户管理', NULL, NULL, '/sys/user-manage', 'menu', '15', 1, 1, '2020-01-12 18:22:00', NULL, NULL);
INSERT INTO `resource` VALUES ('2', '请假管理', '1', 'anticon-edit', NULL, 'menu', '10', 0, 1, '2020-01-06 14:29:24', NULL, NULL);
INSERT INTO `resource` VALUES ('3', '请假一览', '1', NULL, '/leave/leave-statistical-analysis', 'menu', '2', 0, 1, '2020-01-09 09:27:06', NULL, NULL);
INSERT INTO `resource` VALUES ('4', '请假处理', '1', NULL, '/leave/leave-process', 'menu', '2', 1, 1, '2020-01-06 19:51:35', NULL, NULL);
INSERT INTO `resource` VALUES ('5', '请假上报', '1', NULL, '/leave/leave-report', 'menu', '2', 2, 1, '2020-01-06 14:13:59', NULL, NULL);
INSERT INTO `resource` VALUES ('6', '我的请假', '1', NULL, '/leave/my-leave', 'menu', '2', 3, 1, '2020-01-09 08:17:38', NULL, NULL);
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
INSERT INTO `role_auth` VALUES ('1', '12');
INSERT INTO `role_auth` VALUES ('1', '14');
INSERT INTO `role_auth` VALUES ('1', '15');
INSERT INTO `role_auth` VALUES ('1', '17');
INSERT INTO `role_auth` VALUES ('1', '2');
INSERT INTO `role_auth` VALUES ('1', '3');
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
INSERT INTO `user` VALUES ('12341', 'zhuangwei', '庄伟', '111111', '2020-01-15 10:28:35', NULL, 'bitware.163@.com', NULL, 0, 1, NULL, NULL, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('141', 'admin', '冯晓旭', '111111', '2020-01-04 22:14:21', '2020-01-04 22:14:23', 'bitware.163@.com', NULL, 0, 1, NULL, NULL, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('512', 'luzixun', '卢子逊', '111111', '2020-01-30 17:01:08', '2020-02-08 17:01:10', 'bitware.163@.com', NULL, 0, 1, NULL, NULL, 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('6d703fe0-28dd-49ca-8356-ba40723e1745', 'lijian', '李健', '111111', '2020-01-12 21:56:44', NULL, '1241@qq.com', NULL, 0, 1, NULL, '19745124111', 'http://www.bit-ware.com.cn/image/bitwarelog.png');
INSERT INTO `user` VALUES ('ee2d3963-1111-4a27-b4f8-e0d0cd5d7db5', 'zhangqiuju', '张秋菊', '111111', '2020-01-12 21:53:56', NULL, NULL, NULL, 0, 1, NULL, '15545485748', 'http://www.bit-ware.com.cn/image/bitwarelog.png');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('12341', '1');
INSERT INTO `user_role` VALUES ('141', '1');
INSERT INTO `user_role` VALUES ('512', '2');
INSERT INTO `user_role` VALUES ('6d703fe0-28dd-49ca-8356-ba40723e1745', '3');
INSERT INTO `user_role` VALUES ('ee2d3963-1111-4a27-b4f8-e0d0cd5d7db5', '3');

SET FOREIGN_KEY_CHECKS = 1;
