/*
 Navicat Premium Data Transfer

 Source Server         : TEST
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : 2020_wcs_jkr_bzq

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 16/12/2020 12:50:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wcs_menu_dtl
-- ----------------------------
INSERT INTO `wcs_menu_dtl` VALUES (1, 1, '任务', b'1', 0, 0, 1);
INSERT INTO `wcs_menu_dtl` VALUES (2, 0, '任务开关', b'0', 1, 3, 1);
INSERT INTO `wcs_menu_dtl` VALUES (3, 0, '任务状态', b'0', 1, 11, 2);
INSERT INTO `wcs_menu_dtl` VALUES (4, 1, '设备', b'1', 0, 0, 2);
INSERT INTO `wcs_menu_dtl` VALUES (5, 0, '砖机', b'0', 4, 6, 1);
INSERT INTO `wcs_menu_dtl` VALUES (6, 0, '摆渡车', b'0', 4, 4, 2);
INSERT INTO `wcs_menu_dtl` VALUES (7, 0, '运输车', b'0', 4, 5, 3);
INSERT INTO `wcs_menu_dtl` VALUES (8, 1, '轨道', b'1', 0, 7, 3);
INSERT INTO `wcs_menu_dtl` VALUES (9, 0, '轨道状态', b'0', 8, 7, 1);
INSERT INTO `wcs_menu_dtl` VALUES (10, 0, '库存修改', b'0', 8, 10, 2);
INSERT INTO `wcs_menu_dtl` VALUES (11, 1, '统计', b'1', 0, 0, 4);
INSERT INTO `wcs_menu_dtl` VALUES (12, 0, '轨道库存', b'0', 11, 15, 1);
INSERT INTO `wcs_menu_dtl` VALUES (13, 0, '警告信息', b'0', 11, 16, 2);
INSERT INTO `wcs_menu_dtl` VALUES (14, 0, '空满轨道', b'0', 11, 17, 3);
INSERT INTO `wcs_menu_dtl` VALUES (15, 1, '配置', b'1', 0, 0, 5);
INSERT INTO `wcs_menu_dtl` VALUES (16, 0, '摆渡对位', b'0', 15, 13, 2);
INSERT INTO `wcs_menu_dtl` VALUES (17, 2, '任务', b'1', NULL, NULL, 1);
INSERT INTO `wcs_menu_dtl` VALUES (18, NULL, '任务开关', b'0', 17, 3, 1);
INSERT INTO `wcs_menu_dtl` VALUES (19, NULL, '任务状态', b'0', 17, 11, 2);
INSERT INTO `wcs_menu_dtl` VALUES (20, 2, '设备', b'1', NULL, NULL, 2);
INSERT INTO `wcs_menu_dtl` VALUES (21, NULL, '砖机', b'0', 20, 6, 1);
INSERT INTO `wcs_menu_dtl` VALUES (22, NULL, '摆渡车', b'0', 20, 4, 2);
INSERT INTO `wcs_menu_dtl` VALUES (23, NULL, '运输车', b'0', 20, 5, 3);
INSERT INTO `wcs_menu_dtl` VALUES (24, 2, '轨道', b'1', NULL, NULL, 3);
INSERT INTO `wcs_menu_dtl` VALUES (25, NULL, '轨道状态', b'0', 24, 7, 1);
INSERT INTO `wcs_menu_dtl` VALUES (26, NULL, '库存修改', b'0', 24, 10, 2);
INSERT INTO `wcs_menu_dtl` VALUES (27, 2, '统计', b'1', NULL, NULL, 4);
INSERT INTO `wcs_menu_dtl` VALUES (28, NULL, '轨道库存', b'0', 27, 15, 1);
INSERT INTO `wcs_menu_dtl` VALUES (29, NULL, '警告信息', b'0', 27, 16, 2);
INSERT INTO `wcs_menu_dtl` VALUES (30, NULL, '空满轨道', b'0', 27, 17, 3);
INSERT INTO `wcs_menu_dtl` VALUES (31, 2, '配置', b'1', NULL, NULL, 5);
INSERT INTO `wcs_menu_dtl` VALUES (32, NULL, '摆渡对位', b'0', 31, 13, 1);
INSERT INTO `wcs_menu_dtl` VALUES (33, NULL, '区域配置', b'0', 31, 2, 2);
INSERT INTO `wcs_menu_dtl` VALUES (34, NULL, '轨道分配', b'0', 31, 14, 3);
INSERT INTO `wcs_menu_dtl` VALUES (35, NULL, '字典', b'0', 31, 29, 4);
INSERT INTO `wcs_menu_dtl` VALUES (36, NULL, '测可入砖', b'0', 31, 9, 5);
INSERT INTO `wcs_menu_dtl` VALUES (37, NULL, '添加任务', b'0', 31, 12, 6);
INSERT INTO `wcs_menu_dtl` VALUES (38, 2, '授权', b'1', NULL, NULL, 6);
INSERT INTO `wcs_menu_dtl` VALUES (39, NULL, '用户', b'0', 38, 31, 1);
INSERT INTO `wcs_menu_dtl` VALUES (40, NULL, '菜单', b'0', 38, 30, 2);
INSERT INTO `wcs_menu_dtl` VALUES (41, 3, '任务', b'1', 0, 0, 1);
INSERT INTO `wcs_menu_dtl` VALUES (42, 0, '任务开关', b'0', 41, 3, 1);
INSERT INTO `wcs_menu_dtl` VALUES (43, 0, '任务状态', b'0', 41, 11, 2);
INSERT INTO `wcs_menu_dtl` VALUES (44, 3, '设备', b'1', 0, 0, 2);
INSERT INTO `wcs_menu_dtl` VALUES (45, 0, '砖机', b'0', 44, 6, 1);
INSERT INTO `wcs_menu_dtl` VALUES (46, 0, '摆渡车', b'0', 44, 4, 2);
INSERT INTO `wcs_menu_dtl` VALUES (47, 0, '运输车', b'0', 44, 5, 3);
INSERT INTO `wcs_menu_dtl` VALUES (48, 3, '轨道', b'1', 0, 0, 3);
INSERT INTO `wcs_menu_dtl` VALUES (49, 0, '轨道状态', b'0', 48, 7, 1);
INSERT INTO `wcs_menu_dtl` VALUES (50, 0, '库存修改', b'0', 48, 10, 2);
INSERT INTO `wcs_menu_dtl` VALUES (51, 3, '统计', b'1', 0, 0, 4);
INSERT INTO `wcs_menu_dtl` VALUES (52, 0, '轨道库存', b'0', 51, 15, 1);
INSERT INTO `wcs_menu_dtl` VALUES (53, 0, '警告信息', b'0', 51, 16, 2);
INSERT INTO `wcs_menu_dtl` VALUES (54, 0, '空满轨道', b'0', 51, 17, 3);
INSERT INTO `wcs_menu_dtl` VALUES (55, 3, '配置', b'1', 0, 0, 5);
INSERT INTO `wcs_menu_dtl` VALUES (56, 0, '摆渡对位', b'0', 55, 13, 1);
INSERT INTO `wcs_menu_dtl` VALUES (57, 0, '区域配置', b'0', 55, 2, 2);
INSERT INTO `wcs_menu_dtl` VALUES (58, 0, '轨道分配', b'0', 55, 14, 3);
INSERT INTO `wcs_menu_dtl` VALUES (59, 0, '字典', b'0', 55, 29, 4);
INSERT INTO `wcs_menu_dtl` VALUES (60, 0, '测可入砖', b'0', 55, 9, 5);
INSERT INTO `wcs_menu_dtl` VALUES (61, 0, '添加任务', b'0', 55, 12, 6);
INSERT INTO `wcs_menu_dtl` VALUES (62, 3, '授权', b'1', 0, 0, 6);
INSERT INTO `wcs_menu_dtl` VALUES (63, 0, '用户', b'0', 62, 31, 1);
INSERT INTO `wcs_menu_dtl` VALUES (64, 0, '菜单', b'0', 62, 30, 2);
INSERT INTO `wcs_menu_dtl` VALUES (65, 4, '主页', b'0', NULL, 1, 1);
INSERT INTO `wcs_menu_dtl` VALUES (66, 4, '任务', b'1', NULL, NULL, 2);
INSERT INTO `wcs_menu_dtl` VALUES (67, NULL, '开关', b'0', 66, 3, 1);
INSERT INTO `wcs_menu_dtl` VALUES (68, NULL, '任务', b'0', 66, 11, 2);
INSERT INTO `wcs_menu_dtl` VALUES (69, NULL, '按轨出库', b'0', 66, 18, 3);
INSERT INTO `wcs_menu_dtl` VALUES (70, 4, '设备', b'1', NULL, NULL, 3);
INSERT INTO `wcs_menu_dtl` VALUES (71, NULL, '砖机', b'0', 70, 6, 1);
INSERT INTO `wcs_menu_dtl` VALUES (72, NULL, '摆渡车', b'0', 70, 4, 2);
INSERT INTO `wcs_menu_dtl` VALUES (73, NULL, '运输车', b'0', 70, 5, 3);
INSERT INTO `wcs_menu_dtl` VALUES (74, NULL, '轨道', b'0', 70, 7, 4);
INSERT INTO `wcs_menu_dtl` VALUES (75, 4, '统计', b'1', NULL, NULL, 4);
INSERT INTO `wcs_menu_dtl` VALUES (76, NULL, '规格', b'0', 75, 8, 1);
INSERT INTO `wcs_menu_dtl` VALUES (77, NULL, '库存', b'0', 75, 15, 2);
INSERT INTO `wcs_menu_dtl` VALUES (78, NULL, '轨道', b'0', 75, 10, 3);
INSERT INTO `wcs_menu_dtl` VALUES (79, 4, '设置', b'1', NULL, NULL, 5);
INSERT INTO `wcs_menu_dtl` VALUES (80, NULL, '轨道分配', b'0', 79, 14, 1);
INSERT INTO `wcs_menu_dtl` VALUES (81, NULL, '摆渡对位', b'0', 79, 13, 2);
INSERT INTO `wcs_menu_dtl` VALUES (82, NULL, '区域配置', b'0', 79, 2, 3);
INSERT INTO `wcs_menu_dtl` VALUES (83, NULL, '字典', b'0', 79, 29, 4);
INSERT INTO `wcs_menu_dtl` VALUES (84, NULL, '测可入砖', b'0', 79, 9, 5);
INSERT INTO `wcs_menu_dtl` VALUES (85, 4, '记录', b'1', NULL, NULL, 6);
INSERT INTO `wcs_menu_dtl` VALUES (86, NULL, '警告', b'0', 85, 16, 1);
INSERT INTO `wcs_menu_dtl` VALUES (87, NULL, '空满轨道', b'0', 85, 17, 2);
INSERT INTO `wcs_menu_dtl` VALUES (88, 0, '设备及轨道', b'0', 15, 2, 3);
INSERT INTO `wcs_menu_dtl` VALUES (89, 0, '规格编号', b'0', 15, 8, 1);

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
INSERT INTO `wcs_module` VALUES (19, '品种设置', 1, 'RFGOODTYPESETTING', 'com.keda.wcsfixplatformapp.screen.rfgood.RfGoodMainScreen', '', '', '', '平板-品种查看/添加');
INSERT INTO `wcs_module` VALUES (20, '轨道设置', 1, 'RFTRACK', 'com.keda.wcsfixplatformapp.screen.rftrack.RfTrackScreen', '', '', '', '平板-轨道查看/修改状态');
INSERT INTO `wcs_module` VALUES (21, '砖机规格', 1, 'RFTILEGOOD', 'com.keda.wcsfixplatformapp.screen.rftilegood.RfTileGoodScreen', '', '', '', '平板-砖机规格查看/修改');
INSERT INTO `wcs_module` VALUES (22, '任务开关', 1, 'RFTASKSWITCH', 'com.keda.wcsfixplatformapp.screen.rfswitch.RfSwitchScreen', '', '', '', '平板-区域任务开关控制');
INSERT INTO `wcs_module` VALUES (23, '摆渡车状态', 1, 'RFDEVFERRY', 'com.keda.wcsfixplatformapp.screen.rfferry.RfFerryScreen', '', '', '', '平板-摆渡车详细状态');
INSERT INTO `wcs_module` VALUES (24, '运输车状态', 1, 'RFDEVCARRIER', 'com.keda.wcsfixplatformapp.screen.rfdevcarrier.RfDevCarrierScreen', '', '', '', '平板-运输车详细状态');
INSERT INTO `wcs_module` VALUES (25, '砖机状态', 1, 'RFDEVTILELIFTER', 'com.keda.wcsfixplatformapp.screen.rftilelifter.RfTileLifterScreen', '', '', '', '平板-砖机详细状态');
INSERT INTO `wcs_module` VALUES (26, '轨道库存', 1, 'RFTRACKSTOCK', 'com.keda.wcsfixplatformapp.screen.rftrackstock.RfTrackStockScreen', '', '', '', '平板-单一轨道库存查看/添加/删除');
INSERT INTO `wcs_module` VALUES (27, '任务信息', 1, 'RFSTOCKTRANS', 'com.keda.wcsfixplatformapp.screen.rftrans.RfTransScreen', '', '', '', '平板-任务查看/操作');
INSERT INTO `wcs_module` VALUES (28, '按轨上砖', 1, 'RFTILETRACK', 'com.keda.wcsfixplatformapp.screen.rftiletrack.RfTileTrackScreen', '', '', '', '平板-上砖机按轨道上砖');
INSERT INTO `wcs_module` VALUES (29, '字典', 0, 'Diction', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'DictionCtl', '字典值查看');
INSERT INTO `wcs_module` VALUES (30, '菜单', 0, 'Menu', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'MenuCtl', 'PC调度菜单配置修改');
INSERT INTO `wcs_module` VALUES (31, '用户', 0, 'User', '', 'DarkPrimaryBrush', 'ConfigGeometry', 'UserCtl', 'PC调度用户配置');

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
-- Other
-- ----------------------------

INSERT INTO diction(`id`, `type`, `valuetype`, `name`, `isadd`, `isedit`, `isdelete`, `authorizelevel`) VALUES (6, 0, 4, '版本信息', b'0', b'0', b'0', 1);
INSERT INTO diction(`id`, `type`, `valuetype`, `name`, `isadd`, `isedit`, `isdelete`, `authorizelevel`) VALUES (7, 0, 0, '转产差值', b'1', b'1', b'1', 1);

INSERT INTO diction_dtl(`id`, `diction_id`, `code`, `name`, `int_value`, `bool_value`, `string_value`, `double_value`, `uint_value`, `order`, `updatetime`) VALUES (57, 4, 'PDA_INIT_VERSION', 'PDA基础字典版本', 1, NULL, '', NULL, NULL, NULL, NULL);
INSERT INTO diction_dtl(`id`, `diction_id`, `code`, `name`, `int_value`, `bool_value`, `string_value`, `double_value`, `uint_value`, `order`, `updatetime`) VALUES (58, 4, 'PDA_GOOD_VERSION', 'PDA规格字典版本', 1, NULL, '', NULL, NULL, NULL, NULL);
INSERT INTO diction_dtl(`id`, `diction_id`, `code`, `name`, `int_value`, `bool_value`, `string_value`, `double_value`, `uint_value`, `order`, `updatetime`) VALUES (59, 7, 'TileLifterShiftCount', '下砖机转产差值(层数)', 99, NULL, NULL, NULL, NULL, NULL, NULL);


ALTER TABLE device ADD COLUMN old_goodid int(11) UNSIGNED NULL COMMENT '上一个品种';
ALTER TABLE device ADD COLUMN pre_goodid int(11) UNSIGNED NULL DEFAULT NULL COMMENT '预设品种';
ALTER TABLE device ADD COLUMN last_track_id int(11) UNSIGNED NULL DEFAULT NULL COMMENT '砖机上次作业轨道';
ALTER TABLE device ADD COLUMN do_shift bit(1) NULL DEFAULT NULL COMMENT '开启转产';
ALTER TABLE device ADD COLUMN left_goods tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '左轨道品种';
ALTER TABLE device ADD COLUMN right_goods tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '右轨道品种';

update device set old_goodid = 0, pre_goodid = 0, last_track_id = 0, do_shift = 0, left_goods = 0, right_goods = 0;


SET FOREIGN_KEY_CHECKS = 1;
