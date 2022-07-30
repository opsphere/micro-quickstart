-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: 10.60.79.233    Database: mc_message
-- ------------------------------------------------------
-- Server version	5.7.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mc_message` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
use mc_message;

--
-- Table structure for table `msg_message_detail`
--

DROP TABLE IF EXISTS msg_message_detail;
CREATE TABLE `msg_message_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT '消息类型',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息等级',
  `method` varchar(100) NOT NULL DEFAULT '' COMMENT '消息形式',
  `source` varchar(200) NOT NULL DEFAULT '' COMMENT '来源',
  `title` varchar(128) NOT NULL DEFAULT '' COMMENT '消息标题',
  `receivers` varchar(500) NOT NULL DEFAULT '' COMMENT '接收者',
  `content` text COMMENT '消息内容',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_msg_message_detail_delete_at` (`delete_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息详情表';

DROP TABLE IF EXISTS msg_message_receiver;
CREATE TABLE `msg_message_receiver` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `message_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '消息id',
  `task_id` varchar(100) NOT NULL DEFAULT '' COMMENT '任务id',
  `domain` varchar(100) NOT NULL DEFAULT '' COMMENT '主体',
  `method` varchar(32) NOT NULL DEFAULT '' COMMENT '消息形式',
  `receiver` varchar(200) NOT NULL DEFAULT '' COMMENT '接收者',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态:0-未发送,1-发送失败,2-未读,3-已读,4-删除',
  `result` varchar(300) NOT NULL DEFAULT '' COMMENT 'result',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `delete_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_msg_message_receiver_message_id` (`message_id`),
  KEY `idx_msg_message_receiver_task_id` (`task_id`),
  KEY `idx_msg_message_receiver_domain` (`domain`),
  KEY `idx_msg_message_receiver_receiver` (`receiver`),
  KEY `idx_msg_message_receiver_delete_at` (`delete_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息接收信息表';

DROP TABLE IF EXISTS setting_internal_receiver;
CREATE TABLE `setting_internal_receiver` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain` varchar(100) NOT NULL DEFAULT '' COMMENT '主体',
  `receiver` varchar(200) NOT NULL DEFAULT '' COMMENT '接收者',
  `method` varchar(32) NOT NULL DEFAULT '' COMMENT '消息形式',
  PRIMARY KEY (`id`),
  KEY `idx_setting_internal_receiver_receiver` (`receiver`),
  KEY `idx_setting_internal_receiver_domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='内部消息接收人设置表';

DROP TABLE IF EXISTS setting_plugin;
CREATE TABLE `setting_plugin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '插件名称',
  `code` varchar(100) NOT NULL DEFAULT '' COMMENT '插件标识',
  `path` varchar(200) NOT NULL DEFAULT '' COMMENT '插件路径',
  `disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='插件表';

DROP TABLE IF EXISTS setting_receiver;
CREATE TABLE `setting_receiver` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain` varchar(100) NOT NULL DEFAULT '' COMMENT '主体',
  `receiver` varchar(200) NOT NULL DEFAULT '' COMMENT '接收者',
  `method` varchar(32) NOT NULL DEFAULT '' COMMENT '消息形式',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '接收消息等级',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态:1-不接收消息',
  PRIMARY KEY (`id`),
  KEY `idx_setting_receiver_domain` (`domain`),
  KEY `idx_setting_receiver_receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息设置表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-13 14:44:47
