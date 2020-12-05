/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : wcsfixplatform

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 26/08/2020 14:34:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `port` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '类型',
  `type2` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '类型二',
  `enable` bit(1) NULL DEFAULT NULL COMMENT '可用',
  `att1` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `att2` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `goods_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '品种ID',
  `left_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '上下砖机：左轨道ID',
  `right_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '上下砖机：右轨道ID',
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dev_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `dev_ltrack_id_fk`(`left_track_id`) USING BTREE,
  INDEX `dev_rtrack_id_fk`(`right_track_id`) USING BTREE,
  CONSTRAINT `dev_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dev_ltrack_id_fk` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dev_rtrack_id_fk` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES (1, '3#下砖机_1', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (2, '3#下砖机_2', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (3, '3#下砖机_3', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (4, '3#下砖机_4', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (5, '5#下砖机_1', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (6, '5#下砖机_2', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (7, '5#下砖机_3', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (8, '4#下砖机_1', '127.0.0.1', 2000, 3, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (9, '4#下砖机_2', '127.0.0.1', 2000, 3, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (10, '1#下砖机_1', '127.0.0.1', 2000, 3, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (11, '1#下砖机_2', '127.0.0.1', 2000, 3, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (12, '2#下砖机_1', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (13, '2#下砖机_2', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (14, '2#下砖机_3', '127.0.0.1', 2000, 3, 1, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (15, '3#上砖机_1', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (16, '3#上砖机_2', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (17, '3#上砖机_3', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (18, '3#上砖机_4', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (19, '5#上砖机_1', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (20, '4#上砖机_1', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (21, '1#上砖机_1', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (22, '2#上砖机_1', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (23, '2#上砖机_2', '127.0.0.1', 2000, 2, 2, b'0', NULL, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (24, '3#运输车_1', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (25, '3#运输车_2', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (26, '3#运输车_3', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (27, '3#运输车_4', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (28, '3#运输车_5', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (29, '3#运输车_6', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (30, '3#运输车_7', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (31, '3#运输车_8', '127.0.0.1', 2000, 1, 0, b'0', 1, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (32, '5#运输车_1', '127.0.0.1', 2000, 1, 0, b'0', 2, 1, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (33, '5#运输车_2', '127.0.0.1', 2000, 1, 0, b'0', 2, 1, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (34, '5#运输车_3', '127.0.0.1', 2000, 1, 0, b'0', 2, 1, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (35, '1#运输车_1', '127.0.0.1', 2000, 1, 0, b'0', 2, 3, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (36, '1#运输车_2', '127.0.0.1', 2000, 1, 0, b'0', 2, 3, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (37, '1#运输车_3', '127.0.0.1', 2000, 1, 0, b'0', 2, 3, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (38, '1#运输车_4', '127.0.0.1', 2000, 1, 0, b'0', 2, 3, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (39, '2#运输车_1', '127.0.0.1', 2000, 1, 0, b'0', 3, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (40, '2#运输车_2', '127.0.0.1', 2000, 1, 0, b'0', 3, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (41, '2#运输车_3', '127.0.0.1', 2000, 1, 0, b'0', 3, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (42, '2#运输车_4', '127.0.0.1', 2000, 1, 0, b'0', 3, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (43, '2#运输车_5', '127.0.0.1', 2000, 1, 0, b'0', 3, NULL, NULL, NULL, NULL, '');
INSERT INTO `device` VALUES (44, '2#运输车_6', '127.0.0.1', 2000, 1, 0, b'0', 3, NULL, NULL, NULL, NULL, '');

SET FOREIGN_KEY_CHECKS = 1;
