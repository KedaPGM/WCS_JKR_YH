/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : wcsplatform

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 18/08/2020 18:05:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `istemp` bit(1) NULL DEFAULT NULL COMMENT '是否是模板',
  `updatetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES (1, '测试', '普通型', b'0', NULL);
INSERT INTO `device` VALUES (2, '上下砖机', '普通型', NULL, '2020-08-18 16:28:40');
INSERT INTO `device` VALUES (3, '运输车', '普通型', NULL, '2020-08-18 16:28:51');

-- ----------------------------
-- Table structure for device_param
-- ----------------------------
DROP TABLE IF EXISTS `device_param`;
CREATE TABLE `device_param`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `device_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value_type` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `int_value` int(11) NULL DEFAULT NULL,
  `bool_value` bit(1) NULL DEFAULT NULL,
  `string_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `double_value` float(6, 3) UNSIGNED NULL DEFAULT NULL,
  `order` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '顺序',
  `updatetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `param_deviceid_fk`(`device_id`) USING BTREE,
  CONSTRAINT `param_deviceid_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for device_socket
-- ----------------------------
DROP TABLE IF EXISTS `device_socket`;
CREATE TABLE `device_socket`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `socket_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `enable` bit(1) NULL DEFAULT NULL COMMENT '启用/停用',
  `ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `port` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `memo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `deviceid_fk`(`device_id`) USING BTREE,
  INDEX `socketid_fk`(`socket_id`) USING BTREE,
  CONSTRAINT `deviceid_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `socketid_fk` FOREIGN KEY (`socket_id`) REFERENCES `socket` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device_socket
-- ----------------------------
INSERT INTO `device_socket` VALUES (1, 1, 1, b'1', '127.0.0.1', 2000, NULL);
INSERT INTO `device_socket` VALUES (2, 2, 2, b'1', '127.0.0.1', 2001, NULL);
INSERT INTO `device_socket` VALUES (3, 3, 3, b'1', '127.0.0.1', 2002, NULL);
INSERT INTO `device_socket` VALUES (4, 3, 4, b'1', '127.0.0.1', 2003, NULL);
INSERT INTO `device_socket` VALUES (5, 3, 5, b'1', '127.0.0.1', 2004, NULL);

-- ----------------------------
-- Table structure for diction
-- ----------------------------
DROP TABLE IF EXISTS `diction`;
CREATE TABLE `diction`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '类型',
  `valuetype` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `isadd` bit(1) NULL DEFAULT NULL COMMENT '是否添加',
  `isedit` bit(1) NULL DEFAULT NULL COMMENT '是否编辑',
  `isdelete` bit(1) NULL DEFAULT NULL COMMENT '是否可以删除',
  `authorizelevel` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '权限等级',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_idx`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction
-- ----------------------------
INSERT INTO `diction` VALUES (1, 0, 0, '状态', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (2, 0, 0, '货物状态', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (3, 0, 0, '需求信号', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (4, 0, 0, '介入状态', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (5, 0, 0, '作业模式', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (6, 0, 0, '上下砖机控制码', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (7, 0, 0, '运输车控制码', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (8, 0, 0, '运输车任务', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (9, 0, 0, '运输车速度', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (10, 0, 0, '运输车职责', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (11, 0, 0, '运输车状态', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (12, 0, 0, '顶升上位', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (13, 0, 0, '顶升下位', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (15, 0, 0, '货物状态', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (16, 0, 0, '运输车模式', b'1', b'1', b'1', 10);
INSERT INTO `diction` VALUES (17, 0, 0, '轨道状态', b'1', b'1', b'1', 10);

-- ----------------------------
-- Table structure for diction_dtl
-- ----------------------------
DROP TABLE IF EXISTS `diction_dtl`;
CREATE TABLE `diction_dtl`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `diction_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `int_value` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '整型',
  `bool_value` bit(1) NULL DEFAULT NULL COMMENT 'bool类型',
  `string_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字符串类型',
  `double_value` double(6, 2) UNSIGNED NULL DEFAULT NULL COMMENT '浮点类型',
  `order` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `updatetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dic_id_fk`(`diction_id`) USING BTREE,
  CONSTRAINT `dic_id_fk` FOREIGN KEY (`diction_id`) REFERENCES `diction` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction_dtl
-- ----------------------------
INSERT INTO `diction_dtl` VALUES (1, 1, '无', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (2, 1, '空闲', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (3, 1, '作业中', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (4, 1, '停止', 3, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (5, 1, '故障', 4, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (6, 2, '无砖', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (7, 2, '有砖', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (8, 3, '无', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (9, 3, '有', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (10, 4, '离开', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (11, 4, '介入', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (12, 5, '自动', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (13, 5, '手动', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (14, 6, '查询状态', 0, b'0', '', 0.00, 0, '2020-08-18 11:16:34');
INSERT INTO `diction_dtl` VALUES (15, 6, '介入1-左', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (16, 6, '介入2-右', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (17, 7, '查询', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (18, 7, '作业', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (19, 7, '速度', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (20, 7, '职责', 3, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (21, 7, '中止', 127, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (22, 8, '后退至下砖机取砖', 1, b'0', '', 0.00, 0, '2020-08-18 11:25:14');
INSERT INTO `diction_dtl` VALUES (23, 8, '前进至上砖机放砖', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (24, 8, '后退至摆渡车', 3, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (25, 8, '前进至摆渡车', 4, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (26, 8, '后退至轨道取砖', 5, b'0', '', 0.00, 0, '2020-08-18 11:26:01');
INSERT INTO `diction_dtl` VALUES (27, 8, '前进至轨道放砖', 6, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (28, 8, '后退至轨道倒库', 7, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (29, 8, '前进至点', 8, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (30, 8, '后退至点', 9, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (31, 9, '查询', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (32, 9, '设置手动快速', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (33, 9, '设置手动慢速', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (34, 9, '设置自动快速', 3, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (35, 9, '设置自动满速', 4, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (36, 10, '负责上砖', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (37, 10, '负责下砖', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (38, 10, '负责倒库', 3, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (39, 11, '停止', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (40, 11, '前进', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (41, 11, '后退', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (42, 11, '设备故障', 254, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (43, 8, '停止', 127, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (44, 12, '无', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (45, 12, '有', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (46, 13, '无', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (47, 13, '有', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (48, 15, '无货', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (49, 15, '有货', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (50, 16, '自动', 1, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (51, 16, '手动', 2, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (52, 17, '空', 0, b'0', '', 0.00, 0, NULL);
INSERT INTO `diction_dtl` VALUES (53, 17, '满', 1, b'0', '', 0.00, 0, NULL);

-- ----------------------------
-- Table structure for protocol
-- ----------------------------
DROP TABLE IF EXISTS `protocol`;
CREATE TABLE `protocol`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '协议名称',
  `handle` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '发送/接收类型',
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '协议通信类型',
  `length` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of protocol
-- ----------------------------
INSERT INTO `protocol` VALUES (1, '测试', 0, 0, 6);
INSERT INTO `protocol` VALUES (2, '上下砖机状态信息', 0, 0, 13);
INSERT INTO `protocol` VALUES (3, '上下砖机操作指令', 1, 0, 7);
INSERT INTO `protocol` VALUES (4, '运输车操作指令', 1, 0, 6);
INSERT INTO `protocol` VALUES (5, '运输车状态信息', 0, 0, 15);
INSERT INTO `protocol` VALUES (6, '运输车速度信息', 0, 0, 10);
INSERT INTO `protocol` VALUES (7, '运输车轨道空满信息', 0, 0, 8);
INSERT INTO `protocol` VALUES (8, '运输车轨道信息反馈', 1, 0, 9);
INSERT INTO `protocol` VALUES (9, '运输车报警信息', 0, 0, 4);

-- ----------------------------
-- Table structure for protocol_dtl
-- ----------------------------
DROP TABLE IF EXISTS `protocol_dtl`;
CREATE TABLE `protocol_dtl`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `protocol_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `offset` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `size` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `value` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '值',
  `value_type` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `diction_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `prodtl_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '头部/尾部/数据',
  `bitoffset` tinyint(3) NULL DEFAULT NULL COMMENT '字节中位的位置',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pro_id_fk`(`protocol_id`) USING BTREE,
  INDEX `pro_dic_id_fk`(`diction_id`) USING BTREE,
  CONSTRAINT `pro_dic_id_fk` FOREIGN KEY (`diction_id`) REFERENCES `diction` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pro_id_fk` FOREIGN KEY (`protocol_id`) REFERENCES `protocol` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of protocol_dtl
-- ----------------------------
INSERT INTO `protocol_dtl` VALUES (1, 1, '头部', 0, 2, 36896, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (2, 1, '数据', 2, 1, 0, 6, 1, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (3, 1, '数据', 3, 1, 0, 6, 1, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (5, 1, '尾部', 4, 2, 65534, 8, NULL, 2, NULL);
INSERT INTO `protocol_dtl` VALUES (6, 2, '头部', 0, 2, 37121, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (7, 2, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (8, 2, '货物1状态-左', 3, 1, 0, 5, 2, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (9, 2, '货物状态-右', 4, 1, 0, 5, 2, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (10, 2, '需求信号1-左', 5, 1, 0, 5, 3, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (11, 2, '需求信号2-右', 6, 1, 0, 5, 3, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (12, 2, '满砖片数', 7, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (13, 2, '介入状态1-左', 8, 1, 0, 5, 4, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (14, 2, '介入状态2-右', 9, 1, 0, 5, 4, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (15, 2, '操作模式', 10, 1, 0, 5, 5, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (16, 2, '尾部', 11, 2, 65534, 8, NULL, 2, NULL);
INSERT INTO `protocol_dtl` VALUES (17, 3, '头部', 0, 2, 36865, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (18, 3, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (19, 3, '控制码', 3, 1, 0, 5, 6, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (20, 3, '值', 4, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (21, 3, '尾部', 5, 2, 65534, 8, NULL, 2, NULL);
INSERT INTO `protocol_dtl` VALUES (22, 4, '头部', 0, 2, 38401, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (23, 4, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (24, 4, '控制码', 3, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (25, 4, '尾部', 4, 2, 65534, 8, NULL, 2, NULL);
INSERT INTO `protocol_dtl` VALUES (26, 5, '头部', 0, 2, 38657, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (27, 5, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (28, 5, '设备状态', 3, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (29, 5, '当前点', 4, 2, 0, 8, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (30, 5, '执行任务', 6, 1, 0, 5, 8, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (31, 5, '完成任务', 7, 1, 0, 5, 8, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (32, 5, '顶升上位', 8, 1, 0, 5, 12, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (33, 5, '顶升下位', 9, 1, 0, 5, 13, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (34, 5, '货物状态', 10, 1, 0, 5, 15, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (35, 5, '职责', 11, 1, 0, 5, 10, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (36, 5, '预留', 12, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (37, 5, '尾部', 13, 2, 65534, 8, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (38, 6, '头部', 0, 2, 38658, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (39, 6, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (40, 6, '手动快速', 3, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (41, 6, '手动满速', 4, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (42, 6, '自动快速', 5, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (43, 6, '自动满速', 6, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (44, 6, '预留', 7, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (45, 6, '尾部', 8, 2, 65534, 8, NULL, 2, NULL);
INSERT INTO `protocol_dtl` VALUES (46, 7, '头部', 0, 2, 38659, 8, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (47, 7, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (48, 7, '轨道号', 3, 2, 0, 8, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (49, 7, '空满状态', 5, 1, 0, 5, 17, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (50, 7, '预留', 6, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (51, 7, '尾部', 7, 1, 65534, 5, NULL, 2, NULL);
INSERT INTO `protocol_dtl` VALUES (52, 8, '头部', 0, 2, 38400, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (53, 8, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (54, 8, '控制码', 3, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (55, 8, '轨道号', 4, 2, 0, 8, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (56, 8, '空满状态', 6, 1, 0, 5, 17, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (57, 8, '尾部', 7, 2, 65534, 8, NULL, 2, NULL);
INSERT INTO `protocol_dtl` VALUES (58, 9, '头部', 0, 2, 0, 8, NULL, 0, NULL);
INSERT INTO `protocol_dtl` VALUES (59, 9, '设备号', 2, 1, 0, 5, NULL, 1, NULL);
INSERT INTO `protocol_dtl` VALUES (60, 9, '故障1', 3, 1, 0, 3, NULL, 1, NULL);

-- ----------------------------
-- Table structure for socket
-- ----------------------------
DROP TABLE IF EXISTS `socket`;
CREATE TABLE `socket`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '协议类型',
  `memo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of socket
-- ----------------------------
INSERT INTO `socket` VALUES (1, '测试', 0, '普通型');
INSERT INTO `socket` VALUES (2, '上下砖机', 0, '普通型');
INSERT INTO `socket` VALUES (3, '运输机状态', 0, '普通型');
INSERT INTO `socket` VALUES (4, '运输车轨道', 0, '普通型');
INSERT INTO `socket` VALUES (5, '运输车报警', 0, '普通型');

-- ----------------------------
-- Table structure for socket_protocol
-- ----------------------------
DROP TABLE IF EXISTS `socket_protocol`;
CREATE TABLE `socket_protocol`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `socket_id` int(11) UNSIGNED NOT NULL,
  `protocol_id` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sockettemp_id_fk`(`socket_id`) USING BTREE,
  INDEX `protocol_id_fk`(`protocol_id`) USING BTREE,
  CONSTRAINT `protocol_id_fk` FOREIGN KEY (`protocol_id`) REFERENCES `protocol` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sockettemp_id_fk` FOREIGN KEY (`socket_id`) REFERENCES `socket` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of socket_protocol
-- ----------------------------
INSERT INTO `socket_protocol` VALUES (1, 1, 1);
INSERT INTO `socket_protocol` VALUES (2, 2, 2);
INSERT INTO `socket_protocol` VALUES (3, 2, 3);
INSERT INTO `socket_protocol` VALUES (4, 3, 4);
INSERT INTO `socket_protocol` VALUES (5, 3, 5);
INSERT INTO `socket_protocol` VALUES (6, 3, 6);
INSERT INTO `socket_protocol` VALUES (7, 4, 7);
INSERT INTO `socket_protocol` VALUES (8, 4, 8);

SET FOREIGN_KEY_CHECKS = 1;
