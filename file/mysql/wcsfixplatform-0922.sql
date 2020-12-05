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

 Date: 22/09/2020 11:24:19
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
INSERT INTO `area_device` VALUES (17, 5, 17, 0, NULL);
INSERT INTO `area_device` VALUES (18, 4, 18, 0, NULL);
INSERT INTO `area_device` VALUES (19, 1, 19, 0, NULL);
INSERT INTO `area_device` VALUES (20, 2, 20, 0, NULL);
INSERT INTO `area_device` VALUES (21, 2, 21, 0, NULL);
INSERT INTO `area_device` VALUES (22, 3, 22, 3, NULL);
INSERT INTO `area_device` VALUES (23, 5, 23, 3, NULL);
INSERT INTO `area_device` VALUES (24, 1, 24, 3, NULL);
INSERT INTO `area_device` VALUES (25, 2, 25, 3, NULL);
INSERT INTO `area_device` VALUES (26, 3, 26, 2, NULL);
INSERT INTO `area_device` VALUES (27, 5, 27, 2, NULL);
INSERT INTO `area_device` VALUES (28, 1, 28, 2, NULL);
INSERT INTO `area_device` VALUES (29, 2, 29, 2, NULL);
INSERT INTO `area_device` VALUES (30, 3, 30, 4, NULL);
INSERT INTO `area_device` VALUES (31, 3, 31, 4, NULL);
INSERT INTO `area_device` VALUES (32, 3, 32, 4, NULL);
INSERT INTO `area_device` VALUES (33, 3, 33, 4, NULL);
INSERT INTO `area_device` VALUES (34, 3, 34, 4, NULL);
INSERT INTO `area_device` VALUES (35, 3, 35, 4, NULL);
INSERT INTO `area_device` VALUES (36, 3, 36, 4, NULL);
INSERT INTO `area_device` VALUES (37, 3, 37, 4, NULL);
INSERT INTO `area_device` VALUES (38, 5, 38, 4, NULL);
INSERT INTO `area_device` VALUES (39, 5, 39, 4, NULL);
INSERT INTO `area_device` VALUES (40, 5, 40, 4, NULL);
INSERT INTO `area_device` VALUES (41, 1, 41, 4, NULL);
INSERT INTO `area_device` VALUES (42, 1, 42, 4, NULL);
INSERT INTO `area_device` VALUES (43, 1, 43, 4, NULL);
INSERT INTO `area_device` VALUES (44, 1, 44, 4, NULL);
INSERT INTO `area_device` VALUES (45, 2, 45, 4, NULL);
INSERT INTO `area_device` VALUES (46, 2, 46, 4, NULL);
INSERT INTO `area_device` VALUES (47, 2, 47, 4, NULL);
INSERT INTO `area_device` VALUES (48, 2, 48, 4, NULL);
INSERT INTO `area_device` VALUES (49, 2, 49, 4, NULL);
INSERT INTO `area_device` VALUES (50, 2, 50, 4, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 610 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area_device_track
-- ----------------------------
INSERT INTO `area_device_track` VALUES (325, 1, 24, 52, 70);
INSERT INTO `area_device_track` VALUES (326, 1, 24, 53, 60);
INSERT INTO `area_device_track` VALUES (327, 1, 24, 54, 50);
INSERT INTO `area_device_track` VALUES (328, 1, 24, 55, 40);
INSERT INTO `area_device_track` VALUES (329, 1, 24, 56, 30);
INSERT INTO `area_device_track` VALUES (330, 1, 24, 57, 20);
INSERT INTO `area_device_track` VALUES (331, 1, 24, 58, 10);
INSERT INTO `area_device_track` VALUES (332, 1, 24, 10, 1);
INSERT INTO `area_device_track` VALUES (334, 1, 24, 45, 140);
INSERT INTO `area_device_track` VALUES (335, 1, 24, 46, 130);
INSERT INTO `area_device_track` VALUES (336, 1, 24, 47, 120);
INSERT INTO `area_device_track` VALUES (337, 1, 24, 48, 110);
INSERT INTO `area_device_track` VALUES (338, 1, 24, 49, 100);
INSERT INTO `area_device_track` VALUES (339, 1, 24, 50, 90);
INSERT INTO `area_device_track` VALUES (340, 1, 24, 51, 80);
INSERT INTO `area_device_track` VALUES (343, 1, 24, 11, 1);
INSERT INTO `area_device_track` VALUES (344, 1, 28, 92, 70);
INSERT INTO `area_device_track` VALUES (345, 1, 28, 93, 60);
INSERT INTO `area_device_track` VALUES (346, 1, 28, 94, 50);
INSERT INTO `area_device_track` VALUES (347, 1, 28, 95, 40);
INSERT INTO `area_device_track` VALUES (348, 1, 28, 96, 30);
INSERT INTO `area_device_track` VALUES (349, 1, 28, 97, 20);
INSERT INTO `area_device_track` VALUES (350, 1, 28, 98, 10);
INSERT INTO `area_device_track` VALUES (351, 1, 28, 23, 1);
INSERT INTO `area_device_track` VALUES (352, 1, 28, 24, 1);
INSERT INTO `area_device_track` VALUES (353, 1, 28, 85, 140);
INSERT INTO `area_device_track` VALUES (354, 1, 28, 86, 130);
INSERT INTO `area_device_track` VALUES (355, 1, 28, 87, 120);
INSERT INTO `area_device_track` VALUES (356, 1, 28, 88, 110);
INSERT INTO `area_device_track` VALUES (357, 1, 28, 89, 100);
INSERT INTO `area_device_track` VALUES (358, 1, 28, 90, 90);
INSERT INTO `area_device_track` VALUES (359, 1, 28, 91, 80);
INSERT INTO `area_device_track` VALUES (362, 1, 10, 52, 70);
INSERT INTO `area_device_track` VALUES (363, 1, 10, 53, 60);
INSERT INTO `area_device_track` VALUES (364, 1, 10, 54, 50);
INSERT INTO `area_device_track` VALUES (365, 1, 10, 55, 40);
INSERT INTO `area_device_track` VALUES (366, 1, 10, 56, 30);
INSERT INTO `area_device_track` VALUES (367, 1, 10, 57, 20);
INSERT INTO `area_device_track` VALUES (368, 1, 10, 58, 10);
INSERT INTO `area_device_track` VALUES (369, 1, 10, 45, 140);
INSERT INTO `area_device_track` VALUES (370, 1, 10, 46, 130);
INSERT INTO `area_device_track` VALUES (371, 1, 10, 47, 120);
INSERT INTO `area_device_track` VALUES (372, 1, 10, 48, 110);
INSERT INTO `area_device_track` VALUES (373, 1, 10, 49, 100);
INSERT INTO `area_device_track` VALUES (374, 1, 10, 50, 90);
INSERT INTO `area_device_track` VALUES (375, 1, 10, 51, 80);
INSERT INTO `area_device_track` VALUES (376, 1, 11, 52, 70);
INSERT INTO `area_device_track` VALUES (377, 1, 11, 53, 60);
INSERT INTO `area_device_track` VALUES (378, 1, 11, 54, 50);
INSERT INTO `area_device_track` VALUES (379, 1, 11, 55, 40);
INSERT INTO `area_device_track` VALUES (380, 1, 11, 56, 30);
INSERT INTO `area_device_track` VALUES (381, 1, 11, 57, 20);
INSERT INTO `area_device_track` VALUES (382, 1, 11, 58, 10);
INSERT INTO `area_device_track` VALUES (383, 1, 11, 45, 140);
INSERT INTO `area_device_track` VALUES (384, 1, 11, 46, 130);
INSERT INTO `area_device_track` VALUES (385, 1, 11, 47, 120);
INSERT INTO `area_device_track` VALUES (386, 1, 11, 48, 110);
INSERT INTO `area_device_track` VALUES (387, 1, 11, 49, 100);
INSERT INTO `area_device_track` VALUES (388, 1, 11, 50, 90);
INSERT INTO `area_device_track` VALUES (389, 1, 11, 51, 80);
INSERT INTO `area_device_track` VALUES (390, 1, 19, 92, 70);
INSERT INTO `area_device_track` VALUES (391, 1, 19, 93, 60);
INSERT INTO `area_device_track` VALUES (392, 1, 19, 94, 50);
INSERT INTO `area_device_track` VALUES (393, 1, 19, 95, 40);
INSERT INTO `area_device_track` VALUES (394, 1, 19, 96, 30);
INSERT INTO `area_device_track` VALUES (395, 1, 19, 97, 20);
INSERT INTO `area_device_track` VALUES (396, 1, 19, 98, 10);
INSERT INTO `area_device_track` VALUES (397, 1, 19, 85, 140);
INSERT INTO `area_device_track` VALUES (398, 1, 19, 86, 130);
INSERT INTO `area_device_track` VALUES (399, 1, 19, 87, 120);
INSERT INTO `area_device_track` VALUES (400, 1, 19, 88, 110);
INSERT INTO `area_device_track` VALUES (401, 1, 19, 89, 100);
INSERT INTO `area_device_track` VALUES (402, 1, 19, 90, 90);
INSERT INTO `area_device_track` VALUES (403, 1, 19, 91, 80);
INSERT INTO `area_device_track` VALUES (404, 5, 5, 41, 10);
INSERT INTO `area_device_track` VALUES (405, 5, 5, 42, 20);
INSERT INTO `area_device_track` VALUES (406, 5, 5, 43, 30);
INSERT INTO `area_device_track` VALUES (407, 5, 5, 44, 40);
INSERT INTO `area_device_track` VALUES (408, 5, 5, 45, 60);
INSERT INTO `area_device_track` VALUES (409, 5, 5, 46, 50);
INSERT INTO `area_device_track` VALUES (410, 5, 5, 47, 70);
INSERT INTO `area_device_track` VALUES (411, 5, 5, 48, 80);
INSERT INTO `area_device_track` VALUES (412, 5, 5, 49, 90);
INSERT INTO `area_device_track` VALUES (413, 5, 5, 50, 100);
INSERT INTO `area_device_track` VALUES (414, 5, 5, 51, 110);
INSERT INTO `area_device_track` VALUES (415, 5, 6, 41, 10);
INSERT INTO `area_device_track` VALUES (416, 5, 6, 42, 20);
INSERT INTO `area_device_track` VALUES (417, 5, 6, 43, 30);
INSERT INTO `area_device_track` VALUES (418, 5, 6, 44, 40);
INSERT INTO `area_device_track` VALUES (419, 5, 6, 45, 60);
INSERT INTO `area_device_track` VALUES (420, 5, 6, 46, 50);
INSERT INTO `area_device_track` VALUES (421, 5, 6, 47, 70);
INSERT INTO `area_device_track` VALUES (422, 5, 6, 48, 80);
INSERT INTO `area_device_track` VALUES (423, 5, 6, 49, 90);
INSERT INTO `area_device_track` VALUES (424, 5, 6, 50, 100);
INSERT INTO `area_device_track` VALUES (425, 5, 6, 51, 110);
INSERT INTO `area_device_track` VALUES (426, 5, 7, 41, 10);
INSERT INTO `area_device_track` VALUES (427, 5, 7, 42, 20);
INSERT INTO `area_device_track` VALUES (428, 5, 7, 43, 30);
INSERT INTO `area_device_track` VALUES (429, 5, 7, 44, 40);
INSERT INTO `area_device_track` VALUES (430, 5, 7, 45, 60);
INSERT INTO `area_device_track` VALUES (431, 5, 7, 46, 50);
INSERT INTO `area_device_track` VALUES (432, 5, 7, 47, 70);
INSERT INTO `area_device_track` VALUES (433, 5, 7, 48, 80);
INSERT INTO `area_device_track` VALUES (434, 5, 7, 49, 90);
INSERT INTO `area_device_track` VALUES (435, 5, 7, 50, 100);
INSERT INTO `area_device_track` VALUES (436, 5, 7, 51, 110);
INSERT INTO `area_device_track` VALUES (437, 5, 17, 81, 10);
INSERT INTO `area_device_track` VALUES (438, 5, 17, 82, 20);
INSERT INTO `area_device_track` VALUES (439, 5, 17, 83, 30);
INSERT INTO `area_device_track` VALUES (440, 5, 17, 84, 40);
INSERT INTO `area_device_track` VALUES (441, 5, 17, 85, 50);
INSERT INTO `area_device_track` VALUES (442, 5, 17, 86, 60);
INSERT INTO `area_device_track` VALUES (443, 5, 17, 87, 70);
INSERT INTO `area_device_track` VALUES (444, 5, 17, 88, 80);
INSERT INTO `area_device_track` VALUES (445, 5, 17, 89, 90);
INSERT INTO `area_device_track` VALUES (446, 5, 17, 90, 100);
INSERT INTO `area_device_track` VALUES (447, 5, 17, 91, 110);
INSERT INTO `area_device_track` VALUES (448, 5, 23, 41, 2);
INSERT INTO `area_device_track` VALUES (449, 5, 23, 42, 3);
INSERT INTO `area_device_track` VALUES (450, 5, 23, 43, 4);
INSERT INTO `area_device_track` VALUES (451, 5, 23, 44, 5);
INSERT INTO `area_device_track` VALUES (452, 5, 23, 5, 1);
INSERT INTO `area_device_track` VALUES (453, 5, 23, 6, 1);
INSERT INTO `area_device_track` VALUES (454, 5, 23, 7, 1);
INSERT INTO `area_device_track` VALUES (455, 5, 23, 45, 8);
INSERT INTO `area_device_track` VALUES (456, 5, 23, 46, 9);
INSERT INTO `area_device_track` VALUES (457, 5, 23, 47, 10);
INSERT INTO `area_device_track` VALUES (458, 5, 23, 48, 11);
INSERT INTO `area_device_track` VALUES (459, 5, 23, 49, 12);
INSERT INTO `area_device_track` VALUES (460, 5, 23, 50, 13);
INSERT INTO `area_device_track` VALUES (461, 5, 23, 51, 14);
INSERT INTO `area_device_track` VALUES (462, 5, 23, 8, 15);
INSERT INTO `area_device_track` VALUES (463, 5, 23, 9, 16);
INSERT INTO `area_device_track` VALUES (464, 5, 27, 81, 2);
INSERT INTO `area_device_track` VALUES (465, 5, 27, 82, 3);
INSERT INTO `area_device_track` VALUES (466, 5, 27, 83, 4);
INSERT INTO `area_device_track` VALUES (467, 5, 27, 84, 5);
INSERT INTO `area_device_track` VALUES (468, 5, 27, 19, 1);
INSERT INTO `area_device_track` VALUES (469, 5, 27, 20, 1);
INSERT INTO `area_device_track` VALUES (470, 5, 27, 85, 7);
INSERT INTO `area_device_track` VALUES (471, 5, 27, 86, 8);
INSERT INTO `area_device_track` VALUES (472, 5, 27, 87, 9);
INSERT INTO `area_device_track` VALUES (473, 5, 27, 88, 10);
INSERT INTO `area_device_track` VALUES (474, 5, 27, 89, 11);
INSERT INTO `area_device_track` VALUES (475, 5, 27, 90, 12);
INSERT INTO `area_device_track` VALUES (476, 5, 27, 91, 13);
INSERT INTO `area_device_track` VALUES (477, 5, 27, 21, 14);
INSERT INTO `area_device_track` VALUES (478, 5, 27, 22, 15);
INSERT INTO `area_device_track` VALUES (479, 3, 1, 29, 1);
INSERT INTO `area_device_track` VALUES (480, 3, 1, 30, 2);
INSERT INTO `area_device_track` VALUES (481, 3, 1, 31, 3);
INSERT INTO `area_device_track` VALUES (482, 3, 1, 32, 4);
INSERT INTO `area_device_track` VALUES (483, 3, 1, 33, 5);
INSERT INTO `area_device_track` VALUES (484, 3, 1, 34, 6);
INSERT INTO `area_device_track` VALUES (485, 3, 1, 35, 7);
INSERT INTO `area_device_track` VALUES (486, 3, 1, 36, 8);
INSERT INTO `area_device_track` VALUES (487, 3, 1, 37, 9);
INSERT INTO `area_device_track` VALUES (488, 3, 1, 38, 10);
INSERT INTO `area_device_track` VALUES (489, 3, 1, 39, 11);
INSERT INTO `area_device_track` VALUES (490, 3, 1, 40, 12);
INSERT INTO `area_device_track` VALUES (491, 3, 4, 29, 12);
INSERT INTO `area_device_track` VALUES (492, 3, 4, 30, 11);
INSERT INTO `area_device_track` VALUES (493, 3, 4, 31, 10);
INSERT INTO `area_device_track` VALUES (494, 3, 4, 32, 9);
INSERT INTO `area_device_track` VALUES (495, 3, 4, 33, 8);
INSERT INTO `area_device_track` VALUES (496, 3, 4, 34, 7);
INSERT INTO `area_device_track` VALUES (497, 3, 4, 35, 6);
INSERT INTO `area_device_track` VALUES (498, 3, 4, 36, 5);
INSERT INTO `area_device_track` VALUES (499, 3, 4, 37, 4);
INSERT INTO `area_device_track` VALUES (500, 3, 4, 38, 3);
INSERT INTO `area_device_track` VALUES (501, 3, 4, 39, 2);
INSERT INTO `area_device_track` VALUES (502, 3, 4, 40, 1);
INSERT INTO `area_device_track` VALUES (503, 3, 2, 29, 6);
INSERT INTO `area_device_track` VALUES (504, 3, 2, 30, 5);
INSERT INTO `area_device_track` VALUES (505, 3, 2, 31, 4);
INSERT INTO `area_device_track` VALUES (506, 3, 2, 32, 3);
INSERT INTO `area_device_track` VALUES (507, 3, 2, 33, 2);
INSERT INTO `area_device_track` VALUES (508, 3, 2, 34, 1);
INSERT INTO `area_device_track` VALUES (509, 3, 2, 35, 7);
INSERT INTO `area_device_track` VALUES (510, 3, 2, 36, 8);
INSERT INTO `area_device_track` VALUES (511, 3, 2, 37, 9);
INSERT INTO `area_device_track` VALUES (512, 3, 2, 38, 10);
INSERT INTO `area_device_track` VALUES (513, 3, 2, 39, 11);
INSERT INTO `area_device_track` VALUES (514, 3, 2, 40, 12);
INSERT INTO `area_device_track` VALUES (515, 3, 3, 29, 12);
INSERT INTO `area_device_track` VALUES (516, 3, 3, 30, 11);
INSERT INTO `area_device_track` VALUES (517, 3, 3, 31, 10);
INSERT INTO `area_device_track` VALUES (518, 3, 3, 32, 9);
INSERT INTO `area_device_track` VALUES (519, 3, 3, 33, 8);
INSERT INTO `area_device_track` VALUES (520, 3, 3, 34, 7);
INSERT INTO `area_device_track` VALUES (521, 3, 3, 35, 1);
INSERT INTO `area_device_track` VALUES (522, 3, 3, 36, 2);
INSERT INTO `area_device_track` VALUES (523, 3, 3, 37, 3);
INSERT INTO `area_device_track` VALUES (524, 3, 3, 38, 4);
INSERT INTO `area_device_track` VALUES (525, 3, 3, 39, 5);
INSERT INTO `area_device_track` VALUES (526, 3, 3, 40, 6);
INSERT INTO `area_device_track` VALUES (527, 3, 22, 29, 1);
INSERT INTO `area_device_track` VALUES (528, 3, 22, 30, 2);
INSERT INTO `area_device_track` VALUES (529, 3, 22, 31, 3);
INSERT INTO `area_device_track` VALUES (530, 3, 22, 32, 4);
INSERT INTO `area_device_track` VALUES (531, 3, 22, 33, 5);
INSERT INTO `area_device_track` VALUES (532, 3, 22, 34, 6);
INSERT INTO `area_device_track` VALUES (533, 3, 22, 35, 7);
INSERT INTO `area_device_track` VALUES (534, 3, 22, 36, 8);
INSERT INTO `area_device_track` VALUES (535, 3, 22, 37, 9);
INSERT INTO `area_device_track` VALUES (536, 3, 22, 38, 10);
INSERT INTO `area_device_track` VALUES (537, 3, 22, 39, 11);
INSERT INTO `area_device_track` VALUES (538, 3, 22, 40, 12);
INSERT INTO `area_device_track` VALUES (539, 3, 22, 1, 13);
INSERT INTO `area_device_track` VALUES (540, 3, 22, 2, 14);
INSERT INTO `area_device_track` VALUES (541, 3, 22, 3, 15);
INSERT INTO `area_device_track` VALUES (542, 3, 22, 4, 16);
INSERT INTO `area_device_track` VALUES (543, 3, 26, 69, 1);
INSERT INTO `area_device_track` VALUES (544, 3, 26, 70, 2);
INSERT INTO `area_device_track` VALUES (545, 3, 26, 71, 3);
INSERT INTO `area_device_track` VALUES (546, 3, 26, 72, 4);
INSERT INTO `area_device_track` VALUES (547, 3, 26, 73, 5);
INSERT INTO `area_device_track` VALUES (548, 3, 26, 74, 6);
INSERT INTO `area_device_track` VALUES (549, 3, 26, 75, 7);
INSERT INTO `area_device_track` VALUES (550, 3, 26, 76, 8);
INSERT INTO `area_device_track` VALUES (551, 3, 26, 77, 9);
INSERT INTO `area_device_track` VALUES (552, 3, 26, 78, 10);
INSERT INTO `area_device_track` VALUES (553, 3, 26, 79, 11);
INSERT INTO `area_device_track` VALUES (554, 3, 26, 80, 12);
INSERT INTO `area_device_track` VALUES (555, 3, 26, 15, 13);
INSERT INTO `area_device_track` VALUES (556, 3, 26, 16, 14);
INSERT INTO `area_device_track` VALUES (557, 3, 26, 17, 15);
INSERT INTO `area_device_track` VALUES (558, 3, 26, 18, 16);
INSERT INTO `area_device_track` VALUES (559, 3, 15, 69, 1);
INSERT INTO `area_device_track` VALUES (560, 3, 15, 70, 2);
INSERT INTO `area_device_track` VALUES (561, 3, 15, 71, 3);
INSERT INTO `area_device_track` VALUES (562, 3, 15, 72, 4);
INSERT INTO `area_device_track` VALUES (563, 3, 15, 73, 5);
INSERT INTO `area_device_track` VALUES (564, 3, 15, 74, 6);
INSERT INTO `area_device_track` VALUES (565, 3, 15, 75, 7);
INSERT INTO `area_device_track` VALUES (566, 3, 15, 76, 8);
INSERT INTO `area_device_track` VALUES (567, 3, 15, 77, 9);
INSERT INTO `area_device_track` VALUES (568, 3, 15, 78, 10);
INSERT INTO `area_device_track` VALUES (569, 3, 15, 79, 11);
INSERT INTO `area_device_track` VALUES (570, 3, 15, 80, 12);
INSERT INTO `area_device_track` VALUES (571, 3, 16, 69, 1);
INSERT INTO `area_device_track` VALUES (572, 3, 16, 70, 2);
INSERT INTO `area_device_track` VALUES (573, 3, 16, 71, 3);
INSERT INTO `area_device_track` VALUES (574, 3, 16, 72, 4);
INSERT INTO `area_device_track` VALUES (575, 3, 16, 73, 5);
INSERT INTO `area_device_track` VALUES (576, 3, 16, 74, 6);
INSERT INTO `area_device_track` VALUES (577, 3, 16, 75, 7);
INSERT INTO `area_device_track` VALUES (578, 3, 16, 76, 8);
INSERT INTO `area_device_track` VALUES (579, 3, 16, 77, 9);
INSERT INTO `area_device_track` VALUES (580, 3, 16, 78, 10);
INSERT INTO `area_device_track` VALUES (581, 3, 16, 79, 11);
INSERT INTO `area_device_track` VALUES (582, 3, 16, 80, 12);
INSERT INTO `area_device_track` VALUES (583, 2, 13, 59, 1);
INSERT INTO `area_device_track` VALUES (584, 2, 13, 60, 2);
INSERT INTO `area_device_track` VALUES (585, 2, 13, 61, 3);
INSERT INTO `area_device_track` VALUES (586, 2, 13, 62, 4);
INSERT INTO `area_device_track` VALUES (587, 2, 13, 63, 5);
INSERT INTO `area_device_track` VALUES (588, 2, 13, 64, 6);
INSERT INTO `area_device_track` VALUES (589, 2, 13, 65, 7);
INSERT INTO `area_device_track` VALUES (590, 2, 13, 66, 8);
INSERT INTO `area_device_track` VALUES (591, 2, 13, 67, 9);
INSERT INTO `area_device_track` VALUES (592, 2, 13, 68, 10);
INSERT INTO `area_device_track` VALUES (593, 2, 12, 59, 1);
INSERT INTO `area_device_track` VALUES (594, 2, 12, 60, 2);
INSERT INTO `area_device_track` VALUES (595, 2, 12, 61, 3);
INSERT INTO `area_device_track` VALUES (596, 2, 12, 62, 4);
INSERT INTO `area_device_track` VALUES (597, 2, 12, 63, 5);
INSERT INTO `area_device_track` VALUES (598, 2, 12, 64, 6);
INSERT INTO `area_device_track` VALUES (599, 2, 12, 65, 7);
INSERT INTO `area_device_track` VALUES (600, 2, 12, 66, 8);
INSERT INTO `area_device_track` VALUES (601, 2, 12, 67, 9);
INSERT INTO `area_device_track` VALUES (602, 2, 12, 68, 10);
INSERT INTO `area_device_track` VALUES (603, 4, 18, 85, 1);
INSERT INTO `area_device_track` VALUES (604, 4, 18, 86, 2);
INSERT INTO `area_device_track` VALUES (605, 4, 18, 87, 3);
INSERT INTO `area_device_track` VALUES (606, 4, 18, 88, 4);
INSERT INTO `area_device_track` VALUES (607, 4, 18, 89, 5);
INSERT INTO `area_device_track` VALUES (608, 4, 18, 90, 6);
INSERT INTO `area_device_track` VALUES (609, 4, 18, 91, 7);

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
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area_track
-- ----------------------------
INSERT INTO `area_track` VALUES (1, 1, 23, 1);
INSERT INTO `area_track` VALUES (2, 1, 24, 1);
INSERT INTO `area_track` VALUES (3, 1, 52, 0);
INSERT INTO `area_track` VALUES (4, 1, 53, 0);
INSERT INTO `area_track` VALUES (5, 1, 54, 2);
INSERT INTO `area_track` VALUES (6, 1, 55, 2);
INSERT INTO `area_track` VALUES (7, 1, 56, 2);
INSERT INTO `area_track` VALUES (8, 1, 57, 2);
INSERT INTO `area_track` VALUES (9, 1, 58, 2);
INSERT INTO `area_track` VALUES (10, 1, 92, 2);
INSERT INTO `area_track` VALUES (11, 1, 93, 2);
INSERT INTO `area_track` VALUES (12, 1, 94, 3);
INSERT INTO `area_track` VALUES (13, 1, 95, 3);
INSERT INTO `area_track` VALUES (14, 1, 96, 3);
INSERT INTO `area_track` VALUES (15, 1, 97, 3);
INSERT INTO `area_track` VALUES (16, 1, 98, 3);
INSERT INTO `area_track` VALUES (17, 1, 113, 3);
INSERT INTO `area_track` VALUES (18, 1, 114, 3);
INSERT INTO `area_track` VALUES (19, 1, 1, 5);
INSERT INTO `area_track` VALUES (20, 1, 1, 6);
INSERT INTO `area_track` VALUES (21, 1, 45, 2);
INSERT INTO `area_track` VALUES (22, 1, 46, 2);
INSERT INTO `area_track` VALUES (23, 1, 47, 2);
INSERT INTO `area_track` VALUES (24, 1, 48, 2);
INSERT INTO `area_track` VALUES (25, 1, 49, 2);
INSERT INTO `area_track` VALUES (26, 1, 50, 2);
INSERT INTO `area_track` VALUES (27, 1, 51, 2);
INSERT INTO `area_track` VALUES (28, 1, 85, 3);
INSERT INTO `area_track` VALUES (29, 1, 86, 3);
INSERT INTO `area_track` VALUES (30, 1, 87, 3);
INSERT INTO `area_track` VALUES (31, 1, 88, 3);
INSERT INTO `area_track` VALUES (32, 1, 89, 3);
INSERT INTO `area_track` VALUES (33, 1, 90, 3);
INSERT INTO `area_track` VALUES (34, 1, 91, 3);
INSERT INTO `area_track` VALUES (35, 5, 5, 1);
INSERT INTO `area_track` VALUES (36, 5, 6, 1);
INSERT INTO `area_track` VALUES (37, 5, 7, 1);
INSERT INTO `area_track` VALUES (38, 5, 19, 0);
INSERT INTO `area_track` VALUES (39, 5, 20, 0);
INSERT INTO `area_track` VALUES (40, 5, 41, 2);
INSERT INTO `area_track` VALUES (41, 5, 42, 2);
INSERT INTO `area_track` VALUES (42, 5, 43, 2);
INSERT INTO `area_track` VALUES (43, 5, 44, 2);
INSERT INTO `area_track` VALUES (44, 5, 81, 3);
INSERT INTO `area_track` VALUES (45, 5, 82, 3);
INSERT INTO `area_track` VALUES (46, 5, 83, 3);
INSERT INTO `area_track` VALUES (47, 5, 84, 3);
INSERT INTO `area_track` VALUES (48, 5, 111, 5);
INSERT INTO `area_track` VALUES (49, 5, 112, 6);
INSERT INTO `area_track` VALUES (50, 5, 45, 2);
INSERT INTO `area_track` VALUES (51, 5, 46, 2);
INSERT INTO `area_track` VALUES (52, 5, 47, 2);
INSERT INTO `area_track` VALUES (53, 5, 48, 2);
INSERT INTO `area_track` VALUES (54, 5, 49, 2);
INSERT INTO `area_track` VALUES (55, 5, 50, 2);
INSERT INTO `area_track` VALUES (56, 5, 51, 2);
INSERT INTO `area_track` VALUES (57, 5, 85, 3);
INSERT INTO `area_track` VALUES (58, 5, 86, 3);
INSERT INTO `area_track` VALUES (59, 5, 87, 3);
INSERT INTO `area_track` VALUES (60, 5, 88, 3);
INSERT INTO `area_track` VALUES (61, 5, 89, 3);
INSERT INTO `area_track` VALUES (62, 5, 90, 3);
INSERT INTO `area_track` VALUES (63, 5, 91, 3);
INSERT INTO `area_track` VALUES (64, 3, 1, 1);
INSERT INTO `area_track` VALUES (65, 3, 2, 1);
INSERT INTO `area_track` VALUES (66, 3, 3, 1);
INSERT INTO `area_track` VALUES (67, 3, 4, 1);
INSERT INTO `area_track` VALUES (68, 3, 15, 0);
INSERT INTO `area_track` VALUES (69, 3, 16, 0);
INSERT INTO `area_track` VALUES (70, 3, 17, 0);
INSERT INTO `area_track` VALUES (71, 3, 18, 0);
INSERT INTO `area_track` VALUES (72, 3, 29, 2);
INSERT INTO `area_track` VALUES (73, 3, 30, 2);
INSERT INTO `area_track` VALUES (74, 3, 31, 2);
INSERT INTO `area_track` VALUES (75, 3, 32, 2);
INSERT INTO `area_track` VALUES (76, 3, 33, 2);
INSERT INTO `area_track` VALUES (77, 3, 34, 2);
INSERT INTO `area_track` VALUES (78, 3, 35, 2);
INSERT INTO `area_track` VALUES (79, 3, 36, 2);
INSERT INTO `area_track` VALUES (80, 3, 37, 2);
INSERT INTO `area_track` VALUES (81, 3, 38, 2);
INSERT INTO `area_track` VALUES (82, 3, 39, 2);
INSERT INTO `area_track` VALUES (83, 3, 40, 2);
INSERT INTO `area_track` VALUES (84, 3, 69, 3);
INSERT INTO `area_track` VALUES (85, 3, 70, 3);
INSERT INTO `area_track` VALUES (86, 3, 71, 3);
INSERT INTO `area_track` VALUES (87, 3, 72, 3);
INSERT INTO `area_track` VALUES (88, 3, 73, 3);
INSERT INTO `area_track` VALUES (89, 3, 74, 3);
INSERT INTO `area_track` VALUES (90, 3, 75, 3);
INSERT INTO `area_track` VALUES (91, 3, 76, 3);
INSERT INTO `area_track` VALUES (92, 3, 77, 3);
INSERT INTO `area_track` VALUES (93, 3, 78, 3);
INSERT INTO `area_track` VALUES (94, 3, 79, 3);
INSERT INTO `area_track` VALUES (95, 3, 80, 3);
INSERT INTO `area_track` VALUES (96, 3, 109, 5);
INSERT INTO `area_track` VALUES (97, 3, 110, 6);
INSERT INTO `area_track` VALUES (98, 2, 25, 0);
INSERT INTO `area_track` VALUES (99, 2, 26, 0);
INSERT INTO `area_track` VALUES (100, 2, 27, 0);
INSERT INTO `area_track` VALUES (101, 2, 28, 0);
INSERT INTO `area_track` VALUES (102, 2, 59, 2);
INSERT INTO `area_track` VALUES (103, 2, 60, 2);
INSERT INTO `area_track` VALUES (104, 2, 61, 2);
INSERT INTO `area_track` VALUES (105, 2, 62, 2);
INSERT INTO `area_track` VALUES (106, 2, 63, 2);
INSERT INTO `area_track` VALUES (107, 2, 64, 2);
INSERT INTO `area_track` VALUES (108, 2, 65, 2);
INSERT INTO `area_track` VALUES (109, 2, 66, 2);
INSERT INTO `area_track` VALUES (110, 2, 67, 2);
INSERT INTO `area_track` VALUES (111, 2, 68, 2);
INSERT INTO `area_track` VALUES (112, 2, 99, 3);
INSERT INTO `area_track` VALUES (113, 2, 100, 3);
INSERT INTO `area_track` VALUES (114, 2, 101, 3);
INSERT INTO `area_track` VALUES (115, 2, 102, 3);
INSERT INTO `area_track` VALUES (116, 2, 103, 3);
INSERT INTO `area_track` VALUES (117, 2, 104, 3);
INSERT INTO `area_track` VALUES (118, 2, 105, 3);
INSERT INTO `area_track` VALUES (119, 2, 106, 3);
INSERT INTO `area_track` VALUES (120, 2, 107, 3);
INSERT INTO `area_track` VALUES (121, 2, 108, 3);
INSERT INTO `area_track` VALUES (122, 2, 115, 5);
INSERT INTO `area_track` VALUES (123, 2, 116, 6);

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
INSERT INTO `device` VALUES (1, '3_A1', '127.0.0.1', 2001, 1, 1, b'1', 0, 0, 1, 1, NULL, 0, 0, 0, '161');
INSERT INTO `device` VALUES (2, '3_A2', '127.0.0.1', 2001, 1, 1, b'1', 0, 0, 2, 2, NULL, 0, 0, 0, '162');
INSERT INTO `device` VALUES (3, '3_A3', '127.0.0.1', 2001, 1, 1, b'1', 0, 0, 3, 3, NULL, 0, 0, 0, '163');
INSERT INTO `device` VALUES (4, '3_A4', '127.0.0.1', 2001, 1, 1, b'1', 0, 0, 4, 4, NULL, 0, 0, 0, '164');
INSERT INTO `device` VALUES (5, '5_A1', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 18, 5, NULL, 0, 0, 0, '165');
INSERT INTO `device` VALUES (6, '5_A2', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 19, 6, NULL, 0, 0, 0, '166');
INSERT INTO `device` VALUES (7, '5_A3', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 20, 7, NULL, 0, 0, 0, '167');
INSERT INTO `device` VALUES (8, '4_A2', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, 1, 8, 9, 0, 1, 0, '168');
INSERT INTO `device` VALUES (9, '4_A1', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, 2, 8, 9, 8, 1, 0, '169');
INSERT INTO `device` VALUES (10, '1_A2', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 15, 10, 11, 0, 1, 0, '170');
INSERT INTO `device` VALUES (11, '1_A1', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 24, 10, 11, 10, 1, 0, '171');
INSERT INTO `device` VALUES (12, '2_A1', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 17, 12, NULL, 0, 0, 0, '172');
INSERT INTO `device` VALUES (13, '2_A2', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 1, 13, NULL, 0, 0, 0, '173');
INSERT INTO `device` VALUES (14, '2_A3', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 5, 14, NULL, 0, 0, 0, '174');
INSERT INTO `device` VALUES (15, '3_D1', '127.0.0.1', 2001, 0, 2, b'1', 0, 0, 1, 15, 16, 0, 0, 0, '209');
INSERT INTO `device` VALUES (16, '3_D2', '127.0.0.1', 2001, 0, 2, b'1', 0, 0, 2, 17, 18, 0, 0, 0, '210');
INSERT INTO `device` VALUES (17, '5_D1', '127.0.0.1', 2001, 0, 2, b'0', 0, 0, 18, 19, 20, 0, 0, 0, '211');
INSERT INTO `device` VALUES (18, '4_D1', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 21, 22, NULL, NULL, 0, '212');
INSERT INTO `device` VALUES (19, '1_D1', '127.0.0.1', 2001, 0, 2, b'0', 0, 0, 16, 23, 24, 0, 0, 0, '213');
INSERT INTO `device` VALUES (20, '2_D1', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 25, 26, NULL, NULL, 0, '214');
INSERT INTO `device` VALUES (21, '2_D2', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 27, 28, NULL, NULL, 0, '215');
INSERT INTO `device` VALUES (22, '3_B1', '127.0.0.1', 2002, 3, 0, b'1', 0, 0, NULL, 109, NULL, 0, 0, 0, '177');
INSERT INTO `device` VALUES (23, '5_B1', '127.0.0.1', 2002, 3, 0, b'0', 0, 0, NULL, 111, NULL, 0, 0, 0, '178');
INSERT INTO `device` VALUES (24, '1_B1', '127.0.0.1', 2002, 3, 0, b'1', 0, 0, NULL, 113, NULL, 0, 0, 0, '179');
INSERT INTO `device` VALUES (25, '2_B1', '127.0.0.1', 2002, 3, 0, b'0', 0, 0, NULL, 115, NULL, 0, 0, 0, '180');
INSERT INTO `device` VALUES (26, '3_B2', '127.0.0.1', 2002, 2, 0, b'1', 0, 0, NULL, 110, NULL, 0, 0, 0, '181');
INSERT INTO `device` VALUES (27, '5_B2', '127.0.0.1', 2002, 2, 0, b'0', 0, 0, NULL, 112, NULL, 0, 0, 0, '182');
INSERT INTO `device` VALUES (28, '1_B2', '127.0.0.1', 2002, 2, 0, b'1', 0, 0, NULL, 114, NULL, 0, 0, 0, '183');
INSERT INTO `device` VALUES (29, '2_B2', '127.0.0.1', 2002, 2, 0, b'0', 0, 0, NULL, 116, NULL, 0, 0, 0, '184');
INSERT INTO `device` VALUES (30, '3_C1', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '193');
INSERT INTO `device` VALUES (31, '3_C2', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '194');
INSERT INTO `device` VALUES (32, '3_C3', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '195');
INSERT INTO `device` VALUES (33, '3_C4', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '196');
INSERT INTO `device` VALUES (34, '3_C5', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '197');
INSERT INTO `device` VALUES (35, '3_C6', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '198');
INSERT INTO `device` VALUES (36, '3_C7', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '199');
INSERT INTO `device` VALUES (37, '3_C8', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '200');
INSERT INTO `device` VALUES (38, '5_C1', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '201');
INSERT INTO `device` VALUES (39, '5_C2', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '202');
INSERT INTO `device` VALUES (40, '5_C3', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '203');
INSERT INTO `device` VALUES (41, '1_C1', '127.0.0.1', 2003, 4, 0, b'1', 1, 0, NULL, NULL, NULL, 0, 0, 0, '204');
INSERT INTO `device` VALUES (42, '1_C2', '127.0.0.1', 2003, 4, 0, b'1', 1, 0, NULL, NULL, NULL, 0, 0, 0, '205');
INSERT INTO `device` VALUES (43, '1_C3', '127.0.0.1', 2003, 4, 0, b'1', 1, 0, NULL, NULL, NULL, 0, 0, 0, '206');
INSERT INTO `device` VALUES (44, '1_C4', '127.0.0.1', 2003, 4, 0, b'1', 1, 0, NULL, NULL, NULL, 0, 0, 0, '207');
INSERT INTO `device` VALUES (45, '2_C1', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '208');
INSERT INTO `device` VALUES (46, '2_C2', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '209');
INSERT INTO `device` VALUES (47, '2_C3', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '210');
INSERT INTO `device` VALUES (48, '2_C4', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '211');
INSERT INTO `device` VALUES (49, '2_C5', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '212');
INSERT INTO `device` VALUES (50, '2_C6', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '213');

-- ----------------------------
-- Table structure for device_copy1
-- ----------------------------
DROP TABLE IF EXISTS `device_copy1`;
CREATE TABLE `device_copy1`  (
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
  CONSTRAINT `device_copy1_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_copy1_ibfk_2` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_copy1_ibfk_3` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device_copy1
-- ----------------------------
INSERT INTO `device_copy1` VALUES (1, '3#下_A1', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, NULL, 1, NULL, 0, 0, 0, '161');
INSERT INTO `device_copy1` VALUES (2, '3#下_A2', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, NULL, 2, NULL, 0, 0, 0, '162');
INSERT INTO `device_copy1` VALUES (3, '3#下_A3', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, NULL, 3, NULL, 0, 0, 0, '163');
INSERT INTO `device_copy1` VALUES (4, '3#下_A4', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, NULL, 4, NULL, 0, 0, 0, '164');
INSERT INTO `device_copy1` VALUES (5, '5#下_A5', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '165');
INSERT INTO `device_copy1` VALUES (6, '5#下_A6', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '166');
INSERT INTO `device_copy1` VALUES (7, '5#下_A7', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '167');
INSERT INTO `device_copy1` VALUES (8, '4#下_A8', '127.0.0.1', 2001, 1, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '168');
INSERT INTO `device_copy1` VALUES (9, '4#下_A9', '127.0.0.1', 2001, 1, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '169');
INSERT INTO `device_copy1` VALUES (10, '1#下_A10', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, NULL, 10, 11, 0, 1, 0, '170');
INSERT INTO `device_copy1` VALUES (11, '1#下_A11', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, NULL, 10, 11, 10, 1, 0, '171');
INSERT INTO `device_copy1` VALUES (12, '2#下_A12', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '172');
INSERT INTO `device_copy1` VALUES (13, '2#下_A13', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '173');
INSERT INTO `device_copy1` VALUES (14, '2#下_A14', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '174');
INSERT INTO `device_copy1` VALUES (15, '3#上_D1', '127.0.0.1', 2001, 0, 2, b'0', 0, 0, NULL, 15, NULL, 0, 0, 0, '209');
INSERT INTO `device_copy1` VALUES (16, '3#上_D2', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 16, NULL, NULL, 0, 0, '210');
INSERT INTO `device_copy1` VALUES (17, '3#上_D3', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 17, NULL, NULL, 0, 0, '211');
INSERT INTO `device_copy1` VALUES (18, '3#上_D4', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 18, NULL, NULL, 0, 0, '212');
INSERT INTO `device_copy1` VALUES (19, '5#上_D5', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '213');
INSERT INTO `device_copy1` VALUES (20, '4#上_D6', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '214');
INSERT INTO `device_copy1` VALUES (21, '1#上_D7', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '215');
INSERT INTO `device_copy1` VALUES (22, '2#上_D8', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '216');
INSERT INTO `device_copy1` VALUES (23, '2#上_D9', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '217');
INSERT INTO `device_copy1` VALUES (24, '3#摆_B1', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, 109, NULL, NULL, NULL, NULL, '177');
INSERT INTO `device_copy1` VALUES (25, '5#摆_B2', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '178');
INSERT INTO `device_copy1` VALUES (26, '1#摆_B2', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, 113, NULL, NULL, NULL, NULL, '179');
INSERT INTO `device_copy1` VALUES (27, '2#摆_B4', '127.0.0.1', 2002, 3, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '180');
INSERT INTO `device_copy1` VALUES (28, '3#摆_B5', '127.0.0.1', 2002, 2, 0, b'0', 0, 0, NULL, 110, NULL, 0, 0, 0, '181');
INSERT INTO `device_copy1` VALUES (29, '5#摆_B6', '127.0.0.1', 2002, 2, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '182');
INSERT INTO `device_copy1` VALUES (30, '1#摆_B7', '127.0.0.1', 2002, 2, 0, b'0', NULL, NULL, NULL, 114, NULL, NULL, NULL, NULL, '183');
INSERT INTO `device_copy1` VALUES (31, '2#摆_B8', '127.0.0.1', 2002, 2, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '184');
INSERT INTO `device_copy1` VALUES (32, '3#运_C1', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '193');
INSERT INTO `device_copy1` VALUES (33, '3#运_C2', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '194');
INSERT INTO `device_copy1` VALUES (34, '3#运_C3', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '195');
INSERT INTO `device_copy1` VALUES (35, '3#运_C4', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '196');
INSERT INTO `device_copy1` VALUES (36, '3#运_C5', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '197');
INSERT INTO `device_copy1` VALUES (37, '3#运_C6', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '198');
INSERT INTO `device_copy1` VALUES (38, '3#运_C7', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '199');
INSERT INTO `device_copy1` VALUES (39, '3#运_C8', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '200');
INSERT INTO `device_copy1` VALUES (40, '5#运_C9', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '201');
INSERT INTO `device_copy1` VALUES (41, '5#运_C10', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '202');
INSERT INTO `device_copy1` VALUES (42, '5#运_C11', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '203');
INSERT INTO `device_copy1` VALUES (43, '1#运_C12', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '204');
INSERT INTO `device_copy1` VALUES (44, '1#运_C13', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '205');
INSERT INTO `device_copy1` VALUES (45, '1#运_C14', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '206');
INSERT INTO `device_copy1` VALUES (46, '1#运_C15', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '207');
INSERT INTO `device_copy1` VALUES (47, '2#运_C16', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '208');
INSERT INTO `device_copy1` VALUES (48, '2#运_C17', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '209');
INSERT INTO `device_copy1` VALUES (49, '2#运_C18', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '210');
INSERT INTO `device_copy1` VALUES (50, '2#运_C19', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '211');
INSERT INTO `device_copy1` VALUES (51, '2#运_C20', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '212');
INSERT INTO `device_copy1` VALUES (52, '2#运_C21', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '213');

-- ----------------------------
-- Table structure for device_copy2
-- ----------------------------
DROP TABLE IF EXISTS `device_copy2`;
CREATE TABLE `device_copy2`  (
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
  CONSTRAINT `device_copy2_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_copy2_ibfk_2` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_copy2_ibfk_3` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device_copy2
-- ----------------------------
INSERT INTO `device_copy2` VALUES (1, '3_A1', '192.168.0.31', 2000, 1, 1, b'0', NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '161');
INSERT INTO `device_copy2` VALUES (2, '3_A2', '192.168.0.36', 2000, 1, 1, b'0', NULL, NULL, NULL, 2, NULL, NULL, 0, 0, '162');
INSERT INTO `device_copy2` VALUES (3, '3_A3', '192.168.0.41', 2000, 1, 1, b'0', NULL, NULL, NULL, 3, NULL, NULL, 0, 0, '163');
INSERT INTO `device_copy2` VALUES (4, '3_A4', '192.168.0.46', 2000, 1, 1, b'0', NULL, NULL, NULL, 4, NULL, NULL, 0, 0, '164');
INSERT INTO `device_copy2` VALUES (5, '5_A1', '192.168.0.51', 2000, 1, 1, b'0', NULL, NULL, NULL, 5, NULL, NULL, 0, 0, '165');
INSERT INTO `device_copy2` VALUES (6, '5_A2', '192.168.0.56', 2000, 1, 1, b'0', NULL, NULL, NULL, 6, NULL, NULL, 0, 0, '166');
INSERT INTO `device_copy2` VALUES (7, '5_A3', '192.168.0.61', 2000, 1, 1, b'0', NULL, NULL, NULL, 7, NULL, NULL, 0, 0, '167');
INSERT INTO `device_copy2` VALUES (8, '4_A1', '192.168.0.66', 2000, 1, 2, b'0', NULL, NULL, NULL, 8, 9, NULL, 1, 0, '168');
INSERT INTO `device_copy2` VALUES (9, '4_A2', '192.168.0.71', 2000, 1, 2, b'0', NULL, NULL, NULL, 8, 9, 8, 1, 0, '169');
INSERT INTO `device_copy2` VALUES (10, '1_A1', '192.168.0.76', 2000, 1, 2, b'0', NULL, NULL, NULL, 10, 11, NULL, 1, 0, '170');
INSERT INTO `device_copy2` VALUES (11, '1_A2', '192.168.0.26', 2000, 1, 2, b'0', NULL, NULL, NULL, 10, 11, 10, 1, 0, '171');
INSERT INTO `device_copy2` VALUES (12, '2_A1', '192.168.0.116', 2000, 1, 1, b'0', NULL, NULL, NULL, 12, NULL, NULL, 0, NULL, '172');
INSERT INTO `device_copy2` VALUES (13, '2_A2', '192.168.0.121', 2000, 1, 1, b'0', NULL, NULL, NULL, 13, NULL, NULL, 0, NULL, '173');
INSERT INTO `device_copy2` VALUES (14, '2_A3', '192.168.0.126', 2000, 1, 1, b'0', NULL, NULL, NULL, 14, NULL, NULL, 0, NULL, '174');
INSERT INTO `device_copy2` VALUES (15, '3_D1', '192.168.0.81', 2000, 0, 2, b'0', NULL, NULL, NULL, 15, 16, NULL, NULL, 0, '209');
INSERT INTO `device_copy2` VALUES (16, '3_D2', '192.168.0.86', 2000, 0, 2, b'0', NULL, NULL, NULL, 17, 18, NULL, NULL, 0, '210');
INSERT INTO `device_copy2` VALUES (17, '5_D1', '192.168.0.91', 2000, 0, 2, b'0', NULL, NULL, NULL, 19, 20, NULL, NULL, 0, '211');
INSERT INTO `device_copy2` VALUES (18, '4_D1', '192.168.0.96', 2000, 0, 2, b'0', NULL, NULL, NULL, 21, 22, NULL, NULL, 0, '212');
INSERT INTO `device_copy2` VALUES (19, '1_D1', '192.168.0.101', 2000, 0, 2, b'0', NULL, NULL, NULL, 23, 24, NULL, NULL, 0, '213');
INSERT INTO `device_copy2` VALUES (20, '2_D1', '192.168.0.106', 2000, 0, 2, b'0', NULL, NULL, NULL, 25, 26, NULL, NULL, 0, '214');
INSERT INTO `device_copy2` VALUES (21, '2_D2', '192.168.0.111', 2000, 0, 2, b'0', NULL, NULL, NULL, 27, 28, NULL, NULL, 0, '215');
INSERT INTO `device_copy2` VALUES (22, '3_B1', '192.168.0.131', 2000, 3, 0, b'0', NULL, NULL, NULL, 109, NULL, NULL, NULL, NULL, '177');
INSERT INTO `device_copy2` VALUES (23, '5_B1', '192.168.0.132', 2000, 3, 0, b'0', NULL, NULL, NULL, 111, NULL, NULL, NULL, NULL, '178');
INSERT INTO `device_copy2` VALUES (24, '1_B1', '192.168.0.133', 2000, 3, 0, b'0', NULL, NULL, NULL, 113, NULL, NULL, NULL, NULL, '179');
INSERT INTO `device_copy2` VALUES (25, '2_B1', '192.168.0.134', 2000, 3, 0, b'0', NULL, NULL, NULL, 115, NULL, NULL, NULL, NULL, '180');
INSERT INTO `device_copy2` VALUES (26, '3_B2', '192.168.0.135', 2000, 2, 0, b'0', NULL, NULL, NULL, 110, NULL, NULL, NULL, NULL, '181');
INSERT INTO `device_copy2` VALUES (27, '5_B2', '192.168.0.136', 2000, 2, 0, b'0', NULL, NULL, NULL, 112, NULL, NULL, NULL, NULL, '182');
INSERT INTO `device_copy2` VALUES (28, '1_B2', '192.168.0.137', 2000, 2, 0, b'0', NULL, NULL, NULL, 114, NULL, NULL, NULL, NULL, '183');
INSERT INTO `device_copy2` VALUES (29, '2_B2', '192.168.0.138', 2000, 2, 0, b'0', NULL, NULL, NULL, 116, NULL, NULL, NULL, NULL, '184');
INSERT INTO `device_copy2` VALUES (30, '3_C1', '192.168.0.151', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '193');
INSERT INTO `device_copy2` VALUES (31, '3_C2', '192.168.0.152', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '194');
INSERT INTO `device_copy2` VALUES (32, '3_C3', '192.168.0.153', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '195');
INSERT INTO `device_copy2` VALUES (33, '3_C4', '192.168.0.154', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '196');
INSERT INTO `device_copy2` VALUES (34, '3_C5', '192.168.0.155', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '197');
INSERT INTO `device_copy2` VALUES (35, '3_C6', '192.168.0.156', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '198');
INSERT INTO `device_copy2` VALUES (36, '3_C7', '192.168.0.157', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '199');
INSERT INTO `device_copy2` VALUES (37, '3_C8', '192.168.0.158', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '200');
INSERT INTO `device_copy2` VALUES (38, '5_C1', '192.168.0.159', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '201');
INSERT INTO `device_copy2` VALUES (39, '5_C2', '192.168.0.160', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '202');
INSERT INTO `device_copy2` VALUES (40, '5_C3', '192.168.0.161', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '203');
INSERT INTO `device_copy2` VALUES (41, '1_C1', '192.168.0.162', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '204');
INSERT INTO `device_copy2` VALUES (42, '1_C2', '192.168.0.163', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '205');
INSERT INTO `device_copy2` VALUES (43, '1_C3', '192.168.0.164', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '206');
INSERT INTO `device_copy2` VALUES (44, '1_C4', '192.168.0.165', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '207');
INSERT INTO `device_copy2` VALUES (45, '2_C1', '192.168.0.166', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '208');
INSERT INTO `device_copy2` VALUES (46, '2_C2', '192.168.0.167', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '209');
INSERT INTO `device_copy2` VALUES (47, '2_C3', '192.168.0.168', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '210');
INSERT INTO `device_copy2` VALUES (48, '2_C4', '192.168.0.169', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '211');
INSERT INTO `device_copy2` VALUES (49, '2_C5', '192.168.0.170', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '212');
INSERT INTO `device_copy2` VALUES (50, '2_C6', '192.168.0.211', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '213');

-- ----------------------------
-- Table structure for device_sim
-- ----------------------------
DROP TABLE IF EXISTS `device_sim`;
CREATE TABLE `device_sim`  (
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
  CONSTRAINT `device_sim_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_sim_ibfk_2` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_sim_ibfk_3` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device_sim
-- ----------------------------
INSERT INTO `device_sim` VALUES (1, '3_A1', '127.0.0.1', 2001, 1, 1, b'1', 0, 0, 1, 1, NULL, 0, 0, 0, '161');
INSERT INTO `device_sim` VALUES (2, '3_A2', '127.0.0.1', 2001, 1, 1, b'1', 0, 0, 2, 2, NULL, 0, 0, 0, '162');
INSERT INTO `device_sim` VALUES (3, '3_A3', '127.0.0.1', 2001, 1, 1, b'0', 0, 0, 3, 3, NULL, 0, 0, 0, '163');
INSERT INTO `device_sim` VALUES (4, '3_A4', '127.0.0.1', 2001, 1, 1, b'1', 0, 0, 4, 4, NULL, 0, 0, 0, '164');
INSERT INTO `device_sim` VALUES (5, '5_A1', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, 5, NULL, NULL, 0, NULL, '165');
INSERT INTO `device_sim` VALUES (6, '5_A2', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, 6, NULL, NULL, 0, NULL, '166');
INSERT INTO `device_sim` VALUES (7, '5_A3', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, 7, NULL, NULL, 0, NULL, '167');
INSERT INTO `device_sim` VALUES (8, '4_A1', '127.0.0.1', 2001, 1, 2, b'0', NULL, NULL, NULL, 8, 9, NULL, 1, NULL, '168');
INSERT INTO `device_sim` VALUES (9, '4_A2', '127.0.0.1', 2001, 1, 2, b'0', NULL, NULL, NULL, 8, 9, 8, 1, NULL, '169');
INSERT INTO `device_sim` VALUES (10, '1_A1', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, 16, 10, 11, 0, 1, 0, '170');
INSERT INTO `device_sim` VALUES (11, '1_A2', '127.0.0.1', 2001, 1, 2, b'0', 0, 0, 16, 10, 11, 10, 1, 0, '171');
INSERT INTO `device_sim` VALUES (12, '2_A1', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, 12, NULL, NULL, 0, NULL, '172');
INSERT INTO `device_sim` VALUES (13, '2_A2', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, 13, NULL, NULL, 0, NULL, '173');
INSERT INTO `device_sim` VALUES (14, '2_A3', '127.0.0.1', 2001, 1, 1, b'0', NULL, NULL, NULL, 14, NULL, NULL, 0, NULL, '174');
INSERT INTO `device_sim` VALUES (15, '3_D1', '127.0.0.1', 2001, 0, 2, b'0', 0, 0, NULL, 15, 16, 0, 0, 0, '209');
INSERT INTO `device_sim` VALUES (16, '3_D2', '127.0.0.1', 2001, 0, 2, b'0', 0, 0, NULL, 17, 18, 0, 0, 0, '210');
INSERT INTO `device_sim` VALUES (17, '5_D1', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 19, 20, NULL, NULL, 0, '211');
INSERT INTO `device_sim` VALUES (18, '4_D1', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 21, 22, NULL, NULL, 0, '212');
INSERT INTO `device_sim` VALUES (19, '1_D1', '127.0.0.1', 2001, 0, 2, b'0', 0, 0, 16, 23, 24, 0, 0, 0, '213');
INSERT INTO `device_sim` VALUES (20, '2_D1', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 25, 26, NULL, NULL, 0, '214');
INSERT INTO `device_sim` VALUES (21, '2_D2', '127.0.0.1', 2001, 0, 2, b'0', NULL, NULL, NULL, 27, 28, NULL, NULL, 0, '215');
INSERT INTO `device_sim` VALUES (22, '3_B1', '127.0.0.1', 2002, 3, 0, b'0', 0, 0, NULL, 109, NULL, 0, 0, 0, '177');
INSERT INTO `device_sim` VALUES (23, '5_B1', '127.0.0.1', 2002, 3, 0, b'0', 0, 0, NULL, 111, NULL, 0, 0, 0, '178');
INSERT INTO `device_sim` VALUES (24, '1_B1', '127.0.0.1', 2002, 3, 0, b'0', 0, 0, NULL, 113, NULL, 0, 0, 0, '179');
INSERT INTO `device_sim` VALUES (25, '2_B1', '127.0.0.1', 2002, 3, 0, b'1', 0, 0, NULL, 115, NULL, 0, 0, 0, '180');
INSERT INTO `device_sim` VALUES (26, '3_B2', '127.0.0.1', 2002, 2, 0, b'0', 0, 0, NULL, 110, NULL, 0, 0, 0, '181');
INSERT INTO `device_sim` VALUES (27, '5_B2', '127.0.0.1', 2002, 2, 0, b'0', 0, 0, NULL, 112, NULL, 0, 0, 0, '182');
INSERT INTO `device_sim` VALUES (28, '1_B2', '127.0.0.1', 2002, 2, 0, b'0', 0, 0, NULL, 114, NULL, 0, 0, 0, '183');
INSERT INTO `device_sim` VALUES (29, '2_B2', '127.0.0.1', 2002, 2, 0, b'0', NULL, NULL, NULL, 116, NULL, NULL, NULL, NULL, '184');
INSERT INTO `device_sim` VALUES (30, '3_C1', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '193');
INSERT INTO `device_sim` VALUES (31, '3_C2', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '194');
INSERT INTO `device_sim` VALUES (32, '3_C3', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '195');
INSERT INTO `device_sim` VALUES (33, '3_C4', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '196');
INSERT INTO `device_sim` VALUES (34, '3_C5', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '197');
INSERT INTO `device_sim` VALUES (35, '3_C6', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '198');
INSERT INTO `device_sim` VALUES (36, '3_C7', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '199');
INSERT INTO `device_sim` VALUES (37, '3_C8', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '200');
INSERT INTO `device_sim` VALUES (38, '5_C1', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '201');
INSERT INTO `device_sim` VALUES (39, '5_C2', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '202');
INSERT INTO `device_sim` VALUES (40, '5_C3', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '203');
INSERT INTO `device_sim` VALUES (41, '1_C1', '127.0.0.1', 2003, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '204');
INSERT INTO `device_sim` VALUES (42, '1_C2', '127.0.0.1', 2003, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '205');
INSERT INTO `device_sim` VALUES (43, '1_C3', '127.0.0.1', 2003, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '206');
INSERT INTO `device_sim` VALUES (44, '1_C4', '127.0.0.1', 2003, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '207');
INSERT INTO `device_sim` VALUES (45, '2_C1', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '208');
INSERT INTO `device_sim` VALUES (46, '2_C2', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '209');
INSERT INTO `device_sim` VALUES (47, '2_C3', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '210');
INSERT INTO `device_sim` VALUES (48, '2_C4', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '211');
INSERT INTO `device_sim` VALUES (49, '2_C5', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '212');
INSERT INTO `device_sim` VALUES (50, '2_C6', '127.0.0.1', 2003, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '213');

-- ----------------------------
-- Table structure for device_vip
-- ----------------------------
DROP TABLE IF EXISTS `device_vip`;
CREATE TABLE `device_vip`  (
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
  CONSTRAINT `device_vip_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_vip_ibfk_2` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_vip_ibfk_3` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device_vip
-- ----------------------------
INSERT INTO `device_vip` VALUES (1, '3_A1', '192.168.0.31', 2000, 1, 1, b'0', 0, 0, 1, 1, NULL, 0, 0, 0, '161');
INSERT INTO `device_vip` VALUES (2, '3_A2', '192.168.0.36', 2000, 1, 1, b'0', 0, 0, 2, 2, NULL, 0, 0, 0, '162');
INSERT INTO `device_vip` VALUES (3, '3_A3', '192.168.0.41', 2000, 1, 1, b'0', 0, 0, 3, 3, NULL, 0, 0, 0, '163');
INSERT INTO `device_vip` VALUES (4, '3_A4', '192.168.0.46', 2000, 1, 1, b'0', 0, 0, 4, 4, NULL, 0, 0, 0, '164');
INSERT INTO `device_vip` VALUES (5, '5_A1', '192.168.0.51', 2000, 1, 1, b'0', NULL, NULL, NULL, 5, NULL, NULL, 0, NULL, '165');
INSERT INTO `device_vip` VALUES (6, '5_A2', '192.168.0.56', 2000, 1, 1, b'0', NULL, NULL, NULL, 6, NULL, NULL, 0, NULL, '166');
INSERT INTO `device_vip` VALUES (7, '5_A3', '192.168.0.61', 2000, 1, 1, b'0', NULL, NULL, NULL, 7, NULL, NULL, 0, NULL, '167');
INSERT INTO `device_vip` VALUES (8, '4_A1', '192.168.0.66', 2000, 1, 2, b'0', NULL, NULL, NULL, 8, 9, NULL, 1, NULL, '168');
INSERT INTO `device_vip` VALUES (9, '4_A2', '192.168.0.71', 2000, 1, 2, b'0', NULL, NULL, NULL, 8, 9, 8, 1, NULL, '169');
INSERT INTO `device_vip` VALUES (10, '1_A1', '192.168.0.76', 2000, 1, 2, b'0', 0, 0, 16, 10, 11, 0, 1, 0, '170');
INSERT INTO `device_vip` VALUES (11, '1_A2', '192.168.0.26', 2000, 1, 2, b'0', 0, 0, 16, 10, 11, 10, 1, 0, '171');
INSERT INTO `device_vip` VALUES (12, '2_A1', '192.168.0.116', 2000, 1, 1, b'0', NULL, NULL, NULL, 12, NULL, NULL, 0, NULL, '172');
INSERT INTO `device_vip` VALUES (13, '2_A2', '192.168.0.121', 2000, 1, 1, b'0', NULL, NULL, NULL, 13, NULL, NULL, 0, NULL, '173');
INSERT INTO `device_vip` VALUES (14, '2_A3', '192.168.0.126', 2000, 1, 1, b'0', NULL, NULL, NULL, 14, NULL, NULL, 0, NULL, '174');
INSERT INTO `device_vip` VALUES (15, '3_D1', '192.168.0.81', 2000, 0, 2, b'0', 0, 0, NULL, 15, 16, 0, 0, 0, '209');
INSERT INTO `device_vip` VALUES (16, '3_D2', '192.168.0.86', 2000, 0, 2, b'0', 0, 0, NULL, 17, 18, 0, 0, 0, '210');
INSERT INTO `device_vip` VALUES (17, '5_D1', '192.168.0.91', 2000, 0, 2, b'0', NULL, NULL, NULL, 19, 20, NULL, NULL, 0, '211');
INSERT INTO `device_vip` VALUES (18, '4_D1', '192.168.0.96', 2000, 0, 2, b'0', NULL, NULL, NULL, 21, 22, NULL, NULL, 0, '212');
INSERT INTO `device_vip` VALUES (19, '1_D1', '192.168.0.101', 2000, 0, 2, b'0', 0, 0, 16, 23, 24, 0, 0, 0, '213');
INSERT INTO `device_vip` VALUES (20, '2_D1', '192.168.0.106', 2000, 0, 2, b'0', NULL, NULL, NULL, 25, 26, NULL, NULL, 0, '214');
INSERT INTO `device_vip` VALUES (21, '2_D2', '192.168.0.111', 2000, 0, 2, b'0', NULL, NULL, NULL, 27, 28, NULL, NULL, 0, '215');
INSERT INTO `device_vip` VALUES (22, '3_B1', '192.168.0.131', 2000, 3, 0, b'0', 0, 0, NULL, 109, NULL, 0, 0, 0, '177');
INSERT INTO `device_vip` VALUES (23, '5_B1', '192.168.0.132', 2000, 3, 0, b'0', 0, 0, NULL, 111, NULL, 0, 0, 0, '178');
INSERT INTO `device_vip` VALUES (24, '1_B1', '192.168.0.133', 2000, 3, 0, b'0', 0, 0, NULL, 113, NULL, 0, 0, 0, '179');
INSERT INTO `device_vip` VALUES (25, '2_B1', '192.168.0.134', 2000, 3, 0, b'0', 0, 0, NULL, 115, NULL, 0, 0, 0, '180');
INSERT INTO `device_vip` VALUES (26, '3_B2', '192.168.0.135', 2000, 2, 0, b'0', 0, 0, NULL, 110, NULL, 0, 0, 0, '181');
INSERT INTO `device_vip` VALUES (27, '5_B2', '192.168.0.136', 2000, 2, 0, b'0', 0, 0, NULL, 112, NULL, 0, 0, 0, '182');
INSERT INTO `device_vip` VALUES (28, '1_B2', '192.168.0.137', 2000, 2, 0, b'0', 0, 0, NULL, 114, NULL, 0, 0, 0, '183');
INSERT INTO `device_vip` VALUES (29, '2_B2', '192.168.0.138', 2000, 2, 0, b'0', NULL, NULL, NULL, 116, NULL, NULL, NULL, NULL, '184');
INSERT INTO `device_vip` VALUES (30, '3_C1', '192.168.0.151', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '193');
INSERT INTO `device_vip` VALUES (31, '3_C2', '192.168.0.152', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '194');
INSERT INTO `device_vip` VALUES (32, '3_C3', '192.168.0.153', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '195');
INSERT INTO `device_vip` VALUES (33, '3_C4', '192.168.0.154', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '196');
INSERT INTO `device_vip` VALUES (34, '3_C5', '192.168.0.155', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '197');
INSERT INTO `device_vip` VALUES (35, '3_C6', '192.168.0.156', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '198');
INSERT INTO `device_vip` VALUES (36, '3_C7', '192.168.0.157', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '199');
INSERT INTO `device_vip` VALUES (37, '3_C8', '192.168.0.158', 2000, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '200');
INSERT INTO `device_vip` VALUES (38, '5_C1', '192.168.0.159', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '201');
INSERT INTO `device_vip` VALUES (39, '5_C2', '192.168.0.160', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '202');
INSERT INTO `device_vip` VALUES (40, '5_C3', '192.168.0.161', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '203');
INSERT INTO `device_vip` VALUES (41, '1_C1', '192.168.0.162', 2000, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '204');
INSERT INTO `device_vip` VALUES (42, '1_C2', '192.168.0.163', 2000, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '205');
INSERT INTO `device_vip` VALUES (43, '1_C3', '192.168.0.164', 2000, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '206');
INSERT INTO `device_vip` VALUES (44, '1_C4', '192.168.0.165', 2000, 4, 0, b'0', 1, 0, NULL, NULL, NULL, 0, 0, 0, '207');
INSERT INTO `device_vip` VALUES (45, '2_C1', '192.168.0.166', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '208');
INSERT INTO `device_vip` VALUES (46, '2_C2', '192.168.0.167', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '209');
INSERT INTO `device_vip` VALUES (47, '2_C3', '192.168.0.168', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '210');
INSERT INTO `device_vip` VALUES (48, '2_C4', '192.168.0.169', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '211');
INSERT INTO `device_vip` VALUES (49, '2_C5', '192.168.0.170', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '212');
INSERT INTO `device_vip` VALUES (50, '2_C6', '192.168.0.211', 2000, 4, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '213');

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction
-- ----------------------------
INSERT INTO `diction` VALUES (1, 0, 4, '序列号生成', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (2, 0, 1, '任务开关', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (3, 0, 2, '警告信息', b'1', b'1', b'1', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction_dtl
-- ----------------------------
INSERT INTO `diction_dtl` VALUES (1, 1, 'NewStockId', '生成库存ID', NULL, b'0', '', NULL, 221, 0, '2020-09-22 11:03:48');
INSERT INTO `diction_dtl` VALUES (2, 1, 'NewTranId', '生成交易ID', NULL, b'0', '', NULL, 236, 0, '2020-09-22 11:03:48');
INSERT INTO `diction_dtl` VALUES (3, 1, 'NewWarnId', '生成警告ID', NULL, b'0', '', NULL, 206, 0, '2020-09-22 11:10:34');
INSERT INTO `diction_dtl` VALUES (4, 1, 'NewGoodId', '生成品种ID', NULL, b'0', '', NULL, 20, NULL, '2020-09-15 14:07:32');
INSERT INTO `diction_dtl` VALUES (5, 2, 'Area1Down', '1号线下砖', NULL, b'0', '', NULL, NULL, NULL, '2020-09-22 11:05:04');
INSERT INTO `diction_dtl` VALUES (6, 2, 'Area1Up', '1号线上砖', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 01:27:37');
INSERT INTO `diction_dtl` VALUES (7, 2, 'Area1Sort', '1号线倒库', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 00:30:40');
INSERT INTO `diction_dtl` VALUES (8, 2, 'Area2Down', '2号线下砖', NULL, b'1', '', NULL, NULL, NULL, '2020-09-22 09:56:18');
INSERT INTO `diction_dtl` VALUES (9, 2, 'Area2Up', '2号线上砖', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 01:27:39');
INSERT INTO `diction_dtl` VALUES (10, 2, 'Area2Sort', '2号线倒库', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 00:30:41');
INSERT INTO `diction_dtl` VALUES (11, 2, 'Area3Down', '3号线下砖', NULL, b'1', '', NULL, NULL, NULL, '2020-09-22 01:59:08');
INSERT INTO `diction_dtl` VALUES (12, 2, 'Area3Up', '3号线上砖', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 01:27:37');
INSERT INTO `diction_dtl` VALUES (13, 2, 'Area3Sort', '3号线倒库', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 00:30:41');
INSERT INTO `diction_dtl` VALUES (14, 2, 'Area4Down', '4号线下砖', NULL, b'0', '', NULL, NULL, NULL, '2020-09-21 01:38:31');
INSERT INTO `diction_dtl` VALUES (15, 2, 'Area4Up', '4号线上砖', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 01:27:38');
INSERT INTO `diction_dtl` VALUES (16, 2, 'Area4Sort', '4号线倒库', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 00:30:42');
INSERT INTO `diction_dtl` VALUES (17, 2, 'Area5Down', '5号线下砖', NULL, b'0', '', NULL, NULL, NULL, '2020-09-21 01:38:32');
INSERT INTO `diction_dtl` VALUES (18, 2, 'Area5Up', '5号线上砖', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 01:27:38');
INSERT INTO `diction_dtl` VALUES (19, 2, 'Area5Sort', '5号线倒库', NULL, b'1', '', NULL, NULL, NULL, '2020-09-21 00:30:43');
INSERT INTO `diction_dtl` VALUES (20, 3, 'DeviceOffline', '设备离线提示', NULL, b'0', '设备离线', NULL, NULL, NULL, '2020-09-13 21:21:28');
INSERT INTO `diction_dtl` VALUES (21, 3, 'TrackFullButNoneStock', '满砖无库存', NULL, b'0', '满砖无库存', NULL, NULL, NULL, '2020-09-13 21:21:28');
INSERT INTO `diction_dtl` VALUES (22, 3, 'CarrierLoadSortTask', '小车倒库中但是小车有货', NULL, b'0', '小车倒库中但是小车有货', NULL, NULL, NULL, '2020-09-13 21:21:28');
INSERT INTO `diction_dtl` VALUES (23, 3, 'CarrierLoadNotSortTask', '小车倒库中任务清除', NULL, b'0', '小车倒库中任务清除', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (24, 3, 'ReadConBreakenCheckWire', '阅读器断开[检查连接线]', NULL, NULL, '阅读器断开[检查连接线]', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (25, 3, 'StoreSlowOverTimeCheckLight', '前进储砖减速超时，检查定位光电', NULL, NULL, '前进储砖减速超时，检查定位光电', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (26, 3, 'FrontAvoidAlert', '前防撞触发', NULL, NULL, '前防撞触发', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (27, 3, 'BackAvoidAlert', '后防撞触发', NULL, NULL, '后防撞触发', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (28, 3, 'FunctinSwitchOverTime', '功能 切换超时', NULL, NULL, '功能 切换超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (29, 3, 'BackTakeOverTime', '后退取砖任务超时', NULL, b'0', '后退取砖任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (30, 3, 'FrontGiveOverTime', '前进放砖任务超时', NULL, b'0', '前进放砖任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (31, 3, 'FrontPointOverTime', '前进至点任务超时', NULL, b'0', '前进至点任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (32, 3, 'BackPointOverTime', '后退至点任务超时', NULL, b'0', '后退至点任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (33, 3, 'Back2FerryOverTime', '后退至摆渡任务超时', NULL, b'0', '后退至摆渡任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (34, 3, 'Front2FerryOverTime', '前进至摆渡任务超时', NULL, b'0', '前进至摆渡任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (35, 3, 'GoUpOverTime', '上升超时', NULL, b'0', '上升超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (36, 3, 'GoDownOverTime', '下降超时', NULL, b'0', '下降超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (37, 3, 'BackTakeCannotDo', '后退取砖条件不满足', NULL, b'0', '后退取砖条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (38, 3, 'FrontGiveCannotDo', '前进放砖条件不满足', NULL, b'0', '前进放砖条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (39, 3, 'Back2FerryCannotDo', '后退至摆渡条件不满足', NULL, b'0', '后退至摆渡条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (40, 3, 'Front2FerryCannotDo', '前进至摆渡条件不满足', NULL, b'0', '前进至摆渡条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (41, 3, 'Back2SortCannotDo', '后退至轨道倒库条件不满足', NULL, b'0', '后退至轨道倒库条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (42, 3, 'Front2PointCannotDo', '前进至点条件不满足', NULL, b'0', '前进至点条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (43, 3, 'Back2PointCannotDo', '后退至点条件不满足', NULL, b'0', '后退至点条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (44, 3, 'NotGoodToGoUp', '无砖不执行上升', NULL, b'0', '无砖不执行上升', NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 462 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ferry_pos
-- ----------------------------
INSERT INTO `ferry_pos` VALUES (390, 10, 24, 110, -7248);
INSERT INTO `ferry_pos` VALUES (391, 11, 24, 111, 25545);
INSERT INTO `ferry_pos` VALUES (392, 23, 24, 609, 0);
INSERT INTO `ferry_pos` VALUES (393, 24, 24, 610, 0);
INSERT INTO `ferry_pos` VALUES (394, 52, 24, 224, -44413);
INSERT INTO `ferry_pos` VALUES (395, 53, 24, 225, -31727);
INSERT INTO `ferry_pos` VALUES (396, 54, 24, 226, -19100);
INSERT INTO `ferry_pos` VALUES (397, 55, 24, 227, -6262);
INSERT INTO `ferry_pos` VALUES (398, 56, 24, 228, 6504);
INSERT INTO `ferry_pos` VALUES (399, 57, 24, 229, 19199);
INSERT INTO `ferry_pos` VALUES (400, 58, 24, 230, 31877);
INSERT INTO `ferry_pos` VALUES (401, 92, 24, 524, 0);
INSERT INTO `ferry_pos` VALUES (402, 93, 24, 525, 0);
INSERT INTO `ferry_pos` VALUES (403, 94, 24, 526, 0);
INSERT INTO `ferry_pos` VALUES (404, 95, 24, 527, 0);
INSERT INTO `ferry_pos` VALUES (405, 96, 24, 528, 0);
INSERT INTO `ferry_pos` VALUES (406, 97, 24, 529, 0);
INSERT INTO `ferry_pos` VALUES (407, 98, 24, 530, 0);
INSERT INTO `ferry_pos` VALUES (408, 8, 24, 108, 0);
INSERT INTO `ferry_pos` VALUES (409, 9, 24, 109, 0);
INSERT INTO `ferry_pos` VALUES (410, 21, 24, 607, 0);
INSERT INTO `ferry_pos` VALUES (411, 22, 24, 608, 0);
INSERT INTO `ferry_pos` VALUES (412, 45, 24, 217, 0);
INSERT INTO `ferry_pos` VALUES (413, 46, 24, 218, 0);
INSERT INTO `ferry_pos` VALUES (414, 47, 24, 219, 0);
INSERT INTO `ferry_pos` VALUES (415, 48, 24, 220, 0);
INSERT INTO `ferry_pos` VALUES (416, 49, 24, 221, 0);
INSERT INTO `ferry_pos` VALUES (417, 50, 24, 222, 0);
INSERT INTO `ferry_pos` VALUES (418, 51, 24, 223, 0);
INSERT INTO `ferry_pos` VALUES (419, 85, 24, 517, 0);
INSERT INTO `ferry_pos` VALUES (420, 86, 24, 518, 0);
INSERT INTO `ferry_pos` VALUES (421, 87, 24, 519, 0);
INSERT INTO `ferry_pos` VALUES (422, 88, 24, 520, 0);
INSERT INTO `ferry_pos` VALUES (423, 89, 24, 521, 0);
INSERT INTO `ferry_pos` VALUES (424, 90, 24, 522, 0);
INSERT INTO `ferry_pos` VALUES (425, 91, 24, 523, 0);
INSERT INTO `ferry_pos` VALUES (427, 10, 28, 110, 0);
INSERT INTO `ferry_pos` VALUES (429, 11, 28, 111, 0);
INSERT INTO `ferry_pos` VALUES (431, 23, 28, 609, -5138);
INSERT INTO `ferry_pos` VALUES (433, 24, 28, 610, 27676);
INSERT INTO `ferry_pos` VALUES (435, 52, 28, 224, 0);
INSERT INTO `ferry_pos` VALUES (437, 53, 28, 225, 0);
INSERT INTO `ferry_pos` VALUES (439, 54, 28, 226, 0);
INSERT INTO `ferry_pos` VALUES (441, 55, 28, 227, 0);
INSERT INTO `ferry_pos` VALUES (443, 56, 28, 228, 0);
INSERT INTO `ferry_pos` VALUES (445, 57, 28, 229, 0);
INSERT INTO `ferry_pos` VALUES (447, 58, 28, 230, 0);
INSERT INTO `ferry_pos` VALUES (449, 92, 28, 524, -44544);
INSERT INTO `ferry_pos` VALUES (451, 93, 28, 525, -31782);
INSERT INTO `ferry_pos` VALUES (453, 94, 28, 526, -18885);
INSERT INTO `ferry_pos` VALUES (455, 95, 28, 527, -6258);
INSERT INTO `ferry_pos` VALUES (457, 96, 28, 528, 6615);
INSERT INTO `ferry_pos` VALUES (459, 97, 28, 529, 19601);
INSERT INTO `ferry_pos` VALUES (461, 98, 28, 530, 32073);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `area_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '区域',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '品种名称',
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '色号',
  `width` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '宽',
  `length` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '长',
  `isoversize` bit(1) NULL DEFAULT NULL COMMENT '是否超限',
  `stack` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '垛数',
  `pieces` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '满砖数',
  `carriertype` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '运输车类型',
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `updatetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 2, '2:600x600-A', 'A', 600, 600, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (2, 2, '2:600x900-A', 'A', 600, 900, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (3, 2, '2:600x1200-A', 'A', 600, 1200, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (4, 2, '2:700x1300-A', 'A', 700, 1300, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (5, 2, '2:750x1500-A', 'A', 750, 1500, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (6, 2, '2:800x1400-A', 'A', 800, 1400, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (7, 2, '2:800x1600-A', 'A', 800, 1600, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (8, 2, '2:800x2000-A', 'A', 800, 2000, b'0', 2, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (9, 4, '4:700x1300-A', 'A', 700, 1300, b'0', 3, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (10, 4, '4:750x1500-A', 'A', 750, 1500, b'0', 3, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (11, 1, '1:800x1400-A', 'A', 800, 1400, b'1', 2, 10, 1, '', '2020-09-20 14:58:58');
INSERT INTO `goods` VALUES (12, 1, '1:900x1800-A', 'A', 900, 1800, b'1', 2, 10, 1, '', '2020-09-20 14:59:04');
INSERT INTO `goods` VALUES (13, 1, '1:800x2000-A', 'A', 800, 2000, b'0', 1, 10, 1, '', '2020-09-20 14:59:19');
INSERT INTO `goods` VALUES (14, 1, '1:800x2600-A', 'A', 800, 2600, b'1', 1, 10, 1, '', '2020-09-20 14:59:35');
INSERT INTO `goods` VALUES (15, 1, '1:1200x2400-淡灰', '淡灰', 1200, 2400, b'0', 1, 15, 1, '', '2020-09-22 09:47:35');
INSERT INTO `goods` VALUES (16, 1, '1:1200x2700-A', 'A', 1200, 2700, b'1', 1, 10, 1, '', '2020-09-20 14:59:44');
INSERT INTO `goods` VALUES (17, 1, '1:1600x3200-A', 'A', 1600, 3200, b'1', 1, 10, 1, '', '2020-09-20 14:59:48');
INSERT INTO `goods` VALUES (18, 5, '5:1200x2400-A', 'A', 1200, 2400, b'1', 3, 10, 0, '', '2020-09-22 09:47:24');
INSERT INTO `goods` VALUES (19, 5, '5:1200x2700-A', 'A', 1200, 2700, b'1', 3, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (20, 5, '5:1000x3000-A', 'A', 1000, 3000, b'1', 3, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (21, 4, '4:800x2600-A', 'A', 800, 2600, b'1', 3, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (22, 4, '4:1200x2400-A', 'A', 1200, 2400, b'1', 3, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (23, 4, '4:1200x2700-A', 'A', 1200, 2700, b'1', 3, 10, 0, NULL, NULL);
INSERT INTO `goods` VALUES (24, 1, '1:1200x2400-白板', '白板', 1200, 2400, b'0', 1, 35, 1, '', '2020-09-22 09:46:54');

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
INSERT INTO `rf_client` VALUES ('861563040006350', '', '192.168.191.5:50082', '2020-09-21 09:56:08', '2020-09-21 15:43:13');
INSERT INTO `rf_client` VALUES ('866264036099336', '', '192.168.1.6:34657', '2020-09-20 01:06:23', '2020-09-21 01:53:37');

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
  `tilelifter_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '下砖机ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sto_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `sto_track_id_fk`(`track_id`) USING BTREE,
  CONSTRAINT `sto_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sto_track_id_fk` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock
-- ----------------------------
INSERT INTO `stock` VALUES (31, 24, 3, 45, 96, '2020-09-22 10:36:29', 0, 0, 11);
INSERT INTO `stock` VALUES (32, 24, 3, 45, 96, '2020-09-22 10:36:29', 1, 1, 11);
INSERT INTO `stock` VALUES (33, 24, 3, 45, 96, '2020-09-22 10:36:29', 2, 1, 11);
INSERT INTO `stock` VALUES (34, 24, 3, 45, 96, '2020-09-22 10:36:29', 3, 1, 11);
INSERT INTO `stock` VALUES (35, 24, 3, 45, 96, '2020-09-22 10:36:29', 6, 1, 10);
INSERT INTO `stock` VALUES (36, 24, 3, 45, 96, '2020-09-22 10:36:29', 4, 1, 10);
INSERT INTO `stock` VALUES (37, 24, 3, 45, 96, '2020-09-22 10:36:29', 5, 1, 11);
INSERT INTO `stock` VALUES (38, 24, 1, 15, 96, '2020-09-22 10:36:29', 7, 1, 10);
INSERT INTO `stock` VALUES (39, 24, 1, 30, 96, '2020-09-22 10:36:29', 8, 1, 10);
INSERT INTO `stock` VALUES (40, 24, 1, 30, 96, '2020-09-22 10:36:29', 9, 1, 10);
INSERT INTO `stock` VALUES (41, 24, 1, 30, 96, '2020-09-22 10:36:29', 10, 1, 10);
INSERT INTO `stock` VALUES (42, 24, 1, 30, 96, '2020-09-22 10:36:29', 11, 1, 10);
INSERT INTO `stock` VALUES (43, 24, 1, 16, 96, '2020-09-22 10:36:29', 12, 1, 11);
INSERT INTO `stock` VALUES (44, 24, 1, 30, 96, '2020-09-22 10:36:29', 13, 1, 10);
INSERT INTO `stock` VALUES (45, 24, 1, 30, 96, '2020-09-22 10:36:29', 14, 1, 10);
INSERT INTO `stock` VALUES (46, 24, 1, 30, 96, '2020-09-22 10:36:29', 15, 1, 10);
INSERT INTO `stock` VALUES (47, 24, 1, 30, 96, '2020-09-22 10:36:29', 16, 1, 10);
INSERT INTO `stock` VALUES (48, 24, 1, 30, 96, '2020-09-22 10:36:29', 17, 1, 10);
INSERT INTO `stock` VALUES (49, 24, 1, 30, 96, '2020-09-22 10:36:29', 18, 1, 10);
INSERT INTO `stock` VALUES (50, 24, 1, 30, 96, '2020-09-22 10:36:29', 19, 1, 10);
INSERT INTO `stock` VALUES (51, 24, 1, 30, 96, '2020-09-22 10:36:29', 20, 1, 10);
INSERT INTO `stock` VALUES (52, 24, 1, 30, 96, '2020-09-22 10:36:29', 21, 1, 10);
INSERT INTO `stock` VALUES (53, 24, 1, 30, 96, '2020-09-22 10:36:29', 23, 1, 10);
INSERT INTO `stock` VALUES (54, 24, 1, 30, 96, '2020-09-22 10:36:29', 22, 1, 10);
INSERT INTO `stock` VALUES (55, 24, 1, 30, 96, '2020-09-22 10:36:29', 24, 1, 10);
INSERT INTO `stock` VALUES (56, 24, 1, 30, 96, '2020-09-22 10:36:29', 25, 1, 10);
INSERT INTO `stock` VALUES (57, 24, 1, 30, 95, '2020-09-22 10:36:29', 0, 0, 10);
INSERT INTO `stock` VALUES (58, 24, 1, 30, 95, '2020-09-22 10:36:29', 1, 1, 10);
INSERT INTO `stock` VALUES (59, 24, 1, 30, 95, '2020-09-22 10:36:29', 2, 1, 10);
INSERT INTO `stock` VALUES (60, 24, 1, 30, 95, '2020-09-22 10:36:29', 3, 1, 10);
INSERT INTO `stock` VALUES (61, 24, 1, 30, 95, '2020-09-22 10:36:29', 4, 1, 10);
INSERT INTO `stock` VALUES (62, 24, 1, 30, 95, '2020-09-22 10:36:29', 5, 1, 10);
INSERT INTO `stock` VALUES (63, 24, 1, 30, 95, '2020-09-22 10:36:29', 6, 1, 10);
INSERT INTO `stock` VALUES (64, 24, 1, 30, 95, '2020-09-22 10:36:29', 7, 1, 10);
INSERT INTO `stock` VALUES (65, 24, 1, 30, 95, '2020-09-22 10:36:29', 8, 1, 10);
INSERT INTO `stock` VALUES (66, 24, 1, 30, 95, '2020-09-22 10:36:29', 9, 1, 10);
INSERT INTO `stock` VALUES (67, 24, 1, 30, 95, '2020-09-22 10:36:29', 10, 1, 10);
INSERT INTO `stock` VALUES (68, 24, 1, 30, 95, '2020-09-22 10:36:29', 11, 1, 10);
INSERT INTO `stock` VALUES (69, 24, 1, 30, 95, '2020-09-22 10:36:29', 12, 1, 10);
INSERT INTO `stock` VALUES (70, 24, 1, 30, 95, '2020-09-22 10:36:29', 13, 1, 10);
INSERT INTO `stock` VALUES (71, 24, 1, 30, 95, '2020-09-22 10:36:29', 14, 1, 10);
INSERT INTO `stock` VALUES (72, 24, 1, 30, 95, '2020-09-22 10:36:29', 15, 1, 10);
INSERT INTO `stock` VALUES (73, 24, 1, 30, 95, '2020-09-22 10:36:29', 16, 1, 10);
INSERT INTO `stock` VALUES (74, 24, 1, 30, 95, '2020-09-22 10:36:29', 17, 1, 10);
INSERT INTO `stock` VALUES (75, 24, 1, 30, 95, '2020-09-22 10:36:29', 18, 1, 10);
INSERT INTO `stock` VALUES (76, 24, 1, 35, 95, '2020-09-22 10:36:29', 19, 1, 10);
INSERT INTO `stock` VALUES (77, 24, 1, 35, 95, '2020-09-22 10:36:29', 20, 1, 10);
INSERT INTO `stock` VALUES (78, 24, 1, 35, 95, '2020-09-22 10:36:29', 21, 1, 10);
INSERT INTO `stock` VALUES (79, 24, 1, 35, 95, '2020-09-22 10:36:29', 22, 1, 10);
INSERT INTO `stock` VALUES (80, 24, 1, 35, 95, '2020-09-22 10:36:29', 23, 1, 10);
INSERT INTO `stock` VALUES (81, 24, 1, 35, 95, '2020-09-22 10:36:29', 24, 1, 10);
INSERT INTO `stock` VALUES (82, 24, 1, 35, 95, '2020-09-22 10:36:29', 25, 1, 10);
INSERT INTO `stock` VALUES (83, 24, 1, 35, 56, '2020-09-22 10:36:29', 0, 0, 10);
INSERT INTO `stock` VALUES (84, 24, 1, 35, 56, '2020-09-22 10:36:29', 1, 1, 10);
INSERT INTO `stock` VALUES (85, 24, 1, 35, 56, '2020-09-22 10:36:29', 2, 1, 10);
INSERT INTO `stock` VALUES (86, 24, 1, 35, 56, '2020-09-22 10:36:29', 3, 1, 10);
INSERT INTO `stock` VALUES (87, 24, 1, 35, 56, '2020-09-22 10:36:29', 4, 1, 10);
INSERT INTO `stock` VALUES (88, 24, 1, 35, 56, '2020-09-22 10:36:29', 5, 1, 10);
INSERT INTO `stock` VALUES (89, 24, 1, 35, 56, '2020-09-22 10:36:29', 6, 1, 10);
INSERT INTO `stock` VALUES (90, 24, 1, 35, 56, '2020-09-22 10:36:29', 7, 1, 10);
INSERT INTO `stock` VALUES (91, 24, 1, 35, 56, '2020-09-22 10:36:29', 8, 1, 10);
INSERT INTO `stock` VALUES (92, 24, 1, 35, 56, '2020-09-22 10:36:29', 9, 1, 10);
INSERT INTO `stock` VALUES (93, 24, 1, 35, 56, '2020-09-22 10:36:29', 10, 1, 10);
INSERT INTO `stock` VALUES (94, 24, 1, 35, 56, '2020-09-22 10:36:29', 11, 1, 10);
INSERT INTO `stock` VALUES (95, 24, 1, 35, 56, '2020-09-22 10:36:29', 12, 1, 10);
INSERT INTO `stock` VALUES (96, 24, 1, 35, 56, '2020-09-22 10:36:29', 13, 1, 10);
INSERT INTO `stock` VALUES (97, 24, 1, 35, 56, '2020-09-22 10:36:29', 14, 1, 10);
INSERT INTO `stock` VALUES (98, 24, 1, 35, 56, '2020-09-22 10:36:29', 15, 1, 10);
INSERT INTO `stock` VALUES (99, 24, 1, 35, 56, '2020-09-22 10:36:29', 16, 1, 10);
INSERT INTO `stock` VALUES (100, 24, 1, 35, 56, '2020-09-22 10:36:29', 17, 1, 10);
INSERT INTO `stock` VALUES (101, 24, 1, 35, 56, '2020-09-22 10:36:29', 18, 1, 10);
INSERT INTO `stock` VALUES (102, 24, 1, 35, 56, '2020-09-22 10:36:29', 19, 1, 10);
INSERT INTO `stock` VALUES (103, 24, 1, 35, 56, '2020-09-22 10:36:29', 20, 1, 10);
INSERT INTO `stock` VALUES (104, 24, 1, 35, 56, '2020-09-22 10:36:29', 21, 1, 10);
INSERT INTO `stock` VALUES (105, 24, 1, 35, 56, '2020-09-22 10:36:29', 22, 1, 10);
INSERT INTO `stock` VALUES (106, 24, 1, 35, 56, '2020-09-22 10:36:29', 23, 1, 10);
INSERT INTO `stock` VALUES (107, 24, 1, 35, 56, '2020-09-22 10:36:29', 24, 1, 10);
INSERT INTO `stock` VALUES (108, 15, 1, 35, 55, '2020-09-22 03:35:09', 0, 0, 10);
INSERT INTO `stock` VALUES (109, 15, 1, 35, 55, '2020-09-22 04:04:53', 1, 1, 10);
INSERT INTO `stock` VALUES (110, 15, 1, 35, 55, '2020-09-22 04:32:57', 2, 1, 10);
INSERT INTO `stock` VALUES (111, 15, 1, 35, 55, '2020-09-22 05:01:58', 3, 1, 10);
INSERT INTO `stock` VALUES (112, 15, 1, 35, 55, '2020-09-22 05:30:48', 4, 1, 10);
INSERT INTO `stock` VALUES (113, 15, 1, 35, 55, '2020-09-22 06:01:29', 5, 1, 10);
INSERT INTO `stock` VALUES (114, 15, 1, 35, 55, '2020-09-22 06:46:37', 6, 1, 10);
INSERT INTO `stock` VALUES (115, 15, 1, 35, 55, '2020-09-22 07:18:39', 7, 1, 10);
INSERT INTO `stock` VALUES (116, 15, 1, 35, 55, '2020-09-22 07:47:25', 8, 1, 10);
INSERT INTO `stock` VALUES (117, 15, 1, 35, 55, '2020-09-22 08:17:21', 9, 1, 10);
INSERT INTO `stock` VALUES (118, 15, 1, 35, 55, '2020-09-22 08:46:17', 10, 1, 10);
INSERT INTO `stock` VALUES (119, 15, 1, 35, 55, '2020-09-22 09:15:25', 11, 1, 10);
INSERT INTO `stock` VALUES (120, 15, 1, 35, 55, '2020-09-22 09:43:26', 12, 1, 10);
INSERT INTO `stock` VALUES (206, 15, 1, 50, 55, '2020-09-22 10:06:33', 13, 1, 10);
INSERT INTO `stock` VALUES (207, 24, 1, 50, 58, '2020-09-22 10:09:28', 0, 0, 11);
INSERT INTO `stock` VALUES (208, 15, 1, 50, 55, '2020-09-22 10:11:22', 14, 1, 10);
INSERT INTO `stock` VALUES (209, 24, 1, 50, 58, '2020-09-22 10:15:18', 1, 1, 11);
INSERT INTO `stock` VALUES (210, 15, 1, 50, 55, '2020-09-22 10:16:12', 15, 1, 10);
INSERT INTO `stock` VALUES (211, 24, 1, 50, 58, '2020-09-22 10:17:06', 2, 1, 11);
INSERT INTO `stock` VALUES (212, 15, 1, 50, 55, '2020-09-22 10:43:18', 16, 1, 10);
INSERT INTO `stock` VALUES (213, 24, 1, 50, 58, '2020-09-22 10:44:04', 3, 1, 11);
INSERT INTO `stock` VALUES (214, 24, 1, 50, 58, '2020-09-22 10:48:31', 4, 1, 11);
INSERT INTO `stock` VALUES (215, 15, 1, 50, 55, '2020-09-22 10:49:21', 17, 1, 10);
INSERT INTO `stock` VALUES (216, 24, 1, 50, 58, '2020-09-22 10:53:17', 5, 1, 11);
INSERT INTO `stock` VALUES (217, 15, 1, 50, 55, '2020-09-22 10:58:19', 18, 1, 10);
INSERT INTO `stock` VALUES (218, 24, 1, 50, 58, '2020-09-22 10:59:26', 6, 1, 11);
INSERT INTO `stock` VALUES (219, 15, 1, 50, 55, '2020-09-22 11:03:35', 19, 1, 10);
INSERT INTO `stock` VALUES (220, 24, 1, 50, 58, '2020-09-22 11:04:26', 7, 1, 11);

-- ----------------------------
-- Table structure for stock_log
-- ----------------------------
DROP TABLE IF EXISTS `stock_log`;
CREATE TABLE `stock_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `goods_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '品种ID',
  `stack` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '垛数',
  `pieces` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '片数',
  `track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '储砖轨道ID',
  `tilelifter_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '下砖机ID',
  `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '生产时间/消耗时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_log
-- ----------------------------
INSERT INTO `stock_log` VALUES (1, 1, 1, 1, 1, 1, '2020-09-18 19:04:35');
INSERT INTO `stock_log` VALUES (2, 1, 2, 100, 1, 1, '2020-09-18 19:53:33');
INSERT INTO `stock_log` VALUES (3, 1, 2, 100, 1, 1, '2020-09-18 20:29:38');
INSERT INTO `stock_log` VALUES (4, 1, 2, 100, 1, 1, '2020-09-18 20:30:43');
INSERT INTO `stock_log` VALUES (5, 1, 2, 100, 1, 1, '2020-09-18 21:05:39');
INSERT INTO `stock_log` VALUES (6, 1, 2, 100, 1, 1, '2020-09-18 21:09:28');
INSERT INTO `stock_log` VALUES (7, 4, 2, 100, 4, 4, '2020-09-18 21:09:30');
INSERT INTO `stock_log` VALUES (8, 2, 2, 100, 2, 2, '2020-09-18 21:09:32');
INSERT INTO `stock_log` VALUES (9, 1, 2, 100, 1, 1, '2020-09-18 22:11:56');
INSERT INTO `stock_log` VALUES (10, 1, 2, 100, 1, 1, '2020-09-18 22:38:45');
INSERT INTO `stock_log` VALUES (11, 1, 2, 100, 1, 1, '2020-09-18 23:08:23');
INSERT INTO `stock_log` VALUES (12, 4, 2, 100, 4, 4, '2020-09-18 23:08:27');
INSERT INTO `stock_log` VALUES (13, 2, 2, 100, 2, 2, '2020-09-18 23:13:29');
INSERT INTO `stock_log` VALUES (14, 2, 2, 100, 2, 2, '2020-09-18 23:19:23');
INSERT INTO `stock_log` VALUES (15, 1, 2, 100, 1, 1, '2020-09-19 16:15:32');
INSERT INTO `stock_log` VALUES (16, 1, 2, 100, 1, 1, '2020-09-19 16:18:46');
INSERT INTO `stock_log` VALUES (17, 1, 2, 100, 1, 1, '2020-09-20 14:28:27');
INSERT INTO `stock_log` VALUES (18, 1, 2, 100, 1, 1, '2020-09-20 14:30:30');
INSERT INTO `stock_log` VALUES (19, 2, 2, 100, 2, 2, '2020-09-20 14:31:18');
INSERT INTO `stock_log` VALUES (20, 1, 2, 100, 1, 1, '2020-09-20 14:33:51');
INSERT INTO `stock_log` VALUES (21, 2, 2, 100, 2, 2, '2020-09-20 14:33:54');
INSERT INTO `stock_log` VALUES (22, 1, 2, 100, 1, 1, '2020-09-20 17:25:05');
INSERT INTO `stock_log` VALUES (23, 2, 2, 100, 2, 2, '2020-09-20 17:25:10');
INSERT INTO `stock_log` VALUES (24, 1, 2, 100, 1, 1, '2020-09-20 17:31:45');
INSERT INTO `stock_log` VALUES (25, 4, 2, 100, 4, 4, '2020-09-20 23:58:27');
INSERT INTO `stock_log` VALUES (26, 2, 2, 100, 2, 2, '2020-09-21 00:03:03');
INSERT INTO `stock_log` VALUES (27, 3, 2, 100, 3, 3, '2020-09-21 00:03:06');
INSERT INTO `stock_log` VALUES (28, 19, 3, 150, 6, 6, '2020-09-21 00:04:20');
INSERT INTO `stock_log` VALUES (29, 16, 3, 150, 10, 10, '2020-09-21 00:04:20');
INSERT INTO `stock_log` VALUES (30, 1, 2, 100, 13, 13, '2020-09-21 00:04:24');
INSERT INTO `stock_log` VALUES (31, 18, 3, 150, 5, 5, '2020-09-21 00:04:24');
INSERT INTO `stock_log` VALUES (32, 20, 3, 150, 7, 7, '2020-09-21 00:04:24');
INSERT INTO `stock_log` VALUES (33, 4, 2, 100, 4, 4, '2020-09-21 00:05:02');
INSERT INTO `stock_log` VALUES (34, 16, 3, 150, 10, 11, '2020-09-21 00:05:49');
INSERT INTO `stock_log` VALUES (35, 16, 3, 150, 11, 10, '2020-09-21 00:06:52');
INSERT INTO `stock_log` VALUES (36, 16, 3, 150, 10, 10, '2020-09-21 00:06:52');
INSERT INTO `stock_log` VALUES (37, 3, 2, 100, 3, 3, '2020-09-21 00:27:48');
INSERT INTO `stock_log` VALUES (38, 1, 2, 100, 1, 1, '2020-09-21 00:27:48');
INSERT INTO `stock_log` VALUES (39, 16, 3, 150, 10, 10, '2020-09-21 00:27:49');
INSERT INTO `stock_log` VALUES (40, 4, 2, 100, 4, 4, '2020-09-21 00:27:49');
INSERT INTO `stock_log` VALUES (41, 20, 3, 150, 7, 7, '2020-09-21 00:27:50');
INSERT INTO `stock_log` VALUES (42, 18, 3, 150, 5, 5, '2020-09-21 00:27:52');
INSERT INTO `stock_log` VALUES (43, 19, 3, 150, 6, 6, '2020-09-21 00:27:54');
INSERT INTO `stock_log` VALUES (44, 16, 3, 150, 10, 11, '2020-09-21 00:28:52');
INSERT INTO `stock_log` VALUES (45, 16, 3, 150, 11, 10, '2020-09-21 00:29:47');
INSERT INTO `stock_log` VALUES (46, 16, 3, 150, 10, 10, '2020-09-21 00:29:47');
INSERT INTO `stock_log` VALUES (47, 16, 3, 150, 11, 11, '2020-09-21 00:30:46');
INSERT INTO `stock_log` VALUES (48, 16, 3, 150, 10, 11, '2020-09-21 00:30:46');
INSERT INTO `stock_log` VALUES (49, 20, 3, 150, 7, 7, '2020-09-21 00:33:48');
INSERT INTO `stock_log` VALUES (50, 18, 3, 150, 5, 5, '2020-09-21 00:34:40');
INSERT INTO `stock_log` VALUES (51, 16, 3, 150, 10, 10, '2020-09-21 00:34:57');
INSERT INTO `stock_log` VALUES (52, 3, 2, 100, 3, 3, '2020-09-21 00:35:00');
INSERT INTO `stock_log` VALUES (53, 19, 3, 150, 6, 6, '2020-09-21 00:35:00');
INSERT INTO `stock_log` VALUES (54, 1, 2, 100, 1, 1, '2020-09-21 00:35:00');
INSERT INTO `stock_log` VALUES (55, 4, 2, 100, 4, 4, '2020-09-21 00:36:30');
INSERT INTO `stock_log` VALUES (56, 2, 2, 100, 2, 2, '2020-09-21 00:37:35');
INSERT INTO `stock_log` VALUES (57, 16, 3, 150, 10, 11, '2020-09-21 00:37:37');
INSERT INTO `stock_log` VALUES (58, 16, 3, 150, 11, 10, '2020-09-21 00:39:40');
INSERT INTO `stock_log` VALUES (59, 16, 3, 150, 10, 10, '2020-09-21 00:39:40');
INSERT INTO `stock_log` VALUES (60, 20, 3, 150, 7, 7, '2020-09-21 00:39:57');
INSERT INTO `stock_log` VALUES (61, 16, 3, 150, 11, 11, '2020-09-21 00:40:20');
INSERT INTO `stock_log` VALUES (62, 16, 3, 150, 10, 11, '2020-09-21 00:40:20');
INSERT INTO `stock_log` VALUES (63, 18, 3, 150, 5, 5, '2020-09-21 00:40:37');
INSERT INTO `stock_log` VALUES (64, 3, 2, 100, 3, 3, '2020-09-21 00:42:40');
INSERT INTO `stock_log` VALUES (65, 17, 3, 150, 12, 12, '2020-09-21 00:42:48');
INSERT INTO `stock_log` VALUES (66, 19, 3, 150, 6, 6, '2020-09-21 00:42:50');
INSERT INTO `stock_log` VALUES (67, 1, 2, 100, 1, 1, '2020-09-21 00:43:41');
INSERT INTO `stock_log` VALUES (68, 4, 2, 100, 4, 4, '2020-09-21 00:44:36');
INSERT INTO `stock_log` VALUES (69, 16, 3, 150, 10, 10, '2020-09-21 00:44:43');
INSERT INTO `stock_log` VALUES (70, 16, 3, 150, 10, 11, '2020-09-21 00:45:35');
INSERT INTO `stock_log` VALUES (71, 20, 3, 150, 7, 7, '2020-09-21 00:45:45');
INSERT INTO `stock_log` VALUES (72, 2, 2, 100, 2, 2, '2020-09-21 00:45:48');
INSERT INTO `stock_log` VALUES (73, 18, 3, 150, 5, 5, '2020-09-21 00:46:30');
INSERT INTO `stock_log` VALUES (74, 3, 2, 100, 3, 3, '2020-09-21 00:48:17');
INSERT INTO `stock_log` VALUES (75, 19, 3, 150, 6, 6, '2020-09-21 00:48:24');
INSERT INTO `stock_log` VALUES (76, 1, 2, 100, 1, 1, '2020-09-21 00:49:21');
INSERT INTO `stock_log` VALUES (77, 16, 3, 150, 11, 10, '2020-09-21 00:49:41');
INSERT INTO `stock_log` VALUES (78, 16, 3, 150, 10, 10, '2020-09-21 00:49:41');
INSERT INTO `stock_log` VALUES (79, 16, 3, 150, 11, 11, '2020-09-21 00:50:21');
INSERT INTO `stock_log` VALUES (80, 16, 3, 150, 10, 11, '2020-09-21 00:50:21');
INSERT INTO `stock_log` VALUES (81, 4, 2, 100, 4, 4, '2020-09-21 00:50:46');
INSERT INTO `stock_log` VALUES (82, 20, 3, 150, 7, 7, '2020-09-21 00:51:31');
INSERT INTO `stock_log` VALUES (83, 2, 2, 100, 2, 2, '2020-09-21 00:51:59');
INSERT INTO `stock_log` VALUES (84, 18, 3, 150, 5, 5, '2020-09-21 00:52:14');
INSERT INTO `stock_log` VALUES (85, 3, 2, 100, 3, 3, '2020-09-21 00:53:56');
INSERT INTO `stock_log` VALUES (86, 19, 3, 150, 6, 6, '2020-09-21 00:54:00');
INSERT INTO `stock_log` VALUES (87, 16, 3, 150, 10, 10, '2020-09-21 00:54:45');
INSERT INTO `stock_log` VALUES (88, 1, 2, 100, 1, 1, '2020-09-21 00:55:01');
INSERT INTO `stock_log` VALUES (89, 16, 3, 150, 10, 11, '2020-09-21 00:55:46');
INSERT INTO `stock_log` VALUES (90, 4, 2, 100, 4, 4, '2020-09-21 00:56:51');
INSERT INTO `stock_log` VALUES (91, 20, 3, 150, 7, 7, '2020-09-21 00:57:19');
INSERT INTO `stock_log` VALUES (92, 18, 3, 150, 5, 5, '2020-09-21 00:58:06');
INSERT INTO `stock_log` VALUES (93, 2, 2, 100, 2, 2, '2020-09-21 00:58:15');
INSERT INTO `stock_log` VALUES (94, 3, 2, 100, 3, 3, '2020-09-21 00:59:35');
INSERT INTO `stock_log` VALUES (95, 19, 3, 150, 6, 6, '2020-09-21 00:59:38');
INSERT INTO `stock_log` VALUES (96, 16, 3, 150, 11, 10, '2020-09-21 00:59:44');
INSERT INTO `stock_log` VALUES (97, 16, 3, 150, 10, 10, '2020-09-21 00:59:44');
INSERT INTO `stock_log` VALUES (98, 16, 3, 150, 11, 11, '2020-09-21 01:00:29');
INSERT INTO `stock_log` VALUES (99, 16, 3, 150, 10, 11, '2020-09-21 01:00:29');
INSERT INTO `stock_log` VALUES (100, 1, 2, 100, 1, 1, '2020-09-21 01:00:46');
INSERT INTO `stock_log` VALUES (101, 4, 2, 100, 4, 4, '2020-09-21 01:03:01');
INSERT INTO `stock_log` VALUES (102, 20, 3, 150, 7, 7, '2020-09-21 01:03:09');
INSERT INTO `stock_log` VALUES (103, 18, 3, 150, 5, 5, '2020-09-21 01:04:00');
INSERT INTO `stock_log` VALUES (104, 2, 2, 100, 2, 2, '2020-09-21 01:04:37');
INSERT INTO `stock_log` VALUES (105, 16, 3, 150, 10, 10, '2020-09-21 01:04:42');
INSERT INTO `stock_log` VALUES (106, 3, 2, 100, 3, 3, '2020-09-21 01:05:14');
INSERT INTO `stock_log` VALUES (107, 19, 3, 150, 6, 6, '2020-09-21 01:05:14');
INSERT INTO `stock_log` VALUES (108, 16, 3, 150, 10, 11, '2020-09-21 01:05:45');
INSERT INTO `stock_log` VALUES (109, 1, 2, 100, 1, 1, '2020-09-21 01:06:29');
INSERT INTO `stock_log` VALUES (110, 20, 3, 150, 7, 7, '2020-09-21 01:09:02');
INSERT INTO `stock_log` VALUES (111, 4, 2, 100, 4, 4, '2020-09-21 01:09:15');
INSERT INTO `stock_log` VALUES (112, 16, 3, 150, 11, 10, '2020-09-21 01:09:44');
INSERT INTO `stock_log` VALUES (113, 16, 3, 150, 10, 10, '2020-09-21 01:09:44');
INSERT INTO `stock_log` VALUES (114, 18, 3, 150, 5, 5, '2020-09-21 01:09:52');
INSERT INTO `stock_log` VALUES (115, 16, 3, 150, 11, 11, '2020-09-21 01:10:34');
INSERT INTO `stock_log` VALUES (116, 16, 3, 150, 10, 11, '2020-09-21 01:10:34');
INSERT INTO `stock_log` VALUES (117, 19, 3, 150, 6, 6, '2020-09-21 01:10:57');
INSERT INTO `stock_log` VALUES (118, 2, 2, 100, 2, 2, '2020-09-21 01:11:02');
INSERT INTO `stock_log` VALUES (119, 3, 2, 100, 3, 3, '2020-09-21 01:11:47');
INSERT INTO `stock_log` VALUES (120, 1, 2, 100, 1, 1, '2020-09-21 01:12:32');
INSERT INTO `stock_log` VALUES (121, 16, 3, 150, 10, 10, '2020-09-21 01:14:42');
INSERT INTO `stock_log` VALUES (122, 20, 3, 150, 7, 7, '2020-09-21 01:14:50');
INSERT INTO `stock_log` VALUES (123, 4, 2, 100, 4, 4, '2020-09-21 01:15:30');
INSERT INTO `stock_log` VALUES (124, 16, 3, 150, 10, 11, '2020-09-21 01:15:32');
INSERT INTO `stock_log` VALUES (125, 18, 3, 150, 5, 5, '2020-09-21 01:15:47');
INSERT INTO `stock_log` VALUES (126, 19, 3, 150, 6, 6, '2020-09-21 01:16:37');
INSERT INTO `stock_log` VALUES (127, 2, 2, 100, 2, 2, '2020-09-21 01:17:20');
INSERT INTO `stock_log` VALUES (128, 3, 2, 100, 3, 3, '2020-09-21 01:17:57');
INSERT INTO `stock_log` VALUES (129, 1, 2, 100, 1, 1, '2020-09-21 01:18:47');
INSERT INTO `stock_log` VALUES (130, 16, 3, 150, 11, 10, '2020-09-21 01:19:42');
INSERT INTO `stock_log` VALUES (131, 16, 3, 150, 10, 10, '2020-09-21 01:19:42');
INSERT INTO `stock_log` VALUES (132, 20, 3, 150, 7, 7, '2020-09-21 01:20:37');
INSERT INTO `stock_log` VALUES (133, 16, 3, 150, 11, 11, '2020-09-21 01:20:37');
INSERT INTO `stock_log` VALUES (134, 16, 3, 150, 10, 11, '2020-09-21 01:20:37');
INSERT INTO `stock_log` VALUES (135, 18, 3, 150, 5, 5, '2020-09-21 01:21:32');
INSERT INTO `stock_log` VALUES (136, 4, 2, 100, 4, 4, '2020-09-21 01:21:45');
INSERT INTO `stock_log` VALUES (137, 19, 3, 150, 6, 6, '2020-09-21 01:22:15');
INSERT INTO `stock_log` VALUES (138, 2, 2, 100, 2, 2, '2020-09-21 01:23:30');
INSERT INTO `stock_log` VALUES (139, 3, 2, 100, 3, 3, '2020-09-21 01:24:13');
INSERT INTO `stock_log` VALUES (140, 16, 3, 150, 10, 10, '2020-09-21 01:24:40');
INSERT INTO `stock_log` VALUES (141, 1, 2, 100, 1, 1, '2020-09-21 01:24:57');
INSERT INTO `stock_log` VALUES (142, 16, 3, 150, 10, 11, '2020-09-21 01:25:28');
INSERT INTO `stock_log` VALUES (143, 20, 3, 150, 7, 7, '2020-09-21 01:26:25');
INSERT INTO `stock_log` VALUES (144, 18, 3, 150, 5, 5, '2020-09-21 01:27:15');
INSERT INTO `stock_log` VALUES (145, 4, 2, 100, 4, 4, '2020-09-21 01:27:55');
INSERT INTO `stock_log` VALUES (146, 19, 3, 150, 6, 6, '2020-09-21 01:28:13');
INSERT INTO `stock_log` VALUES (147, 2, 2, 100, 2, 2, '2020-09-21 01:29:40');
INSERT INTO `stock_log` VALUES (148, 16, 3, 150, 11, 10, '2020-09-21 01:29:40');
INSERT INTO `stock_log` VALUES (149, 16, 3, 150, 10, 10, '2020-09-21 01:29:40');
INSERT INTO `stock_log` VALUES (150, 3, 2, 100, 3, 3, '2020-09-21 01:30:15');
INSERT INTO `stock_log` VALUES (151, 18, 3, 150, 19, 17, '2020-09-21 01:30:20');
INSERT INTO `stock_log` VALUES (152, 16, 3, 150, 11, 11, '2020-09-21 01:30:25');
INSERT INTO `stock_log` VALUES (153, 16, 3, 150, 10, 11, '2020-09-21 01:30:25');
INSERT INTO `stock_log` VALUES (154, 1, 2, 100, 8, 8, '2020-09-21 01:30:50');
INSERT INTO `stock_log` VALUES (155, 1, 2, 100, 1, 1, '2020-09-21 01:31:03');
INSERT INTO `stock_log` VALUES (156, 20, 3, 150, 7, 7, '2020-09-21 01:32:01');
INSERT INTO `stock_log` VALUES (157, 1, 2, 100, 15, 15, '2020-09-21 01:32:19');
INSERT INTO `stock_log` VALUES (158, 2, 2, 100, 17, 16, '2020-09-21 01:32:26');
INSERT INTO `stock_log` VALUES (159, 18, 3, 150, 5, 5, '2020-09-21 01:32:53');
INSERT INTO `stock_log` VALUES (160, 19, 3, 150, 6, 6, '2020-09-21 01:33:53');
INSERT INTO `stock_log` VALUES (161, 4, 2, 100, 4, 4, '2020-09-21 01:34:08');
INSERT INTO `stock_log` VALUES (162, 16, 3, 150, 10, 10, '2020-09-21 01:34:42');
INSERT INTO `stock_log` VALUES (163, 16, 3, 150, 10, 11, '2020-09-21 01:35:29');
INSERT INTO `stock_log` VALUES (164, 2, 2, 100, 2, 2, '2020-09-21 01:35:54');
INSERT INTO `stock_log` VALUES (165, 3, 2, 100, 3, 3, '2020-09-21 01:36:40');
INSERT INTO `stock_log` VALUES (166, 1, 2, 100, 1, 1, '2020-09-21 01:37:30');
INSERT INTO `stock_log` VALUES (167, 20, 3, 150, 7, 7, '2020-09-21 01:37:37');
INSERT INTO `stock_log` VALUES (168, 16, 3, 150, 10, 10, '2020-09-22 01:38:38');
INSERT INTO `stock_log` VALUES (169, 16, 3, 150, 10, 10, '2020-09-22 01:39:20');
INSERT INTO `stock_log` VALUES (170, 16, 3, 150, 10, 10, '2020-09-22 01:42:48');
INSERT INTO `stock_log` VALUES (171, 16, 3, 150, 10, 10, '2020-09-22 01:52:36');
INSERT INTO `stock_log` VALUES (172, 16, 3, 150, 10, 10, '2020-09-22 01:58:47');
INSERT INTO `stock_log` VALUES (173, 1, 2, 100, 1, 1, '2020-09-22 01:59:17');
INSERT INTO `stock_log` VALUES (174, 2, 2, 100, 2, 2, '2020-09-22 01:59:17');
INSERT INTO `stock_log` VALUES (175, 3, 2, 100, 3, 3, '2020-09-22 01:59:17');
INSERT INTO `stock_log` VALUES (176, 4, 2, 100, 4, 4, '2020-09-22 01:59:17');
INSERT INTO `stock_log` VALUES (177, 16, 3, 150, 10, 10, '2020-09-22 09:07:15');
INSERT INTO `stock_log` VALUES (178, 16, 3, 150, 10, 10, '2020-09-22 09:26:23');
INSERT INTO `stock_log` VALUES (179, 1, 2, 100, 1, 1, '2020-09-22 09:27:03');
INSERT INTO `stock_log` VALUES (180, 2, 2, 100, 2, 2, '2020-09-22 09:27:03');
INSERT INTO `stock_log` VALUES (181, 16, 3, 150, 11, 10, '2020-09-22 09:31:57');
INSERT INTO `stock_log` VALUES (182, 16, 3, 150, 10, 10, '2020-09-22 09:31:57');
INSERT INTO `stock_log` VALUES (183, 1, 2, 100, 1, 1, '2020-09-22 09:32:43');
INSERT INTO `stock_log` VALUES (184, 2, 2, 100, 2, 2, '2020-09-22 09:33:43');
INSERT INTO `stock_log` VALUES (185, 16, 3, 150, 10, 10, '2020-09-22 09:36:56');
INSERT INTO `stock_log` VALUES (186, 4, 2, 100, 4, 4, '2020-09-22 09:37:43');
INSERT INTO `stock_log` VALUES (187, 1, 2, 100, 1, 1, '2020-09-22 09:39:01');
INSERT INTO `stock_log` VALUES (188, 2, 2, 100, 2, 2, '2020-09-22 09:39:56');
INSERT INTO `stock_log` VALUES (189, 16, 3, 150, 11, 10, '2020-09-22 09:41:56');
INSERT INTO `stock_log` VALUES (190, 16, 3, 150, 10, 10, '2020-09-22 09:41:56');
INSERT INTO `stock_log` VALUES (191, 4, 2, 100, 4, 4, '2020-09-22 09:43:28');
INSERT INTO `stock_log` VALUES (192, 1, 2, 100, 1, 1, '2020-09-22 09:45:06');
INSERT INTO `stock_log` VALUES (193, 2, 2, 100, 2, 2, '2020-09-22 09:45:59');
INSERT INTO `stock_log` VALUES (194, 16, 3, 150, 10, 10, '2020-09-22 09:46:56');
INSERT INTO `stock_log` VALUES (195, 4, 2, 100, 4, 4, '2020-09-22 09:49:11');
INSERT INTO `stock_log` VALUES (196, 1, 2, 100, 1, 1, '2020-09-22 09:51:14');
INSERT INTO `stock_log` VALUES (197, 16, 3, 150, 11, 10, '2020-09-22 09:51:56');
INSERT INTO `stock_log` VALUES (198, 16, 3, 150, 10, 10, '2020-09-22 09:51:56');
INSERT INTO `stock_log` VALUES (199, 2, 2, 100, 2, 2, '2020-09-22 09:52:16');
INSERT INTO `stock_log` VALUES (200, 15, 1, 50, 10, 10, '2020-09-22 09:53:37');
INSERT INTO `stock_log` VALUES (201, 4, 2, 100, 4, 4, '2020-09-22 09:54:57');
INSERT INTO `stock_log` VALUES (202, 4, 2, 100, 4, 4, '2020-09-22 09:55:50');
INSERT INTO `stock_log` VALUES (203, 1, 2, 100, 1, 1, '2020-09-22 09:57:23');
INSERT INTO `stock_log` VALUES (204, 15, 1, 50, 11, 10, '2020-09-22 09:58:31');
INSERT INTO `stock_log` VALUES (205, 15, 1, 50, 10, 10, '2020-09-22 09:58:31');
INSERT INTO `stock_log` VALUES (206, 2, 2, 100, 2, 2, '2020-09-22 09:58:58');
INSERT INTO `stock_log` VALUES (207, 4, 2, 100, 4, 4, '2020-09-22 10:01:33');
INSERT INTO `stock_log` VALUES (208, 15, 1, 50, 10, 10, '2020-09-22 10:05:26');
INSERT INTO `stock_log` VALUES (209, 24, 1, 50, 11, 11, '2020-09-22 10:08:52');
INSERT INTO `stock_log` VALUES (210, 24, 1, 50, 10, 11, '2020-09-22 10:08:53');
INSERT INTO `stock_log` VALUES (211, 15, 1, 50, 11, 10, '2020-09-22 10:10:46');
INSERT INTO `stock_log` VALUES (212, 15, 1, 50, 10, 10, '2020-09-22 10:10:46');
INSERT INTO `stock_log` VALUES (213, 24, 1, 50, 10, 11, '2020-09-22 10:14:36');
INSERT INTO `stock_log` VALUES (214, 15, 1, 50, 10, 10, '2020-09-22 10:15:32');
INSERT INTO `stock_log` VALUES (215, 24, 1, 50, 10, 11, '2020-09-22 10:16:27');
INSERT INTO `stock_log` VALUES (216, 15, 1, 50, 10, 10, '2020-09-22 10:42:40');
INSERT INTO `stock_log` VALUES (217, 24, 1, 50, 11, 11, '2020-09-22 10:43:30');
INSERT INTO `stock_log` VALUES (218, 24, 1, 50, 10, 11, '2020-09-22 10:43:31');
INSERT INTO `stock_log` VALUES (219, 24, 1, 50, 10, 11, '2020-09-22 10:47:41');
INSERT INTO `stock_log` VALUES (220, 15, 1, 50, 10, 10, '2020-09-22 10:48:43');
INSERT INTO `stock_log` VALUES (221, 24, 1, 50, 11, 11, '2020-09-22 10:52:38');
INSERT INTO `stock_log` VALUES (222, 24, 1, 50, 10, 11, '2020-09-22 10:52:38');
INSERT INTO `stock_log` VALUES (223, 15, 1, 50, 10, 10, '2020-09-22 10:57:38');
INSERT INTO `stock_log` VALUES (224, 24, 1, 50, 10, 11, '2020-09-22 10:58:33');
INSERT INTO `stock_log` VALUES (225, 15, 1, 50, 11, 10, '2020-09-22 11:02:58');
INSERT INTO `stock_log` VALUES (226, 15, 1, 50, 10, 10, '2020-09-22 11:02:58');
INSERT INTO `stock_log` VALUES (227, 24, 1, 50, 11, 11, '2020-09-22 11:03:48');
INSERT INTO `stock_log` VALUES (228, 24, 1, 50, 10, 11, '2020-09-22 11:03:48');

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
  `cancel` bit(1) NULL DEFAULT NULL COMMENT '是否取消',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tran_produce_time_idx`(`create_time`) USING BTREE,
  INDEX `tran_type_idx`(`trans_type`) USING BTREE,
  INDEX `tran_status_idx`(`trans_status`) USING BTREE,
  INDEX `tran_finish_idx`(`finish`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_trans
-- ----------------------------
INSERT INTO `stock_trans` VALUES (221, 0, 7, 1, 15, 206, 10, 55, 10, 24, 24, 42, '2020-09-22 10:05:26', '2020-09-22 10:06:22', '2020-09-22 10:06:39', b'1', '2020-09-22 10:06:40', NULL);
INSERT INTO `stock_trans` VALUES (222, 0, 7, 1, 24, 207, 11, 58, 11, 24, 24, 42, '2020-09-22 10:08:53', '2020-09-22 10:09:19', '2020-09-22 10:09:34', b'1', '2020-09-22 10:09:35', NULL);
INSERT INTO `stock_trans` VALUES (223, 0, 7, 1, 15, 208, 11, 55, 10, 24, 24, 42, '2020-09-22 10:10:46', '2020-09-22 10:11:03', '2020-09-22 10:11:28', b'1', '2020-09-22 10:11:29', NULL);
INSERT INTO `stock_trans` VALUES (224, 0, 7, 1, 24, 209, 10, 58, 11, 24, 24, 42, '2020-09-22 10:14:37', '2020-09-22 10:14:53', '2020-09-22 10:15:24', b'1', '2020-09-22 10:15:25', NULL);
INSERT INTO `stock_trans` VALUES (225, 0, 7, 1, 15, 210, 10, 55, 10, 24, 24, 42, '2020-09-22 10:15:32', '2020-09-22 10:16:03', '2020-09-22 10:16:18', b'1', '2020-09-22 10:16:19', NULL);
INSERT INTO `stock_trans` VALUES (226, 0, 7, 1, 24, 211, 10, 58, 11, 24, 24, 42, '2020-09-22 10:16:27', '2020-09-22 10:16:43', '2020-09-22 10:17:12', b'1', '2020-09-22 10:17:14', NULL);
INSERT INTO `stock_trans` VALUES (227, 0, 7, 1, 15, 212, 10, 55, 10, 24, 24, 42, '2020-09-22 10:42:40', '2020-09-22 10:43:09', '2020-09-22 10:43:24', b'1', '2020-09-22 10:43:25', NULL);
INSERT INTO `stock_trans` VALUES (228, 0, 7, 1, 24, 213, 11, 58, 11, 24, 24, 42, '2020-09-22 10:43:31', '2020-09-22 10:43:55', '2020-09-22 10:44:10', b'1', '2020-09-22 10:44:11', NULL);
INSERT INTO `stock_trans` VALUES (229, 0, 7, 1, 24, 214, 10, 58, 11, 24, 24, 42, '2020-09-22 10:47:41', '2020-09-22 10:48:10', '2020-09-22 10:48:37', b'1', '2020-09-22 10:48:38', NULL);
INSERT INTO `stock_trans` VALUES (230, 0, 7, 1, 15, 215, 10, 55, 10, 24, 24, 42, '2020-09-22 10:48:43', '2020-09-22 10:49:12', '2020-09-22 10:49:27', b'1', '2020-09-22 10:49:28', NULL);
INSERT INTO `stock_trans` VALUES (231, 0, 7, 1, 24, 216, 11, 58, 11, 24, 24, 42, '2020-09-22 10:52:38', '2020-09-22 10:53:06', '2020-09-22 10:53:23', b'1', '2020-09-22 10:53:24', NULL);
INSERT INTO `stock_trans` VALUES (232, 0, 7, 1, 15, 217, 10, 55, 10, 24, 24, 42, '2020-09-22 10:57:38', '2020-09-22 10:58:08', '2020-09-22 10:58:25', b'1', '2020-09-22 10:58:26', NULL);
INSERT INTO `stock_trans` VALUES (233, 0, 7, 1, 24, 218, 10, 58, 11, 24, 24, 42, '2020-09-22 10:58:33', '2020-09-22 10:58:53', '2020-09-22 10:59:30', b'1', '2020-09-22 10:59:31', NULL);
INSERT INTO `stock_trans` VALUES (234, 0, 7, 1, 15, 219, 11, 55, 10, 24, 24, 42, '2020-09-22 11:02:58', '2020-09-22 11:03:18', '2020-09-22 11:03:41', b'1', '2020-09-22 11:03:42', NULL);
INSERT INTO `stock_trans` VALUES (235, 0, 7, 1, 24, 220, 11, 58, 11, 24, 24, 42, '2020-09-22 11:03:48', '2020-09-22 11:04:17', '2020-09-22 11:04:32', b'1', '2020-09-22 11:04:33', NULL);

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
  `recent_goodid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '最近上砖/下砖规格',
  `recent_tileid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '最近上/下砖机ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of track
-- ----------------------------
INSERT INTO `track` VALUES (1, '3_A1_轨道', 3, 1, 0, 1, 0, 0, 0, 0, 101, 100, 0, 0, 0, NULL, 101, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (2, '3_A2_轨道', 3, 1, 0, 1, 0, 0, 0, 0, 102, 100, 0, 0, 0, NULL, 102, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (3, '3_A3_轨道', 3, 1, 0, 1, 0, 0, 0, 0, 103, 100, 0, 0, 0, NULL, 103, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (4, '3_A4_轨道', 3, 1, 0, 1, 0, 0, 0, 0, 104, 100, 0, 0, 0, NULL, 104, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (5, '5_A1_轨道', 5, 1, 0, 1, 0, 0, 0, 0, 105, 100, 0, 0, 0, NULL, 105, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (6, '5_A2_轨道', 5, 1, 0, 1, 0, 0, 0, 0, 106, 100, 0, 0, 0, NULL, 106, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (7, '5_A3_轨道', 5, 1, 0, 1, 0, 0, 0, 0, 107, 100, 0, 0, 0, NULL, 107, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (8, '4_A1_轨道', 4, 1, 0, 1, 0, 0, 0, 0, 108, 100, 0, 0, 0, NULL, 108, 118, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (9, '4_A2_轨道', 4, 1, 0, 1, 0, 0, 0, 0, 109, 100, 0, 0, 0, NULL, 109, 119, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (10, '1_A1_轨道', 1, 1, 1, 1, 0, 0, 0, 0, 110, 100, 0, 0, 0, NULL, 110, 120, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (11, '1_A2_轨道', 1, 1, 0, 1, 0, 0, 0, 0, 111, 100, 0, 0, 0, NULL, 111, 121, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (12, '2_A1_轨道', 2, 1, 0, 1, 0, 0, 0, 0, 112, 100, 0, 0, 0, NULL, 112, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (13, '2_A2_轨道', 2, 1, 0, 1, 0, 0, 0, 0, 113, 100, 0, 0, 0, NULL, 113, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (14, '2_A3_轨道', 2, 1, 0, 1, 0, 0, 0, 0, 114, 100, 0, 0, 0, NULL, 114, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (15, '3_D1_轨道', 3, 0, 0, 1, 0, 0, 0, 601, 0, 100, 0, 0, 0, NULL, 601, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (16, '3_D2_轨道', 3, 0, 0, 1, 0, 0, 0, 602, 0, 100, 0, 0, 0, NULL, 602, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (17, '3_D3_轨道', 3, 0, 0, 1, 0, 0, 0, 603, 0, 100, 0, 0, 0, NULL, 603, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (18, '3_D4_轨道', 3, 0, 0, 1, 0, 0, 0, 604, 0, 100, 0, 0, 0, NULL, 604, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (19, '5_D1_轨道', 5, 0, 0, 1, 0, 0, 0, 605, 0, 100, 0, 0, 0, NULL, 605, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (20, '5_D2_轨道', 5, 0, 0, 1, 0, 0, 0, 606, 0, 100, 0, 0, 0, NULL, 606, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (21, '4_D1_轨道', 4, 0, 0, 1, 0, 0, 0, 607, 0, 100, 0, 0, 0, NULL, 607, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (22, '4_D2_轨道', 4, 0, 0, 1, 0, 0, 0, 608, 0, 100, 0, 0, 0, NULL, 608, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (23, '1_D1_轨道', 1, 0, 0, 1, 0, 0, 0, 609, 0, 100, 0, 0, 0, NULL, 609, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (24, '1_D2_轨道', 1, 0, 0, 1, 0, 0, 0, 610, 0, 100, 0, 0, 0, NULL, 610, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (25, '2_D1_轨道', 2, 0, 0, 1, 0, 0, 0, 611, 0, 100, 0, 0, 0, NULL, 611, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (26, '2_D2_轨道', 2, 0, 0, 1, 0, 0, 0, 612, 0, 100, 0, 0, 0, NULL, 612, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (27, '2_D3_轨道', 2, 0, 0, 1, 0, 0, 0, 613, 0, 100, 0, 0, 0, NULL, 613, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (28, '2_D4_轨道', 2, 0, 0, 1, 0, 0, 0, 614, 0, 100, 0, 0, 0, NULL, 614, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (29, '3_01_入', 3, 2, 0, 1, 700, 450, 250, 201, 0, 100, 69, 0, 30, NULL, 201, 301, NULL, NULL, NULL, NULL, 0, 0, 0);
INSERT INTO `track` VALUES (30, '3_02_入', 3, 2, 0, 1, 700, 250, 250, 202, 0, 100, 70, 29, 31, NULL, 202, 302, NULL, NULL, NULL, NULL, 0, 0, 0);
INSERT INTO `track` VALUES (31, '3_03_入', 3, 2, 0, 1, 700, 250, 250, 203, 0, 100, 71, 30, 32, NULL, 203, 303, NULL, NULL, NULL, NULL, 0, 0, 0);
INSERT INTO `track` VALUES (32, '3_04_入', 3, 2, 0, 1, 700, 250, 250, 204, 0, 100, 72, 31, 33, NULL, 204, 304, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (33, '3_05_入', 3, 2, 0, 1, 700, 250, 250, 205, 0, 100, 73, 32, 34, NULL, 205, 305, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (34, '3_06_入', 3, 2, 0, 1, 700, 250, 250, 206, 0, 100, 74, 33, 35, NULL, 206, 306, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (35, '3_07_入', 3, 2, 0, 1, 700, 250, 250, 207, 0, 100, 75, 34, 36, NULL, 207, 307, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (36, '3_08_入', 3, 2, 0, 1, 700, 250, 250, 208, 0, 100, 76, 35, 37, NULL, 208, 308, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (37, '3_09_入', 3, 2, 0, 1, 700, 250, 250, 209, 0, 100, 77, 36, 38, NULL, 209, 309, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (38, '3_10_入', 3, 2, 0, 1, 700, 250, 250, 210, 0, 100, 78, 37, 39, NULL, 210, 310, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (39, '3_11_入', 3, 2, 0, 1, 700, 250, 250, 211, 0, 100, 79, 38, 40, NULL, 211, 311, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (40, '3_12_入', 3, 2, 0, 1, 700, 250, 700, 212, 0, 100, 80, 39, 0, NULL, 212, 312, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (41, '5_01_入', 5, 2, 0, 1, 700, 400, 700, 213, 0, 100, 81, 0, 42, NULL, 213, 313, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (42, '5_02_入', 5, 2, 0, 1, 700, 700, 700, 214, 0, 100, 82, 41, 43, NULL, 214, 314, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (43, '5_03_入', 5, 2, 0, 1, 700, 700, 700, 215, 0, 100, 83, 42, 44, NULL, 215, 315, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (44, '5_04_入', 5, 2, 0, 1, 700, 700, 600, 216, 0, 100, 84, 43, 45, NULL, 216, 316, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (45, '4_01_入', 4, 2, 0, 1, 700, 600, 400, 217, 0, 100, 85, 44, 46, NULL, 217, 317, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (46, '4_02_入', 4, 2, 0, 1, 700, 400, 400, 218, 0, 100, 86, 45, 47, NULL, 218, 318, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (47, '4_03_入', 4, 2, 0, 1, 700, 400, 400, 219, 0, 100, 87, 46, 48, NULL, 219, 319, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (48, '4_04_入', 4, 2, 0, 1, 700, 400, 400, 220, 0, 100, 88, 47, 49, NULL, 220, 320, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (49, '4_05_入', 4, 2, 0, 1, 700, 400, 400, 221, 0, 100, 89, 48, 50, NULL, 221, 321, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (50, '4_06_入', 4, 2, 0, 1, 700, 400, 400, 222, 0, 100, 90, 49, 51, NULL, 222, 322, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (51, '4_07_入', 4, 2, 0, 0, 700, 400, 800, 223, 0, 100, 91, 50, 52, NULL, 223, 323, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (52, '1_01_入', 1, 2, 0, 1, 900, 800, 500, 224, 0, 100, 92, 51, 53, NULL, 224, 324, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (53, '1_02_入', 1, 2, 0, 1, 900, 500, 500, 225, 0, 100, 93, 52, 54, NULL, 225, 325, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (54, '1_03_入', 1, 2, 0, 1, 900, 500, 500, 226, 0, 100, 94, 53, 55, NULL, 226, 326, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (55, '1_04_入', 1, 2, 1, 1, 900, 500, 500, 227, 0, 100, 95, 54, 56, NULL, 227, 327, NULL, NULL, NULL, NULL, 0, 15, 10);
INSERT INTO `track` VALUES (56, '1_05_入', 1, 2, 2, 1, 900, 500, 500, 228, 0, 100, 96, 55, 57, NULL, 228, 328, NULL, NULL, NULL, NULL, 0, 15, 0);
INSERT INTO `track` VALUES (57, '1_06_入', 1, 2, 0, 1, 900, 500, 500, 229, 0, 100, 97, 56, 58, NULL, 229, 329, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (58, '1_07_入', 1, 2, 1, 1, 900, 500, 500, 230, 0, 100, 98, 57, 0, NULL, 230, 330, NULL, NULL, NULL, NULL, 0, 24, 11);
INSERT INTO `track` VALUES (59, '2_01_入', 2, 2, 0, 1, 700, 450, 250, 231, 0, 100, 99, 0, 60, NULL, 231, 331, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (60, '2_02_入', 2, 2, 0, 1, 700, 250, 250, 232, 0, 100, 100, 59, 61, NULL, 232, 332, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (61, '2_03_入', 2, 2, 0, 1, 700, 250, 250, 233, 0, 100, 101, 60, 62, NULL, 233, 333, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (62, '2_04_入', 2, 2, 0, 1, 700, 250, 250, 234, 0, 100, 102, 61, 63, NULL, 234, 334, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (63, '2_05_入', 2, 2, 0, 1, 700, 250, 250, 235, 0, 100, 103, 62, 64, NULL, 235, 335, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (64, '2_06_入', 2, 2, 0, 1, 700, 250, 250, 236, 0, 100, 104, 63, 65, NULL, 236, 336, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (65, '2_07_入', 2, 2, 0, 1, 700, 250, 250, 237, 0, 100, 105, 64, 66, NULL, 237, 337, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (66, '2_08_入', 2, 2, 0, 1, 700, 250, 250, 238, 0, 100, 106, 65, 67, NULL, 238, 338, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (67, '2_09_入', 2, 2, 0, 1, 700, 250, 250, 239, 0, 100, 107, 66, 68, NULL, 239, 339, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (68, '2_10_入', 2, 2, 0, 1, 700, 250, 250, 240, 0, 100, 108, 67, 0, NULL, 240, 340, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (69, '3_01_出', 3, 3, 0, 1, 700, 450, 250, 0, 501, 100, 29, 0, 70, NULL, 501, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (70, '3_02_出', 3, 3, 0, 1, 700, 250, 250, 0, 502, 100, 30, 69, 71, NULL, 502, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (71, '3_03_出', 3, 3, 0, 1, 700, 250, 250, 0, 503, 100, 31, 70, 72, NULL, 503, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (72, '3_04_出', 3, 3, 0, 1, 700, 250, 250, 0, 504, 100, 32, 71, 73, NULL, 504, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (73, '3_05_出', 3, 3, 0, 1, 700, 250, 250, 0, 505, 100, 33, 72, 74, NULL, 505, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (74, '3_06_出', 3, 3, 0, 1, 700, 250, 250, 0, 506, 100, 34, 73, 75, NULL, 506, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (75, '3_07_出', 3, 3, 0, 1, 700, 250, 250, 0, 507, 100, 35, 74, 76, NULL, 507, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (76, '3_08_出', 3, 3, 0, 1, 700, 250, 250, 0, 508, 100, 36, 75, 77, NULL, 508, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (77, '3_09_出', 3, 3, 0, 1, 700, 250, 250, 0, 509, 100, 37, 76, 78, NULL, 509, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (78, '3_10_出', 3, 3, 0, 1, 700, 250, 250, 0, 510, 100, 38, 77, 79, NULL, 510, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (79, '3_11_出', 3, 3, 0, 1, 700, 250, 250, 0, 511, 100, 39, 78, 80, NULL, 511, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (80, '3_12_出', 3, 3, 0, 1, 700, 250, 700, 0, 512, 100, 40, 79, 0, NULL, 512, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (81, '5_01_出', 5, 3, 0, 1, 700, 400, 700, 0, 513, 100, 41, 0, 82, NULL, 513, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (82, '5_02_出', 5, 3, 0, 1, 700, 700, 700, 0, 514, 100, 42, 81, 83, NULL, 514, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (83, '5_03_出', 5, 3, 0, 1, 700, 700, 700, 0, 515, 100, 43, 82, 84, NULL, 515, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (84, '5_04_出', 5, 3, 0, 1, 700, 700, 600, 0, 516, 100, 44, 83, 85, NULL, 516, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (85, '4_01_出', 4, 3, 0, 1, 700, 600, 400, 0, 517, 100, 45, 84, 86, NULL, 517, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (86, '4_02_出', 4, 3, 0, 1, 700, 400, 400, 0, 518, 100, 46, 85, 87, NULL, 518, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (87, '4_03_出', 4, 3, 0, 1, 700, 400, 400, 0, 519, 100, 47, 86, 88, NULL, 519, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (88, '4_04_出', 4, 3, 0, 1, 700, 400, 400, 0, 520, 100, 48, 87, 89, NULL, 520, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (89, '4_05_出', 4, 3, 0, 1, 700, 400, 400, 0, 521, 100, 49, 88, 90, NULL, 521, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (90, '4_06_出', 4, 3, 0, 1, 700, 400, 400, 0, 522, 100, 50, 89, 91, NULL, 522, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (91, '4_07_出', 4, 3, 0, 1, 700, 400, 800, 0, 523, 100, 51, 90, 92, NULL, 523, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (92, '1_01_出', 1, 3, 0, 1, 900, 800, 500, 0, 524, 100, 52, 91, 93, NULL, 524, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (93, '1_02_出', 1, 3, 0, 1, 900, 500, 500, 0, 525, 100, 53, 92, 94, NULL, 525, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (94, '1_03_出', 1, 3, 0, 1, 900, 500, 500, 0, 526, 100, 54, 93, 95, NULL, 526, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (95, '1_04_出', 1, 3, 2, 1, 900, 500, 500, 0, 527, 100, 55, 94, 96, NULL, 527, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (96, '1_05_出', 1, 3, 2, 1, 900, 500, 500, 0, 528, 100, 56, 95, 97, NULL, 528, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (97, '1_06_出', 1, 3, 0, 1, 900, 500, 500, 0, 529, 100, 57, 96, 98, NULL, 529, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (98, '1_07_出', 1, 3, 0, 1, 900, 500, 500, 0, 530, 100, 58, 97, 0, NULL, 530, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (99, '2_01_出', 2, 3, 0, 1, 700, 450, 250, 0, 531, 100, 59, 0, 100, NULL, 531, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (100, '2_02_出', 2, 3, 0, 1, 700, 250, 250, 0, 532, 100, 60, 99, 101, NULL, 532, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (101, '2_03_出', 2, 3, 0, 1, 700, 250, 250, 0, 533, 100, 61, 100, 102, NULL, 533, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (102, '2_04_出', 2, 3, 0, 1, 700, 250, 250, 0, 534, 100, 62, 101, 103, NULL, 534, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (103, '2_05_出', 2, 3, 0, 1, 700, 250, 250, 0, 535, 100, 63, 102, 104, NULL, 535, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (104, '2_06_出', 2, 3, 0, 1, 700, 250, 250, 0, 536, 100, 64, 103, 105, NULL, 536, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (105, '2_07_出', 2, 3, 0, 1, 700, 250, 250, 0, 537, 100, 65, 104, 106, NULL, 537, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (106, '2_08_出', 2, 3, 0, 1, 700, 250, 250, 0, 538, 100, 66, 105, 107, NULL, 538, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (107, '2_09_出', 2, 3, 0, 1, 700, 250, 250, 0, 539, 100, 67, 106, 108, NULL, 539, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (108, '2_10_出', 2, 3, 0, 1, 700, 250, 250, 0, 540, 100, 68, 107, 0, NULL, 540, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (109, '3_01_摆轨', 3, 5, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 701, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (110, '3_02_摆轨', 3, 6, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 741, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (111, '5_01_摆轨', 5, 5, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 702, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (112, '5_02_摆轨', 5, 6, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 742, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (113, '1_01_摆轨', 1, 5, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 703, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (114, '1_02_摆轨', 1, 6, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 743, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (115, '2_01_摆轨', 2, 5, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 704, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);
INSERT INTO `track` VALUES (116, '2_02_摆轨', 2, 6, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 744, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL);

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
  `track_id` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '轨道ID',
  `trans_id` int(10) UNSIGNED NOT NULL,
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `createtime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '报警时间',
  `resolvetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '解决时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warning
-- ----------------------------
INSERT INTO `warning` VALUES (99, 0, 0, b'1', 2, 0, 0, '3_A2: 设备离线', '2020-09-20 17:24:48', '2020-09-20 17:24:48');
INSERT INTO `warning` VALUES (100, 0, 0, b'1', 25, 0, 0, '2_B1: 设备离线', '2020-09-20 17:24:48', '2020-09-20 17:24:48');
INSERT INTO `warning` VALUES (101, 0, 0, b'1', 1, 0, 0, '3_A1: 设备离线', '2020-09-20 17:24:48', '2020-09-20 17:24:48');
INSERT INTO `warning` VALUES (102, 0, 0, b'1', 22, 0, 0, '3_B1: 设备离线', '2020-09-20 17:24:48', '2020-09-20 17:24:48');
INSERT INTO `warning` VALUES (103, 0, 0, b'1', 32, 0, 0, '3_C3: 设备离线', '2020-09-20 17:24:48', '2020-09-20 17:24:48');
INSERT INTO `warning` VALUES (104, 0, 0, b'1', 2, 0, 0, '3_A2: 设备离线', '2020-09-20 17:31:29', '2020-09-20 17:31:29');
INSERT INTO `warning` VALUES (106, 0, 0, b'1', 32, 0, 0, '3_C3: 设备离线', '2020-09-20 17:31:29', '2020-09-20 17:31:29');
INSERT INTO `warning` VALUES (107, 0, 0, b'1', 1, 0, 0, '3_A1: 设备离线', '2020-09-20 17:31:29', '2020-09-20 17:31:29');
INSERT INTO `warning` VALUES (105, 0, 0, b'1', 22, 0, 0, '3_B1: 设备离线', '2020-09-20 17:31:29', '2020-09-20 17:31:29');
INSERT INTO `warning` VALUES (108, 0, 0, b'1', 25, 0, 0, '2_B1: 设备离线', '2020-09-20 17:31:29', '2020-09-20 17:31:29');
INSERT INTO `warning` VALUES (109, 0, 0, b'1', 25, 0, 0, '2_B1: 设备离线', '2020-09-20 23:06:50', '2020-09-20 23:06:50');
INSERT INTO `warning` VALUES (111, 0, 0, b'1', 2, 0, 0, '3_A2: 设备离线', '2020-09-20 23:07:08', '2020-09-20 23:07:08');
INSERT INTO `warning` VALUES (110, 0, 0, b'1', 22, 0, 0, '3_B1: 设备离线', '2020-09-20 23:07:20', '2020-09-20 23:07:20');
INSERT INTO `warning` VALUES (113, 0, 0, b'1', 1, 0, 0, '3_A1: 设备离线', '2020-09-20 23:06:57', '2020-09-20 23:06:57');
INSERT INTO `warning` VALUES (112, 0, 0, b'1', 32, 0, 0, '3_C3: 设备离线', '2020-09-20 23:07:28', '2020-09-20 23:07:28');
INSERT INTO `warning` VALUES (114, 0, 0, b'1', 6, 0, 0, '5_A2: 设备离线', '2020-09-20 23:46:07', '2020-09-20 23:46:07');
INSERT INTO `warning` VALUES (115, 0, 0, b'1', 7, 0, 0, '5_A3: 设备离线', '2020-09-20 23:46:08', '2020-09-20 23:46:08');
INSERT INTO `warning` VALUES (116, 0, 0, b'1', 10, 0, 0, '1_A1: 设备离线', '2020-09-20 23:46:12', '2020-09-20 23:46:12');
INSERT INTO `warning` VALUES (117, 0, 0, b'1', 11, 0, 0, '1_A2: 设备离线', '2020-09-20 23:46:14', '2020-09-20 23:46:14');
INSERT INTO `warning` VALUES (118, 0, 0, b'1', 12, 0, 0, '2_A1: 设备离线', '2020-09-20 23:46:18', '2020-09-20 23:46:18');
INSERT INTO `warning` VALUES (119, 0, 0, b'1', 13, 0, 0, '2_A2: 设备离线', '2020-09-20 23:46:20', '2020-09-20 23:46:20');
INSERT INTO `warning` VALUES (120, 0, 0, b'1', 14, 0, 0, '2_A3: 设备离线', '2020-09-20 23:46:21', '2020-09-20 23:46:21');
INSERT INTO `warning` VALUES (121, 0, 0, b'1', 15, 0, 0, '3_D1: 设备离线', '2020-09-20 23:46:23', '2020-09-20 23:46:23');
INSERT INTO `warning` VALUES (122, 0, 0, b'1', 16, 0, 0, '3_D2: 设备离线', '2020-09-20 23:46:24', '2020-09-20 23:46:24');
INSERT INTO `warning` VALUES (123, 0, 0, b'1', 16, 0, 0, '3_D2: 设备离线', '2020-09-20 23:46:28', '2020-09-20 23:46:28');
INSERT INTO `warning` VALUES (124, 0, 0, b'1', 15, 0, 0, '3_D1: 设备离线', '2020-09-20 23:46:30', '2020-09-20 23:46:30');
INSERT INTO `warning` VALUES (125, 0, 0, b'1', 16, 0, 0, '3_D2: 设备离线', '2020-09-20 23:59:35', '2020-09-20 23:59:35');
INSERT INTO `warning` VALUES (126, 0, 0, b'1', 15, 0, 0, '3_D1: 设备离线', '2020-09-20 23:59:33', '2020-09-20 23:59:33');
INSERT INTO `warning` VALUES (127, 0, 0, b'1', 22, 0, 0, '3_B1: 设备离线', '2020-09-20 23:57:11', '2020-09-20 23:57:11');
INSERT INTO `warning` VALUES (128, 0, 0, b'1', 24, 0, 0, '1_B1: 设备离线', '2020-09-20 23:57:13', '2020-09-20 23:57:13');
INSERT INTO `warning` VALUES (129, 0, 0, b'1', 28, 0, 0, '1_B2: 设备离线', '2020-09-20 23:57:15', '2020-09-20 23:57:15');
INSERT INTO `warning` VALUES (130, 0, 0, b'1', 25, 0, 0, '2_B1: 设备离线', '2020-09-20 23:57:18', '2020-09-20 23:57:18');
INSERT INTO `warning` VALUES (131, 0, 0, b'1', 30, 0, 0, '3_C1: 设备离线', '2020-09-20 23:57:25', '2020-09-20 23:57:25');
INSERT INTO `warning` VALUES (132, 0, 0, b'1', 31, 0, 0, '3_C2: 设备离线', '2020-09-20 23:57:30', '2020-09-20 23:57:30');
INSERT INTO `warning` VALUES (133, 0, 0, b'1', 38, 0, 0, '5_C1: 设备离线', '2020-09-20 23:57:36', '2020-09-20 23:57:36');
INSERT INTO `warning` VALUES (134, 0, 0, b'1', 39, 0, 0, '5_C2: 设备离线', '2020-09-20 23:57:38', '2020-09-20 23:57:38');
INSERT INTO `warning` VALUES (135, 0, 0, b'1', 41, 0, 0, '1_C1: 设备离线', '2020-09-20 23:57:41', '2020-09-20 23:57:41');
INSERT INTO `warning` VALUES (136, 0, 0, b'1', 42, 0, 0, '1_C2: 设备离线', '2020-09-20 23:57:43', '2020-09-20 23:57:43');
INSERT INTO `warning` VALUES (137, 0, 0, b'1', 45, 0, 0, '2_C1: 设备离线', '2020-09-20 23:57:46', '2020-09-20 23:57:46');
INSERT INTO `warning` VALUES (138, 0, 0, b'1', 46, 0, 0, '2_C2: 设备离线', '2020-09-20 23:57:48', '2020-09-20 23:57:48');
INSERT INTO `warning` VALUES (139, 0, 0, b'1', 32, 0, 0, '3_C3: 设备离线', '2020-09-21 00:01:24', '2020-09-21 00:01:24');
INSERT INTO `warning` VALUES (140, 0, 0, b'1', 23, 0, 0, '5_B1: 设备离线', '2020-09-21 00:07:30', '2020-09-21 00:07:30');
INSERT INTO `warning` VALUES (141, 0, 0, b'1', 26, 0, 0, '3_B2: 设备离线', '2020-09-21 00:30:50', '2020-09-21 00:30:50');
INSERT INTO `warning` VALUES (142, 0, 0, b'1', 27, 0, 0, '5_B2: 设备离线', '2020-09-21 00:30:51', '2020-09-21 00:30:51');
INSERT INTO `warning` VALUES (143, 0, 0, b'1', 29, 0, 0, '2_B2: 设备离线', '2020-09-21 00:30:53', '2020-09-21 00:30:53');
INSERT INTO `warning` VALUES (144, 0, 0, b'1', 37, 0, 0, '3_C8: 设备离线', '2020-09-21 00:30:59', '2020-09-21 00:30:59');
INSERT INTO `warning` VALUES (145, 0, 0, b'1', 36, 0, 0, '3_C7: 设备离线', '2020-09-21 00:31:01', '2020-09-21 00:31:01');
INSERT INTO `warning` VALUES (146, 0, 0, b'1', 44, 0, 0, '1_C4: 设备离线', '2020-09-21 00:31:04', '2020-09-21 00:31:04');
INSERT INTO `warning` VALUES (147, 0, 0, b'1', 50, 0, 0, '2_C6: 设备离线', '2020-09-21 00:31:08', '2020-09-21 00:31:08');
INSERT INTO `warning` VALUES (148, 0, 0, b'1', 49, 0, 0, '2_C5: 设备离线', '2020-09-21 00:31:10', '2020-09-21 00:31:10');
INSERT INTO `warning` VALUES (149, 0, 0, b'1', 40, 0, 0, '5_C3: 设备离线', '2020-09-21 01:21:53', '2020-09-21 01:21:53');
INSERT INTO `warning` VALUES (150, 0, 0, b'1', 8, 0, 0, '4_A1: 设备离线', '2020-09-21 01:26:25', '2020-09-21 01:26:25');
INSERT INTO `warning` VALUES (151, 0, 0, b'1', 9, 0, 0, '4_A2: 设备离线', '2020-09-21 01:26:27', '2020-09-21 01:26:27');
INSERT INTO `warning` VALUES (152, 0, 0, b'1', 15, 0, 0, '3_D1: 设备离线', '2020-09-21 01:26:40', '2020-09-21 01:26:40');
INSERT INTO `warning` VALUES (153, 0, 0, b'1', 16, 0, 0, '3_D2: 设备离线', '2020-09-21 01:26:42', '2020-09-21 01:26:42');
INSERT INTO `warning` VALUES (154, 0, 0, b'1', 17, 0, 0, '5_D1: 设备离线', '2020-09-21 01:29:47', '2020-09-21 01:29:47');
INSERT INTO `warning` VALUES (155, 0, 0, b'1', 24, 0, 0, '1_B1: 设备离线', '2020-09-22 01:38:02', '2020-09-22 01:38:02');
INSERT INTO `warning` VALUES (156, 0, 0, b'1', 28, 0, 0, '1_B2: 设备离线', '2020-09-22 01:38:04', '2020-09-22 01:38:04');
INSERT INTO `warning` VALUES (157, 0, 0, b'1', 41, 0, 0, '1_C1: 设备离线', '2020-09-22 01:38:08', '2020-09-22 01:38:08');
INSERT INTO `warning` VALUES (158, 0, 0, b'1', 42, 0, 0, '1_C2: 设备离线', '2020-09-22 01:38:10', '2020-09-22 01:38:10');
INSERT INTO `warning` VALUES (159, 0, 0, b'1', 43, 0, 0, '1_C3: 设备离线', '2020-09-22 01:38:12', '2020-09-22 01:38:12');
INSERT INTO `warning` VALUES (160, 0, 0, b'1', 44, 0, 0, '1_C4: 设备离线', '2020-09-22 01:38:15', '2020-09-22 01:38:14');
INSERT INTO `warning` VALUES (161, 0, 0, b'1', 2, 0, 0, '3_A2: 设备离线', '2020-09-22 01:58:07', '2020-09-22 01:58:07');
INSERT INTO `warning` VALUES (162, 0, 0, b'1', 3, 0, 0, '3_A3: 设备离线', '2020-09-22 01:58:10', '2020-09-22 01:58:10');
INSERT INTO `warning` VALUES (163, 0, 0, b'1', 4, 0, 0, '3_A4: 设备离线', '2020-09-22 01:58:13', '2020-09-22 01:58:13');
INSERT INTO `warning` VALUES (164, 0, 0, b'1', 15, 0, 0, '3_D1: 设备离线', '2020-09-22 01:58:14', '2020-09-22 01:58:14');
INSERT INTO `warning` VALUES (165, 0, 0, b'1', 16, 0, 0, '3_D2: 设备离线', '2020-09-22 01:58:16', '2020-09-22 01:58:16');
INSERT INTO `warning` VALUES (166, 0, 0, b'1', 22, 0, 0, '3_B1: 设备离线', '2020-09-22 01:58:23', '2020-09-22 01:58:23');
INSERT INTO `warning` VALUES (167, 0, 0, b'1', 26, 0, 0, '3_B2: 设备离线', '2020-09-22 01:58:25', '2020-09-22 01:58:25');
INSERT INTO `warning` VALUES (168, 0, 0, b'1', 30, 0, 0, '3_C1: 设备离线', '2020-09-22 01:58:29', '2020-09-22 01:58:29');
INSERT INTO `warning` VALUES (169, 0, 0, b'1', 35, 0, 0, '3_C6: 设备离线', '2020-09-22 01:58:31', '2020-09-22 01:58:31');
INSERT INTO `warning` VALUES (170, 0, 0, b'1', 16, 0, 0, '3_D2: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (172, 0, 0, b'1', 15, 0, 0, '3_D1: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (173, 0, 0, b'1', 4, 0, 0, '3_A4: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (174, 0, 0, b'1', 10, 0, 0, '1_A1: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (175, 0, 0, b'1', 3, 0, 0, '3_A3: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (176, 0, 0, b'1', 1, 0, 0, '3_A1: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (177, 0, 0, b'1', 2, 0, 0, '3_A2: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (178, 0, 0, b'1', 44, 0, 0, '1_C4: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (179, 0, 0, b'1', 43, 0, 0, '1_C3: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (180, 0, 0, b'1', 42, 0, 0, '1_C2: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (181, 0, 0, b'1', 41, 0, 0, '1_C1: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (182, 0, 0, b'1', 35, 0, 0, '3_C6: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (171, 0, 0, b'1', 28, 0, 0, '1_B2: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (184, 0, 0, b'1', 24, 0, 0, '1_B1: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (183, 0, 0, b'1', 30, 0, 0, '3_C1: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (185, 0, 0, b'1', 26, 0, 0, '3_B2: 设备离线', '2020-09-22 09:18:19', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (186, 0, 0, b'1', 22, 0, 0, '3_B1: 设备离线', '2020-09-22 09:18:20', '2020-09-22 09:18:19');
INSERT INTO `warning` VALUES (187, 0, 0, b'1', 11, 0, 0, '1_A2: 设备离线', '2020-09-22 09:39:18', '2020-09-22 09:39:18');
INSERT INTO `warning` VALUES (188, 0, 0, b'0', 1, 0, 0, '3_A1: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (189, 0, 0, b'0', 2, 0, 0, '3_A2: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (190, 0, 0, b'0', 3, 0, 0, '3_A3: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (191, 0, 0, b'0', 4, 0, 0, '3_A4: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (192, 0, 0, b'0', 11, 0, 0, '1_A1: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (193, 0, 0, b'0', 10, 0, 0, '1_A2: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (194, 0, 0, b'0', 15, 0, 0, '3_D1: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (195, 0, 0, b'0', 22, 0, 0, '3_B1: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (198, 0, 0, b'0', 24, 0, 0, '1_B1: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (197, 0, 0, b'0', 35, 0, 0, '3_C6: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (196, 0, 0, b'0', 16, 0, 0, '3_D2: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (199, 0, 0, b'0', 28, 0, 0, '1_B2: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (200, 0, 0, b'0', 41, 0, 0, '1_C1: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (202, 0, 0, b'0', 43, 0, 0, '1_C3: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (201, 0, 0, b'0', 26, 0, 0, '3_B2: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (203, 0, 0, b'0', 30, 0, 0, '3_C1: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (204, 0, 0, b'0', 42, 0, 0, '1_C2: 设备离线', '2020-09-22 11:10:34', NULL);
INSERT INTO `warning` VALUES (205, 0, 0, b'0', 44, 0, 0, '1_C4: 设备离线', '2020-09-22 11:10:34', NULL);

-- ----------------------------
-- View structure for active_dev
-- ----------------------------
DROP VIEW IF EXISTS `active_dev`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `active_dev` AS select `t`.`id` AS `id`,`t`.`name` AS `name`,`t`.`ip` AS `ip`,`t`.`port` AS `port`,`t`.`type` AS `type`,`t`.`type2` AS `type2`,`t`.`enable` AS `enable`,`t`.`att1` AS `att1`,`t`.`att2` AS `att2`,`t`.`goods_id` AS `goods_id`,`t`.`left_track_id` AS `left_track_id`,`t`.`right_track_id` AS `right_track_id`,`t`.`brother_dev_id` AS `brother_dev_id`,`t`.`strategy_in` AS `strategy_in`,`t`.`strategy_out` AS `strategy_out`,`t`.`memo` AS `memo` from `device` `t` where (`t`.`enable` = 1);

-- ----------------------------
-- View structure for stock_sum
-- ----------------------------
DROP VIEW IF EXISTS `stock_sum`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `stock_sum` AS select `t`.`goods_id` AS `goods_id`,`t`.`track_id` AS `track_id`,min(`t`.`produce_time`) AS `produce_time`,count(`t`.`id`) AS `count`,sum(`t`.`pieces`) AS `pieces`,sum(`t`.`stack`) AS `stack` from `stock` `t` group by `t`.`track_id`,`t`.`goods_id`;

SET FOREIGN_KEY_CHECKS = 1;
