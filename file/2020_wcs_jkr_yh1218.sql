/*
 Navicat Premium Data Transfer

 Source Server         : TEST
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : 2020_wcs_jkr_yh

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 18/12/2020 09:42:30
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
  `c_sorttask` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '倒库任务数量',
  `carriertype` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '运输车类型',
  `full_qty` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '轨道未达到满砖警告数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '区域' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES (1, '1#', b'1', b'1', '1号线', 2, 0, 10);

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '区域内设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area_device
-- ----------------------------
INSERT INTO `area_device` VALUES (1, 1, 1, 1, NULL);
INSERT INTO `area_device` VALUES (2, 1, 2, 1, NULL);
INSERT INTO `area_device` VALUES (3, 1, 3, 1, NULL);
INSERT INTO `area_device` VALUES (4, 1, 4, 1, NULL);
INSERT INTO `area_device` VALUES (5, 1, 5, 1, NULL);
INSERT INTO `area_device` VALUES (6, 1, 6, 1, NULL);
INSERT INTO `area_device` VALUES (7, 1, 7, 0, NULL);
INSERT INTO `area_device` VALUES (8, 1, 8, 0, NULL);
INSERT INTO `area_device` VALUES (9, 1, 9, 3, NULL);
INSERT INTO `area_device` VALUES (10, 1, 10, 3, NULL);
INSERT INTO `area_device` VALUES (11, 1, 11, 2, NULL);
INSERT INTO `area_device` VALUES (12, 1, 12, 2, NULL);
INSERT INTO `area_device` VALUES (13, 1, 13, 4, NULL);
INSERT INTO `area_device` VALUES (14, 1, 14, 4, NULL);
INSERT INTO `area_device` VALUES (15, 1, 15, 4, NULL);
INSERT INTO `area_device` VALUES (16, 1, 16, 4, NULL);
INSERT INTO `area_device` VALUES (17, 1, 17, 4, NULL);
INSERT INTO `area_device` VALUES (18, 1, 18, 4, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 780 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '区域内设备作业的轨道' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area_device_track
-- ----------------------------
INSERT INTO `area_device_track` VALUES (379, 1, 9, 17, 1);
INSERT INTO `area_device_track` VALUES (380, 1, 9, 18, 2);
INSERT INTO `area_device_track` VALUES (381, 1, 9, 19, 3);
INSERT INTO `area_device_track` VALUES (382, 1, 9, 20, 4);
INSERT INTO `area_device_track` VALUES (383, 1, 9, 21, 5);
INSERT INTO `area_device_track` VALUES (384, 1, 9, 22, 6);
INSERT INTO `area_device_track` VALUES (385, 1, 9, 23, 7);
INSERT INTO `area_device_track` VALUES (386, 1, 9, 24, 8);
INSERT INTO `area_device_track` VALUES (387, 1, 9, 25, 9);
INSERT INTO `area_device_track` VALUES (388, 1, 9, 26, 10);
INSERT INTO `area_device_track` VALUES (389, 1, 9, 27, 11);
INSERT INTO `area_device_track` VALUES (390, 1, 9, 28, 12);
INSERT INTO `area_device_track` VALUES (391, 1, 9, 29, 13);
INSERT INTO `area_device_track` VALUES (392, 1, 9, 30, 14);
INSERT INTO `area_device_track` VALUES (393, 1, 9, 31, 15);
INSERT INTO `area_device_track` VALUES (394, 1, 9, 32, 16);
INSERT INTO `area_device_track` VALUES (395, 1, 9, 33, 17);
INSERT INTO `area_device_track` VALUES (396, 1, 9, 34, 18);
INSERT INTO `area_device_track` VALUES (397, 1, 9, 35, 19);
INSERT INTO `area_device_track` VALUES (398, 1, 9, 36, 20);
INSERT INTO `area_device_track` VALUES (399, 1, 9, 37, 21);
INSERT INTO `area_device_track` VALUES (400, 1, 9, 38, 22);
INSERT INTO `area_device_track` VALUES (401, 1, 9, 39, 23);
INSERT INTO `area_device_track` VALUES (402, 1, 9, 40, 24);
INSERT INTO `area_device_track` VALUES (403, 1, 9, 41, 25);
INSERT INTO `area_device_track` VALUES (404, 1, 9, 42, 26);
INSERT INTO `area_device_track` VALUES (405, 1, 9, 43, 27);
INSERT INTO `area_device_track` VALUES (409, 1, 9, 1, 31);
INSERT INTO `area_device_track` VALUES (410, 1, 9, 2, 32);
INSERT INTO `area_device_track` VALUES (411, 1, 9, 3, 33);
INSERT INTO `area_device_track` VALUES (412, 1, 9, 4, 34);
INSERT INTO `area_device_track` VALUES (413, 1, 9, 5, 35);
INSERT INTO `area_device_track` VALUES (414, 1, 9, 6, 36);
INSERT INTO `area_device_track` VALUES (415, 1, 9, 7, 37);
INSERT INTO `area_device_track` VALUES (416, 1, 9, 8, 38);
INSERT INTO `area_device_track` VALUES (417, 1, 9, 9, 39);
INSERT INTO `area_device_track` VALUES (418, 1, 9, 10, 40);
INSERT INTO `area_device_track` VALUES (419, 1, 9, 11, 41);
INSERT INTO `area_device_track` VALUES (423, 1, 10, 19, 3);
INSERT INTO `area_device_track` VALUES (424, 1, 10, 20, 4);
INSERT INTO `area_device_track` VALUES (425, 1, 10, 21, 5);
INSERT INTO `area_device_track` VALUES (426, 1, 10, 22, 6);
INSERT INTO `area_device_track` VALUES (427, 1, 10, 23, 7);
INSERT INTO `area_device_track` VALUES (428, 1, 10, 24, 8);
INSERT INTO `area_device_track` VALUES (429, 1, 10, 25, 9);
INSERT INTO `area_device_track` VALUES (430, 1, 10, 26, 10);
INSERT INTO `area_device_track` VALUES (431, 1, 10, 27, 11);
INSERT INTO `area_device_track` VALUES (432, 1, 10, 28, 12);
INSERT INTO `area_device_track` VALUES (433, 1, 10, 29, 13);
INSERT INTO `area_device_track` VALUES (434, 1, 10, 30, 14);
INSERT INTO `area_device_track` VALUES (435, 1, 10, 31, 15);
INSERT INTO `area_device_track` VALUES (436, 1, 10, 32, 16);
INSERT INTO `area_device_track` VALUES (437, 1, 10, 33, 17);
INSERT INTO `area_device_track` VALUES (438, 1, 10, 34, 18);
INSERT INTO `area_device_track` VALUES (439, 1, 10, 35, 19);
INSERT INTO `area_device_track` VALUES (440, 1, 10, 36, 20);
INSERT INTO `area_device_track` VALUES (441, 1, 10, 37, 21);
INSERT INTO `area_device_track` VALUES (442, 1, 10, 38, 22);
INSERT INTO `area_device_track` VALUES (443, 1, 10, 39, 23);
INSERT INTO `area_device_track` VALUES (444, 1, 10, 40, 24);
INSERT INTO `area_device_track` VALUES (445, 1, 10, 41, 25);
INSERT INTO `area_device_track` VALUES (446, 1, 10, 42, 26);
INSERT INTO `area_device_track` VALUES (447, 1, 10, 43, 27);
INSERT INTO `area_device_track` VALUES (448, 1, 10, 44, 28);
INSERT INTO `area_device_track` VALUES (449, 1, 10, 45, 29);
INSERT INTO `area_device_track` VALUES (450, 1, 10, 46, 30);
INSERT INTO `area_device_track` VALUES (452, 1, 10, 2, 32);
INSERT INTO `area_device_track` VALUES (453, 1, 10, 3, 33);
INSERT INTO `area_device_track` VALUES (454, 1, 10, 4, 34);
INSERT INTO `area_device_track` VALUES (455, 1, 10, 5, 35);
INSERT INTO `area_device_track` VALUES (456, 1, 10, 6, 36);
INSERT INTO `area_device_track` VALUES (457, 1, 10, 7, 37);
INSERT INTO `area_device_track` VALUES (458, 1, 10, 8, 38);
INSERT INTO `area_device_track` VALUES (459, 1, 10, 9, 39);
INSERT INTO `area_device_track` VALUES (460, 1, 10, 10, 40);
INSERT INTO `area_device_track` VALUES (461, 1, 10, 11, 41);
INSERT INTO `area_device_track` VALUES (462, 1, 10, 12, 42);
INSERT INTO `area_device_track` VALUES (463, 1, 11, 47, 1);
INSERT INTO `area_device_track` VALUES (464, 1, 11, 48, 2);
INSERT INTO `area_device_track` VALUES (465, 1, 11, 49, 3);
INSERT INTO `area_device_track` VALUES (466, 1, 11, 50, 4);
INSERT INTO `area_device_track` VALUES (467, 1, 11, 51, 5);
INSERT INTO `area_device_track` VALUES (468, 1, 11, 52, 6);
INSERT INTO `area_device_track` VALUES (469, 1, 11, 53, 7);
INSERT INTO `area_device_track` VALUES (470, 1, 11, 54, 8);
INSERT INTO `area_device_track` VALUES (471, 1, 11, 55, 9);
INSERT INTO `area_device_track` VALUES (472, 1, 11, 56, 10);
INSERT INTO `area_device_track` VALUES (473, 1, 11, 57, 11);
INSERT INTO `area_device_track` VALUES (474, 1, 11, 58, 12);
INSERT INTO `area_device_track` VALUES (475, 1, 11, 59, 13);
INSERT INTO `area_device_track` VALUES (476, 1, 11, 60, 14);
INSERT INTO `area_device_track` VALUES (477, 1, 11, 61, 15);
INSERT INTO `area_device_track` VALUES (478, 1, 11, 62, 16);
INSERT INTO `area_device_track` VALUES (479, 1, 11, 63, 17);
INSERT INTO `area_device_track` VALUES (480, 1, 11, 64, 18);
INSERT INTO `area_device_track` VALUES (481, 1, 11, 65, 19);
INSERT INTO `area_device_track` VALUES (482, 1, 11, 66, 20);
INSERT INTO `area_device_track` VALUES (483, 1, 11, 67, 21);
INSERT INTO `area_device_track` VALUES (484, 1, 11, 68, 22);
INSERT INTO `area_device_track` VALUES (485, 1, 11, 69, 23);
INSERT INTO `area_device_track` VALUES (486, 1, 11, 70, 24);
INSERT INTO `area_device_track` VALUES (487, 1, 11, 71, 25);
INSERT INTO `area_device_track` VALUES (488, 1, 11, 72, 26);
INSERT INTO `area_device_track` VALUES (489, 1, 11, 73, 27);
INSERT INTO `area_device_track` VALUES (490, 1, 11, 74, 28);
INSERT INTO `area_device_track` VALUES (493, 1, 11, 13, 31);
INSERT INTO `area_device_track` VALUES (494, 1, 11, 14, 32);
INSERT INTO `area_device_track` VALUES (495, 1, 11, 15, 33);
INSERT INTO `area_device_track` VALUES (496, 1, 11, 16, 34);
INSERT INTO `area_device_track` VALUES (499, 1, 12, 49, 3);
INSERT INTO `area_device_track` VALUES (500, 1, 12, 50, 4);
INSERT INTO `area_device_track` VALUES (501, 1, 12, 51, 5);
INSERT INTO `area_device_track` VALUES (502, 1, 12, 52, 6);
INSERT INTO `area_device_track` VALUES (503, 1, 12, 53, 7);
INSERT INTO `area_device_track` VALUES (504, 1, 12, 54, 8);
INSERT INTO `area_device_track` VALUES (505, 1, 12, 55, 9);
INSERT INTO `area_device_track` VALUES (506, 1, 12, 56, 10);
INSERT INTO `area_device_track` VALUES (507, 1, 12, 57, 11);
INSERT INTO `area_device_track` VALUES (508, 1, 12, 58, 12);
INSERT INTO `area_device_track` VALUES (509, 1, 12, 59, 13);
INSERT INTO `area_device_track` VALUES (510, 1, 12, 60, 14);
INSERT INTO `area_device_track` VALUES (511, 1, 12, 61, 15);
INSERT INTO `area_device_track` VALUES (512, 1, 12, 62, 16);
INSERT INTO `area_device_track` VALUES (513, 1, 12, 63, 17);
INSERT INTO `area_device_track` VALUES (514, 1, 12, 64, 18);
INSERT INTO `area_device_track` VALUES (515, 1, 12, 65, 19);
INSERT INTO `area_device_track` VALUES (516, 1, 12, 66, 20);
INSERT INTO `area_device_track` VALUES (517, 1, 12, 67, 21);
INSERT INTO `area_device_track` VALUES (518, 1, 12, 68, 22);
INSERT INTO `area_device_track` VALUES (519, 1, 12, 69, 23);
INSERT INTO `area_device_track` VALUES (520, 1, 12, 70, 24);
INSERT INTO `area_device_track` VALUES (521, 1, 12, 71, 25);
INSERT INTO `area_device_track` VALUES (522, 1, 12, 72, 26);
INSERT INTO `area_device_track` VALUES (523, 1, 12, 73, 27);
INSERT INTO `area_device_track` VALUES (524, 1, 12, 74, 28);
INSERT INTO `area_device_track` VALUES (525, 1, 12, 75, 29);
INSERT INTO `area_device_track` VALUES (526, 1, 12, 76, 30);
INSERT INTO `area_device_track` VALUES (527, 1, 12, 13, 31);
INSERT INTO `area_device_track` VALUES (528, 1, 12, 14, 32);
INSERT INTO `area_device_track` VALUES (529, 1, 12, 15, 33);
INSERT INTO `area_device_track` VALUES (530, 1, 12, 16, 34);
INSERT INTO `area_device_track` VALUES (531, 1, 1, 17, 1);
INSERT INTO `area_device_track` VALUES (532, 1, 1, 18, 2);
INSERT INTO `area_device_track` VALUES (533, 1, 1, 19, 3);
INSERT INTO `area_device_track` VALUES (534, 1, 1, 20, 4);
INSERT INTO `area_device_track` VALUES (535, 1, 1, 21, 5);
INSERT INTO `area_device_track` VALUES (536, 1, 1, 22, 6);
INSERT INTO `area_device_track` VALUES (537, 1, 1, 23, 7);
INSERT INTO `area_device_track` VALUES (538, 1, 1, 24, 8);
INSERT INTO `area_device_track` VALUES (539, 1, 1, 25, 9);
INSERT INTO `area_device_track` VALUES (540, 1, 1, 26, 10);
INSERT INTO `area_device_track` VALUES (541, 1, 1, 27, 11);
INSERT INTO `area_device_track` VALUES (542, 1, 1, 28, 12);
INSERT INTO `area_device_track` VALUES (543, 1, 1, 29, 13);
INSERT INTO `area_device_track` VALUES (544, 1, 1, 30, 14);
INSERT INTO `area_device_track` VALUES (545, 1, 1, 31, 15);
INSERT INTO `area_device_track` VALUES (546, 1, 1, 32, 16);
INSERT INTO `area_device_track` VALUES (547, 1, 1, 33, 17);
INSERT INTO `area_device_track` VALUES (548, 1, 1, 34, 18);
INSERT INTO `area_device_track` VALUES (549, 1, 1, 35, 19);
INSERT INTO `area_device_track` VALUES (550, 1, 1, 36, 20);
INSERT INTO `area_device_track` VALUES (551, 1, 1, 37, 21);
INSERT INTO `area_device_track` VALUES (552, 1, 1, 38, 22);
INSERT INTO `area_device_track` VALUES (553, 1, 1, 39, 23);
INSERT INTO `area_device_track` VALUES (554, 1, 1, 40, 24);
INSERT INTO `area_device_track` VALUES (555, 1, 1, 41, 25);
INSERT INTO `area_device_track` VALUES (556, 1, 1, 42, 26);
INSERT INTO `area_device_track` VALUES (557, 1, 1, 43, 27);
INSERT INTO `area_device_track` VALUES (558, 1, 1, 44, 28);
INSERT INTO `area_device_track` VALUES (561, 1, 2, 17, 1);
INSERT INTO `area_device_track` VALUES (562, 1, 2, 18, 2);
INSERT INTO `area_device_track` VALUES (563, 1, 2, 19, 3);
INSERT INTO `area_device_track` VALUES (564, 1, 2, 20, 4);
INSERT INTO `area_device_track` VALUES (565, 1, 2, 21, 5);
INSERT INTO `area_device_track` VALUES (566, 1, 2, 22, 6);
INSERT INTO `area_device_track` VALUES (567, 1, 2, 23, 7);
INSERT INTO `area_device_track` VALUES (568, 1, 2, 24, 8);
INSERT INTO `area_device_track` VALUES (569, 1, 2, 25, 9);
INSERT INTO `area_device_track` VALUES (570, 1, 2, 26, 10);
INSERT INTO `area_device_track` VALUES (571, 1, 2, 27, 11);
INSERT INTO `area_device_track` VALUES (572, 1, 2, 28, 12);
INSERT INTO `area_device_track` VALUES (573, 1, 2, 29, 13);
INSERT INTO `area_device_track` VALUES (574, 1, 2, 30, 14);
INSERT INTO `area_device_track` VALUES (575, 1, 2, 31, 15);
INSERT INTO `area_device_track` VALUES (576, 1, 2, 32, 16);
INSERT INTO `area_device_track` VALUES (577, 1, 2, 33, 17);
INSERT INTO `area_device_track` VALUES (578, 1, 2, 34, 18);
INSERT INTO `area_device_track` VALUES (579, 1, 2, 35, 19);
INSERT INTO `area_device_track` VALUES (580, 1, 2, 36, 20);
INSERT INTO `area_device_track` VALUES (581, 1, 2, 37, 21);
INSERT INTO `area_device_track` VALUES (582, 1, 2, 38, 22);
INSERT INTO `area_device_track` VALUES (583, 1, 2, 39, 23);
INSERT INTO `area_device_track` VALUES (584, 1, 2, 40, 24);
INSERT INTO `area_device_track` VALUES (585, 1, 2, 41, 25);
INSERT INTO `area_device_track` VALUES (586, 1, 2, 42, 26);
INSERT INTO `area_device_track` VALUES (587, 1, 2, 43, 27);
INSERT INTO `area_device_track` VALUES (588, 1, 2, 44, 28);
INSERT INTO `area_device_track` VALUES (589, 1, 2, 45, 29);
INSERT INTO `area_device_track` VALUES (590, 1, 2, 46, 30);
INSERT INTO `area_device_track` VALUES (591, 1, 3, 17, 1);
INSERT INTO `area_device_track` VALUES (592, 1, 3, 18, 2);
INSERT INTO `area_device_track` VALUES (593, 1, 3, 19, 3);
INSERT INTO `area_device_track` VALUES (594, 1, 3, 20, 4);
INSERT INTO `area_device_track` VALUES (595, 1, 3, 21, 5);
INSERT INTO `area_device_track` VALUES (596, 1, 3, 22, 6);
INSERT INTO `area_device_track` VALUES (597, 1, 3, 23, 7);
INSERT INTO `area_device_track` VALUES (598, 1, 3, 24, 8);
INSERT INTO `area_device_track` VALUES (599, 1, 3, 25, 9);
INSERT INTO `area_device_track` VALUES (600, 1, 3, 26, 10);
INSERT INTO `area_device_track` VALUES (601, 1, 3, 27, 11);
INSERT INTO `area_device_track` VALUES (602, 1, 3, 28, 12);
INSERT INTO `area_device_track` VALUES (603, 1, 3, 29, 13);
INSERT INTO `area_device_track` VALUES (604, 1, 3, 30, 14);
INSERT INTO `area_device_track` VALUES (605, 1, 3, 31, 15);
INSERT INTO `area_device_track` VALUES (606, 1, 3, 32, 16);
INSERT INTO `area_device_track` VALUES (607, 1, 3, 33, 17);
INSERT INTO `area_device_track` VALUES (608, 1, 3, 34, 18);
INSERT INTO `area_device_track` VALUES (609, 1, 3, 35, 19);
INSERT INTO `area_device_track` VALUES (610, 1, 3, 36, 20);
INSERT INTO `area_device_track` VALUES (611, 1, 3, 37, 21);
INSERT INTO `area_device_track` VALUES (612, 1, 3, 38, 22);
INSERT INTO `area_device_track` VALUES (613, 1, 3, 39, 23);
INSERT INTO `area_device_track` VALUES (614, 1, 3, 40, 24);
INSERT INTO `area_device_track` VALUES (615, 1, 3, 41, 25);
INSERT INTO `area_device_track` VALUES (616, 1, 3, 42, 26);
INSERT INTO `area_device_track` VALUES (617, 1, 3, 43, 27);
INSERT INTO `area_device_track` VALUES (618, 1, 3, 44, 28);
INSERT INTO `area_device_track` VALUES (619, 1, 3, 45, 29);
INSERT INTO `area_device_track` VALUES (620, 1, 3, 46, 30);
INSERT INTO `area_device_track` VALUES (621, 1, 4, 17, 30);
INSERT INTO `area_device_track` VALUES (622, 1, 4, 18, 29);
INSERT INTO `area_device_track` VALUES (623, 1, 4, 19, 28);
INSERT INTO `area_device_track` VALUES (624, 1, 4, 20, 27);
INSERT INTO `area_device_track` VALUES (625, 1, 4, 21, 26);
INSERT INTO `area_device_track` VALUES (626, 1, 4, 22, 25);
INSERT INTO `area_device_track` VALUES (627, 1, 4, 23, 24);
INSERT INTO `area_device_track` VALUES (628, 1, 4, 24, 23);
INSERT INTO `area_device_track` VALUES (629, 1, 4, 25, 22);
INSERT INTO `area_device_track` VALUES (630, 1, 4, 26, 21);
INSERT INTO `area_device_track` VALUES (631, 1, 4, 27, 20);
INSERT INTO `area_device_track` VALUES (632, 1, 4, 28, 19);
INSERT INTO `area_device_track` VALUES (633, 1, 4, 29, 18);
INSERT INTO `area_device_track` VALUES (634, 1, 4, 30, 17);
INSERT INTO `area_device_track` VALUES (635, 1, 4, 31, 16);
INSERT INTO `area_device_track` VALUES (636, 1, 4, 32, 15);
INSERT INTO `area_device_track` VALUES (637, 1, 4, 33, 14);
INSERT INTO `area_device_track` VALUES (638, 1, 4, 34, 13);
INSERT INTO `area_device_track` VALUES (639, 1, 4, 35, 12);
INSERT INTO `area_device_track` VALUES (640, 1, 4, 36, 11);
INSERT INTO `area_device_track` VALUES (641, 1, 4, 37, 10);
INSERT INTO `area_device_track` VALUES (642, 1, 4, 38, 9);
INSERT INTO `area_device_track` VALUES (643, 1, 4, 39, 8);
INSERT INTO `area_device_track` VALUES (644, 1, 4, 40, 7);
INSERT INTO `area_device_track` VALUES (645, 1, 4, 41, 6);
INSERT INTO `area_device_track` VALUES (646, 1, 4, 42, 5);
INSERT INTO `area_device_track` VALUES (647, 1, 4, 43, 4);
INSERT INTO `area_device_track` VALUES (648, 1, 4, 44, 3);
INSERT INTO `area_device_track` VALUES (649, 1, 4, 45, 2);
INSERT INTO `area_device_track` VALUES (650, 1, 4, 46, 1);
INSERT INTO `area_device_track` VALUES (651, 1, 5, 17, 30);
INSERT INTO `area_device_track` VALUES (652, 1, 5, 18, 29);
INSERT INTO `area_device_track` VALUES (653, 1, 5, 19, 28);
INSERT INTO `area_device_track` VALUES (654, 1, 5, 20, 27);
INSERT INTO `area_device_track` VALUES (655, 1, 5, 21, 26);
INSERT INTO `area_device_track` VALUES (656, 1, 5, 22, 25);
INSERT INTO `area_device_track` VALUES (657, 1, 5, 23, 24);
INSERT INTO `area_device_track` VALUES (658, 1, 5, 24, 23);
INSERT INTO `area_device_track` VALUES (659, 1, 5, 25, 22);
INSERT INTO `area_device_track` VALUES (660, 1, 5, 26, 21);
INSERT INTO `area_device_track` VALUES (661, 1, 5, 27, 20);
INSERT INTO `area_device_track` VALUES (662, 1, 5, 28, 19);
INSERT INTO `area_device_track` VALUES (663, 1, 5, 29, 18);
INSERT INTO `area_device_track` VALUES (664, 1, 5, 30, 17);
INSERT INTO `area_device_track` VALUES (665, 1, 5, 31, 16);
INSERT INTO `area_device_track` VALUES (666, 1, 5, 32, 15);
INSERT INTO `area_device_track` VALUES (667, 1, 5, 33, 14);
INSERT INTO `area_device_track` VALUES (668, 1, 5, 34, 13);
INSERT INTO `area_device_track` VALUES (669, 1, 5, 35, 12);
INSERT INTO `area_device_track` VALUES (670, 1, 5, 36, 11);
INSERT INTO `area_device_track` VALUES (671, 1, 5, 37, 10);
INSERT INTO `area_device_track` VALUES (672, 1, 5, 38, 9);
INSERT INTO `area_device_track` VALUES (673, 1, 5, 39, 8);
INSERT INTO `area_device_track` VALUES (674, 1, 5, 40, 7);
INSERT INTO `area_device_track` VALUES (675, 1, 5, 41, 6);
INSERT INTO `area_device_track` VALUES (676, 1, 5, 42, 5);
INSERT INTO `area_device_track` VALUES (677, 1, 5, 43, 4);
INSERT INTO `area_device_track` VALUES (678, 1, 5, 44, 3);
INSERT INTO `area_device_track` VALUES (679, 1, 5, 45, 2);
INSERT INTO `area_device_track` VALUES (680, 1, 5, 46, 1);
INSERT INTO `area_device_track` VALUES (683, 1, 6, 19, 28);
INSERT INTO `area_device_track` VALUES (684, 1, 6, 20, 27);
INSERT INTO `area_device_track` VALUES (685, 1, 6, 21, 26);
INSERT INTO `area_device_track` VALUES (686, 1, 6, 22, 25);
INSERT INTO `area_device_track` VALUES (687, 1, 6, 23, 24);
INSERT INTO `area_device_track` VALUES (688, 1, 6, 24, 23);
INSERT INTO `area_device_track` VALUES (689, 1, 6, 25, 22);
INSERT INTO `area_device_track` VALUES (690, 1, 6, 26, 21);
INSERT INTO `area_device_track` VALUES (691, 1, 6, 27, 20);
INSERT INTO `area_device_track` VALUES (692, 1, 6, 28, 19);
INSERT INTO `area_device_track` VALUES (693, 1, 6, 29, 18);
INSERT INTO `area_device_track` VALUES (694, 1, 6, 30, 17);
INSERT INTO `area_device_track` VALUES (695, 1, 6, 31, 16);
INSERT INTO `area_device_track` VALUES (696, 1, 6, 32, 15);
INSERT INTO `area_device_track` VALUES (697, 1, 6, 33, 14);
INSERT INTO `area_device_track` VALUES (698, 1, 6, 34, 13);
INSERT INTO `area_device_track` VALUES (699, 1, 6, 35, 12);
INSERT INTO `area_device_track` VALUES (700, 1, 6, 36, 11);
INSERT INTO `area_device_track` VALUES (701, 1, 6, 37, 10);
INSERT INTO `area_device_track` VALUES (702, 1, 6, 38, 9);
INSERT INTO `area_device_track` VALUES (703, 1, 6, 39, 8);
INSERT INTO `area_device_track` VALUES (704, 1, 6, 40, 7);
INSERT INTO `area_device_track` VALUES (705, 1, 6, 41, 6);
INSERT INTO `area_device_track` VALUES (706, 1, 6, 42, 5);
INSERT INTO `area_device_track` VALUES (707, 1, 6, 43, 4);
INSERT INTO `area_device_track` VALUES (708, 1, 6, 44, 3);
INSERT INTO `area_device_track` VALUES (709, 1, 6, 45, 2);
INSERT INTO `area_device_track` VALUES (710, 1, 6, 46, 1);
INSERT INTO `area_device_track` VALUES (711, 1, 7, 47, 1);
INSERT INTO `area_device_track` VALUES (712, 1, 7, 48, 2);
INSERT INTO `area_device_track` VALUES (713, 1, 7, 49, 3);
INSERT INTO `area_device_track` VALUES (714, 1, 7, 50, 4);
INSERT INTO `area_device_track` VALUES (715, 1, 7, 51, 5);
INSERT INTO `area_device_track` VALUES (716, 1, 7, 52, 6);
INSERT INTO `area_device_track` VALUES (717, 1, 7, 53, 7);
INSERT INTO `area_device_track` VALUES (718, 1, 7, 54, 8);
INSERT INTO `area_device_track` VALUES (719, 1, 7, 55, 9);
INSERT INTO `area_device_track` VALUES (720, 1, 7, 56, 10);
INSERT INTO `area_device_track` VALUES (721, 1, 7, 57, 11);
INSERT INTO `area_device_track` VALUES (722, 1, 7, 58, 12);
INSERT INTO `area_device_track` VALUES (723, 1, 7, 59, 13);
INSERT INTO `area_device_track` VALUES (724, 1, 7, 60, 14);
INSERT INTO `area_device_track` VALUES (725, 1, 7, 61, 15);
INSERT INTO `area_device_track` VALUES (726, 1, 7, 62, 16);
INSERT INTO `area_device_track` VALUES (727, 1, 7, 63, 17);
INSERT INTO `area_device_track` VALUES (728, 1, 7, 64, 18);
INSERT INTO `area_device_track` VALUES (729, 1, 7, 65, 19);
INSERT INTO `area_device_track` VALUES (730, 1, 7, 66, 20);
INSERT INTO `area_device_track` VALUES (731, 1, 7, 67, 21);
INSERT INTO `area_device_track` VALUES (732, 1, 7, 68, 22);
INSERT INTO `area_device_track` VALUES (733, 1, 7, 69, 23);
INSERT INTO `area_device_track` VALUES (734, 1, 7, 70, 24);
INSERT INTO `area_device_track` VALUES (735, 1, 7, 71, 25);
INSERT INTO `area_device_track` VALUES (736, 1, 7, 72, 26);
INSERT INTO `area_device_track` VALUES (737, 1, 7, 73, 27);
INSERT INTO `area_device_track` VALUES (738, 1, 7, 74, 28);
INSERT INTO `area_device_track` VALUES (739, 1, 7, 75, 29);
INSERT INTO `area_device_track` VALUES (740, 1, 7, 76, 30);
INSERT INTO `area_device_track` VALUES (741, 1, 8, 47, 30);
INSERT INTO `area_device_track` VALUES (742, 1, 8, 48, 29);
INSERT INTO `area_device_track` VALUES (743, 1, 8, 49, 28);
INSERT INTO `area_device_track` VALUES (744, 1, 8, 50, 27);
INSERT INTO `area_device_track` VALUES (745, 1, 8, 51, 26);
INSERT INTO `area_device_track` VALUES (746, 1, 8, 52, 25);
INSERT INTO `area_device_track` VALUES (747, 1, 8, 53, 24);
INSERT INTO `area_device_track` VALUES (748, 1, 8, 54, 23);
INSERT INTO `area_device_track` VALUES (749, 1, 8, 55, 22);
INSERT INTO `area_device_track` VALUES (750, 1, 8, 56, 21);
INSERT INTO `area_device_track` VALUES (751, 1, 8, 57, 20);
INSERT INTO `area_device_track` VALUES (752, 1, 8, 58, 19);
INSERT INTO `area_device_track` VALUES (753, 1, 8, 59, 18);
INSERT INTO `area_device_track` VALUES (754, 1, 8, 60, 17);
INSERT INTO `area_device_track` VALUES (755, 1, 8, 61, 16);
INSERT INTO `area_device_track` VALUES (756, 1, 8, 62, 15);
INSERT INTO `area_device_track` VALUES (757, 1, 8, 63, 14);
INSERT INTO `area_device_track` VALUES (758, 1, 8, 64, 13);
INSERT INTO `area_device_track` VALUES (759, 1, 8, 65, 12);
INSERT INTO `area_device_track` VALUES (760, 1, 8, 66, 11);
INSERT INTO `area_device_track` VALUES (761, 1, 8, 67, 10);
INSERT INTO `area_device_track` VALUES (762, 1, 8, 68, 9);
INSERT INTO `area_device_track` VALUES (763, 1, 8, 69, 8);
INSERT INTO `area_device_track` VALUES (764, 1, 8, 70, 7);
INSERT INTO `area_device_track` VALUES (765, 1, 8, 71, 6);
INSERT INTO `area_device_track` VALUES (766, 1, 8, 72, 5);
INSERT INTO `area_device_track` VALUES (767, 1, 8, 73, 4);
INSERT INTO `area_device_track` VALUES (768, 1, 8, 74, 3);
INSERT INTO `area_device_track` VALUES (769, 1, 8, 75, 2);
INSERT INTO `area_device_track` VALUES (770, 1, 8, 76, 1);
INSERT INTO `area_device_track` VALUES (772, 1, 9, 44, 28);
INSERT INTO `area_device_track` VALUES (775, 1, 9, 12, 42);
INSERT INTO `area_device_track` VALUES (776, 1, 9, 46, 41);
INSERT INTO `area_device_track` VALUES (777, 1, 9, 45, 42);
INSERT INTO `area_device_track` VALUES (778, 1, 1, 46, 29);
INSERT INTO `area_device_track` VALUES (779, 1, 1, 45, 30);

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
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '区域内轨道' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of area_track
-- ----------------------------
INSERT INTO `area_track` VALUES (1, 1, 1, 1);
INSERT INTO `area_track` VALUES (2, 1, 2, 1);
INSERT INTO `area_track` VALUES (3, 1, 3, 1);
INSERT INTO `area_track` VALUES (4, 1, 4, 1);
INSERT INTO `area_track` VALUES (5, 1, 5, 1);
INSERT INTO `area_track` VALUES (6, 1, 6, 1);
INSERT INTO `area_track` VALUES (7, 1, 7, 1);
INSERT INTO `area_track` VALUES (8, 1, 8, 1);
INSERT INTO `area_track` VALUES (9, 1, 9, 1);
INSERT INTO `area_track` VALUES (10, 1, 10, 1);
INSERT INTO `area_track` VALUES (11, 1, 11, 1);
INSERT INTO `area_track` VALUES (12, 1, 12, 1);
INSERT INTO `area_track` VALUES (13, 1, 13, 0);
INSERT INTO `area_track` VALUES (14, 1, 14, 0);
INSERT INTO `area_track` VALUES (15, 1, 15, 0);
INSERT INTO `area_track` VALUES (16, 1, 16, 0);
INSERT INTO `area_track` VALUES (17, 1, 17, 2);
INSERT INTO `area_track` VALUES (18, 1, 18, 2);
INSERT INTO `area_track` VALUES (19, 1, 19, 2);
INSERT INTO `area_track` VALUES (20, 1, 20, 2);
INSERT INTO `area_track` VALUES (21, 1, 21, 2);
INSERT INTO `area_track` VALUES (22, 1, 22, 2);
INSERT INTO `area_track` VALUES (23, 1, 23, 2);
INSERT INTO `area_track` VALUES (24, 1, 24, 2);
INSERT INTO `area_track` VALUES (25, 1, 25, 2);
INSERT INTO `area_track` VALUES (26, 1, 26, 2);
INSERT INTO `area_track` VALUES (27, 1, 27, 2);
INSERT INTO `area_track` VALUES (28, 1, 28, 2);
INSERT INTO `area_track` VALUES (29, 1, 29, 2);
INSERT INTO `area_track` VALUES (30, 1, 30, 2);
INSERT INTO `area_track` VALUES (31, 1, 31, 2);
INSERT INTO `area_track` VALUES (32, 1, 32, 2);
INSERT INTO `area_track` VALUES (33, 1, 33, 2);
INSERT INTO `area_track` VALUES (34, 1, 34, 2);
INSERT INTO `area_track` VALUES (35, 1, 35, 2);
INSERT INTO `area_track` VALUES (36, 1, 36, 2);
INSERT INTO `area_track` VALUES (37, 1, 37, 2);
INSERT INTO `area_track` VALUES (38, 1, 38, 2);
INSERT INTO `area_track` VALUES (39, 1, 39, 2);
INSERT INTO `area_track` VALUES (40, 1, 40, 2);
INSERT INTO `area_track` VALUES (41, 1, 41, 2);
INSERT INTO `area_track` VALUES (42, 1, 42, 2);
INSERT INTO `area_track` VALUES (43, 1, 43, 2);
INSERT INTO `area_track` VALUES (44, 1, 44, 2);
INSERT INTO `area_track` VALUES (45, 1, 45, 2);
INSERT INTO `area_track` VALUES (46, 1, 46, 2);
INSERT INTO `area_track` VALUES (47, 1, 47, 3);
INSERT INTO `area_track` VALUES (48, 1, 48, 3);
INSERT INTO `area_track` VALUES (49, 1, 49, 3);
INSERT INTO `area_track` VALUES (50, 1, 50, 3);
INSERT INTO `area_track` VALUES (51, 1, 51, 3);
INSERT INTO `area_track` VALUES (52, 1, 52, 3);
INSERT INTO `area_track` VALUES (53, 1, 53, 3);
INSERT INTO `area_track` VALUES (54, 1, 54, 3);
INSERT INTO `area_track` VALUES (55, 1, 55, 3);
INSERT INTO `area_track` VALUES (56, 1, 56, 3);
INSERT INTO `area_track` VALUES (57, 1, 57, 3);
INSERT INTO `area_track` VALUES (58, 1, 58, 3);
INSERT INTO `area_track` VALUES (59, 1, 59, 3);
INSERT INTO `area_track` VALUES (60, 1, 60, 3);
INSERT INTO `area_track` VALUES (61, 1, 61, 3);
INSERT INTO `area_track` VALUES (62, 1, 62, 3);
INSERT INTO `area_track` VALUES (63, 1, 63, 3);
INSERT INTO `area_track` VALUES (64, 1, 64, 3);
INSERT INTO `area_track` VALUES (65, 1, 65, 3);
INSERT INTO `area_track` VALUES (66, 1, 66, 3);
INSERT INTO `area_track` VALUES (67, 1, 67, 3);
INSERT INTO `area_track` VALUES (68, 1, 68, 3);
INSERT INTO `area_track` VALUES (69, 1, 69, 3);
INSERT INTO `area_track` VALUES (70, 1, 70, 3);
INSERT INTO `area_track` VALUES (71, 1, 71, 3);
INSERT INTO `area_track` VALUES (72, 1, 72, 3);
INSERT INTO `area_track` VALUES (73, 1, 73, 3);
INSERT INTO `area_track` VALUES (74, 1, 74, 3);
INSERT INTO `area_track` VALUES (75, 1, 75, 3);
INSERT INTO `area_track` VALUES (76, 1, 76, 3);
INSERT INTO `area_track` VALUES (77, 1, 77, 5);
INSERT INTO `area_track` VALUES (78, 1, 78, 5);
INSERT INTO `area_track` VALUES (79, 1, 79, 6);
INSERT INTO `area_track` VALUES (80, 1, 80, 6);

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
  `area` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '区域值用于过滤',
  `order` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
  `offlinetime` datetime(0) NULL DEFAULT NULL COMMENT '离线时间',
  `a_givemisstrack` bit(1) NULL DEFAULT NULL COMMENT '前进放货扫不到点',
  `a_takemisstrack` bit(1) NULL DEFAULT NULL COMMENT '后退取货扫不到点',
  `a_poweroff` bit(1) NULL DEFAULT NULL COMMENT '轨道掉电',
  `a_alert_track` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '所在轨道',
  `do_work` bit(1) NULL DEFAULT NULL COMMENT '开启作业',
  `work_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '作业类型\r\n砖机：0按规格 1按轨道',
  `old_goodid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '上一个品种',
  `pre_goodid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '预设品种',
  `last_track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '砖机上次作业轨道',
  `do_shift` bit(1) NULL DEFAULT NULL COMMENT '开启转产',
  `left_goods` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '左轨道品种',
  `right_goods` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '右轨道品种',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dev_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `dev_ltrack_id_fk`(`left_track_id`) USING BTREE,
  INDEX `dev_rtrack_id_fk`(`right_track_id`) USING BTREE,
  CONSTRAINT `dev_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dev_ltrack_id_fk` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dev_rtrack_id_fk` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES (1, '下砖机A1', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 1, 1, 2, 0, 4, 0, '161', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, 0, 0, NULL, b'0', 1, 2);
INSERT INTO `device` VALUES (2, '下砖机A2', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 1, 3, 4, 0, 4, 0, '162', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (3, '下砖机A3', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 1, 5, 6, 0, 4, 0, '163', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (4, '下砖机A4', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 3, 7, 8, 0, 4, 0, '164', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (5, '下砖机A5', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 3, 9, 10, 0, 4, 0, '165', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (6, '下砖机A6', '127.0.0.1', 2001, 1, 2, b'1', 0, 0, 3, 11, 12, 0, 4, 0, '166', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (7, '上砖机D1', '127.0.0.1', 2001, 0, 2, b'1', 0, 0, 1, 13, 14, 0, 0, 1, '209', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (8, '上砖机D2', '127.0.0.1', 2001, 0, 2, b'1', 0, 0, 3, 15, 16, 0, 0, 1, '210', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (9, '摆渡车B1', '127.0.0.1', 2002, 3, 0, b'1', 0, 0, NULL, 77, NULL, 0, 0, 0, '177', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (10, '摆渡车B2', '127.0.0.1', 2002, 3, 0, b'1', 0, 0, NULL, 78, NULL, 0, 0, 0, '178', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (11, '摆渡车B5', '127.0.0.1', 2002, 2, 0, b'1', 0, 0, NULL, 79, NULL, 0, 0, 0, '181', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (12, '摆渡车B6', '127.0.0.1', 2002, 2, 0, b'1', 0, 0, NULL, 80, NULL, 0, 0, 0, '182', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (13, '运输车C1', '127.0.0.1', 2003, 4, 0, b'0', 0, 0, NULL, NULL, NULL, 0, 0, 0, '193', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (14, '运输车C2', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '194', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (15, '运输车C3', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '195', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (16, '运输车C4', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '196', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (17, '运输车C5', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '197', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `device` VALUES (18, '运输车C6', '127.0.0.1', 2003, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '198', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL);

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
  `area` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '区域值用于过滤',
  `order` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
  `offlinetime` datetime(0) NULL DEFAULT NULL COMMENT '离线时间',
  `a_givemisstrack` bit(1) NULL DEFAULT NULL COMMENT '前进放货扫不到点',
  `a_takemisstrack` bit(1) NULL DEFAULT NULL COMMENT '后退取货扫不到点',
  `a_poweroff` bit(1) NULL DEFAULT NULL COMMENT '轨道掉电',
  `a_alert_track` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '所在轨道',
  `do_work` bit(1) NULL DEFAULT NULL COMMENT '开启作业',
  `work_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '作业类型\r\n砖机：0按规格 1按轨道',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dev_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `dev_ltrack_id_fk`(`left_track_id`) USING BTREE,
  INDEX `dev_rtrack_id_fk`(`right_track_id`) USING BTREE,
  CONSTRAINT `device_copy1_ibfk_1` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_copy1_ibfk_2` FOREIGN KEY (`left_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_copy1_ibfk_3` FOREIGN KEY (`right_track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设备' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device_copy1
-- ----------------------------
INSERT INTO `device_copy1` VALUES (1, '下砖机A1', '192.168.0.31', 2000, 1, 2, b'1', 0, 0, 1, 1, 2, 0, 4, 0, '161', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (2, '下砖机A2', '192.168.0.36', 2000, 1, 2, b'1', 0, 0, 1, 3, 4, 0, 4, 0, '162', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (3, '下砖机A3', '192.168.0.41', 2000, 1, 2, b'1', 0, 0, 1, 5, 6, 0, 4, 0, '163', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (4, '下砖机A4', '192.168.0.46', 2000, 1, 2, b'1', 0, 0, 3, 7, 8, 0, 4, 0, '164', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (5, '下砖机A5', '192.168.0.51', 2000, 1, 2, b'1', 0, 0, 3, 9, 10, 0, 4, 0, '165', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (6, '下砖机A6', '192.168.0.56', 2000, 1, 2, b'1', 0, 0, 3, 11, 12, 0, 4, 0, '166', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (7, '上砖机D1', '192.168.0.81', 2000, 0, 2, b'1', 0, 0, 1, 13, 14, 0, 0, 1, '209', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (8, '上砖机D2', '192.168.0.86', 2000, 0, 2, b'1', 0, 0, 3, 15, 16, 0, 0, 1, '210', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (9, '摆渡车B1', '192.168.0.131', 2000, 3, 0, b'1', 0, 0, NULL, 77, NULL, 0, 0, 0, '177', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (10, '摆渡车B2', '192.168.0.132', 2000, 3, 0, b'1', 0, 0, NULL, 78, NULL, 0, 0, 0, '178', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (11, '摆渡车B5', '192.168.0.135', 2000, 2, 0, b'1', 0, 0, NULL, 79, NULL, 0, 0, 0, '181', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (12, '摆渡车B6', '192.168.0.136', 2000, 2, 0, b'1', 0, 0, NULL, 80, NULL, 0, 0, 0, '182', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (13, '运输车C1', '192.168.0.151', 2000, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '193', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (14, '运输车C2', '192.168.0.152', 2000, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '194', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (15, '运输车C3', '192.168.0.153', 2000, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '195', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (16, '运输车C4', '192.168.0.154', 2000, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '196', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (17, '运输车C5', '192.168.0.155', 2000, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '197', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);
INSERT INTO `device_copy1` VALUES (18, '运输车C6', '192.168.0.156', 2000, 4, 0, b'1', 0, 0, NULL, NULL, NULL, 0, 0, 0, '198', 1, NULL, NULL, NULL, NULL, NULL, NULL, b'1', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction
-- ----------------------------
INSERT INTO `diction` VALUES (1, 0, 4, '序列号生成', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (2, 0, 1, '任务开关', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (3, 0, 2, '警告信息', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (4, 0, 0, '最小存放时间', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (5, 0, 0, '安全距离', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (6, 0, 0, '版本信息', b'0', b'1', b'0', 1);
INSERT INTO `diction` VALUES (7, 0, 0, '转产差值', b'1', b'1', b'1', 1);
INSERT INTO `diction` VALUES (8, 0, 1, '配置开关', b'0', b'1', b'0', 100);

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
  `updatetime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dic_id_fk`(`diction_id`) USING BTREE,
  CONSTRAINT `dic_id_fk` FOREIGN KEY (`diction_id`) REFERENCES `diction` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diction_dtl
-- ----------------------------
INSERT INTO `diction_dtl` VALUES (1, 1, 'NewStockId', '生成库存ID', NULL, NULL, '', NULL, 3784, NULL, '2020-12-12 09:57:38');
INSERT INTO `diction_dtl` VALUES (2, 1, 'NewTranId', '生成交易ID', NULL, NULL, '', NULL, 7480, NULL, '2020-12-12 09:58:28');
INSERT INTO `diction_dtl` VALUES (3, 1, 'NewWarnId', '生成警告ID', NULL, NULL, '', NULL, 6162, NULL, '2020-12-13 10:55:25');
INSERT INTO `diction_dtl` VALUES (4, 1, 'NewGoodId', '生成品种ID', NULL, NULL, '', NULL, 130, NULL, '2020-12-12 08:55:02');
INSERT INTO `diction_dtl` VALUES (5, 2, 'Area1Down', '1号线下砖', NULL, b'0', '', NULL, NULL, NULL, '2020-12-12 09:58:50');
INSERT INTO `diction_dtl` VALUES (6, 2, 'Area1Up', '1号线上砖', NULL, b'0', '', NULL, NULL, NULL, '2020-12-12 09:58:49');
INSERT INTO `diction_dtl` VALUES (20, 3, 'DeviceOffline', '设备离线提示', NULL, NULL, '设备离线', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (21, 3, 'TrackFullButNoneStock', '满砖无库存', NULL, NULL, '满砖无库存', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (22, 3, 'CarrierLoadSortTask', '小车倒库中但是小车有货', NULL, NULL, '小车倒库中但是小车有货', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (23, 3, 'CarrierLoadNotSortTask', '小车倒库中任务清除', NULL, NULL, '小车倒库中任务清除', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (24, 3, 'ReadConBreakenCheckWire', '阅读器断开[检查连接线]', NULL, NULL, 'RFID阅读器断开[检查连接线]', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (25, 3, 'StoreSlowOverTimeCheckLight', '前进储砖减速超时，检查定位光电', NULL, NULL, '前进储砖减速超时，检查定位光电', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (26, 3, 'FrontAvoidAlert', '前防撞触发', NULL, NULL, '前防撞触发', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (27, 3, 'BackAvoidAlert', '后防撞触发', NULL, NULL, '后防撞触发', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (28, 3, 'FunctinSwitchOverTime', '功能 切换超时', NULL, NULL, '功能 切换超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (29, 3, 'BackTakeOverTime', '后退取砖任务超时', NULL, NULL, '后退取砖任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (30, 3, 'FrontGiveOverTime', '前进放砖任务超时', NULL, NULL, '前进放砖任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (31, 3, 'FrontPointOverTime', '前进至点任务超时', NULL, NULL, '前进至点任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (32, 3, 'BackPointOverTime', '后退至点任务超时', NULL, NULL, '后退至点任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (33, 3, 'Back2FerryOverTime', '后退至摆渡任务超时', NULL, NULL, '后退至摆渡任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (34, 3, 'Front2FerryOverTime', '前进至摆渡任务超时', NULL, NULL, '前进至摆渡任务超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (35, 3, 'GoUpOverTime', '上升超时', NULL, NULL, '上升超时，检查上到位信号', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (36, 3, 'GoDownOverTime', '下降超时', NULL, NULL, '下降超时，检查下到位信号', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (37, 3, 'BackTakeCannotDo', '后退取砖条件不满足', NULL, NULL, '后退取砖条件不满足[摆渡上，下位，无砖]', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (38, 3, 'FrontGiveCannotDo', '前进放砖条件不满足', NULL, NULL, '前进放砖条件不满足[摆渡上，上位，有砖]', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (39, 3, 'Back2FerryCannotDo', '后退至摆渡条件不满足', NULL, NULL, '后退至摆渡条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (40, 3, 'Front2FerryCannotDo', '前进至摆渡条件不满足', NULL, NULL, '前进至摆渡条件不满足', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (41, 3, 'Back2SortCannotDo', '后退至轨道倒库条件不满足', NULL, NULL, '后退倒库条件不满足[下位,无砖,轨道头]', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (42, 3, 'Front2PointCannotDo', '前进至点条件不满足', NULL, NULL, '前进至点条件不满足，是否在轨道前进方向轨道头部？', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (43, 3, 'Back2PointCannotDo', '后退至点条件不满足', NULL, NULL, '后退至点条件不满足，是否在轨道后退方向轨道头部？', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (44, 3, 'NotGoodToGoUp', '无砖不执行上升', NULL, NULL, '无砖不执行上升', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (45, 3, 'SortTaskOverTime', '倒库超时', NULL, NULL, '倒库超时', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (46, 3, 'TileNoneStrategy', '砖机没有设置策略', NULL, NULL, '砖机没有设置策略', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (47, 3, 'CarrierFullSignalFullNotOnStoreTrack', '小车满砖信号不在储砖轨道', NULL, NULL, '小车满砖信号不在储砖轨道', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (48, 3, 'CarrierGiveMissTrack', '前进放货没扫到地标', NULL, NULL, '前进放货没扫到地标,手动下降放货，移回轨道头', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (49, 3, 'DownTileHaveNotTrackToStore', '砖机找不到合适轨道存砖', NULL, NULL, '砖机找不到合适轨道存砖', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (50, 3, 'UpTileHaveNotStockToOut', '砖机找不到合适库存出库', NULL, NULL, '砖机找不到合适库存出库', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (51, 3, 'TrackEarlyFull', '请检查轨道是否提前满砖了', NULL, NULL, '请检查轨道是否提前满砖了', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (52, 4, 'MinStockTime', '最小存放时间(小时)', 0, NULL, NULL, NULL, NULL, NULL, '2020-11-18 21:26:18');
INSERT INTO `diction_dtl` VALUES (53, 5, 'FerryAvoidNumber', '摆渡车(轨道数)', 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (54, 3, 'UpTileHaveNoTrackToOut', '砖机找不到合适轨道上砖', NULL, NULL, '砖机找不到合适轨道上砖', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (57, 6, 'PDA_INIT_VERSION', 'PDA基础字典版本', 9, NULL, '', NULL, NULL, NULL, '2020-12-17 14:00:05');
INSERT INTO `diction_dtl` VALUES (58, 6, 'PDA_GOOD_VERSION', 'PDA规格字典版本', 5, NULL, '', NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (59, 7, 'TileLifterShiftCount', '下砖机转产差值(层数)', 99, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `diction_dtl` VALUES (60, 8, 'UserLoginFunction', 'PDA登陆功能开关', NULL, b'0', 'PDA登陆功能开关', NULL, NULL, NULL, '2020-12-17 13:59:59');

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
) ENGINE = InnoDB AUTO_INCREMENT = 357 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '摆渡对位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ferry_pos
-- ----------------------------
INSERT INTO `ferry_pos` VALUES (205, 17, 9, 201, 0);
INSERT INTO `ferry_pos` VALUES (206, 18, 9, 202, -7471);
INSERT INTO `ferry_pos` VALUES (207, 19, 9, 203, -6929);
INSERT INTO `ferry_pos` VALUES (208, 20, 9, 204, -6372);
INSERT INTO `ferry_pos` VALUES (209, 21, 9, 205, -5828);
INSERT INTO `ferry_pos` VALUES (210, 22, 9, 206, -5280);
INSERT INTO `ferry_pos` VALUES (211, 23, 9, 207, -4739);
INSERT INTO `ferry_pos` VALUES (212, 24, 9, 208, -4193);
INSERT INTO `ferry_pos` VALUES (213, 25, 9, 209, -3644);
INSERT INTO `ferry_pos` VALUES (214, 26, 9, 210, -3097);
INSERT INTO `ferry_pos` VALUES (215, 27, 9, 211, -2557);
INSERT INTO `ferry_pos` VALUES (216, 28, 9, 212, -2014);
INSERT INTO `ferry_pos` VALUES (217, 29, 9, 213, -1471);
INSERT INTO `ferry_pos` VALUES (218, 30, 9, 214, -926);
INSERT INTO `ferry_pos` VALUES (219, 31, 9, 215, -380);
INSERT INTO `ferry_pos` VALUES (220, 32, 9, 216, 170);
INSERT INTO `ferry_pos` VALUES (221, 33, 9, 217, 711);
INSERT INTO `ferry_pos` VALUES (222, 34, 9, 218, 1255);
INSERT INTO `ferry_pos` VALUES (223, 35, 9, 219, 1801);
INSERT INTO `ferry_pos` VALUES (224, 36, 9, 220, 2346);
INSERT INTO `ferry_pos` VALUES (225, 37, 9, 221, 2893);
INSERT INTO `ferry_pos` VALUES (226, 38, 9, 222, 3439);
INSERT INTO `ferry_pos` VALUES (227, 39, 9, 223, 3984);
INSERT INTO `ferry_pos` VALUES (228, 40, 9, 224, 4531);
INSERT INTO `ferry_pos` VALUES (229, 41, 9, 225, 5869);
INSERT INTO `ferry_pos` VALUES (230, 42, 9, 226, 6388);
INSERT INTO `ferry_pos` VALUES (231, 43, 9, 227, 6906);
INSERT INTO `ferry_pos` VALUES (232, 44, 9, 228, 7427);
INSERT INTO `ferry_pos` VALUES (233, 45, 9, 229, 0);
INSERT INTO `ferry_pos` VALUES (234, 46, 9, 230, 31877);
INSERT INTO `ferry_pos` VALUES (235, 1, 9, 101, -7670);
INSERT INTO `ferry_pos` VALUES (236, 2, 9, 102, -6410);
INSERT INTO `ferry_pos` VALUES (237, 3, 9, 103, -5040);
INSERT INTO `ferry_pos` VALUES (238, 4, 9, 104, -3784);
INSERT INTO `ferry_pos` VALUES (239, 5, 9, 105, -2422);
INSERT INTO `ferry_pos` VALUES (240, 6, 9, 106, -1176);
INSERT INTO `ferry_pos` VALUES (241, 7, 9, 107, 186);
INSERT INTO `ferry_pos` VALUES (242, 8, 9, 108, 1441);
INSERT INTO `ferry_pos` VALUES (243, 9, 9, 109, 2810);
INSERT INTO `ferry_pos` VALUES (244, 10, 9, 110, 4066);
INSERT INTO `ferry_pos` VALUES (245, 11, 9, 111, 6139);
INSERT INTO `ferry_pos` VALUES (246, 12, 9, 112, 7395);
INSERT INTO `ferry_pos` VALUES (247, 17, 10, 201, 0);
INSERT INTO `ferry_pos` VALUES (248, 18, 10, 202, 0);
INSERT INTO `ferry_pos` VALUES (249, 19, 10, 203, -6923);
INSERT INTO `ferry_pos` VALUES (250, 20, 10, 204, -6376);
INSERT INTO `ferry_pos` VALUES (251, 21, 10, 205, -5836);
INSERT INTO `ferry_pos` VALUES (252, 22, 10, 206, -5289);
INSERT INTO `ferry_pos` VALUES (253, 23, 10, 207, -4741);
INSERT INTO `ferry_pos` VALUES (254, 24, 10, 208, -4195);
INSERT INTO `ferry_pos` VALUES (255, 25, 10, 209, -3652);
INSERT INTO `ferry_pos` VALUES (256, 26, 10, 210, -3100);
INSERT INTO `ferry_pos` VALUES (257, 27, 10, 211, -2553);
INSERT INTO `ferry_pos` VALUES (258, 28, 10, 212, -2012);
INSERT INTO `ferry_pos` VALUES (259, 29, 10, 213, -1466);
INSERT INTO `ferry_pos` VALUES (260, 30, 10, 214, -922);
INSERT INTO `ferry_pos` VALUES (261, 31, 10, 215, -382);
INSERT INTO `ferry_pos` VALUES (262, 32, 10, 216, 160);
INSERT INTO `ferry_pos` VALUES (263, 33, 10, 217, 708);
INSERT INTO `ferry_pos` VALUES (264, 34, 10, 218, 1257);
INSERT INTO `ferry_pos` VALUES (265, 35, 10, 219, 1794);
INSERT INTO `ferry_pos` VALUES (266, 36, 10, 220, 2341);
INSERT INTO `ferry_pos` VALUES (267, 37, 10, 221, 2902);
INSERT INTO `ferry_pos` VALUES (268, 38, 10, 222, 3438);
INSERT INTO `ferry_pos` VALUES (269, 39, 10, 223, 3980);
INSERT INTO `ferry_pos` VALUES (270, 40, 10, 224, 4530);
INSERT INTO `ferry_pos` VALUES (271, 41, 10, 225, 5870);
INSERT INTO `ferry_pos` VALUES (272, 42, 10, 226, 6381);
INSERT INTO `ferry_pos` VALUES (273, 43, 10, 227, 6897);
INSERT INTO `ferry_pos` VALUES (274, 44, 10, 228, 7417);
INSERT INTO `ferry_pos` VALUES (275, 45, 10, 229, 7933);
INSERT INTO `ferry_pos` VALUES (276, 46, 10, 230, 8452);
INSERT INTO `ferry_pos` VALUES (277, 1, 10, 101, 0);
INSERT INTO `ferry_pos` VALUES (278, 2, 10, 102, -6413);
INSERT INTO `ferry_pos` VALUES (279, 3, 10, 103, -5039);
INSERT INTO `ferry_pos` VALUES (280, 4, 10, 104, -3791);
INSERT INTO `ferry_pos` VALUES (281, 5, 10, 105, -2429);
INSERT INTO `ferry_pos` VALUES (282, 6, 10, 106, -1164);
INSERT INTO `ferry_pos` VALUES (283, 7, 10, 107, 190);
INSERT INTO `ferry_pos` VALUES (284, 8, 10, 108, 1449);
INSERT INTO `ferry_pos` VALUES (285, 9, 10, 109, 2816);
INSERT INTO `ferry_pos` VALUES (286, 10, 10, 110, 4063);
INSERT INTO `ferry_pos` VALUES (287, 11, 10, 111, 6134);
INSERT INTO `ferry_pos` VALUES (288, 12, 10, 112, 7387);
INSERT INTO `ferry_pos` VALUES (289, 47, 11, 501, -7904);
INSERT INTO `ferry_pos` VALUES (290, 48, 11, 502, -7360);
INSERT INTO `ferry_pos` VALUES (291, 49, 11, 503, -6818);
INSERT INTO `ferry_pos` VALUES (292, 50, 11, 504, -6267);
INSERT INTO `ferry_pos` VALUES (293, 51, 11, 505, -5724);
INSERT INTO `ferry_pos` VALUES (294, 52, 11, 506, -5178);
INSERT INTO `ferry_pos` VALUES (295, 53, 11, 507, -4632);
INSERT INTO `ferry_pos` VALUES (296, 54, 11, 508, -4088);
INSERT INTO `ferry_pos` VALUES (297, 55, 11, 509, -3541);
INSERT INTO `ferry_pos` VALUES (298, 56, 11, 510, -2994);
INSERT INTO `ferry_pos` VALUES (299, 57, 11, 511, -2442);
INSERT INTO `ferry_pos` VALUES (300, 58, 11, 512, -1893);
INSERT INTO `ferry_pos` VALUES (301, 59, 11, 513, -1346);
INSERT INTO `ferry_pos` VALUES (302, 60, 11, 514, -807);
INSERT INTO `ferry_pos` VALUES (303, 61, 11, 515, -261);
INSERT INTO `ferry_pos` VALUES (304, 62, 11, 516, 262);
INSERT INTO `ferry_pos` VALUES (305, 63, 11, 517, 806);
INSERT INTO `ferry_pos` VALUES (306, 64, 11, 518, 1352);
INSERT INTO `ferry_pos` VALUES (307, 65, 11, 519, 1905);
INSERT INTO `ferry_pos` VALUES (308, 66, 11, 520, 2444);
INSERT INTO `ferry_pos` VALUES (309, 67, 11, 521, 2993);
INSERT INTO `ferry_pos` VALUES (310, 68, 11, 522, 3540);
INSERT INTO `ferry_pos` VALUES (311, 69, 11, 523, 4075);
INSERT INTO `ferry_pos` VALUES (312, 70, 11, 524, 4623);
INSERT INTO `ferry_pos` VALUES (313, 71, 11, 525, 5966);
INSERT INTO `ferry_pos` VALUES (314, 72, 11, 526, 6477);
INSERT INTO `ferry_pos` VALUES (315, 73, 11, 527, 7002);
INSERT INTO `ferry_pos` VALUES (316, 74, 11, 528, 7514);
INSERT INTO `ferry_pos` VALUES (317, 75, 11, 529, 0);
INSERT INTO `ferry_pos` VALUES (318, 76, 11, 530, 0);
INSERT INTO `ferry_pos` VALUES (319, 13, 11, 601, -4187);
INSERT INTO `ferry_pos` VALUES (320, 14, 11, 602, -2931);
INSERT INTO `ferry_pos` VALUES (321, 15, 11, 603, 2359);
INSERT INTO `ferry_pos` VALUES (322, 16, 11, 604, 3608);
INSERT INTO `ferry_pos` VALUES (323, 47, 12, 501, 0);
INSERT INTO `ferry_pos` VALUES (324, 48, 12, 502, 0);
INSERT INTO `ferry_pos` VALUES (325, 49, 12, 503, -6848);
INSERT INTO `ferry_pos` VALUES (326, 50, 12, 504, -6303);
INSERT INTO `ferry_pos` VALUES (327, 51, 12, 505, -5760);
INSERT INTO `ferry_pos` VALUES (328, 52, 12, 506, -5213);
INSERT INTO `ferry_pos` VALUES (329, 53, 12, 507, -4667);
INSERT INTO `ferry_pos` VALUES (330, 54, 12, 508, -4121);
INSERT INTO `ferry_pos` VALUES (331, 55, 12, 509, -3575);
INSERT INTO `ferry_pos` VALUES (332, 56, 12, 510, -3030);
INSERT INTO `ferry_pos` VALUES (333, 57, 12, 511, -2485);
INSERT INTO `ferry_pos` VALUES (334, 58, 12, 512, -1939);
INSERT INTO `ferry_pos` VALUES (335, 59, 12, 513, -1389);
INSERT INTO `ferry_pos` VALUES (336, 60, 12, 514, -818);
INSERT INTO `ferry_pos` VALUES (337, 61, 12, 515, -298);
INSERT INTO `ferry_pos` VALUES (338, 62, 12, 516, 248);
INSERT INTO `ferry_pos` VALUES (339, 63, 12, 517, 791);
INSERT INTO `ferry_pos` VALUES (340, 64, 12, 518, 1333);
INSERT INTO `ferry_pos` VALUES (341, 65, 12, 519, 1882);
INSERT INTO `ferry_pos` VALUES (342, 66, 12, 520, 2429);
INSERT INTO `ferry_pos` VALUES (343, 67, 12, 521, 2975);
INSERT INTO `ferry_pos` VALUES (344, 68, 12, 522, 3519);
INSERT INTO `ferry_pos` VALUES (345, 69, 12, 523, 4062);
INSERT INTO `ferry_pos` VALUES (346, 70, 12, 524, 4608);
INSERT INTO `ferry_pos` VALUES (347, 71, 12, 525, 5962);
INSERT INTO `ferry_pos` VALUES (348, 72, 12, 526, 6462);
INSERT INTO `ferry_pos` VALUES (349, 73, 12, 527, 6978);
INSERT INTO `ferry_pos` VALUES (350, 74, 12, 528, 7499);
INSERT INTO `ferry_pos` VALUES (351, 75, 12, 529, 8015);
INSERT INTO `ferry_pos` VALUES (352, 76, 12, 530, 8533);
INSERT INTO `ferry_pos` VALUES (353, 13, 12, 601, -4188);
INSERT INTO `ferry_pos` VALUES (354, 14, 12, 602, -2931);
INSERT INTO `ferry_pos` VALUES (355, 15, 12, 603, 2362);
INSERT INTO `ferry_pos` VALUES (356, 16, 12, 604, 3615);

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
  `oversize` bit(1) NULL DEFAULT NULL COMMENT '是否超限',
  `stack` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '垛数',
  `pieces` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '满砖数',
  `carriertype` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '运输车类型',
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `updatetime` datetime(0) NULL DEFAULT NULL,
  `minstack` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '最少托数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '品种' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 1, '1:800x800-A', 'A', 800, 800, b'0', 4, 50, 0, '测试', '2020-11-13 17:33:26', NULL);
INSERT INTO `goods` VALUES (3, 1, '1:800x800-B', 'B', 800, 800, b'0', 4, 50, 0, '测试', NULL, NULL);

-- ----------------------------
-- Table structure for rf_client
-- ----------------------------
DROP TABLE IF EXISTS `rf_client`;
CREATE TABLE `rf_client`  (
  `rfid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端唯一标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `conn_time` datetime(0) NULL DEFAULT NULL COMMENT '最近连接时间',
  `disconn_time` datetime(0) NULL DEFAULT NULL COMMENT '最近离线时间',
  PRIMARY KEY (`rfid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平板' ROW_FORMAT = Dynamic;

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
  `produce_time` datetime(0) NULL DEFAULT NULL COMMENT '生产时间',
  `pos` smallint(6) NULL DEFAULT NULL COMMENT '同轨道中的位置 1-100',
  `pos_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '砖在轨道的位置：顶部/中间/底部',
  `tilelifter_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '下砖机ID',
  `area` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '区域',
  `track_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '轨道类型',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sto_goods_id_fk`(`goods_id`) USING BTREE,
  INDEX `sto_track_id_fk`(`track_id`) USING BTREE,
  CONSTRAINT `sto_goods_id_fk` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sto_track_id_fk` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '库存' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock
-- ----------------------------
INSERT INTO `stock` VALUES (52, 1, 4, 80, 47, '2020-11-26 09:04:13', 0, 0, 2, 1, 3);
INSERT INTO `stock` VALUES (53, 3, 4, 80, 13, '2020-11-26 09:11:49', 0, 0, 5, 1, 0);
INSERT INTO `stock` VALUES (54, 1, 4, 100, 47, '2020-11-26 09:24:12', 1, 1, 3, 1, 3);
INSERT INTO `stock` VALUES (55, 1, 4, 120, 47, '2020-11-26 09:57:25', 2, 1, 1, 1, 3);
INSERT INTO `stock` VALUES (56, 3, 4, 120, 15, '2020-11-26 09:58:03', 1, 0, 4, 1, 0);
INSERT INTO `stock` VALUES (57, 1, 4, 120, 47, '2020-11-26 11:06:20', 3, 1, 2, 1, 3);
INSERT INTO `stock` VALUES (58, 3, 4, 120, 76, '2020-11-26 11:31:21', 2, 0, 5, 1, 3);
INSERT INTO `stock` VALUES (59, 3, 4, 120, 76, '2020-11-26 11:54:40', 3, 1, 4, 1, 3);
INSERT INTO `stock` VALUES (60, 1, 4, 120, 47, '2020-11-26 12:08:38', 4, 1, 3, 1, 3);
INSERT INTO `stock` VALUES (61, 3, 4, 120, 76, '2020-11-26 12:33:36', 4, 1, 5, 1, 3);
INSERT INTO `stock` VALUES (62, 1, 4, 120, 47, '2020-11-26 12:37:01', 5, 1, 1, 1, 3);
INSERT INTO `stock` VALUES (63, 3, 4, 120, 76, '2020-11-26 12:45:16', 5, 1, 6, 1, 3);
INSERT INTO `stock` VALUES (64, 1, 4, 120, 47, '2020-11-26 12:52:49', 6, 1, 2, 1, 3);
INSERT INTO `stock` VALUES (65, 3, 4, 120, 76, '2020-11-26 12:57:37', 6, 1, 4, 1, 3);
INSERT INTO `stock` VALUES (66, 1, 4, 120, 47, '2020-11-26 13:01:56', 7, 1, 3, 1, 3);
INSERT INTO `stock` VALUES (67, 3, 4, 120, 76, '2020-11-26 13:07:07', 7, 1, 5, 1, 3);
INSERT INTO `stock` VALUES (68, 3, 4, 120, 76, '2020-11-26 13:38:43', 8, 1, 5, 1, 3);
INSERT INTO `stock` VALUES (69, 3, 4, 120, 76, '2020-11-26 13:43:20', 9, 1, 4, 1, 3);
INSERT INTO `stock` VALUES (70, 3, 4, 120, 45, '2020-11-26 13:50:05', 0, 0, 6, 1, 2);
INSERT INTO `stock` VALUES (71, 1, 4, 120, 47, '2020-11-26 13:52:28', 8, 1, 3, 1, 3);
INSERT INTO `stock` VALUES (72, 1, 4, 80, 47, '2020-11-26 14:04:26', 9, 1, 0, 1, 3);
INSERT INTO `stock` VALUES (73, 1, 4, 160, 18, '2020-11-26 14:09:41', 0, 0, 2, 1, 2);
INSERT INTO `stock` VALUES (74, 1, 4, 160, 18, '2020-11-26 14:17:04', 1, 1, 2, 1, 2);
INSERT INTO `stock` VALUES (75, 3, 4, 160, 45, '2020-11-26 14:19:09', 1, 1, 6, 1, 2);
INSERT INTO `stock` VALUES (78, 3, 4, 160, 46, '2020-11-26 14:45:23', 0, 0, 4, 1, 2);
INSERT INTO `stock` VALUES (80, 1, 4, 160, 17, '2020-11-26 15:00:40', 0, 0, 3, 1, 2);
INSERT INTO `stock` VALUES (81, 3, 4, 160, 46, '2020-11-26 15:10:19', 1, 1, 5, 1, 2);
INSERT INTO `stock` VALUES (82, 3, 4, 160, 46, '2020-11-26 15:21:36', 2, 1, 6, 1, 2);
INSERT INTO `stock` VALUES (83, 3, 4, 160, 46, '2020-11-26 15:32:46', 3, 1, 4, 1, 2);
INSERT INTO `stock` VALUES (84, 1, 4, 160, 17, '2020-11-26 15:34:40', 1, 1, 2, 1, 2);
INSERT INTO `stock` VALUES (85, 3, 4, 160, 46, '2020-11-26 15:50:10', 4, 1, 5, 1, 2);
INSERT INTO `stock` VALUES (86, 1, 4, 160, 17, '2020-11-26 15:51:19', 2, 1, 3, 1, 2);
INSERT INTO `stock` VALUES (88, 3, 4, 160, 46, '2020-11-26 16:34:32', 5, 1, 4, 1, 2);
INSERT INTO `stock` VALUES (89, 3, 4, 160, 46, '2020-11-26 17:13:27', 6, 1, 6, 1, 2);
INSERT INTO `stock` VALUES (90, 3, 4, 160, 46, '2020-11-26 17:23:35', 7, 1, 5, 1, 2);
INSERT INTO `stock` VALUES (91, 1, 4, 160, 17, '2020-11-26 17:30:00', 3, 1, 1, 1, 2);
INSERT INTO `stock` VALUES (92, 1, 4, 160, 17, '2020-11-26 17:44:33', 4, 1, 3, 1, 2);
INSERT INTO `stock` VALUES (93, 1, 4, 200, 19, '2020-11-27 10:59:03', 0, 0, 0, 1, 2);
INSERT INTO `stock` VALUES (94, 3, 4, 80, 9, '2020-11-27 11:06:02', 0, 0, 5, 1, 1);
INSERT INTO `stock` VALUES (95, 1, 4, 80, 1, '2020-11-27 11:08:47', 0, 0, 1, 1, 1);

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
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '生产时间/消耗时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '库存出入记录' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '库存任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_trans
-- ----------------------------
INSERT INTO `stock_trans` VALUES (78, 0, 1, 1, 1, 52, 3, 17, 2, 9, 9, 14, '2020-11-26 09:04:13', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `stock_trans` VALUES (125, 0, 1, 1, 1, 95, 1, 20, 1, 9, NULL, 13, '2020-11-27 11:25:22', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tile_track
-- ----------------------------
DROP TABLE IF EXISTS `tile_track`;
CREATE TABLE `tile_track`  (
  `id` int(11) UNSIGNED NOT NULL COMMENT '砖机轨道',
  `tile_id` int(11) UNSIGNED NOT NULL COMMENT '砖机ID',
  `track_id` int(11) UNSIGNED NOT NULL,
  `order` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '优先级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for track
-- ----------------------------
DROP TABLE IF EXISTS `track`;
CREATE TABLE `track`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `area` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '区域：过滤作用',
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '类型',
  `stock_status` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '状态',
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
  `alert_status` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '故障状态',
  `alert_carrier` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '故障小车',
  `alert_trans` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '故障任务',
  `early_full` bit(1) NULL DEFAULT NULL COMMENT '提前满砖',
  `full_time` datetime(0) NULL DEFAULT NULL COMMENT '满砖时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '轨道' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of track
-- ----------------------------
INSERT INTO `track` VALUES (1, '101_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 101, 100, 0, 0, 0, NULL, 101, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (2, '102_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 102, 100, 0, 0, 0, NULL, 102, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (3, '103_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 103, 100, 0, 0, 0, NULL, 103, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (4, '104_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 104, 100, 0, 0, 0, NULL, 104, NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (5, '105_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 105, 100, 0, 0, 0, NULL, 105, NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (6, '106_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 106, 100, 0, 0, 0, NULL, 106, NULL, NULL, NULL, NULL, NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (7, '107_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 107, 100, 0, 0, 0, NULL, 107, NULL, NULL, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (8, '108_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 108, 100, 0, 0, 0, NULL, 108, NULL, NULL, NULL, NULL, NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (9, '109_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 109, 100, 0, 0, 0, NULL, 109, NULL, NULL, NULL, NULL, NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (10, '110_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 110, 100, 0, 0, 0, NULL, 110, NULL, NULL, NULL, NULL, NULL, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (11, '111_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 111, 100, 0, 0, 0, NULL, 111, NULL, NULL, NULL, NULL, NULL, 26, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (12, '112_下砖轨', 1, 1, 1, 1, 0, 0, 0, 0, 112, 100, 0, 0, 0, NULL, 112, NULL, NULL, NULL, NULL, NULL, 28, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (13, '601_上砖轨', 1, 0, 1, 1, 0, 0, 0, 601, 0, 100, 0, 0, 0, NULL, 601, NULL, NULL, NULL, NULL, NULL, 108, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (14, '602_上砖轨', 1, 0, 0, 1, 0, 0, 0, 602, 0, 100, 0, 0, 0, NULL, 602, NULL, NULL, NULL, NULL, NULL, 110, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (15, '603_上砖轨', 1, 0, 1, 1, 0, 0, 0, 603, 0, 100, 0, 0, 0, NULL, 603, NULL, NULL, NULL, NULL, NULL, 120, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (16, '604_上砖轨', 1, 0, 0, 1, 0, 0, 0, 604, 0, 100, 0, 0, 0, NULL, 604, NULL, NULL, NULL, NULL, NULL, 122, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (17, '201_储砖入轨', 1, 2, 2, 1, 700, 350, 350, 201, 0, 100, 47, 0, 18, NULL, 201, 301, NULL, NULL, NULL, NULL, 1, 1, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (18, '202_储砖入轨', 1, 2, 2, 1, 700, 350, 350, 202, 0, 100, 48, 17, 19, NULL, 202, 302, NULL, NULL, NULL, NULL, 2, 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (19, '203_储砖入轨', 1, 2, 2, 1, 700, 350, 350, 203, 0, 100, 49, 18, 20, NULL, 203, 303, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (20, '204_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 204, 0, 100, 50, 19, 21, NULL, 204, 304, NULL, NULL, NULL, NULL, 4, 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (21, '205_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 205, 0, 100, 51, 20, 22, NULL, 205, 305, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (22, '206_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 206, 0, 100, 52, 21, 23, NULL, 206, 306, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (23, '207_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 207, 0, 100, 53, 22, 24, NULL, 207, 307, NULL, NULL, NULL, NULL, 7, 1, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (24, '208_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 208, 0, 100, 54, 23, 25, NULL, 208, 308, NULL, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (25, '209_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 209, 0, 100, 55, 24, 26, NULL, 209, 309, NULL, NULL, NULL, NULL, 9, 1, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (26, '210_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 210, 0, 100, 56, 25, 27, NULL, 210, 310, NULL, NULL, NULL, NULL, 10, 1, 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (27, '211_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 211, 0, 100, 57, 26, 28, NULL, 211, 311, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (28, '212_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 212, 0, 100, 58, 27, 29, NULL, 212, 312, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (29, '213_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 213, 0, 100, 59, 28, 30, NULL, 213, 313, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (30, '214_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 214, 0, 100, 60, 29, 31, NULL, 214, 314, NULL, NULL, NULL, NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (31, '215_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 215, 0, 100, 61, 30, 32, NULL, 215, 315, NULL, NULL, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (32, '216_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 216, 0, 100, 62, 31, 33, NULL, 216, 316, NULL, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (33, '217_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 217, 0, 100, 63, 32, 34, NULL, 217, 317, NULL, NULL, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (34, '218_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 218, 0, 100, 64, 33, 35, NULL, 218, 318, NULL, NULL, NULL, NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (35, '219_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 219, 0, 100, 65, 34, 36, NULL, 219, 319, NULL, NULL, NULL, NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (36, '220_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 220, 0, 100, 66, 35, 37, NULL, 220, 320, NULL, NULL, NULL, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (37, '221_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 221, 0, 100, 67, 36, 38, NULL, 221, 321, NULL, NULL, NULL, NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (38, '222_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 222, 0, 100, 68, 37, 39, NULL, 222, 322, NULL, NULL, NULL, NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (39, '223_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 223, 0, 100, 69, 38, 40, NULL, 223, 323, NULL, NULL, NULL, NULL, 23, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (40, '224_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 224, 0, 100, 70, 39, 41, NULL, 224, 324, NULL, NULL, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (41, '225_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 225, 0, 100, 71, 40, 42, NULL, 225, 325, NULL, NULL, NULL, NULL, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (42, '226_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 226, 0, 100, 72, 41, 43, NULL, 226, 326, NULL, NULL, NULL, NULL, 26, 3, 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (43, '227_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 227, 0, 100, 73, 42, 44, NULL, 227, 327, NULL, NULL, NULL, NULL, 27, 3, 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (44, '228_储砖入轨', 1, 2, 0, 1, 700, 350, 350, 228, 0, 100, 74, 43, 45, NULL, 228, 328, NULL, NULL, NULL, NULL, 28, 3, 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (45, '229_储砖入轨', 1, 2, 1, 1, 700, 350, 350, 229, 0, 100, 75, 44, 46, NULL, 229, 329, NULL, NULL, NULL, NULL, 29, 3, 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (46, '230_储砖入轨', 1, 2, 1, 1, 700, 350, 350, 230, 0, 100, 76, 45, 0, NULL, 230, 330, NULL, NULL, NULL, NULL, 30, 3, 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (47, '501_储砖出轨', 1, 3, 2, 1, 700, 350, 350, 0, 501, 100, 17, 0, 48, NULL, 501, NULL, NULL, NULL, NULL, NULL, 101, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (48, '502_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 502, 100, 18, 47, 49, NULL, 502, NULL, NULL, NULL, NULL, NULL, 102, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (49, '503_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 503, 100, 19, 48, 50, NULL, 503, NULL, NULL, NULL, NULL, NULL, 103, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (50, '504_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 504, 100, 20, 49, 51, NULL, 504, NULL, NULL, NULL, NULL, NULL, 104, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (51, '505_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 505, 100, 21, 50, 52, NULL, 505, NULL, NULL, NULL, NULL, NULL, 105, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (52, '506_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 506, 100, 22, 51, 53, NULL, 506, NULL, NULL, NULL, NULL, NULL, 106, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (53, '507_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 507, 100, 23, 52, 54, NULL, 507, NULL, NULL, NULL, NULL, NULL, 107, 0, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (54, '508_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 508, 100, 24, 53, 55, NULL, 508, NULL, NULL, NULL, NULL, NULL, 108, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (55, '509_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 509, 100, 25, 54, 56, NULL, 509, NULL, NULL, NULL, NULL, NULL, 109, 1, 7, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (56, '510_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 510, 100, 26, 55, 57, NULL, 510, NULL, NULL, NULL, NULL, NULL, 110, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (57, '511_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 511, 100, 27, 56, 58, NULL, 511, NULL, NULL, NULL, NULL, NULL, 111, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (58, '512_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 512, 100, 28, 57, 59, NULL, 512, NULL, NULL, NULL, NULL, NULL, 112, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (59, '513_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 513, 100, 29, 58, 60, NULL, 513, NULL, NULL, NULL, NULL, NULL, 113, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (60, '514_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 514, 100, 30, 59, 61, NULL, 514, NULL, NULL, NULL, NULL, NULL, 114, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (61, '515_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 515, 100, 31, 60, 62, NULL, 515, NULL, NULL, NULL, NULL, NULL, 115, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (62, '516_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 516, 100, 32, 61, 63, NULL, 516, NULL, NULL, NULL, NULL, NULL, 116, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (63, '517_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 517, 100, 33, 62, 64, NULL, 517, NULL, NULL, NULL, NULL, NULL, 117, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (64, '518_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 518, 100, 34, 63, 65, NULL, 518, NULL, NULL, NULL, NULL, NULL, 118, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (65, '519_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 519, 100, 35, 64, 66, NULL, 519, NULL, NULL, NULL, NULL, NULL, 119, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (66, '520_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 520, 100, 36, 65, 67, NULL, 520, NULL, NULL, NULL, NULL, NULL, 120, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (67, '521_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 521, 100, 37, 66, 68, NULL, 521, NULL, NULL, NULL, NULL, NULL, 121, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (68, '522_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 522, 100, 38, 67, 69, NULL, 522, NULL, NULL, NULL, NULL, NULL, 122, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (69, '523_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 523, 100, 39, 68, 70, NULL, 523, NULL, NULL, NULL, NULL, NULL, 123, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (70, '524_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 524, 100, 40, 69, 71, NULL, 524, NULL, NULL, NULL, NULL, NULL, 124, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (71, '525_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 525, 100, 41, 70, 72, NULL, 525, NULL, NULL, NULL, NULL, NULL, 125, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (72, '526_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 526, 100, 42, 71, 73, NULL, 526, NULL, NULL, NULL, NULL, NULL, 126, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (73, '527_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 527, 100, 43, 72, 74, NULL, 527, NULL, NULL, NULL, NULL, NULL, 127, 0, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (74, '528_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 528, 100, 44, 73, 75, NULL, 528, NULL, NULL, NULL, NULL, NULL, 128, 0, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (75, '529_储砖出轨', 1, 3, 0, 1, 700, 350, 350, 0, 529, 100, 45, 74, 76, NULL, 529, NULL, NULL, NULL, NULL, NULL, 129, 2, 8, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (76, '530_储砖出轨', 1, 3, 1, 1, 700, 350, 350, 0, 530, 100, 46, 75, 0, NULL, 530, NULL, NULL, NULL, NULL, NULL, 130, 3, 8, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (77, 'B1_摆渡轨', 1, 5, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 701, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (78, 'B2_摆渡轨', 1, 5, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 702, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (79, 'B5_摆渡轨', 1, 6, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 741, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `track` VALUES (80, 'B6_摆渡轨', 1, 6, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, NULL, 742, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for track_log
-- ----------------------------
DROP TABLE IF EXISTS `track_log`;
CREATE TABLE `track_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标识',
  `track_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '轨道ID',
  `type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '日志类型 1空砖 2满砖',
  `dev_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '设备ID',
  `stock_count` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '库存数量',
  `log_time` datetime(0) NULL DEFAULT NULL COMMENT '日志时间',
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `area` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '区域',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '轨道空满记录' ROW_FORMAT = Dynamic;

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
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '报警时间',
  `resolvetime` datetime(0) NULL DEFAULT NULL COMMENT '解决时间',
  INDEX `w_createtime_idx`(`createtime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '报警' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warning
-- ----------------------------
INSERT INTO `warning` VALUES (892, 0, 0, b'0', 4, 0, 0, '下砖机A4: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (893, 0, 0, b'0', 2, 0, 0, '下砖机A2: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (894, 0, 0, b'0', 1, 0, 0, '下砖机A1: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (895, 0, 0, b'0', 3, 0, 0, '下砖机A3: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (896, 0, 0, b'0', 5, 0, 0, '下砖机A5: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (897, 0, 0, b'0', 6, 0, 0, '下砖机A6: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (898, 0, 0, b'0', 9, 0, 0, '摆渡车B1: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (900, 0, 0, b'0', 10, 0, 0, '摆渡车B2: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (899, 0, 0, b'0', 8, 0, 0, '上砖机D2: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (902, 0, 0, b'0', 7, 0, 0, '上砖机D1: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (901, 0, 0, b'0', 11, 0, 0, '摆渡车B5: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (904, 0, 0, b'0', 14, 0, 0, '运输车C2: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (903, 0, 0, b'0', 12, 0, 0, '摆渡车B6: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (905, 0, 0, b'1', 13, 0, 0, '运输车C1: 设备离线', '2020-12-04 04:48:52', '2020-12-06 15:44:29');
INSERT INTO `warning` VALUES (906, 0, 0, b'0', 15, 0, 0, '运输车C3: 设备离线', '2020-12-04 04:48:52', NULL);
INSERT INTO `warning` VALUES (907, 0, 0, b'0', 16, 0, 0, '运输车C4: 设备离线', '2020-12-04 04:48:53', NULL);
INSERT INTO `warning` VALUES (908, 0, 0, b'0', 17, 0, 0, '运输车C5: 设备离线', '2020-12-04 04:48:53', NULL);
INSERT INTO `warning` VALUES (909, 0, 0, b'0', 18, 0, 0, '运输车C6: 设备离线', '2020-12-04 04:48:53', NULL);

-- ----------------------------
-- Table structure for wcs_menu
-- ----------------------------
DROP TABLE IF EXISTS `wcs_menu`;
CREATE TABLE `wcs_menu`  (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `prior` smallint(3) NULL DEFAULT NULL COMMENT '优先级',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wcs_menu
-- ----------------------------
INSERT INTO `wcs_menu` VALUES (1, '基础菜单', 1, '无特殊权限，通用菜单');
INSERT INTO `wcs_menu` VALUES (2, '管理员菜单', 2, '现场管理员');
INSERT INTO `wcs_menu` VALUES (3, '超级管理员菜单', 3, '超级管理员菜单');
INSERT INTO `wcs_menu` VALUES (4, '原调度菜单', 1, '旧调度菜单配置');

-- ----------------------------
-- Table structure for wcs_menu_dtl
-- ----------------------------
DROP TABLE IF EXISTS `wcs_menu_dtl`;
CREATE TABLE `wcs_menu_dtl`  (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `menu_id` int(6) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `folder` bit(1) NULL DEFAULT NULL COMMENT '是否是文件夹',
  `folder_id` int(6) NULL DEFAULT NULL COMMENT '所属文件夹ID',
  `module_id` int(6) NULL DEFAULT NULL COMMENT '模块KEY',
  `order` smallint(3) NULL DEFAULT NULL,
  `rf` bit(1) NULL DEFAULT NULL COMMENT '是否是平板的',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wcs_menu_dtl
-- ----------------------------
INSERT INTO `wcs_menu_dtl` VALUES (1, 1, '任务', b'1', 0, 0, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (2, 0, '任务开关', b'0', 1, 3, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (3, 0, '任务状态', b'0', 1, 11, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (4, 1, '设备', b'1', 0, 0, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (5, 0, '砖机', b'0', 4, 6, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (6, 0, '摆渡车', b'0', 4, 4, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (7, 0, '运输车', b'0', 4, 5, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (8, 1, '轨道', b'1', 0, 7, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (9, 0, '轨道状态', b'0', 8, 7, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (10, 0, '库存修改', b'0', 8, 10, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (11, 1, '统计', b'1', 0, 0, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (12, 0, '轨道库存', b'0', 11, 15, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (13, 0, '警告信息', b'0', 11, 16, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (14, 0, '空满轨道', b'0', 11, 17, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (15, 1, '配置', b'1', 0, 0, 5, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (16, 0, '摆渡对位', b'0', 15, 13, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (17, 2, '任务', b'1', NULL, NULL, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (18, NULL, '任务开关', b'0', 17, 3, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (19, NULL, '任务状态', b'0', 17, 11, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (20, 2, '设备', b'1', NULL, NULL, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (21, NULL, '砖机', b'0', 20, 6, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (22, NULL, '摆渡车', b'0', 20, 4, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (23, NULL, '运输车', b'0', 20, 5, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (24, 2, '轨道', b'1', NULL, NULL, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (25, NULL, '轨道状态', b'0', 24, 7, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (26, NULL, '库存修改', b'0', 24, 10, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (27, 2, '统计', b'1', NULL, NULL, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (28, NULL, '轨道库存', b'0', 27, 15, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (29, NULL, '警告信息', b'0', 27, 16, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (30, NULL, '空满轨道', b'0', 27, 17, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (31, 2, '配置', b'1', NULL, NULL, 5, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (32, NULL, '摆渡对位', b'0', 31, 13, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (33, NULL, '区域配置', b'0', 31, 2, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (34, NULL, '轨道分配', b'0', 31, 14, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (35, NULL, '字典', b'0', 31, 29, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (36, NULL, '测可入砖', b'0', 31, 9, 5, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (37, NULL, '添加任务', b'0', 31, 12, 6, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (38, 2, '授权', b'1', NULL, NULL, 6, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (39, NULL, '用户', b'0', 38, 31, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (40, NULL, '菜单', b'0', 38, 30, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (41, 3, '任务', b'1', 0, 0, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (42, 0, '任务开关', b'0', 41, 3, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (43, 0, '任务状态', b'0', 41, 11, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (44, 3, '设备', b'1', 0, 0, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (45, 0, '砖机', b'0', 44, 6, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (46, 0, '摆渡车', b'0', 44, 4, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (47, 0, '运输车', b'0', 44, 5, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (48, 3, '轨道', b'1', 0, 0, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (49, 0, '轨道状态', b'0', 48, 7, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (50, 0, '库存修改', b'0', 48, 10, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (51, 3, '统计', b'1', 0, 0, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (52, 0, '轨道库存', b'0', 51, 15, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (53, 0, '警告信息', b'0', 51, 16, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (54, 0, '空满轨道', b'0', 51, 17, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (55, 3, '配置', b'1', 0, 0, 5, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (56, 0, '摆渡对位', b'0', 55, 13, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (57, 0, '区域配置', b'0', 55, 2, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (58, 0, '轨道分配', b'0', 55, 14, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (59, 0, '字典', b'0', 55, 29, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (60, 0, '测可入砖', b'0', 55, 9, 5, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (61, 0, '添加任务', b'0', 55, 12, 6, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (62, 3, '授权', b'1', 0, 0, 6, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (63, 0, '用户', b'0', 62, 31, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (64, 0, '菜单', b'0', 62, 30, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (65, 4, '主页', b'0', NULL, 1, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (66, 4, '任务', b'1', NULL, NULL, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (67, NULL, '开关', b'0', 66, 3, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (68, NULL, '任务', b'0', 66, 11, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (69, NULL, '按轨出库', b'0', 66, 18, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (70, 4, '设备', b'1', NULL, NULL, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (71, NULL, '砖机', b'0', 70, 6, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (72, NULL, '摆渡车', b'0', 70, 4, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (73, NULL, '运输车', b'0', 70, 5, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (74, NULL, '轨道', b'0', 70, 7, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (75, 4, '统计', b'1', NULL, NULL, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (76, NULL, '规格', b'0', 75, 8, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (77, NULL, '库存', b'0', 75, 15, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (78, NULL, '轨道', b'0', 75, 10, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (79, 4, '设置', b'1', NULL, NULL, 5, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (80, NULL, '轨道分配', b'0', 79, 14, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (81, NULL, '摆渡对位', b'0', 79, 13, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (82, NULL, '区域配置', b'0', 79, 2, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (83, NULL, '字典', b'0', 79, 29, 4, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (84, NULL, '测可入砖', b'0', 79, 9, 5, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (85, 4, '记录', b'1', NULL, NULL, 6, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (86, NULL, '警告', b'0', 85, 16, 1, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (87, NULL, '空满轨道', b'0', 85, 17, 2, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (88, 0, '设备及轨道', b'0', 15, 2, 3, NULL);
INSERT INTO `wcs_menu_dtl` VALUES (89, 0, '规格编号', b'0', 15, 8, 1, NULL);

-- ----------------------------
-- Table structure for wcs_module
-- ----------------------------
DROP TABLE IF EXISTS `wcs_module`;
CREATE TABLE `wcs_module`  (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模块名称',
  `type` tinyint(3) NULL DEFAULT NULL COMMENT '类型：PC, RF, 电视..',
  `key` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模块对应界面key',
  `entity` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平板-模块类名',
  `brush` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `geometry` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Tab图标',
  `winctlname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'PC调度界面文件名',
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wcs_module
-- ----------------------------
INSERT INTO `wcs_module` VALUES (1, '主页', 0, 'Home', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'HomeCtl', '启动调度自动打开');
INSERT INTO `wcs_module` VALUES (2, '区域', 0, 'Area', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'AreaCtl', '配置砖机/摆渡车轨道');
INSERT INTO `wcs_module` VALUES (3, '开关', 0, 'AreaSwitch', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'AreaSwitchCtl', '任务开关控制');
INSERT INTO `wcs_module` VALUES (4, '摆渡车', 0, 'Ferry', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'FerryCtl', '摆渡车详细状态信息');
INSERT INTO `wcs_module` VALUES (5, '运输车', 0, 'Carrier', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'CarrierCtl', '运输车详细状态信息');
INSERT INTO `wcs_module` VALUES (6, '上下砖机', 0, 'TileLifter', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'TileLifterCtl', '上下砖机详细状态信息');
INSERT INTO `wcs_module` VALUES (7, '轨道信息', 0, 'Track', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'TrackCtl', '轨道状态信息');
INSERT INTO `wcs_module` VALUES (8, '规格', 0, 'Goods', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'GoodsCtl', '规格详细信息');
INSERT INTO `wcs_module` VALUES (9, '测可入砖', 0, 'TestGood', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'TestGoodCtl', '测试轨道是否可以放指定的砖');
INSERT INTO `wcs_module` VALUES (10, '轨道库存', 0, 'Stock', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'StockCtl', '单一轨道库存的详细信息');
INSERT INTO `wcs_module` VALUES (11, '任务', 0, 'Trans', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'TransCtl', '调度设备的任务信息,状态');
INSERT INTO `wcs_module` VALUES (12, '添加任务', 0, 'AddManualTrans', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'AddManualTransCtl', '手动添加任务');
INSERT INTO `wcs_module` VALUES (13, '摆渡对位', 0, 'FerryPos', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'FerryPosCtl', '摆渡车对位，复位');
INSERT INTO `wcs_module` VALUES (14, '轨道分配', 0, 'TrackAllocate', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'TrackAllocateCtl', '查看砖机选定规格的轨道分配');
INSERT INTO `wcs_module` VALUES (15, '库存', 0, 'StockSum', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'StockSumCtl', '所有轨道的库存列表信息');
INSERT INTO `wcs_module` VALUES (16, '警告', 0, 'WarnLog', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'WarnLogCtl', '警告详细信息记录');
INSERT INTO `wcs_module` VALUES (17, '空满轨道', 0, 'TrackLog', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'TrackLogCtl', '轨道空满轨道信息记录');
INSERT INTO `wcs_module` VALUES (18, '按轨出库', 0, 'TileTrack', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'TileTrackCtl', '上砖机按轨道上砖使用');
INSERT INTO `wcs_module` VALUES (19, '品种设置', 1, 'RFGOODTYPESETTING', 'com.keda.wcsfixplatformapp.screen.rfgood.RfGoodMainScreen', '', 'goodstype.png', '', '平板-品种查看/添加');
INSERT INTO `wcs_module` VALUES (20, '轨道设置', 1, 'RFTRACK', 'com.keda.wcsfixplatformapp.screen.rftrack.RfTrackScreen', '', 'assignment.png', '', '平板-轨道查看/修改状态');
INSERT INTO `wcs_module` VALUES (21, '砖机规格', 1, 'RFTILEGOOD', 'com.keda.wcsfixplatformapp.screen.rftilegood.RfTileGoodScreen', '', 'updowndev.png', '', '平板-砖机规格查看/修改');
INSERT INTO `wcs_module` VALUES (22, '任务开关', 1, 'RFTASKSWITCH', 'com.keda.wcsfixplatformapp.screen.rfswitch.RfSwitchScreen', '', 'othersetting.png', '', '平板-区域任务开关控制');
INSERT INTO `wcs_module` VALUES (23, '摆渡车状态', 1, 'RFDEVFERRY', 'com.keda.wcsfixplatformapp.screen.rfferry.RfFerryScreen', '', 'othersetting.png', '', '平板-摆渡车详细状态');
INSERT INTO `wcs_module` VALUES (24, '运输车状态', 1, 'RFDEVCARRIER', 'com.keda.wcsfixplatformapp.screen.rfdevcarrier.RfDevCarrierScreen', '', 'shiftcar.png', '', '平板-运输车详细状态');
INSERT INTO `wcs_module` VALUES (25, '砖机状态', 1, 'RFDEVTILELIFTER', 'com.keda.wcsfixplatformapp.screen.rftilelifter.RfTileLifterScreen', '', 'assignment.png', '', '平板-砖机详细状态');
INSERT INTO `wcs_module` VALUES (26, '轨道库存', 1, 'RFTRACKSTOCK', 'com.keda.wcsfixplatformapp.screen.rftrackstock.RfTrackStockScreen', '', 'assignment.png', '', '平板-单一轨道库存查看/添加/删除');
INSERT INTO `wcs_module` VALUES (27, '任务信息', 1, 'RFSTOCKTRANS', 'com.keda.wcsfixplatformapp.screen.rftrans.RfTransScreen', '', 'updowndev.png', '', '平板-任务查看/操作');
INSERT INTO `wcs_module` VALUES (28, '按轨上砖', 1, 'RFTILETRACK', 'com.keda.wcsfixplatformapp.screen.rftiletrack.RfTileTrackScreen', '', 'updowndev.png', '', '平板-上砖机按轨道上砖');
INSERT INTO `wcs_module` VALUES (29, '字典', 0, 'Diction', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'DictionCtl', '字典值查看');
INSERT INTO `wcs_module` VALUES (30, '菜单', 0, 'Menu', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'MenuCtl', 'PC调度菜单配置修改');
INSERT INTO `wcs_module` VALUES (31, '用户', 0, 'User', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'UserCtl', 'PC调度用户配置');
INSERT INTO `wcs_module` VALUES (32, '摆渡车对位', 1, 'RFARFTRACK', 'com.keda.wcsfixplatformapp.screen.rfferrypose.RfFerryPosScreen', '', 'arttoposition.png', NULL, '平板-摆渡车对位');

-- ----------------------------
-- Table structure for wcs_role
-- ----------------------------
DROP TABLE IF EXISTS `wcs_role`;
CREATE TABLE `wcs_role`  (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `admin` bit(1) NULL DEFAULT NULL COMMENT '是否是管理员角色',
  `menu_id` int(6) NULL DEFAULT NULL COMMENT '菜单',
  `prior` tinyint(3) NULL DEFAULT NULL COMMENT '优先级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wcs_role
-- ----------------------------
INSERT INTO `wcs_role` VALUES (1, '普通角色', b'0', 1, 1);
INSERT INTO `wcs_role` VALUES (2, '管理人员', b'0', 2, 2);
INSERT INTO `wcs_role` VALUES (3, '超级管理员', b'1', 3, 100);

-- ----------------------------
-- Table structure for wcs_user
-- ----------------------------
DROP TABLE IF EXISTS `wcs_user`;
CREATE TABLE `wcs_user`  (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `memo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role_id` int(6) NULL DEFAULT NULL COMMENT '角色ID',
  `exitwcs` bit(1) NULL DEFAULT NULL COMMENT '能否退出调度',
  `guest` bit(1) NULL DEFAULT NULL COMMENT '默认登陆用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wcs_user
-- ----------------------------
INSERT INTO `wcs_user` VALUES (1, '123', '123', '金凯瑞', '一般操作', 1, b'1', b'1');
INSERT INTO `wcs_user` VALUES (2, 'admin', 'admin', '管理员', '', 2, b'1', b'0');
INSERT INTO `wcs_user` VALUES (3, 'supervisor', 'supervisor', '超级管理员', '', 100, b'1', b'0');

-- ----------------------------
-- View structure for active_dev
-- ----------------------------
DROP VIEW IF EXISTS `active_dev`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `active_dev` AS select `t`.`id` AS `id`,`t`.`name` AS `name`,`t`.`ip` AS `ip`,`t`.`port` AS `port`,`t`.`type` AS `type`,`t`.`type2` AS `type2`,`t`.`enable` AS `enable`,`t`.`att1` AS `att1`,`t`.`att2` AS `att2`,`t`.`goods_id` AS `goods_id`,`t`.`left_track_id` AS `left_track_id`,`t`.`right_track_id` AS `right_track_id`,`t`.`brother_dev_id` AS `brother_dev_id`,`t`.`strategy_in` AS `strategy_in`,`t`.`strategy_out` AS `strategy_out`,`t`.`memo` AS `memo` from `device` `t` where (`t`.`enable` = 1);

-- ----------------------------
-- View structure for stock_sum
-- ----------------------------
DROP VIEW IF EXISTS `stock_sum`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `stock_sum` AS select `t`.`goods_id` AS `goods_id`,`t`.`track_id` AS `track_id`,min(`t`.`produce_time`) AS `produce_time`,count(`t`.`id`) AS `count`,sum(`t`.`pieces`) AS `pieces`,sum(`t`.`stack`) AS `stack`,`t`.`area` AS `area`,`t`.`track_type` AS `track_type` from `stock` `t` where (`t`.`track_type` in (2,3,4)) group by `t`.`track_id`,`t`.`goods_id` order by `t`.`area`,`t`.`goods_id`,`produce_time`,`t`.`track_id`;

-- ----------------------------
-- Procedure structure for DELETE_DATA
-- ----------------------------
DROP PROCEDURE IF EXISTS `DELETE_DATA`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DELETE_DATA`()
BEGIN
	/*仅保留 16 天的报警数据*/
	delete from warning where resolve = 1 and DATEDIFF(CURRENT_DATE,createtime) >= 16;
	/*仅保留 16 天的任务数据*/
	delete from stock_trans where (finish = 1 or cancel = 1) and DATEDIFF(CURRENT_DATE,create_time) >= 16;
	/*仅保留 16 天的记录数据*/
	delete from stock_log where DATEDIFF(CURRENT_DATE,create_time) >= 16;
	delete from track_log where DATEDIFF(CURRENT_DATE,log_time) >= 16;
	/*仅保留 16 天的平板数据*/
	delete from rf_client where DATEDIFF(CURRENT_DATE,disconn_time) >= 16;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for DELETE_EVEN
-- ----------------------------
DROP EVENT IF EXISTS `DELETE_EVEN`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` EVENT `DELETE_EVEN`
ON SCHEDULE
EVERY '1' DAY STARTS '2020-10-02 01:00:00'
DO CALL DELETE_DATA()
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
