-- MySQL dump 10.13  Distrib 8.0.18, for osx10.14 (x86_64)
--
-- Host: 10.60.79.212    Database: jcloud_ts
-- ------------------------------------------------------
-- Server version	5.7.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jcloud_ts` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE jcloud_ts;

--
-- Table structure for table `jy_saas_ctl`
--

DROP TABLE IF EXISTS `jy_saas_ctl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_ctl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ctl_case_name` varchar(255) DEFAULT '' COMMENT 'CTL事件名称',
  `ctl_case_ctags` varchar(255) DEFAULT NULL COMMENT 'CTL事件标签ID',
  `ctl_case_createtime` datetime NOT NULL COMMENT '创建时间',
  `ctl_case_updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `ctl_case_describe` varchar(255) DEFAULT NULL COMMENT '事件描述',
  `ctl_case_workgroup_id` varchar(255) DEFAULT NULL COMMENT '工作组ID',
  `ctl_case_upper_id` bigint(20) DEFAULT '0' COMMENT 'CTL上一级ID, 0:默认就是父级',
  `ctl_case_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除,0:删除,1:存在',
  `company` varchar(255) NOT NULL COMMENT '企业名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='CTL管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_ctl`
--


--
-- Table structure for table `jy_saas_group_reportmail`
--

DROP TABLE IF EXISTS `jy_saas_group_reportmail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_group_reportmail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `groups_id` int(11) NOT NULL COMMENT '工作组id',
  `report_subject` varchar(255) DEFAULT '' COMMENT '邮件主体',
  `report_email` longtext COMMENT '邮件地址',
  `report_body` longtext COMMENT '邮件内容',
  `report_push` longtext COMMENT '邮件推送,0:不启用,1:启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='reportMail配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_group_reportmail`
--

--
-- Table structure for table `jy_saas_groups`
--

DROP TABLE IF EXISTS `jy_saas_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `groups_title` varchar(255) DEFAULT '0' COMMENT '工作组名',
  `groups_email` varchar(255) DEFAULT '' COMMENT '工作组邮件',
  `groups_manage_email` varchar(255) DEFAULT '' COMMENT '管理员邮件',
  `groups_workday` varchar(255) DEFAULT NULL COMMENT '工作日',
  `groups_work_starttime_type` tinyint(1) DEFAULT '1' COMMENT '工作时间-开始,1:上午,2:下午',
  `groups_work_starttime` varchar(25) DEFAULT '' COMMENT '工作时间,开始',
  `groups_work_endtime_type` tinyint(1) DEFAULT '1' COMMENT '工作时间-结束,1:上午,2:下午',
  `groups_work_endtime` varchar(25) DEFAULT '' COMMENT '工作时间,结束',
  `groups_createtime` datetime NOT NULL COMMENT '创建时间',
  `groups_timezone_id` int(11) DEFAULT '1' COMMENT '所属时区',
  `groups_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除,0:删除,1:正常',
  `company` varchar(255) NOT NULL COMMENT '企业名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='工作组管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_groups`
--

--
-- Table structure for table `jy_saas_jobs`
--

DROP TABLE IF EXISTS `jy_saas_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `jobs_name` varchar(255) NOT NULL COMMENT '岗位名称',
  `jobs_detail` varchar(255) DEFAULT NULL COMMENT '岗位备注',
  `jobs_upper_id` int(11) DEFAULT NULL COMMENT '直属上一级',
  `jobs_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除,0:删除,1:正常',
  `jobs_createtime` datetime NOT NULL COMMENT '创建时间',
  `jobs_updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '企业名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='岗位管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_jobs`
--

--
-- Table structure for table `jy_saas_jobs_member`
--

DROP TABLE IF EXISTS `jy_saas_jobs_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_jobs_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `jobs_id` int(11) NOT NULL COMMENT '岗位id',
  `member_uuid` varchar(255) NOT NULL COMMENT '用户的ID',
  `member_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除,0:删除,1:正常',
  `member_createtime` datetime DEFAULT NULL COMMENT '创建时间',
  `member_updatetime` datetime DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='岗位用户管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_jobs_member`
--

--
-- Table structure for table `jy_saas_orders`
--

DROP TABLE IF EXISTS `jy_saas_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '工单ID',
  `order_id` varchar(15) NOT NULL COMMENT '工单的编号',
  `order_createtime` datetime NOT NULL COMMENT '创建时间',
  `order_updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `order_reply_status` tinyint(1) DEFAULT '1' COMMENT '响应状态,1:待响应,2:已响应,3:已逾期',
  `order_solvetime` datetime DEFAULT NULL COMMENT '解决时间',
  `order_title` varchar(255) DEFAULT NULL COMMENT '工单标题',
  `order_describe` longtext NOT NULL COMMENT '工单描述',
  `order_risk_level` tinyint(1) DEFAULT '1' COMMENT '严重等级,1:咨询,2:一般,3:轻微,4:严重,5:致命',
  `order_process_level` tinyint(1) DEFAULT '1' COMMENT '处理优先级,1:正常排队,2:高优先级,3:立即处理',
  `order_ctl_c` int(11) NOT NULL COMMENT 'CTL的值-c',
  `order_ctl_t` int(11) DEFAULT '0' COMMENT 'CTL的值-t',
  `order_ctl_l` int(11) DEFAULT '0' COMMENT 'CTL的值-l',
  `order_workgroup_id` bigint(20) NOT NULL COMMENT '工作组ID',
  `order_workgroup_uuid` varchar(255) DEFAULT NULL COMMENT '指派的工作组用户ID',
  `order_report_uuid` varchar(255) DEFAULT NULL COMMENT '报告人ID',
  `order_apply_uuid` varchar(255) DEFAULT NULL COMMENT '申请人ID',
  `order_cc_email` longtext COMMENT '抄送的邮箱地址,用「,」分割',
  `order_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除,0:已删除,1:正常',
  `order_status` tinyint(1) DEFAULT '1' COMMENT '工单状态,1:新建,2:已指派,3:处理中,4:已解决,5:已关闭',
  `order_types` tinyint(1) DEFAULT '0' COMMENT '工单类型,0:事件,1:故障,2:问题,3:变更,4:发布,5:配置',
  `order_handle_uuid` varchar(255) DEFAULT '' COMMENT '经办人',
  `order_restarts` tinyint(1) DEFAULT '0' COMMENT '是否重新打开,0:不是,1:是',
  `company` varchar(255) NOT NULL COMMENT '企业名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='工单管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_orders`
--

--
-- Table structure for table `jy_saas_orders_active`
--

DROP TABLE IF EXISTS `jy_saas_orders_active`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_orders_active` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '工单的ID',
  `order_title` varchar(255) DEFAULT NULL COMMENT '工单标题',
  `order_info` varchar(255) DEFAULT NULL COMMENT '工单描述/处理结果',
  `order_createtime` datetime DEFAULT NULL COMMENT '活动创建时间',
  `order_job_status` tinyint(1) DEFAULT '1' COMMENT '状态机,1:新建工单,2:更新记录,3:关闭工单',
  `order_handle_uuid` varchar(255) DEFAULT NULL COMMENT '经办人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='工单活动记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_orders_active`
--

--
-- Table structure for table `jy_saas_orders_change_types`
--

DROP TABLE IF EXISTS `jy_saas_orders_change_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_orders_change_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `change_type` int(1) NOT NULL COMMENT '转换类型,1:事件转故障,2:故障转问题',
  `change_updatetime` datetime NOT NULL COMMENT '修改时间',
  `change_order_id` bigint(20) NOT NULL COMMENT '工单ID',
  `company` varchar(255) NOT NULL COMMENT '企业名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='工单变更类型台账表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_orders_change_types`
--

--
-- Table structure for table `jy_saas_orders_files`
--

DROP TABLE IF EXISTS `jy_saas_orders_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_orders_files` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '工单的ID',
  `order_file_path` varchar(255) DEFAULT NULL COMMENT '附件路径',
  `order_file_name` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `order_file_delete` tinyint(1) DEFAULT '1' COMMENT '附件删除,0:删除,1:存活',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='工单附件管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_orders_files`
--

--
-- Table structure for table `jy_saas_orders_member_concerned`
--

DROP TABLE IF EXISTS `jy_saas_orders_member_concerned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_orders_member_concerned` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '工单的ID',
  `order_concerned_uuid` varchar(255) DEFAULT NULL COMMENT '关注的用户',
  `order_concerned_delete` tinyint(1) DEFAULT '1' COMMENT '删除,0:删除,1:存活',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='关注记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_orders_member_concerned`
--

--
-- Table structure for table `jy_saas_orders_process`
--

DROP TABLE IF EXISTS `jy_saas_orders_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_orders_process` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '工单的ID',
  `order_process_name` varchar(255) DEFAULT NULL COMMENT '流程信息',
  `order_process_uuid` varchar(255) DEFAULT NULL COMMENT '经办人',
  `order_process_status` tinyint(1) DEFAULT '1' COMMENT '阶段,1:创建工单,2:服务台,3:一线运维,4:运维专家,5:云厂商工单,6:验收,7:结束',
  `order_process_delete` tinyint(1) DEFAULT '1' COMMENT '删除,0:删除,1:存活',
  `order_createtime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8 COMMENT='工单流程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_orders_process`
--

--
-- Table structure for table `jy_saas_sla`
--

DROP TABLE IF EXISTS `jy_saas_sla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_sla` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sla_level` varchar(255) DEFAULT '' COMMENT '紧急程度',
  `sla_tag` varchar(255) DEFAULT '' COMMENT '别名',
  `sla_level_digital` tinyint(1) DEFAULT '1' COMMENT '级别的数字代表/响应级别',
  `sla_period` int(11) DEFAULT '0' COMMENT '响应SLA(秒)',
  `sla_uuid` varchar(255) DEFAULT '' COMMENT '用户的UUID',
  `sla_uptime` datetime NOT NULL COMMENT '修改时间',
  `sla_classify` tinyint(1) DEFAULT '0' COMMENT '数据类型,0:紧急程度,1:SLA设置',
  `sla_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除,0:删除,1:存在',
  `company` varchar(255) NOT NULL COMMENT '企业名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='SLA管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_sla`
--

LOCK TABLES `jy_saas_sla` WRITE;
/*!40000 ALTER TABLE `jy_saas_sla` DISABLE KEYS */;
INSERT INTO `jy_saas_sla` VALUES (31,'','',1,60,'2204241141GF60','2022-06-30 15:28:36',1,1,'JY2204241141N7GF'),(32,'','',2,120,'2204241141GF60','2022-06-30 15:28:44',1,1,'JY2204241141N7GF'),(33,'','',3,600,'','2022-06-30 15:28:27',1,1,'JY2204241141N7GF'),(34,'','',4,600,'','2022-06-30 15:28:27',1,1,'JY2204241141N7GF'),(35,'','',5,600,'','2022-06-30 15:28:27',1,1,'JY2204241141N7GF'),(36,'Critical','紧急',1,0,'2204241141GF60','2022-06-30 15:29:15',0,1,'JY2204241141N7GF'),(37,'High','严重',2,0,'2204241141GF60','2022-06-30 15:32:43',0,1,'JY2204241141N7GF'),(38,'Medium','一般',3,0,'2204241141GF60','2022-06-30 15:33:10',0,1,'JY2204241141N7GF'),(39,'Low','低',4,0,'2204241141GF60','2022-06-30 15:33:35',0,1,'JY2204241141N7GF'),(40,'','',1,600,'','2022-06-30 15:34:19',1,1,'JY2204241141PWZA'),(41,'','',2,600,'','2022-06-30 15:34:19',1,1,'JY2204241141PWZA'),(42,'','',3,600,'','2022-06-30 15:34:19',1,1,'JY2204241141PWZA'),(43,'','',4,600,'','2022-06-30 15:34:19',1,1,'JY2204241141PWZA'),(44,'','',5,600,'','2022-06-30 15:34:19',1,1,'JY2204241141PWZA');
/*!40000 ALTER TABLE `jy_saas_sla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jy_saas_system_config`
--

DROP TABLE IF EXISTS `jy_saas_system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_system_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `config_name` varchar(255) NOT NULL COMMENT '配置的KEY',
  `config_val` varchar(255) DEFAULT NULL COMMENT '配置的Value',
  `company` varchar(255) NOT NULL COMMENT '企业名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='综合配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_system_config`
--

LOCK TABLES `jy_saas_system_config` WRITE;
/*!40000 ALTER TABLE `jy_saas_system_config` DISABLE KEYS */;
INSERT INTO `jy_saas_system_config` VALUES (4,'SLA_CONFIG','1','JY2204241141N7GF');
/*!40000 ALTER TABLE `jy_saas_system_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jy_saas_work_cti`
--

DROP TABLE IF EXISTS `jy_saas_work_cti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_work_cti` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `groups_id` int(11) NOT NULL COMMENT '工作组id',
  `cti_c` int(11) NOT NULL COMMENT 'cti的c',
  `cti_t` int(11) DEFAULT NULL COMMENT 'cti的t',
  `cti_i` int(11) DEFAULT NULL COMMENT 'cti的i',
  `cti_delete` tinyint(1) DEFAULT '1' COMMENT '逻辑删除,0:删除,1:正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='工作组CTI管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_work_cti`
--

--
-- Table structure for table `jy_saas_work_members`
--

DROP TABLE IF EXISTS `jy_saas_work_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jy_saas_work_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `groups_id` int(11) NOT NULL COMMENT '工作组id',
  `member_uuid` varchar(255) DEFAULT '' COMMENT '用户uuid',
  `member_status` tinyint(1) DEFAULT '1' COMMENT '开关,0:关闭,1:开启',
  `member_delete` tinyint(1) DEFAULT '1' COMMENT '删除,0:删除,1:启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='工作组成员管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jy_saas_work_members`
--

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-22 11:12:23
