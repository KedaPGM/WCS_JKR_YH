/*
 Navicat Premium Data Transfer

 Source Server         : TEST
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : 2021_wcs_jy_yh

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 01/06/2021 13:37:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for traffic_control
-- ----------------------------
DROP TABLE IF EXISTS `traffic_control`;
CREATE TABLE `traffic_control`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `area` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '区域',
  `traffic_control_type` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '交管类型',
  `restricted_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '被交管 设备ID',
  `control_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '交管 设备ID',
  `traffic_control_status` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '交管状态（0：交管中，1：已完成）',
  `from_track_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '交管起始轨道ID',
  `from_point` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '交管起始点位',
  `from_site` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '交管起始坐标',
  `to_track_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '交管结束轨道ID',
  `to_point` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '交管结束点位',
  `to_site` smallint(5) UNSIGNED NULL DEFAULT NULL COMMENT '交管结束坐标',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_create_time_index`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '交管表' ROW_FORMAT = Dynamic;

INSERT INTO `diction_dtl`(`id`, `diction_id`, `code`, `name`, `int_value`, `bool_value`, `string_value`, `double_value`, `uint_value`, `order`, `updatetime`) VALUES (8, 1, 'NewTrafficCtlId', '生成交管ID', NULL, NULL, '', NULL, 1, NULL, NULL);

INSERT INTO `diction_dtl`(`id`, `diction_id`, `code`, `name`, `int_value`, `bool_value`, `string_value`, `double_value`, `uint_value`, `order`, `updatetime`) VALUES (9, 3, 'FerryNoLocation', '摆渡车失去位置信息', NULL, NULL, '摆渡车失去位置信息，为安全起见已停止所有任务及指令的执行，待恢复位置信息后再继续作业，请检查设备！', NULL, NULL, NULL, NULL);


SET FOREIGN_KEY_CHECKS = 1;
