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

 Date: 12/09/2020 10:51:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区域名称',
  `enable` bit(1) NULL DEFAULT NULL COMMENT '区域可用',
  `devautorun` bit(1) NULL DEFAULT NULL COMMENT '设备自启动',
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES (1, '1#', b'1', b'1', '1号线');
INSERT INTO `area` VALUES (2, '2#', b'1', b'1', '2号线');
INSERT INTO `area` VALUES (3, '3#', b'1', b'1', '3号线');
INSERT INTO `area` VALUES (4, '4#', b'1', b'1', '4号线');
INSERT INTO `area` VALUES (5, '5#', b'1', b'1', '5号线');

-- ----------------------------
-- Table structure for area_device
-- ----------------------------
DROP TABLE IF EXISTS `area_device`;
CREATE TABLE `area_device`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `area_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '区域ID',
  `device_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '设备ID',
  `dev_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '设备类型1',
  `dev_type2` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '设备类型2',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `at_tile_id_fk`(`device_id`) USING BTREE,
  INDEX `at_area_id_fk`(`area_id`) USING BTREE,
  CONSTRAINT `at_area_id_fk` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `at_tile_id_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area_device
-- ----------------------------
INSERT INTO `area_device` VALUES (1, 3, 1, 1, NULL);
INSERT INTO `area_device` VALUES (2, 3, 2, 1, NULL);
INSERT INTO `area_device` VALUES (3, 3, 3, 1, NULL);
INSERT INTO `area_device` VALUES (4, 3, 4, 1, NULL);
INSERT INTO `area_device` VALUES (5, 5, 5, 1, NULL);
INSERT INTO `area_device` VALUES (6, 5, 6, 1, NULL);
INSERT INTO `area_device` VALUES (7, 5, 7, 1, NULL);
INSERT INTO `area_device` VALUES (8, 4, 8, 1, NULL);
INSERT INTO `area_device` VALUES (9, 4, 9, 1, NULL);
INSERT INTO `area_device` VALUES (10, 1, 10, 1, NULL);
INSERT INTO `area_device` VALUES (11, 1, 11, 1, NULL);
INSERT INTO `area_device` VALUES (12, 2, 12, 1, NULL);
INSERT INTO `area_device` VALUES (13, 2, 13, 1, NULL);
INSERT INTO `area_device` VALUES (14, 2, 14, 1, NULL);
INSERT INTO `area_device` VALUES (15, 3, 15, 0, NULL);
INSERT INTO `area_device` VALUES (16, 3, 16, 0, NULL);
INSERT INTO `area_device` VALUES (17, 3, 17, 0, NULL);
INSERT INTO `area_device` VALUES (18, 3, 18, 0, NULL);
INSERT INTO `area_device` VALUES (19, 5, 19, 0, NULL);
INSERT INTO `area_device` VALUES (20, 4, 20, 0, NULL);
INSERT INTO `area_device` VALUES (21, 1, 21, 0, NULL);
INSERT INTO `area_device` VALUES (22, 2, 22, 0, NULL);
INSERT INTO `area_device` VALUES (23, 2, 23, 0, NULL);
INSERT INTO `area_device` VALUES (24, 3, 24, 3, NULL);
INSERT INTO `area_device` VALUES (25, 5, 25, 3, NULL);
INSERT INTO `area_device` VALUES (26, 1, 26, 3, NULL);
INSERT INTO `area_device` VALUES (27, 2, 27, 3, NULL);
INSERT INTO `area_device` VALUES (28, 3, 28, 2, NULL);
INSERT INTO `area_device` VALUES (29, 5, 29, 2, NULL);
INSERT INTO `area_device` VALUES (30, 1, 30, 2, NULL);
INSERT INTO `area_device` VALUES (31, 2, 31, 2, NULL);
INSERT INTO `area_device` VALUES (32, 3, 32, 4, NULL);
INSERT INTO `area_device` VALUES (33, 3, 33, 4, NULL);
INSERT INTO `area_device` VALUES (34, 3, 34, 4, NULL);
INSERT INTO `area_device` VALUES (35, 3, 35, 4, NULL);
INSERT INTO `area_device` VALUES (36, 3, 36, 4, NULL);
INSERT INTO `area_device` VALUES (37, 3, 37, 4, NULL);
INSERT INTO `area_device` VALUES (38, 3, 38, 4, NULL);
INSERT INTO `area_device` VALUES (39, 3, 39, 4, NULL);
INSERT INTO `area_device` VALUES (40, 5, 40, 4, NULL);
INSERT INTO `area_device` VALUES (41, 5, 41, 4, NULL);
INSERT INTO `area_device` VALUES (42, 5, 42, 4, NULL);
INSERT INTO `area_device` VALUES (43, 1, 43, 4, NULL);
INSERT INTO `area_device` VALUES (44, 1, 44, 4, NULL);
INSERT INTO `area_device` VALUES (45, 1, 45, 4, NULL);
INSERT INTO `area_device` VALUES (46, 1, 46, 4, NULL);
INSERT INTO `area_device` VALUES (47, 2, 47, 4, NULL);
INSERT INTO `area_device` VALUES (48, 2, 48, 4, NULL);
INSERT INTO `area_device` VALUES (49, 2, 49, 4, NULL);
INSERT INTO `area_device` VALUES (50, 2, 50, 4, NULL);
INSERT INTO `area_device` VALUES (51, 2, 51, 4, NULL);
INSERT INTO `area_device` VALUES (52, 2, 52, 4, NULL);

-- ----------------------------
-- Table structure for area_device_track
-- ----------------------------
DROP TABLE IF EXISTS `area_device_track`;
CREATE TABLE `area_device_track`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `area_id` int(11) UNSIGNED NOT NULL COMMENT '区域ID',
  `device_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '设备ID',
  `track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '轨道ID',
  `prior` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '优先级',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `adt_area_id_fk`(`area_id`) USING BTREE,
  INDEX `adt_device_id_fk`(`device_id`) USING BTREE,
  INDEX `adt_track_id_fk`(`track_id`) USING BTREE,
  CONSTRAINT `adt_area_id_fk` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `adt_device_id_fk` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `adt_track_id_fk` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area_device_track
-- ----------------------------
INSERT INTO `area_device_track` VALUES (21, 1, 1, 52, 1);
INSERT INTO `area_device_track` VALUES (22, 1, 1, 53, 2);
INSERT INTO `area_device_track` VALUES (23, 1, 1, 54, 3);
INSERT INTO `area_device_track` VALUES (24, 1, 1, 55, 4);
INSERT INTO `area_device_track` VALUES (25, 1, 1, 56, 5);
INSERT INTO `area_device_track` VALUES (26, 1, 1, 57, 6);
INSERT INTO `area_device_track` VALUES (27, 1, 1, 58, 7);
INSERT INTO `area_device_track` VALUES (28, 3, 1, 29, 1);
INSERT INTO `area_device_track` VALUES (29, 3, 1, 30, 2);
INSERT INTO `area_device_track` VALUES (30, 3, 1, 31, 3);
INSERT INTO `area_device_track` VALUES (31, 3, 1, 32, 4);
INSERT INTO `area_device_track` VALUES (32, 3, 1, 33, 5);
INSERT INTO `area_device_track` VALUES (33, 3, 1, 34, 6);
INSERT INTO `area_device_track` VALUES (34, 3, 1, 35, 7);
INSERT INTO `area_device_track` VALUES (35, 3, 1, 36, 8);
INSERT INTO `area_device_track` VALUES (36, 3, 1, 37, 9);
INSERT INTO `area_device_track` VALUES (37, 3, 1, 38, 10);
INSERT INTO `area_device_track` VALUES (38, 3, 1, 39, 11);
INSERT INTO `area_device_track` VALUES (39, 3, 1, 40, 12);
INSERT INTO `area_device_track` VALUES (40, 1, 10, 52, 1);
INSERT INTO `area_device_track` VALUES (41, 1, 10, 53, 2);
INSERT INTO `area_device_track` VALUES (42, 1, 10, 54, 3);
INSERT INTO `area_device_track` VALUES (43, 1, 10, 55, 4);
INSERT INTO `area_device_track` VALUES (44, 1, 10, 56, 5);
INSERT INTO `area_device_track` VALUES (45, 1, 10, 57, 6);
INSERT INTO `area_device_track` VALUES (46, 1, 10, 58, 7);
INSERT INTO `area_device_track` VALUES (47, 1, 21, 92, 1);
INSERT INTO `area_device_track` VALUES (48, 1, 21, 93, 2);
INSERT INTO `area_device_track` VALUES (49, 1, 21, 94, 3);
INSERT INTO `area_device_track` VALUES (50, 1, 21, 95, 4);
INSERT INTO `area_device_track` VALUES (51, 1, 21, 96, 5);
INSERT INTO `area_device_track` VALUES (52, 1, 21, 97, 6);
INSERT INTO `area_device_track` VALUES (53, 1, 21, 98, 7);
INSERT INTO `area_device_track` VALUES (54, 1, 11, 52, 1);
INSERT INTO `area_device_track` VALUES (55, 1, 11, 53, 2);
INSERT INTO `area_device_track` VALUES (56, 1, 11, 54, 3);
INSERT INTO `area_device_track` VALUES (57, 1, 11, 55, 4);
INSERT INTO `area_device_track` VALUES (58, 1, 11, 56, 5);
INSERT INTO `area_device_track` VALUES (59, 1, 11, 57, 6);
INSERT INTO `area_device_track` VALUES (60, 1, 11, 58, 7);
INSERT INTO `area_device_track` VALUES (61, 1, 26, 52, 1);
INSERT INTO `area_device_track` VALUES (62, 1, 26, 53, 3);
INSERT INTO `area_device_track` VALUES (63, 1, 26, 54, 50);
INSERT INTO `area_device_track` VALUES (64, 1, 26, 55, 5);
INSERT INTO `area_device_track` VALUES (65, 1, 26, 56, 5);
INSERT INTO `area_device_track` VALUES (66, 1, 26, 57, 12);
INSERT INTO `area_device_track` VALUES (67, 1, 26, 58, 30);
INSERT INTO `area_device_track` VALUES (68, 1, 26, 10, 8);
INSERT INTO `area_device_track` VALUES (69, 1, 26, 11, 9);
INSERT INTO `area_device_track` VALUES (70, 1, 30, 92, 1);
INSERT INTO `area_device_track` VALUES (71, 1, 30, 93, 2);
INSERT INTO `area_device_track` VALUES (72, 1, 30, 94, 3);
INSERT INTO `area_device_track` VALUES (73, 1, 30, 95, 4);
INSERT INTO `area_device_track` VALUES (74, 1, 30, 96, 5);
INSERT INTO `area_device_track` VALUES (75, 1, 30, 97, 6);
INSERT INTO `area_device_track` VALUES (76, 1, 30, 98, 7);
INSERT INTO `area_device_track` VALUES (77, 1, 30, 23, 8);
INSERT INTO `area_device_track` VALUES (78, 1, 30, 24, 9);
INSERT INTO `area_device_track` VALUES (79, 3, 24, 29, 1);
INSERT INTO `area_device_track` VALUES (80, 3, 24, 30, 2);
INSERT INTO `area_device_track` VALUES (81, 3, 24, 31, 3);
INSERT INTO `area_device_track` VALUES (82, 3, 24, 32, 4);
INSERT INTO `area_device_track` VALUES (83, 3, 24, 33, 5);
INSERT INTO `area_device_track` VALUES (84, 3, 24, 34, 6);
INSERT INTO `area_device_track` VALUES (85, 3, 24, 35, 7);
INSERT INTO `area_device_track` VALUES (86, 3, 24, 36, 8);
INSERT INTO `area_device_track` VALUES (87, 3, 24, 37, 9);
INSERT INTO `area_device_track` VALUES (88, 3, 24, 38, 10);
INSERT INTO `area_device_track` VALUES (89, 3, 24, 39, 11);
INSERT INTO `area_device_track` VALUES (90, 3, 24, 40, 12);
INSERT INTO `area_device_track` VALUES (91, 3, 24, 1, 13);
INSERT INTO `area_device_track` VALUES (92, 3, 24, 2, 14);
INSERT INTO `area_device_track` VALUES (93, 3, 24, 3, 15);
INSERT INTO `area_device_track` VALUES (94, 3, 24, 4, 16);
INSERT INTO `area_device_track` VALUES (95, 3, 2, 29, 6);
INSERT INTO `area_device_track` VALUES (96, 3, 2, 30, 5);
INSERT INTO `area_device_track` VALUES (97, 3, 2, 31, 4);
INSERT INTO `area_device_track` VALUES (98, 3, 2, 32, 1);
INSERT INTO `area_device_track` VALUES (99, 3, 2, 33, 2);
INSERT INTO `area_device_track` VALUES (100, 3, 2, 34, 3);
INSERT INTO `area_device_track` VALUES (101, 3, 2, 35, 7);
INSERT INTO `area_device_track` VALUES (102, 3, 2, 36, 8);
INSERT INTO `area_device_track` VALUES (103, 3, 2, 37, 9);
INSERT INTO `area_device_track` VALUES (104, 3, 2, 38, 10);
INSERT INTO `area_device_track` VALUES (105, 3, 2, 39, 11);
INSERT INTO `area_device_track` VALUES (106, 3, 2, 40, 12);
INSERT INTO `area_device_track` VALUES (107, 3, 3, 29, 12);
INSERT INTO `area_device_track` VALUES (108, 3, 3, 30, 11);
INSERT INTO `area_device_track` VALUES (109, 3, 3, 31, 10);
INSERT INTO `area_device_track` VALUES (110, 3, 3, 32, 6);
INSERT INTO `area_device_track` VALUES (111, 3, 3, 33, 5);
INSERT INTO `area_device_track` VALUES (112, 3, 3, 34, 4);
INSERT INTO `area_device_track` VALUES (113, 3, 3, 35, 1);
INSERT INTO `area_device_track` VALUES (114, 3, 3, 36, 2);
INSERT INTO `area_device_track` VALUES (115, 3, 3, 37, 3);
INSERT INTO `area_device_track` VALUES (116, 3, 3, 38, 7);
INSERT INTO `area_device_track` VALUES (117, 3, 3, 39, 8);
INSERT INTO `area_device_track` VALUES (118, 3, 3, 40, 9);
INSERT INTO `area_device_track` VALUES (119, 3, 4, 29, 12);
INSERT INTO `area_device_track` VALUES (120, 3, 4, 30, 11);
INSERT INTO `area_device_track` VALUES (121, 3, 4, 31, 10);
INSERT INTO `area_device_track` VALUES (122, 3, 4, 32, 9);
INSERT INTO `area_device_track` VALUES (123, 3, 4, 33, 8);
INSERT INTO `area_device_track` VALUES (124, 3, 4, 34, 7);
INSERT INTO `area_device_track` VALUES (125, 3, 4, 35, 6);
INSERT INTO `area_device_track` VALUES (126, 3, 4, 36, 5);
INSERT INTO `area_device_track` VALUES (127, 3, 4, 37, 4);
INSERT INTO `area_device_track` VALUES (128, 3, 4, 38, 1);
INSERT INTO `area_device_track` VALUES (129, 3, 4, 39, 2);
INSERT INTO `area_device_track` VALUES (130, 3, 4, 40, 3);
INSERT INTO `area_device_track` VALUES (131, 3, 15, 69, 1);
INSERT INTO `area_device_track` VALUES (132, 3, 15, 70, 2);
INSERT INTO `area_device_track` VALUES (133, 3, 15, 71, 3);
INSERT INTO `area_device_track` VALUES (134, 3, 15, 72, 4);
INSERT INTO `area_device_track` VALUES (135, 3, 15, 73, 5);
INSERT INTO `area_device_track` VALUES (136, 3, 15, 74, 6);
INSERT INTO `area_device_track` VALUES (137, 3, 15, 75, 7);
INSERT INTO `area_device_track` VALUES (138, 3, 15, 76, 8);
INSERT INTO `area_device_track` VALUES (139, 3, 15, 77, 9);
INSERT INTO `area_device_track` VALUES (140, 3, 15, 78, 10);
INSERT INTO `area_device_track` VALUES (141, 3, 15, 79, 11);
INSERT INTO `area_device_track` VALUES (142, 3, 15, 80, 12);
INSERT INTO `area_device_track` VALUES (143, 3, 16, 69, 1);
INSERT INTO `area_device_track` VALUES (144, 3, 16, 70, 2);
INSERT INTO `area_device_track` VALUES (145, 3, 16, 71, 3);
INSERT INTO `area_device_track` VALUES (146, 3, 16, 72, 4);
INSERT INTO `area_device_track` VALUES (147, 3, 16, 73, 5);
INSERT INTO `area_device_track` VALUES (148, 3, 16, 74, 6);
INSERT INTO `area_device_track` VALUES (149, 3, 16, 75, 7);
INSERT INTO `area_device_track` VALUES (150, 3, 16, 76, 8);
INSERT INTO `area_device_track` VALUES (151, 3, 16, 77, 9);
INSERT INTO `area_device_track` VALUES (152, 3, 16, 78, 10);
INSERT INTO `area_device_track` VALUES (153, 3, 16, 79, 11);
INSERT INTO `area_device_track` VALUES (154, 3, 16, 80, 12);
INSERT INTO `area_device_track` VALUES (155, 3, 17, 69, 1);
INSERT INTO `area_device_track` VALUES (156, 3, 17, 70, 2);
INSERT INTO `area_device_track` VALUES (157, 3, 17, 71, 3);
INSERT INTO `area_device_track` VALUES (158, 3, 17, 72, 4);
INSERT INTO `area_device_track` VALUES (159, 3, 17, 73, 5);
INSERT INTO `area_device_track` VALUES (160, 3, 17, 74, 6);
INSERT INTO `area_device_track` VALUES (161, 3, 17, 75, 7);
INSERT INTO `area_device_track` VALUES (162, 3, 17, 76, 8);
INSERT INTO `area_device_track` VALUES (163, 3, 17, 77, 9);
INSERT INTO `area_device_track` VALUES (164, 3, 17, 78, 10);
INSERT INTO `area_device_track` VALUES (165, 3, 17, 79, 11);
INSERT INTO `area_device_track` VALUES (166, 3, 17, 80, 12);
INSERT INTO `area_device_track` VALUES (167, 3, 18, 69, 1);
INSERT INTO `area_device_track` VALUES (168, 3, 18, 70, 2);
INSERT INTO `area_device_track` VALUES (169, 3, 18, 71, 3);
INSERT INTO `area_device_track` VALUES (170, 3, 18, 72, 4);
INSERT INTO `area_device_track` VALUES (171, 3, 18, 73, 5);
INSERT INTO `area_device_track` VALUES (172, 3, 18, 74, 6);
INSERT INTO `area_device_track` VALUES (173, 3, 18, 75, 7);
INSERT INTO `area_device_track` VALUES (174, 3, 18, 76, 8);
INSERT INTO `area_device_track` VALUES (175, 3, 18, 77, 9);
INSERT INTO `area_device_track` VALUES (176, 3, 18, 78, 10);
INSERT INTO `area_device_track` VALUES (177, 3, 18, 79, 11);
INSERT INTO `area_device_track` VALUES (178, 3, 18, 80, 12);
INSERT INTO `area_device_track` VALUES (179, 3, 28, 69, 1);
INSERT INTO `area_device_track` VALUES (180, 3, 28, 70, 2);
INSERT INTO `area_device_track` VALUES (181, 3, 28, 71, 3);
INSERT INTO `area_device_track` VALUES (182, 3, 28, 72, 4);
INSERT INTO `area_device_track` VALUES (183, 3, 28, 73, 5);
INSERT INTO `area_device_track` VALUES (184, 3, 28, 74, 6);
INSERT INTO `area_device_track` VALUES (185, 3, 28, 75, 7);
INSERT INTO `area_device_track` VALUES (186, 3, 28, 76, 8);
INSERT INTO `area_device_track` VALUES (187, 3, 28, 77, 9);
INSERT INTO `area_device_track` VALUES (188, 3, 28, 78, 10);
INSERT INTO `area_device_track` VALUES (189, 3, 28, 79, 11);
INSERT INTO `area_device_track` VALUES (190, 3, 28, 80, 12);
INSERT INTO `area_device_track` VALUES (191, 3, 28, 15, 13);
INSERT INTO `area_device_track` VALUES (192, 3, 28, 16, 14);
INSERT INTO `area_device_track` VALUES (193, 3, 28, 17, 15);
INSERT INTO `area_device_track` VALUES (194, 3, 28, 18, 16);

-- ----------------------------
-- Table structure for area_track
-- ----------------------------
DROP TABLE IF EXISTS `area_track`;
CREATE TABLE `area_track`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `area_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '区域ID',
  `track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '轨道ID',
  `track_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '轨道类型',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `atra_area_id_fk`(`area_id`) USING BTREE,
  INDEX `atra_track_id_fk`(`track_id`) USING BTREE,
  CONSTRAINT `atra_area_id_fk` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `atra_track_id_fk` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
  `brother_dev_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '前设备ID[兄弟砖机ID]',
  `strategy_in` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '下砖策略',
  `strategy_out` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '上砖策略',
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dev_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `dev_ltrack_id_fk`(`left_track_id`) USING BTREE,
  INDEX `dev_rtrack_id_fk`(`right_track_id`) USING BTREE,
  CONSTRAINT `dev_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dev_ltrack_id_fk` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dev_rtrack_id_fk` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES (1, '3#下_A1', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 1, 1, NULL, 0, 0, 0, '161');
INSERT INTO `device` VALUES (2, '3#下_A2', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 15, 2, NULL, 0, 0, 0, '162');
INSERT INTO `device` VALUES (3, '3#下_A3', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 14, 3, NULL, 0, 0, 0, '163');
INSERT INTO `device` VALUES (4, '3#下_A4', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 13, 4, NULL, 0, 0, 0, '164');
INSERT INTO `device` VALUES (5, '5#下_A5', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '165');
INSERT INTO `device` VALUES (6, '5#下_A6', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '166');
INSERT INTO `device` VALUES (7, '5#下_A7', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '167');
INSERT INTO `device` VALUES (8, '4#下_A8', '127.0.0.1', 2001, 1, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '168');
INSERT INTO `device` VALUES (9, '4#下_A9', '127.0.0.1', 2001, 1, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '169');
INSERT INTO `device` VALUES (10, '1#下_A10', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, 11, 10, 11, 0, 1, 0, '170');
INSERT INTO `device` VALUES (11, '1#下_A11', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, 11, 10, 11, 10, 1, 0, '171');
INSERT INTO `device` VALUES (12, '2#下_A12', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '172');
INSERT INTO `device` VALUES (13, '2#下_A13', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '173');
INSERT INTO `device` VALUES (14, '2#下_A14', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '174');
INSERT INTO `device` VALUES (15, '3#上_D1', '127.0.0.1', 2001, 0, 2, b'1', 0, 0, 4, 15, NULL, 0, 0, 0, '209');
INSERT INTO `device` VALUES (16, '3#上_D2', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, 1, 16, NULL, NULL, 0, 0, '210');
INSERT INTO `device` VALUES (17, '3#上_D3', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, 3, 17, NULL, NULL, 0, 0, '211');
INSERT INTO `device` VALUES (18, '3#上_D4', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, 4, 18, NULL, NULL, 0, 0, '212');
INSERT INTO `device` VALUES (19, '5#上_D5', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '213');
INSERT INTO `device` VALUES (20, '4#上_D6', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '214');
INSERT INTO `device` VALUES (21, '1#上_D7', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '215');
INSERT INTO `device` VALUES (22, '2#上_D8', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '216');
INSERT INTO `device` VALUES (23, '2#上_D9', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '217');
INSERT INTO `device` VALUES (24, '3#摆_B1', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, 109, NULL, NULL, NULL, NULL, '177');
INSERT INTO `device` VALUES (25, '5#摆_B2', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '178');
INSERT INTO `device` VALUES (26, '1#摆_B2', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, 113, NULL, NULL, NULL, NULL, '179');
INSERT INTO `device` VALUES (27, '2#摆_B4', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '180');
INSERT INTO `device` VALUES (28, '3#摆_B5', '127.0.0.1', 2002, 2, 0, b'1', NULL, NULL, NULL, 110, NULL, NULL, NULL, NULL, '181');
INSERT INTO `device` VALUES (29, '5#摆_B6', '127.0.0.1', 2002, 2, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '182');
INSERT INTO `device` VALUES (30, '1#摆_B7', '127.0.0.1', 2002, 2, 0, b'0', NULL, NULL, NULL, 114, NULL, NULL, NULL, NULL, '183');
INSERT INTO `device` VALUES (31, '2#摆_B8', '127.0.0.1', 2002, 2, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '184');
INSERT INTO `device` VALUES (32, '3#运_C1', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '193');
INSERT INTO `device` VALUES (33, '3#运_C2', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '194');
INSERT INTO `device` VALUES (34, '3#运_C3', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '195');
INSERT INTO `device` VALUES (35, '3#运_C4', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '196');
INSERT INTO `device` VALUES (36, '3#运_C5', '127.0.0.1', 2003, 4, 0, b'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '197');
INSERT INTO `device` VALUES (37, '3#运_C6', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '198');
INSERT INTO `device` VALUES (38, '3#运_C7', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '199');
INSERT INTO `device` VALUES (39, '3#运_C8', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '200');
INSERT INTO `device` VALUES (40, '5#运_C9', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '201');
INSERT INTO `device` VALUES (41, '5#运_C10', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '202');
INSERT INTO `device` VALUES (42, '5#运_C11', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '203');
INSERT INTO `device` VALUES (43, '1#运_C12', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '204');
INSERT INTO `device` VALUES (44, '1#运_C13', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '205');
INSERT INTO `device` VALUES (45, '1#运_C14', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '206');
INSERT INTO `device` VALUES (46, '1#运_C15', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '207');
INSERT INTO `device` VALUES (47, '2#运_C16', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '208');
INSERT INTO `device` VALUES (48, '2#运_C17', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '209');
INSERT INTO `device` VALUES (49, '2#运_C18', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '210');
INSERT INTO `device` VALUES (50, '2#运_C19', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '211');
INSERT INTO `device` VALUES (51, '2#运_C20', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '212');
INSERT INTO `device` VALUES (52, '2#运_C21', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '213');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction
-- ----------------------------
INSERT INTO `diction` VALUES (1, 0, 4, '序列号生成', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (2, 0, 2, '警告信息', b'1', b'1', b'1', 1);

-- ----------------------------
-- Table structure for diction_dtl
-- ----------------------------
DROP TABLE IF EXISTS `diction_dtl`;
CREATE TABLE `diction_dtl`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `diction_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `int_value` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '整型',
  `bool_value` bit(1) NULL DEFAULT NULL COMMENT 'bool类型',
  `string_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字符串类型',
  `double_value` double(6, 2) UNSIGNED NULL DEFAULT NULL COMMENT '浮点类型',
  `uint_value` int(11) UNSIGNED NULL DEFAULT NULL,
  `order` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `updatetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dic_id_fk`(`diction_id`) USING BTREE,
  CONSTRAINT `dic_id_fk` FOREIGN KEY (`diction_id`) REFERENCES `diction` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction_dtl
-- ----------------------------
INSERT INTO `diction_dtl` VALUES (1, 1, 'NewStockId', '生成库存ID', 0, b'0', '', 0.00, 402, 0, '2020-09-11 19:10:41');
INSERT INTO `diction_dtl` VALUES (2, 1, 'NewTranId', '生成交易ID', 0, b'0', '', 0.00, 444, 0, '2020-09-12 02:16:19');
INSERT INTO `diction_dtl` VALUES (3, 1, 'NewWarnId', '生成警告ID', 0, b'0', '', 0.00, 155, 0, '2020-09-12 10:47:26');
INSERT INTO `diction_dtl` VALUES (4, 2, 'DeviceOffline', '设备离线提示', NULL, b'0', '设备离线', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ferry_pos
-- ----------------------------
DROP TABLE IF EXISTS `ferry_pos`;
CREATE TABLE `ferry_pos`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '轨道ID',
  `device_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '设备ID',
  `ferry_code` smallint(4) UNSIGNED NULL DEFAULT NULL COMMENT '摆渡编码',
  `ferry_pos` int(11) NULL DEFAULT NULL COMMENT '实际坐标',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fepos_traid_idx`(`track_id`) USING BTREE,
  INDEX `fepos_devid_idx`(`device_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 372 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ferry_pos
-- ----------------------------
INSERT INTO `ferry_pos` VALUES (277, 12, 24, 112, 0);
INSERT INTO `ferry_pos` VALUES (278, 13, 24, 113, 0);
INSERT INTO `ferry_pos` VALUES (279, 14, 24, 114, 0);
INSERT INTO `ferry_pos` VALUES (280, 25, 24, 611, 0);
INSERT INTO `ferry_pos` VALUES (281, 26, 24, 612, 0);
INSERT INTO `ferry_pos` VALUES (282, 27, 24, 613, 0);
INSERT INTO `ferry_pos` VALUES (283, 28, 24, 614, 0);
INSERT INTO `ferry_pos` VALUES (284, 59, 24, 231, 0);
INSERT INTO `ferry_pos` VALUES (285, 60, 24, 232, 0);
INSERT INTO `ferry_pos` VALUES (286, 61, 24, 233, 0);
INSERT INTO `ferry_pos` VALUES (287, 62, 24, 234, 0);
INSERT INTO `ferry_pos` VALUES (288, 63, 24, 235, 0);
INSERT INTO `ferry_pos` VALUES (289, 64, 24, 236, 0);
INSERT INTO `ferry_pos` VALUES (290, 65, 24, 237, 0);
INSERT INTO `ferry_pos` VALUES (291, 66, 24, 238, 0);
INSERT INTO `ferry_pos` VALUES (292, 67, 24, 239, 0);
INSERT INTO `ferry_pos` VALUES (293, 68, 24, 240, 0);
INSERT INTO `ferry_pos` VALUES (294, 99, 24, 531, 0);
INSERT INTO `ferry_pos` VALUES (295, 100, 24, 532, 0);
INSERT INTO `ferry_pos` VALUES (296, 101, 24, 533, 0);
INSERT INTO `ferry_pos` VALUES (297, 102, 24, 534, 0);
INSERT INTO `ferry_pos` VALUES (298, 103, 24, 535, 0);
INSERT INTO `ferry_pos` VALUES (299, 104, 24, 536, 0);
INSERT INTO `ferry_pos` VALUES (300, 105, 24, 537, 0);
INSERT INTO `ferry_pos` VALUES (301, 106, 24, 538, 0);
INSERT INTO `ferry_pos` VALUES (302, 107, 24, 539, 0);
INSERT INTO `ferry_pos` VALUES (303, 108, 24, 540, 0);
INSERT INTO `ferry_pos` VALUES (304, 10, 24, 110, 0);
INSERT INTO `ferry_pos` VALUES (305, 11, 24, 111, 0);
INSERT INTO `ferry_pos` VALUES (306, 23, 24, 609, -83938254);
INSERT INTO `ferry_pos` VALUES (307, 24, 24, 610, -83938254);
INSERT INTO `ferry_pos` VALUES (308, 52, 24, 224, 0);
INSERT INTO `ferry_pos` VALUES (309, 53, 24, 225, 0);
INSERT INTO `ferry_pos` VALUES (310, 54, 24, 226, 0);
INSERT INTO `ferry_pos` VALUES (311, 55, 24, 227, 0);
INSERT INTO `ferry_pos` VALUES (312, 56, 24, 228, 0);
INSERT INTO `ferry_pos` VALUES (313, 57, 24, 229, 0);
INSERT INTO `ferry_pos` VALUES (314, 58, 24, 230, 0);
INSERT INTO `ferry_pos` VALUES (315, 92, 24, 524, 0);
INSERT INTO `ferry_pos` VALUES (316, 93, 24, 525, 0);
INSERT INTO `ferry_pos` VALUES (317, 94, 24, 526, 0);
INSERT INTO `ferry_pos` VALUES (318, 95, 24, 527, 0);
INSERT INTO `ferry_pos` VALUES (319, 96, 24, 528, 0);
INSERT INTO `ferry_pos` VALUES (320, 97, 24, 529, 0);
INSERT INTO `ferry_pos` VALUES (321, 98, 24, 530, 0);
INSERT INTO `ferry_pos` VALUES (322, 1, 24, 101, 0);
INSERT INTO `ferry_pos` VALUES (323, 2, 24, 102, 0);
INSERT INTO `ferry_pos` VALUES (324, 3, 24, 103, 0);
INSERT INTO `ferry_pos` VALUES (325, 4, 24, 104, 0);
INSERT INTO `ferry_pos` VALUES (326, 15, 24, 601, 0);
INSERT INTO `ferry_pos` VALUES (327, 16, 24, 602, 0);
INSERT INTO `ferry_pos` VALUES (328, 17, 24, 603, 0);
INSERT INTO `ferry_pos` VALUES (329, 18, 24, 604, 0);
INSERT INTO `ferry_pos` VALUES (330, 29, 24, 201, 0);
INSERT INTO `ferry_pos` VALUES (331, 30, 24, 202, 0);
INSERT INTO `ferry_pos` VALUES (332, 31, 24, 203, 0);
INSERT INTO `ferry_pos` VALUES (333, 32, 24, 204, 0);
INSERT INTO `ferry_pos` VALUES (334, 33, 24, 205, 0);
INSERT INTO `ferry_pos` VALUES (335, 34, 24, 206, 0);
INSERT INTO `ferry_pos` VALUES (336, 35, 24, 207, 0);
INSERT INTO `ferry_pos` VALUES (337, 36, 24, 208, 0);
INSERT INTO `ferry_pos` VALUES (338, 37, 24, 209, 0);
INSERT INTO `ferry_pos` VALUES (339, 38, 24, 210, 0);
INSERT INTO `ferry_pos` VALUES (340, 39, 24, 211, 0);
INSERT INTO `ferry_pos` VALUES (341, 40, 24, 212, 0);
INSERT INTO `ferry_pos` VALUES (342, 69, 24, 501, 0);
INSERT INTO `ferry_pos` VALUES (343, 70, 24, 502, 0);
INSERT INTO `ferry_pos` VALUES (344, 71, 24, 503, 0);
INSERT INTO `ferry_pos` VALUES (345, 72, 24, 504, 0);
INSERT INTO `ferry_pos` VALUES (346, 73, 24, 505, 0);
INSERT INTO `ferry_pos` VALUES (347, 74, 24, 506, 0);
INSERT INTO `ferry_pos` VALUES (348, 75, 24, 507, 0);
INSERT INTO `ferry_pos` VALUES (349, 76, 24, 508, 0);
INSERT INTO `ferry_pos` VALUES (350, 77, 24, 509, 0);
INSERT INTO `ferry_pos` VALUES (351, 78, 24, 510, 0);
INSERT INTO `ferry_pos` VALUES (352, 79, 24, 511, 0);
INSERT INTO `ferry_pos` VALUES (353, 80, 24, 512, 0);
INSERT INTO `ferry_pos` VALUES (354, 8, 24, 108, 0);
INSERT INTO `ferry_pos` VALUES (355, 9, 24, 109, 0);
INSERT INTO `ferry_pos` VALUES (356, 21, 24, 607, 0);
INSERT INTO `ferry_pos` VALUES (357, 22, 24, 608, 0);
INSERT INTO `ferry_pos` VALUES (358, 45, 24, 217, 0);
INSERT INTO `ferry_pos` VALUES (359, 46, 24, 218, 0);
INSERT INTO `ferry_pos` VALUES (360, 47, 24, 219, 0);
INSERT INTO `ferry_pos` VALUES (361, 48, 24, 220, 0);
INSERT INTO `ferry_pos` VALUES (362, 49, 24, 221, 0);
INSERT INTO `ferry_pos` VALUES (363, 50, 24, 222, 0);
INSERT INTO `ferry_pos` VALUES (364, 51, 24, 223, 0);
INSERT INTO `ferry_pos` VALUES (365, 85, 24, 517, 0);
INSERT INTO `ferry_pos` VALUES (366, 86, 24, 518, 0);
INSERT INTO `ferry_pos` VALUES (367, 87, 24, 519, 0);
INSERT INTO `ferry_pos` VALUES (368, 88, 24, 520, 0);
INSERT INTO `ferry_pos` VALUES (369, 89, 24, 521, 0);
INSERT INTO `ferry_pos` VALUES (370, 90, 24, 522, 0);
INSERT INTO `ferry_pos` VALUES (371, 91, 24, 523, 0);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '品种名称',
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '色号',
  `length` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '长',
  `width` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '宽',
  `isoversize` bit(1) NULL DEFAULT NULL COMMENT '是否超限',
  `stack` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '垛数',
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '600x600 ', '白', 600, 600, b'1', 2, NULL);
INSERT INTO `goods` VALUES (2, '600x1200', '红', 600, 1200, b'0', 2, NULL);
INSERT INTO `goods` VALUES (3, '750x1500', '绿', 750, 1500, b'1', 2, NULL);
INSERT INTO `goods` VALUES (4, '800x800-蓝', '蓝', 800, 800, b'0', 2, '');
INSERT INTO `goods` VALUES (5, '800x1600', '紫色', 800, 1600, b'1', 2, NULL);
INSERT INTO `goods` VALUES (8, '900x1800', '番茄色', 900, 1800, b'0', 2, NULL);
INSERT INTO `goods` VALUES (9, '1200x2400', '紫罗兰', 1200, 2400, b'0', 2, NULL);
INSERT INTO `goods` VALUES (10, '1200x2600', '米黄', 1200, 2374, b'1', 2, NULL);
INSERT INTO `goods` VALUES (11, '1600x3200', '雅米', 1600, 3200, b'1', 2, NULL);
INSERT INTO `goods` VALUES (12, '3#大板', '222', 4242, 2323, b'1', 2, '我是备注');
INSERT INTO `goods` VALUES (13, '800x800-绿', '浅绿', 800, 800, b'0', 0, '');
INSERT INTO `goods` VALUES (14, '800x800-黄', '黄', 800, 800, b'0', 0, '');
INSERT INTO `goods` VALUES (15, '800x800-白', '白', 800, 800, b'0', 0, '');

-- ----------------------------
-- Table structure for rf_client
-- ----------------------------
DROP TABLE IF EXISTS `rf_client`;
CREATE TABLE `rf_client`  (
  `rfid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端唯一标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `conn_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最近连接时间',
  `disconn_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最近离线时间',
  PRIMARY KEY (`rfid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rf_client
-- ----------------------------
INSERT INTO `rf_client` VALUES ('1', '1', '1', '2020-08-30 16:03:23', '2020-08-30 16:03:25');

-- ----------------------------
-- Table structure for stock
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock`  (
  `id` int(11) UNSIGNED NOT NULL COMMENT '标识',
  `goods_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '品种ID',
  `stack` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '垛数',
  `pieces` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '片数',
  `track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '储砖轨道ID',
  `produce_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '生产时间',
  `pos` smallint(6) NULL DEFAULT NULL COMMENT '同轨道中的位置 1-100',
  `pos_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '砖在轨道的位置：顶部/中间/底部',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sto_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `sto_track_id_fk`(`track_id`) USING BTREE,
  CONSTRAINT `sto_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sto_track_id_fk` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock
-- ----------------------------
INSERT INTO `stock` VALUES (1, 4, 2, 20, 15, '2020-09-12 02:17:13', 6, 2);
INSERT INTO `stock` VALUES (2, 4, 2, 20, 15, '2020-09-12 01:46:54', 4, 2);
INSERT INTO `stock` VALUES (3, 4, 2, 20, 15, '2020-09-12 01:57:48', 5, 2);
INSERT INTO `stock` VALUES (4, 4, 2, 20, 69, '2020-09-12 00:48:06', 4, 1);
INSERT INTO `stock` VALUES (5, 4, 2, 20, 69, '2020-09-12 00:48:06', 5, 1);
INSERT INTO `stock` VALUES (6, 4, 2, 20, 69, '2020-09-12 00:48:06', 6, 1);
INSERT INTO `stock` VALUES (7, 4, 2, 20, 69, '2020-09-12 00:48:06', 7, 1);
INSERT INTO `stock` VALUES (8, 4, 2, 20, 69, '2020-09-12 00:48:06', 8, 1);
INSERT INTO `stock` VALUES (9, 4, 2, 20, 69, '2020-09-12 00:48:06', 9, 1);
INSERT INTO `stock` VALUES (10, 4, 2, 20, 69, '2020-09-12 00:48:06', 10, 2);
INSERT INTO `stock` VALUES (20, 4, 2, 20, 69, '2020-09-12 00:48:06', 2, 1);
INSERT INTO `stock` VALUES (30, 4, 2, 20, 69, '2020-09-12 00:48:06', 3, 1);
INSERT INTO `stock` VALUES (384, 4, 2, 20, 29, '2020-09-11 18:49:32', 1, 0);
INSERT INTO `stock` VALUES (385, 4, 2, 20, 29, '2020-09-11 18:50:30', 2, 1);
INSERT INTO `stock` VALUES (386, 10, 2, 20, 31, '2020-09-11 18:51:20', 1, 0);
INSERT INTO `stock` VALUES (387, 10, 2, 20, 31, '2020-09-11 18:55:13', 2, 1);
INSERT INTO `stock` VALUES (388, 10, 2, 20, 31, '2020-09-11 18:56:14', 3, 1);
INSERT INTO `stock` VALUES (389, 4, 2, 20, 15, '2020-09-12 01:32:30', 3, 2);
INSERT INTO `stock` VALUES (390, 4, 2, 20, 15, '2020-09-12 02:02:27', 6, 2);
INSERT INTO `stock` VALUES (391, 4, 2, 20, 80, '2020-09-13 00:48:06', 3, 1);
INSERT INTO `stock` VALUES (392, 4, 2, 20, 80, '2020-09-13 00:48:06', 4, 1);
INSERT INTO `stock` VALUES (393, 4, 2, 20, 80, '2020-09-13 00:48:06', 5, 1);
INSERT INTO `stock` VALUES (394, 4, 2, 20, 80, '2020-09-13 00:48:06', 6, 1);
INSERT INTO `stock` VALUES (395, 4, 2, 20, 80, '2020-09-13 00:48:06', 7, 1);
INSERT INTO `stock` VALUES (396, 4, 2, 20, 80, '2020-09-13 00:48:06', 8, 1);
INSERT INTO `stock` VALUES (397, 4, 2, 20, 80, '2020-09-13 00:48:06', 9, 1);
INSERT INTO `stock` VALUES (398, 4, 2, 20, 15, '2020-09-12 00:48:06', 10, 2);
INSERT INTO `stock` VALUES (399, 1, 2, 20, 34, '2020-09-11 19:09:10', 1, 0);
INSERT INTO `stock` VALUES (400, 1, 2, 20, 34, '2020-09-11 19:10:31', 2, 1);
INSERT INTO `stock` VALUES (401, 1, 2, 20, 34, '2020-09-11 19:11:48', 3, 1);

-- ----------------------------
-- Table structure for stock_trans
-- ----------------------------
DROP TABLE IF EXISTS `stock_trans`;
CREATE TABLE `stock_trans`  (
  `id` int(11) UNSIGNED NOT NULL COMMENT '交易ID',
  `trans_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '交易类型 1下砖交易 2 上砖交易',
  `trans_status` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '交易状态',
  `area_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '区域ID',
  `goods_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '品种ID',
  `stock_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '库存ID',
  `take_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '取砖轨道ID',
  `give_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '放砖轨道ID',
  `tilelifter_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '上/下砖机ID',
  `take_ferry_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '取货摆渡车ID',
  `give_ferry_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '放货摆渡车ID',
  `carrier_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '运输车ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '生产时间',
  `load_time` datetime(0) NULL DEFAULT NULL COMMENT '取货时间',
  `unload_time` datetime(0) NULL DEFAULT NULL COMMENT '卸货时间',
  `finish` bit(1) NULL DEFAULT NULL COMMENT '是否完成',
  `finish_time` datetime(0) NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tran_produce_time_idx`(`create_time`) USING BTREE,
  INDEX `tran_type_idx`(`trans_type`) USING BTREE,
  INDEX `tran_status_idx`(`trans_status`) USING BTREE,
  INDEX `tran_finish_idx`(`finish`) USING BTREE,
  INDEX `trans_area_id_fk`(`area_id`) USING BTREE,
  INDEX `tran_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `tran_stock_id_fk`(`stock_id`) USING BTREE,
  CONSTRAINT `tran_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tran_stock_id_fk` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `trans_area_id_fk` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_trans
-- ----------------------------
INSERT INTO `stock_trans` VALUES (412, 0, 3, 3, 4, 384, 1, 29, 1, 24, 24, 32, '2020-09-11 18:48:29', '2020-09-11 18:49:08', '2020-09-11 18:49:31', b'1', '2020-09-11 18:49:32');
INSERT INTO `stock_trans` VALUES (413, 0, 3, 3, 4, 385, 1, 29, 1, 24, 24, 32, '2020-09-11 18:49:40', '2020-09-11 18:50:06', '2020-09-11 18:50:29', b'1', '2020-09-11 18:50:30');
INSERT INTO `stock_trans` VALUES (414, 0, 3, 3, 10, 386, 1, 31, 1, 24, 24, 32, '2020-09-11 18:50:38', '2020-09-11 18:51:04', '2020-09-11 18:51:19', b'1', '2020-09-11 18:51:20');
INSERT INTO `stock_trans` VALUES (415, 0, 3, 3, 10, 387, 1, 31, 1, 24, 24, 32, '2020-09-11 18:54:33', '2020-09-11 18:54:57', '2020-09-11 18:55:12', b'1', '2020-09-11 18:55:13');
INSERT INTO `stock_trans` VALUES (416, 0, 3, 3, 10, 388, 1, 31, 1, 24, 24, 32, '2020-09-11 18:55:29', '2020-09-11 18:55:53', '2020-09-11 18:56:13', b'1', '2020-09-11 18:56:14');
INSERT INTO `stock_trans` VALUES (417, 0, 3, 3, 1, 389, 1, 33, 1, 24, 24, 32, '2020-09-11 18:56:25', '2020-09-11 18:56:50', '2020-09-11 18:57:19', b'1', '2020-09-11 18:57:20');
INSERT INTO `stock_trans` VALUES (418, 0, 3, 3, 1, 390, 1, 33, 1, 24, 24, 32, '2020-09-11 18:57:27', '2020-09-11 18:58:00', '2020-09-11 18:58:29', b'1', '2020-09-11 18:58:30');
INSERT INTO `stock_trans` VALUES (419, 0, 3, 3, 1, 391, 1, 33, 1, 24, 24, 32, '2020-09-11 18:58:37', '2020-09-11 18:59:10', '2020-09-11 18:59:39', b'1', '2020-09-11 18:59:40');
INSERT INTO `stock_trans` VALUES (420, 0, 3, 3, 1, 392, 1, 33, 1, 24, 24, 32, '2020-09-11 18:59:47', '2020-09-11 19:00:20', '2020-09-11 19:00:49', b'1', '2020-09-11 19:00:50');
INSERT INTO `stock_trans` VALUES (421, 0, 3, 3, 1, 393, 1, 33, 1, 24, 24, 32, '2020-09-11 19:00:57', '2020-09-11 19:01:27', '2020-09-11 19:01:54', b'1', '2020-09-11 19:01:55');
INSERT INTO `stock_trans` VALUES (422, 0, 3, 3, 1, 394, 1, 33, 1, 24, 24, 32, '2020-09-11 19:02:05', '2020-09-11 19:02:35', '2020-09-11 19:03:02', b'1', '2020-09-11 19:03:03');
INSERT INTO `stock_trans` VALUES (423, 0, 3, 3, 1, 395, 1, 33, 1, 24, 24, 32, '2020-09-11 19:03:13', '2020-09-11 19:03:43', '2020-09-11 19:04:10', b'1', '2020-09-11 19:04:11');
INSERT INTO `stock_trans` VALUES (424, 0, 3, 3, 1, 396, 1, 33, 1, 24, 24, 32, '2020-09-11 19:04:21', '2020-09-11 19:04:53', '2020-09-11 19:05:23', b'1', '2020-09-11 19:05:24');
INSERT INTO `stock_trans` VALUES (425, 0, 3, 3, 1, 397, 1, 33, 1, 24, 24, 32, '2020-09-11 19:05:31', '2020-09-11 19:06:04', '2020-09-11 19:06:33', b'1', '2020-09-11 19:06:34');
INSERT INTO `stock_trans` VALUES (426, 0, 3, 3, 1, 398, 1, 33, 1, 24, 24, 32, '2020-09-11 19:06:41', '2020-09-11 19:07:20', '2020-09-11 19:07:55', b'1', '2020-09-11 19:07:56');
INSERT INTO `stock_trans` VALUES (427, 0, 3, 3, 1, 399, 1, 34, 1, 24, 24, 33, '2020-09-11 19:08:03', '2020-09-11 19:08:36', '2020-09-11 19:09:09', b'1', '2020-09-11 19:09:10');
INSERT INTO `stock_trans` VALUES (428, 0, 3, 3, 1, 400, 1, 34, 1, 24, 24, 33, '2020-09-11 19:09:19', '2020-09-11 19:09:57', '2020-09-11 19:10:30', b'1', '2020-09-11 19:10:31');
INSERT INTO `stock_trans` VALUES (429, 0, 3, 3, 1, 401, 1, 34, 1, 24, 24, 33, '2020-09-11 19:10:41', '2020-09-11 19:11:15', '2020-09-11 19:11:47', b'1', '2020-09-11 19:11:48');
INSERT INTO `stock_trans` VALUES (439, 1, 1, 3, 4, 2, 69, 15, 15, 28, NULL, 36, '2020-09-12 01:44:34', NULL, NULL, b'1', '2020-09-12 01:44:49');
INSERT INTO `stock_trans` VALUES (440, 1, 3, 3, 4, 2, 69, 15, 15, 28, 28, 36, '2020-09-12 01:46:13', NULL, '2020-09-12 01:46:54', b'1', '2020-09-12 01:47:10');
INSERT INTO `stock_trans` VALUES (441, 1, 3, 3, 4, 3, 69, 15, 15, 28, 28, 36, '2020-09-12 01:57:18', '2020-09-12 01:57:22', '2020-09-12 01:57:48', b'1', '2020-09-12 01:58:03');
INSERT INTO `stock_trans` VALUES (442, 1, 3, 3, 4, 390, 80, 15, 15, 28, 28, 39, '2020-09-12 02:00:14', '2020-09-12 02:00:22', '2020-09-12 02:02:27', b'1', '2020-09-12 02:03:22');
INSERT INTO `stock_trans` VALUES (443, 1, 3, 3, 4, 1, 69, 15, 15, 28, 28, 36, '2020-09-12 02:16:19', '2020-09-12 02:16:59', '2020-09-12 02:17:13', b'1', '2020-09-12 02:17:28');

-- ----------------------------
-- Table structure for track
-- ----------------------------
DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `area` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '区域：过滤作用',
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '类型',
  `status` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '状态',
  `track_status` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '轨道状态停用/启用/倒库中',
  `width` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '轨道宽度',
  `left_distance` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '距离左轨道间距',
  `right_distance` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '距离左轨道间距',
  `ferry_up_code` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '摆渡车上砖测轨道编码',
  `ferry_down_code` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '摆渡车下砖测轨道编码',
  `max_store` int(6) UNSIGNED NULL DEFAULT NULL COMMENT '最大存储数量',
  `brother_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '相邻轨道ID',
  `left_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '靠左轨道ID',
  `right_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '靠右轨道ID',
  `memo` smallint(6) NULL DEFAULT NULL COMMENT '备注',
  `rfid_1` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `rfid_2` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `rfid_3` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `rfid_4` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `rfid_5` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `rfid_6` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `order` smallint(6) NULL DEFAULT NULL COMMENT '顺序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of track
-- ----------------------------
INSERT INTO `track` VALUES (1, '3#下砖轨道1', 3, 1, 0, NULL, 0, 0, 0, 0, 101, 1, 0, 0, 0, NULL, 101, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (2, '3#下砖轨道2', 3, 1, 0, NULL, 0, 0, 0, 0, 102, 1, 0, 0, 0, NULL, 102, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (3, '3#下砖轨道3', 3, 1, 0, NULL, 0, 0, 0, 0, 103, 1, 0, 0, 0, NULL, 103, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (4, '3#下砖轨道4', 3, 1, 0, NULL, 0, 0, 0, 0, 104, 1, 0, 0, 0, NULL, 104, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (5, '5#下砖轨道1', 5, 1, 0, NULL, 0, 0, 0, 0, 105, 1, 0, 0, 0, NULL, 105, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (6, '5#下砖轨道2', 5, 1, 0, NULL, 0, 0, 0, 0, 106, 1, 0, 0, 0, NULL, 106, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (7, '5#下砖轨道3', 5, 1, 0, NULL, 0, 0, 0, 0, 107, 1, 0, 0, 0, NULL, 107, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (8, '4#下砖轨道1', 4, 1, 0, NULL, 0, 0, 0, 0, 108, 1, 0, 0, 0, NULL, 108, 118, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (9, '4#下砖轨道2', 4, 1, 0, NULL, 0, 0, 0, 0, 109, 1, 0, 0, 0, NULL, 109, 119, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (10, '1#下砖轨道1', 1, 1, 0, NULL, 0, 0, 0, 0, 110, 1, 0, 0, 0, NULL, 110, 120, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (11, '1#下砖轨道2', 1, 1, 0, NULL, 0, 0, 0, 0, 111, 1, 0, 0, 0, NULL, 111, 121, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (12, '2#下砖轨道1', 2, 1, 0, NULL, 0, 0, 0, 0, 112, 1, 0, 0, 0, NULL, 112, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (13, '2#下砖轨道2', 2, 1, 0, NULL, 0, 0, 0, 0, 113, 1, 0, 0, 0, NULL, 113, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (14, '2#下砖轨道3', 2, 1, 0, NULL, 0, 0, 0, 0, 114, 1, 0, 0, 0, NULL, 114, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (15, '3#上砖轨道1', 3, 0, 2, NULL, 0, 0, 0, 601, 0, 1, 0, 0, 0, NULL, 601, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (16, '3#上砖轨道2', 3, 0, 0, NULL, 0, 0, 0, 602, 0, 1, 0, 0, 0, NULL, 602, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (17, '3#上砖轨道3', 3, 0, 0, NULL, 0, 0, 0, 603, 0, 1, 0, 0, 0, NULL, 603, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (18, '3#上砖轨道4', 3, 0, 0, NULL, 0, 0, 0, 604, 0, 1, 0, 0, 0, NULL, 604, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (19, '5#上砖轨道1', 5, 0, 0, NULL, 0, 0, 0, 605, 0, 1, 0, 0, 0, NULL, 605, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (20, '5#上砖轨道2', 5, 0, 0, NULL, 0, 0, 0, 606, 0, 1, 0, 0, 0, NULL, 606, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (21, '4#上砖轨道1', 4, 0, 0, NULL, 0, 0, 0, 607, 0, 1, 0, 0, 0, NULL, 607, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (22, '4#上砖轨道2', 4, 0, 0, NULL, 0, 0, 0, 608, 0, 1, 0, 0, 0, NULL, 608, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (23, '1#上砖轨道1', 1, 0, 0, NULL, 0, 0, 0, 609, 0, 1, 0, 0, 0, NULL, 609, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (24, '1#上砖轨道2', 1, 0, 0, NULL, 0, 0, 0, 610, 0, 1, 0, 0, 0, NULL, 610, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (25, '2#上砖轨道1', 2, 0, 0, NULL, 0, 0, 0, 611, 0, 1, 0, 0, 0, NULL, 611, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (26, '2#上砖轨道2', 2, 0, 0, NULL, 0, 0, 0, 612, 0, 1, 0, 0, 0, NULL, 612, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (27, '2#上砖轨道3', 2, 0, 0, NULL, 0, 0, 0, 613, 0, 1, 0, 0, 0, NULL, 613, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (28, '2#上砖轨道4', 2, 0, 0, NULL, 0, 0, 0, 614, 0, 1, 0, 0, 0, NULL, 614, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (29, '3#储砖入_1', 3, 2, 0, NULL, 700, 450, 250, 201, 0, 10, 69, 0, 30, NULL, 201, 301, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (30, '3#储砖入_2', 3, 2, 0, NULL, 700, 250, 250, 202, 0, 10, 70, 29, 31, NULL, 202, 302, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (31, '3#储砖入_3', 3, 2, 0, NULL, 700, 250, 250, 203, 0, 10, 71, 30, 32, NULL, 203, 303, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (32, '3#储砖入_4', 3, 2, 0, NULL, 700, 250, 250, 204, 0, 10, 72, 31, 33, NULL, 204, 304, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (33, '3#储砖入_5', 3, 2, 2, NULL, 700, 250, 250, 205, 0, 10, 73, 32, 34, NULL, 205, 305, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (34, '3#储砖入_6', 3, 2, 0, NULL, 700, 250, 250, 206, 0, 10, 74, 33, 35, NULL, 206, 306, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (35, '3#储砖入_7', 3, 2, 0, NULL, 700, 250, 250, 207, 0, 10, 75, 34, 36, NULL, 207, 307, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (36, '3#储砖入_8', 3, 2, 0, NULL, 700, 250, 250, 208, 0, 10, 76, 35, 37, NULL, 208, 308, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (37, '3#储砖入_9', 3, 2, 0, NULL, 700, 250, 250, 209, 0, 10, 77, 36, 38, NULL, 209, 309, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (38, '3#储砖入_10', 3, 2, 0, NULL, 700, 250, 250, 210, 0, 10, 78, 37, 39, NULL, 210, 310, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (39, '3#储砖入_11', 3, 2, 0, NULL, 700, 250, 250, 211, 0, 10, 79, 38, 40, NULL, 211, 311, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (40, '3#储砖入_12', 3, 2, 0, NULL, 700, 250, 700, 212, 0, 10, 80, 39, 0, NULL, 212, 312, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (41, '5#储砖入_1', 5, 2, 0, NULL, 700, 400, 700, 213, 0, 10, 81, 0, 42, NULL, 213, 313, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (42, '5#储砖入_2', 5, 2, 0, NULL, 700, 700, 700, 214, 0, 10, 82, 41, 43, NULL, 214, 314, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (43, '5#储砖入_3', 5, 2, 0, NULL, 700, 700, 700, 215, 0, 10, 83, 42, 44, NULL, 215, 315, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (44, '5#储砖入_4', 5, 2, 0, NULL, 700, 700, 600, 216, 0, 10, 84, 43, 45, NULL, 216, 316, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (45, '4#储砖入_1', 4, 2, 0, NULL, 700, 600, 400, 217, 0, 10, 85, 43, 46, NULL, 217, 317, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (46, '4#储砖入_2', 4, 2, 0, NULL, 700, 400, 400, 218, 0, 10, 86, 45, 47, NULL, 218, 318, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (47, '4#储砖入_3', 4, 2, 0, NULL, 700, 400, 400, 219, 0, 10, 87, 46, 48, NULL, 219, 319, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (48, '4#储砖入_4', 4, 2, 0, NULL, 700, 400, 400, 220, 0, 10, 88, 47, 49, NULL, 220, 320, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (49, '4#储砖入_5', 4, 2, 0, NULL, 700, 400, 400, 221, 0, 10, 89, 48, 50, NULL, 221, 321, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (50, '4#储砖入_6', 4, 2, 0, NULL, 700, 400, 400, 222, 0, 10, 90, 49, 51, NULL, 222, 322, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (51, '4#储砖入_7', 4, 2, 0, NULL, 700, 400, 800, 223, 0, 10, 91, 50, 52, NULL, 223, 323, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (52, '1#储砖入_1', 1, 2, 0, NULL, 900, 800, 500, 224, 0, 10, 92, 51, 53, NULL, 224, 324, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (53, '1#储砖入_2', 1, 2, 0, NULL, 900, 500, 500, 225, 0, 10, 93, 52, 54, NULL, 225, 325, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (54, '1#储砖入_3', 1, 2, 0, NULL, 900, 500, 500, 226, 0, 10, 94, 53, 55, NULL, 226, 326, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (55, '1#储砖入_4', 1, 2, 0, NULL, 900, 500, 500, 227, 0, 10, 95, 54, 56, NULL, 227, 327, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (56, '1#储砖入_5', 1, 2, 0, NULL, 900, 500, 500, 228, 0, 10, 96, 55, 57, NULL, 228, 328, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (57, '1#储砖入_6', 1, 2, 0, NULL, 900, 500, 500, 229, 0, 10, 97, 56, 58, NULL, 229, 329, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (58, '1#储砖入_7', 1, 2, 0, NULL, 900, 500, 500, 230, 0, 10, 98, 57, 0, NULL, 230, 330, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (59, '2#储砖入_1', 2, 2, 0, NULL, 700, 450, 250, 231, 0, 10, 99, 0, 60, NULL, 231, 331, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (60, '2#储砖入_2', 2, 2, 0, NULL, 700, 250, 250, 232, 0, 10, 100, 59, 61, NULL, 232, 332, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (61, '2#储砖入_3', 2, 2, 0, NULL, 700, 250, 250, 233, 0, 10, 101, 60, 62, NULL, 233, 333, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (62, '2#储砖入_4', 2, 2, 0, NULL, 700, 250, 250, 234, 0, 10, 102, 61, 63, NULL, 234, 334, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (63, '2#储砖入_5', 2, 2, 0, NULL, 700, 250, 250, 235, 0, 10, 103, 62, 64, NULL, 235, 335, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (64, '2#储砖入_6', 2, 2, 0, NULL, 700, 250, 250, 236, 0, 10, 104, 63, 65, NULL, 236, 336, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (65, '2#储砖入_7', 2, 2, 0, NULL, 700, 250, 250, 237, 0, 10, 105, 64, 66, NULL, 237, 337, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (66, '2#储砖入_8', 2, 2, 0, NULL, 700, 250, 250, 238, 0, 10, 106, 65, 67, NULL, 238, 338, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (67, '2#储砖入_9', 2, 2, 0, NULL, 700, 250, 250, 239, 0, 10, 107, 66, 68, NULL, 239, 339, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (68, '2#储砖入_10', 2, 2, 0, NULL, 700, 250, 250, 240, 0, 10, 108, 67, 0, NULL, 240, 340, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (69, '3#储砖出_1', 3, 3, 0, NULL, 700, 450, 250, 0, 501, 10, 29, 0, 70, NULL, 501, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (70, '3#储砖出_2', 3, 3, 0, NULL, 700, 250, 250, 0, 502, 10, 30, 69, 71, NULL, 502, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (71, '3#储砖出_3', 3, 3, 0, NULL, 700, 250, 250, 0, 503, 10, 31, 70, 72, NULL, 503, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (72, '3#储砖出_4', 3, 3, 0, NULL, 700, 250, 250, 0, 504, 10, 32, 71, 73, NULL, 504, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (73, '3#储砖出_5', 3, 3, 0, NULL, 700, 250, 250, 0, 505, 10, 33, 72, 74, NULL, 505, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (74, '3#储砖出_6', 3, 3, 0, NULL, 700, 250, 250, 0, 506, 10, 34, 73, 75, NULL, 506, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (75, '3#储砖出_7', 3, 3, 0, NULL, 700, 250, 250, 0, 507, 10, 35, 74, 76, NULL, 507, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (76, '3#储砖出_8', 3, 3, 0, NULL, 700, 250, 250, 0, 508, 10, 36, 75, 77, NULL, 508, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (77, '3#储砖出_9', 3, 3, 0, NULL, 700, 250, 250, 0, 509, 10, 37, 76, 78, NULL, 509, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (78, '3#储砖出_10', 3, 3, 0, NULL, 700, 250, 250, 0, 510, 10, 38, 77, 79, NULL, 510, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (79, '3#储砖出_11', 3, 3, 0, NULL, 700, 250, 250, 0, 511, 10, 39, 78, 80, NULL, 511, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (80, '3#储砖出_12', 3, 3, 0, NULL, 700, 250, 700, 0, 512, 10, 40, 79, 0, NULL, 512, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (81, '5#储砖出_1', 5, 3, 0, NULL, 700, 400, 700, 0, 513, 10, 41, 0, 82, NULL, 513, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (82, '5#储砖出_2', 5, 3, 0, NULL, 700, 700, 700, 0, 514, 10, 42, 81, 83, NULL, 514, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (83, '5#储砖出_3', 5, 3, 0, NULL, 700, 700, 700, 0, 515, 10, 43, 82, 84, NULL, 515, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (84, '5#储砖出_4', 5, 3, 0, NULL, 700, 700, 600, 0, 516, 10, 44, 83, 85, NULL, 516, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (85, '4#储砖出_1', 4, 3, 0, NULL, 700, 600, 400, 0, 517, 10, 45, 84, 86, NULL, 517, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (86, '4#储砖出_2', 4, 3, 0, NULL, 700, 400, 400, 0, 518, 10, 46, 85, 87, NULL, 518, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (87, '4#储砖出_3', 4, 3, 0, NULL, 700, 400, 400, 0, 519, 10, 47, 86, 88, NULL, 519, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (88, '4#储砖出_4', 4, 3, 0, NULL, 700, 400, 400, 0, 520, 10, 48, 87, 89, NULL, 520, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (89, '4#储砖出_5', 4, 3, 0, NULL, 700, 400, 400, 0, 521, 10, 49, 88, 90, NULL, 521, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (90, '4#储砖出_6', 4, 3, 0, NULL, 700, 400, 400, 0, 522, 10, 50, 89, 91, NULL, 522, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (91, '4#储砖出_7', 4, 3, 0, NULL, 700, 400, 800, 0, 523, 10, 51, 90, 92, NULL, 523, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (92, '1#储砖出_1', 1, 3, 0, NULL, 900, 800, 500, 0, 524, 10, 52, 91, 93, NULL, 524, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (93, '1#储砖出_2', 1, 3, 0, NULL, 900, 500, 500, 0, 525, 10, 53, 92, 94, NULL, 525, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (94, '1#储砖出_3', 1, 3, 0, NULL, 900, 500, 500, 0, 526, 10, 54, 93, 95, NULL, 526, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (95, '1#储砖出_4', 1, 3, 0, NULL, 900, 500, 500, 0, 527, 10, 55, 94, 96, NULL, 527, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (96, '1#储砖出_5', 1, 3, 0, NULL, 900, 500, 500, 0, 528, 10, 56, 95, 97, NULL, 528, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (97, '1#储砖出_6', 1, 3, 0, NULL, 900, 500, 500, 0, 529, 10, 57, 96, 98, NULL, 529, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (98, '1#储砖出_7', 1, 3, 0, NULL, 900, 500, 500, 0, 530, 10, 58, 97, 0, NULL, 530, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (99, '2#储砖出_1', 2, 3, 0, NULL, 700, 450, 250, 0, 531, 10, 59, 0, 100, NULL, 531, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (100, '2#储砖出_2', 2, 3, 0, NULL, 700, 250, 250, 0, 532, 10, 60, 99, 101, NULL, 532, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (101, '2#储砖出_3', 2, 3, 0, NULL, 700, 250, 250, 0, 533, 10, 61, 100, 102, NULL, 533, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (102, '2#储砖出_4', 2, 3, 0, NULL, 700, 250, 250, 0, 534, 10, 62, 101, 103, NULL, 534, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (103, '2#储砖出_5', 2, 3, 0, NULL, 700, 250, 250, 0, 535, 10, 63, 102, 104, NULL, 535, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (104, '2#储砖出_6', 2, 3, 0, NULL, 700, 250, 250, 0, 536, 10, 64, 103, 105, NULL, 536, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (105, '2#储砖出_7', 2, 3, 0, NULL, 700, 250, 250, 0, 537, 10, 65, 104, 106, NULL, 537, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (106, '2#储砖出_8', 2, 3, 0, NULL, 700, 250, 250, 0, 538, 10, 66, 105, 107, NULL, 538, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (107, '2#储砖出_9', 2, 3, 0, NULL, 700, 250, 250, 0, 539, 10, 67, 106, 108, NULL, 539, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (108, '2#储砖出_10', 2, 3, 0, NULL, 700, 250, 250, 0, 540, 10, 68, 107, 0, NULL, 540, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (109, '3#摆渡轨道_1', 3, 5, 2, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 701, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (110, '3#摆渡轨道_2', 3, 6, 2, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 741, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (111, '5#摆渡轨道_1', 5, 5, 0, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 702, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (112, '5#摆渡轨道_2', 5, 6, 0, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 742, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (113, '1#摆渡轨道_1', 1, 5, 0, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 703, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (114, '1#摆渡轨道_2', 1, 6, 0, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 743, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (115, '2#摆渡轨道_1', 2, 5, 0, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 704, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `track` VALUES (116, '2#摆渡轨道_2', 3, 6, 0, NULL, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 744, NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for warning
-- ----------------------------
DROP TABLE IF EXISTS `warning`;
CREATE TABLE `warning`  (
  `id` int(11) UNSIGNED NULL DEFAULT NULL,
  `area_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `resolve` bit(1) NULL DEFAULT NULL COMMENT '是否解决',
  `dev_id` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `trans_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `createtime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '报警时间',
  `resolvetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '解决时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warning
-- ----------------------------
INSERT INTO `warning` VALUES (110, 0, 0, b'1', 28, 0, '3#摆_B5: 设备离线', '2020-09-12 01:37:06', '2020-09-12 01:37:06');
INSERT INTO `warning` VALUES (111, 0, 0, b'1', 36, 0, '3#运_C5: 设备离线', '2020-09-12 01:37:06', '2020-09-12 01:37:06');
INSERT INTO `warning` VALUES (112, 0, 0, b'1', 37, 0, '3#运_C6: 设备离线', '2020-09-12 01:37:06', '2020-09-12 01:37:06');
INSERT INTO `warning` VALUES (113, 0, 0, b'1', 38, 0, '3#运_C7: 设备离线', '2020-09-12 01:37:06', '2020-09-12 01:37:06');
INSERT INTO `warning` VALUES (114, 0, 0, b'1', 17, 0, '3#上_D3: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:06');
INSERT INTO `warning` VALUES (115, 0, 0, b'1', 35, 0, '3#运_C4: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:06');
INSERT INTO `warning` VALUES (116, 0, 0, b'1', 39, 0, '3#运_C8: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:07');
INSERT INTO `warning` VALUES (118, 0, 0, b'1', 33, 0, '3#运_C2: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:07');
INSERT INTO `warning` VALUES (117, 0, 0, b'1', 16, 0, '3#上_D2: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:07');
INSERT INTO `warning` VALUES (119, 0, 0, b'1', 32, 0, '3#运_C1: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:07');
INSERT INTO `warning` VALUES (120, 0, 0, b'1', 34, 0, '3#运_C3: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:07');
INSERT INTO `warning` VALUES (121, 0, 0, b'1', 18, 0, '3#上_D4: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:07');
INSERT INTO `warning` VALUES (122, 0, 0, b'1', 15, 0, '3#上_D1: 设备离线', '2020-09-12 01:37:07', '2020-09-12 01:37:07');
INSERT INTO `warning` VALUES (123, 0, 0, b'1', 36, 0, '3#运_C5: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (124, 0, 0, b'1', 38, 0, '3#运_C7: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (125, 0, 0, b'1', 35, 0, '3#运_C4: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (126, 0, 0, b'1', 18, 0, '3#上_D4: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (127, 0, 0, b'1', 28, 0, '3#摆_B5: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (128, 0, 0, b'1', 16, 0, '3#上_D2: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (129, 0, 0, b'1', 33, 0, '3#运_C2: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (130, 0, 0, b'1', 15, 0, '3#上_D1: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (131, 0, 0, b'1', 32, 0, '3#运_C1: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (132, 0, 0, b'1', 17, 0, '3#上_D3: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (133, 0, 0, b'1', 39, 0, '3#运_C8: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (134, 0, 0, b'1', 34, 0, '3#运_C3: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (135, 0, 0, b'1', 37, 0, '3#运_C6: 设备离线', '2020-09-12 02:00:00', '2020-09-12 02:00:00');
INSERT INTO `warning` VALUES (136, 0, 0, b'1', 28, 0, '3#摆_B5: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (137, 0, 0, b'1', 34, 0, '3#运_C3: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (138, 0, 0, b'1', 38, 0, '3#运_C7: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (139, 0, 0, b'1', 35, 0, '3#运_C4: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (140, 0, 0, b'1', 37, 0, '3#运_C6: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (141, 0, 0, b'1', 39, 0, '3#运_C8: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (142, 0, 0, b'1', 36, 0, '3#运_C5: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (143, 0, 0, b'1', 33, 0, '3#运_C2: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (144, 0, 0, b'1', 32, 0, '3#运_C1: 设备离线', '2020-09-12 02:05:08', '2020-09-12 02:05:08');
INSERT INTO `warning` VALUES (145, 0, 0, b'1', 15, 0, '3#上_D1: 设备离线', '2020-09-12 02:05:09', '2020-09-12 02:05:09');
INSERT INTO `warning` VALUES (146, 0, 0, b'1', 16, 0, '3#上_D2: 设备离线', '2020-09-12 02:05:09', '2020-09-12 02:05:09');
INSERT INTO `warning` VALUES (147, 0, 0, b'1', 18, 0, '3#上_D4: 设备离线', '2020-09-12 02:05:09', '2020-09-12 02:05:09');
INSERT INTO `warning` VALUES (148, 0, 0, b'1', 17, 0, '3#上_D3: 设备离线', '2020-09-12 02:05:09', '2020-09-12 02:05:09');
INSERT INTO `warning` VALUES (150, 0, 0, b'1', 15, 0, '3#上_D1: 设备离线', '2020-09-12 02:14:44', '2020-09-12 02:14:44');
INSERT INTO `warning` VALUES (149, 0, 0, b'1', 32, 0, '3#运_C1: 设备离线', '2020-09-12 02:14:44', '2020-09-12 02:14:44');
INSERT INTO `warning` VALUES (151, 0, 0, b'1', 28, 0, '3#摆_B5: 设备离线', '2020-09-12 02:14:44', '2020-09-12 02:14:44');
INSERT INTO `warning` VALUES (152, 0, 0, b'0', 15, 0, '3#上_D1: 设备离线', '2020-09-12 10:47:26', NULL);
INSERT INTO `warning` VALUES (153, 0, 0, b'0', 36, 0, '3#运_C5: 设备离线', '2020-09-12 10:47:26', NULL);
INSERT INTO `warning` VALUES (154, 0, 0, b'0', 28, 0, '3#摆_B5: 设备离线', '2020-09-12 10:47:26', NULL);

-- ----------------------------
-- View structure for stock_sum
-- ----------------------------
DROP VIEW IF EXISTS `stock_sum`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `stock_sum` AS select `t`.`goods_id` AS `goods_id`,`t`.`track_id` AS `track_id`,min(`t`.`produce_time`) AS `produce_time`,count(`t`.`id`) AS `count`,sum(`t`.`pieces`) AS `pieces`,sum(`t`.`stack`) AS `stack` from `stock` `t` group by `t`.`track_id`,`t`.`goods_id`;

SET FOREIGN_KEY_CHECKS = 1;
