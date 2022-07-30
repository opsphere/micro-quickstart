-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: multicloud
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

create database multicloud;
use multicloud;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL COMMENT '应用名',
  `company` varchar(191) NOT NULL COMMENT '所属公司',
  `created` datetime(3) NOT NULL COMMENT '创建时间',
  `p_id` bigint(20) unsigned NOT NULL COMMENT 'Project 表ID',
  `synchronized_time` datetime(3) NOT NULL COMMENT '将资源同步到应用的时间',
  `updated_at` datetime(3) DEFAULT NULL,
  `op` bigint(20) unsigned DEFAULT NULL COMMENT '运维负责人',
  `rd` bigint(20) unsigned DEFAULT NULL COMMENT '业务负责人',
  `description` varchar(191) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  KEY `idx_application_p_id` (`p_id`),
  KEY `idx_application_name` (`name`),
  KEY `idx_application_company` (`company`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COMMENT='应用表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_associate_history`
--

DROP TABLE IF EXISTS `application_associate_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_associate_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(191) NOT NULL COMMENT '所属公司',
  `app_id` bigint(20) unsigned NOT NULL COMMENT 'application 表 ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `service` varchar(32) NOT NULL COMMENT '云服务',
  `instance_id` varchar(255) NOT NULL COMMENT '实例唯一标识',
  `action` varchar(191) NOT NULL COMMENT '动作',
  `created` datetime(3) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_application_associate_history_cloud` (`cloud`),
  KEY `idx_application_associate_history_service` (`service`),
  KEY `idx_application_associate_history_instance_id` (`instance_id`),
  KEY `idx_application_associate_history_company` (`company`),
  KEY `idx_application_associate_history_app_id` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='实例与服务树（应用）关联历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_policy`
--

DROP TABLE IF EXISTS `application_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_policy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL COMMENT '规则名',
  `company` varchar(191) NOT NULL COMMENT '所属公司',
  `app_id` bigint(20) unsigned NOT NULL COMMENT 'application表ID',
  `cloud` longtext COMMENT '云厂商',
  PRIMARY KEY (`id`),
  KEY `idx_application_policy_name` (`name`),
  KEY `idx_application_policy_company` (`company`),
  KEY `idx_application_policy_app_id` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 COMMENT='应用与策略表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_policy_tag`
--

DROP TABLE IF EXISTS `application_policy_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_policy_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(191) NOT NULL COMMENT '所属公司',
  `app_id` bigint(20) unsigned NOT NULL COMMENT 'application 表 ID',
  `ap_id` bigint(20) unsigned NOT NULL COMMENT 'application_policy表ID',
  `tag_id` bigint(20) unsigned NOT NULL COMMENT 'Tag表ID',
  PRIMARY KEY (`id`),
  KEY `idx_application_policy_tag_app_id` (`app_id`),
  KEY `idx_application_policy_tag_ap_id` (`ap_id`),
  KEY `idx_application_policy_tag_tag_id` (`tag_id`),
  KEY `idx_application_policy_tag_company` (`company`)
) ENGINE=InnoDB AUTO_INCREMENT=3028 DEFAULT CHARSET=utf8 COMMENT='应用策略与 tag 表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_resource`
--

DROP TABLE IF EXISTS `application_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_resource` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(191) NOT NULL COMMENT '所属公司',
  `app_id` bigint(20) unsigned NOT NULL COMMENT 'application 表 ID',
  `service` varchar(191) NOT NULL COMMENT '云厂商服务名',
  `instance_id` varchar(191) NOT NULL COMMENT '资源唯一标识',
  `way` varchar(191) NOT NULL COMMENT '资源是如何关联到应用的 automatic通过标签自动关联，manual人工手动关联',
  `ap_id` bigint(20) unsigned DEFAULT NULL COMMENT 'application_policy表ID，如果资源是自动关联的才有这个值',
  `cloud` varchar(191) NOT NULL COMMENT '云厂商',
  `account_id` bigint(20) unsigned NOT NULL COMMENT '云帐号ID',
  PRIMARY KEY (`id`),
  KEY `idx_application_resource_company` (`company`),
  KEY `idx_application_resource_app_id` (`app_id`),
  KEY `idx_application_resource_service` (`service`),
  KEY `idx_application_resource_instance_id` (`instance_id`),
  KEY `idx_application_resource_way` (`way`),
  KEY `idx_application_resource_ap_id` (`ap_id`),
  KEY `idx_application_resource_cloud` (`cloud`),
  KEY `idx_application_resource_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16382 DEFAULT CHARSET=utf8 COMMENT='应用与资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_user`
--

DROP TABLE IF EXISTS `application_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `application_id` bigint(20) unsigned NOT NULL COMMENT '应用ID',
  `user_id` bigint(20) unsigned NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`),
  KEY `idx_application_user_application_id` (`application_id`),
  KEY `idx_application_user_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COMMENT='应用成员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multi_table_signed`
--

DROP TABLE IF EXISTS `multi_table_signed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multi_table_signed` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sign` varchar(191) DEFAULT NULL,
  `max_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_multi_table_signed_sign` (`sign`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='存储多表间最大的 ID，确保多表间的自增 ID 不重复';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL COMMENT '项目名',
  `company` varchar(191) NOT NULL COMMENT '所属公司',
  `created` datetime(3) NOT NULL COMMENT '创建时间',
  `pnode` bigint(20) unsigned DEFAULT NULL COMMENT '上级节点信息',
  `op` bigint(20) unsigned DEFAULT NULL COMMENT '运维负责人',
  `updated_at` datetime(3) DEFAULT NULL,
  `rd` bigint(20) unsigned DEFAULT NULL COMMENT '业务负责人',
  `description` varchar(191) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  KEY `idx_project_name` (`name`),
  KEY `idx_project_company` (`company`),
  KEY `idx_project_pnode` (`pnode`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='项目表，其 id 不能与 application 表重复';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quota_limit_amount`
--

DROP TABLE IF EXISTS `quota_limit_amount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_limit_amount` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `node` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '节点ID',
  `month` bigint(20) unsigned NOT NULL COMMENT '月份',
  `quota` double NOT NULL DEFAULT '0' COMMENT '金额',
  PRIMARY KEY (`id`),
  KEY `idx_quota_limit_amount_company` (`company`),
  KEY `idx_quota_limit_amount_node` (`node`),
  KEY `idx_quota_limit_amount_month` (`month`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='费用配额表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quota_resource_maximum`
--

DROP TABLE IF EXISTS `quota_resource_maximum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_resource_maximum` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `node` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '节点ID',
  `resource` varchar(32) NOT NULL COMMENT '云服务,资源类型',
  `maximum` bigint(20) NOT NULL DEFAULT '0' COMMENT '上限',
  PRIMARY KEY (`id`),
  KEY `idx_quota_resource_maximum_company` (`company`),
  KEY `idx_quota_resource_maximum_node` (`node`),
  KEY `idx_quota_resource_maximum_resource` (`resource`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='资源配额表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_ack`
--

DROP TABLE IF EXISTS `resource_aliyun_ack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_ack` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version` varchar(255) DEFAULT NULL COMMENT '版本',
  KEY `idx_resource_aliyun_ack_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_ack_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_ack_company` (`company`),
  KEY `idx_resource_aliyun_ack_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_ack_account_id` (`account_id`),
  KEY `idx_resource_aliyun_ack_cloud` (`cloud`),
  KEY `idx_resource_aliyun_ack_region` (`region`),
  KEY `idx_resource_aliyun_ack_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun ack 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_bandwidth`
--

DROP TABLE IF EXISTS `resource_aliyun_bandwidth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_bandwidth` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_aliyun_bandwidth_region` (`region`),
  KEY `idx_resource_aliyun_bandwidth_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_bandwidth_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_bandwidth_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_bandwidth_company` (`company`),
  KEY `idx_resource_aliyun_bandwidth_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_bandwidth_account_id` (`account_id`),
  KEY `idx_resource_aliyun_bandwidth_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun bandwidth 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_disk`
--

DROP TABLE IF EXISTS `resource_aliyun_disk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_disk` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `size` bigint(20) NOT NULL DEFAULT '0' COMMENT '云盘大小',
  KEY `idx_resource_aliyun_disk_region` (`region`),
  KEY `idx_resource_aliyun_disk_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_disk_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_disk_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_disk_company` (`company`),
  KEY `idx_resource_aliyun_disk_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_disk_account_id` (`account_id`),
  KEY `idx_resource_aliyun_disk_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun disk 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_ecs`
--

DROP TABLE IF EXISTS `resource_aliyun_ecs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_ecs` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `cpu` longtext COMMENT 'cpu',
  `memory` longtext COMMENT '内存',
  KEY `idx_resource_aliyun_ecs_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_ecs_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_ecs_public_ip` (`public_ip`),
  KEY `idx_resource_aliyun_ecs_e_ip` (`e_ip`),
  KEY `idx_resource_aliyun_ecs_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_ecs_company` (`company`),
  KEY `idx_resource_aliyun_ecs_private_ip` (`private_ip`),
  KEY `idx_resource_aliyun_ecs_account_id` (`account_id`),
  KEY `idx_resource_aliyun_ecs_cloud` (`cloud`),
  KEY `idx_resource_aliyun_ecs_region` (`region`),
  KEY `idx_resource_aliyun_ecs_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun ecs 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_eip`
--

DROP TABLE IF EXISTS `resource_aliyun_eip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_eip` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `binded_instance_id` varchar(255) NOT NULL COMMENT '绑定该 eip 的实例的 ID',
  `private_ip` longtext COMMENT '内网IP',
  `public_ip` longtext COMMENT '公网IP',
  KEY `idx_resource_aliyun_eip_account_id` (`account_id`),
  KEY `idx_resource_aliyun_eip_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_eip_company` (`company`),
  KEY `idx_resource_aliyun_eip_binded_instance_id` (`binded_instance_id`),
  KEY `idx_resource_aliyun_eip_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_eip_region` (`region`),
  KEY `idx_resource_aliyun_eip_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_eip_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_eip_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun eip 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_file_storage`
--

DROP TABLE IF EXISTS `resource_aliyun_file_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_file_storage` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `size` double DEFAULT NULL COMMENT '共享容量',
  `used_size` double DEFAULT NULL COMMENT '已使用容量',
  `type` longtext COMMENT '类型',
  `description` longtext COMMENT '共享的描述',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_aliyun_file_storage_account_id` (`account_id`),
  KEY `idx_resource_aliyun_file_storage_cloud` (`cloud`),
  KEY `idx_resource_aliyun_file_storage_region` (`region`),
  KEY `idx_resource_aliyun_file_storage_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_file_storage_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_file_storage_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_file_storage_company` (`company`),
  KEY `idx_resource_aliyun_file_storage_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun file storage(nas) 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_mongo`
--

DROP TABLE IF EXISTS `resource_aliyun_mongo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_mongo` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '引擎版本',
  `engine` varchar(255) DEFAULT NULL COMMENT '引擎',
  KEY `idx_resource_aliyun_mongo_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_mongo_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_mongo_company` (`company`),
  KEY `idx_resource_aliyun_mongo_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_mongo_account_id` (`account_id`),
  KEY `idx_resource_aliyun_mongo_cloud` (`cloud`),
  KEY `idx_resource_aliyun_mongo_region` (`region`),
  KEY `idx_resource_aliyun_mongo_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun mongo 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_nat`
--

DROP TABLE IF EXISTS `resource_aliyun_nat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_nat` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `description` varchar(2000) DEFAULT NULL,
  KEY `idx_resource_aliyun_nat_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_nat_account_id` (`account_id`),
  KEY `idx_resource_aliyun_nat_cloud` (`cloud`),
  KEY `idx_resource_aliyun_nat_region` (`region`),
  KEY `idx_resource_aliyun_nat_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_nat_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_nat_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_nat_company` (`company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun nat 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_oceanbase`
--

DROP TABLE IF EXISTS `resource_aliyun_oceanbase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_oceanbase` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_aliyun_oceanbase_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_oceanbase_account_id` (`account_id`),
  KEY `idx_resource_aliyun_oceanbase_cloud` (`cloud`),
  KEY `idx_resource_aliyun_oceanbase_region` (`region`),
  KEY `idx_resource_aliyun_oceanbase_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_oceanbase_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_oceanbase_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_oceanbase_company` (`company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun oceanbase 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_oss`
--

DROP TABLE IF EXISTS `resource_aliyun_oss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_oss` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `extranet_endpoint` longtext,
  `intranet_endpoint` longtext,
  KEY `idx_resource_aliyun_oss_company` (`company`),
  KEY `idx_resource_aliyun_oss_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_oss_account_id` (`account_id`),
  KEY `idx_resource_aliyun_oss_cloud` (`cloud`),
  KEY `idx_resource_aliyun_oss_region` (`region`),
  KEY `idx_resource_aliyun_oss_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_oss_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_oss_instance_status` (`instance_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun oss 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_polarx`
--

DROP TABLE IF EXISTS `resource_aliyun_polarx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_polarx` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `engine` varchar(255) DEFAULT NULL COMMENT '数据库引擎',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '数据库引擎版本',
  `pay_type` varchar(255) DEFAULT NULL COMMENT '付费类型',
  KEY `idx_resource_aliyun_polarx_account_id` (`account_id`),
  KEY `idx_resource_aliyun_polarx_cloud` (`cloud`),
  KEY `idx_resource_aliyun_polarx_region` (`region`),
  KEY `idx_resource_aliyun_polarx_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_polarx_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_polarx_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_polarx_company` (`company`),
  KEY `idx_resource_aliyun_polarx_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun PolarDB-X 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_rds`
--

DROP TABLE IF EXISTS `resource_aliyun_rds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_rds` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '引擎版本',
  `engine` varchar(255) DEFAULT NULL COMMENT '数据库引擎',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  KEY `idx_resource_aliyun_rds_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_rds_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_rds_company` (`company`),
  KEY `idx_resource_aliyun_rds_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_rds_account_id` (`account_id`),
  KEY `idx_resource_aliyun_rds_cloud` (`cloud`),
  KEY `idx_resource_aliyun_rds_region` (`region`),
  KEY `idx_resource_aliyun_rds_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun rds 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_redis`
--

DROP TABLE IF EXISTS `resource_aliyun_redis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_redis` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cluster_enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用集群',
  `shards` bigint(20) DEFAULT NULL COMMENT 'number of shards',
  `nodes` bigint(20) DEFAULT NULL COMMENT 'number of nodes',
  KEY `idx_resource_aliyun_redis_region` (`region`),
  KEY `idx_resource_aliyun_redis_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_redis_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_redis_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_redis_company` (`company`),
  KEY `idx_resource_aliyun_redis_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_redis_account_id` (`account_id`),
  KEY `idx_resource_aliyun_redis_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun redis 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_securitygroup`
--

DROP TABLE IF EXISTS `resource_aliyun_securitygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_securitygroup` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `description` varchar(2000) DEFAULT NULL,
  KEY `idx_resource_aliyun_securitygroup_account_id` (`account_id`),
  KEY `idx_resource_aliyun_securitygroup_cloud` (`cloud`),
  KEY `idx_resource_aliyun_securitygroup_region` (`region`),
  KEY `idx_resource_aliyun_securitygroup_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_securitygroup_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_securitygroup_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_securitygroup_company` (`company`),
  KEY `idx_resource_aliyun_securitygroup_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun security group 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_slb`
--

DROP TABLE IF EXISTS `resource_aliyun_slb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_slb` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `dns_name` varchar(500) DEFAULT NULL COMMENT 'dns名字',
  KEY `idx_resource_aliyun_slb_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_slb_private_ip` (`private_ip`),
  KEY `idx_resource_aliyun_slb_e_ip` (`e_ip`),
  KEY `idx_resource_aliyun_slb_account_id` (`account_id`),
  KEY `idx_resource_aliyun_slb_cloud` (`cloud`),
  KEY `idx_resource_aliyun_slb_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_slb_company` (`company`),
  KEY `idx_resource_aliyun_slb_public_ip` (`public_ip`),
  KEY `idx_resource_aliyun_slb_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_slb_region` (`region`),
  KEY `idx_resource_aliyun_slb_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun 负载均衡表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_subnet`
--

DROP TABLE IF EXISTS `resource_aliyun_subnet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_subnet` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `vpc_id` varchar(200) DEFAULT NULL COMMENT 'vpc id',
  `cidr` varchar(255) DEFAULT NULL COMMENT 'cidr',
  KEY `idx_resource_aliyun_subnet_company` (`company`),
  KEY `idx_resource_aliyun_subnet_resource_id` (`resource_id`),
  KEY `idx_resource_aliyun_subnet_account_id` (`account_id`),
  KEY `idx_resource_aliyun_subnet_cloud` (`cloud`),
  KEY `idx_resource_aliyun_subnet_region` (`region`),
  KEY `idx_resource_aliyun_subnet_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_subnet_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_subnet_instance_status` (`instance_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun subnet 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aliyun_vpc`
--

DROP TABLE IF EXISTS `resource_aliyun_vpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aliyun_vpc` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cidr_block` varchar(255) DEFAULT NULL,
  KEY `idx_resource_aliyun_vpc_account_id` (`account_id`),
  KEY `idx_resource_aliyun_vpc_cloud` (`cloud`),
  KEY `idx_resource_aliyun_vpc_region` (`region`),
  KEY `idx_resource_aliyun_vpc_instance_id` (`instance_id`),
  KEY `idx_resource_aliyun_vpc_instance_name` (`instance_name`),
  KEY `idx_resource_aliyun_vpc_instance_status` (`instance_status`),
  KEY `idx_resource_aliyun_vpc_company` (`company`),
  KEY `idx_resource_aliyun_vpc_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aliyun vpc 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_docdb`
--

DROP TABLE IF EXISTS `resource_aws_docdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_docdb` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `engine` longtext COMMENT '引擎',
  `engine_version` longtext COMMENT '引擎版本',
  `size` bigint(20) DEFAULT NULL COMMENT '节点数',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `subnet_group` longtext COMMENT '子网组',
  KEY `idx_resource_aws_docdb_company` (`company`),
  KEY `idx_resource_aws_docdb_resource_id` (`resource_id`),
  KEY `idx_resource_aws_docdb_account_id` (`account_id`),
  KEY `idx_resource_aws_docdb_cloud` (`cloud`),
  KEY `idx_resource_aws_docdb_region` (`region`),
  KEY `idx_resource_aws_docdb_instance_id` (`instance_id`),
  KEY `idx_resource_aws_docdb_instance_name` (`instance_name`),
  KEY `idx_resource_aws_docdb_instance_status` (`instance_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws documentdb 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_ec2`
--

DROP TABLE IF EXISTS `resource_aws_ec2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_ec2` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `cpu` longtext COMMENT 'cpu',
  `memory` longtext COMMENT '内存',
  KEY `idx_resource_aws_ec2_company` (`company`),
  KEY `idx_resource_aws_ec2_public_ip` (`public_ip`),
  KEY `idx_resource_aws_ec2_private_ip` (`private_ip`),
  KEY `idx_resource_aws_ec2_e_ip` (`e_ip`),
  KEY `idx_resource_aws_ec2_region` (`region`),
  KEY `idx_resource_aws_ec2_instance_status` (`instance_status`),
  KEY `idx_resource_aws_ec2_cloud` (`cloud`),
  KEY `idx_resource_aws_ec2_instance_id` (`instance_id`),
  KEY `idx_resource_aws_ec2_instance_name` (`instance_name`),
  KEY `idx_resource_aws_ec2_resource_id` (`resource_id`),
  KEY `idx_resource_aws_ec2_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws ec2 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_eip`
--

DROP TABLE IF EXISTS `resource_aws_eip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_eip` (
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `allocation_id` longtext COMMENT '地址分配的ID',
  `address_name` varchar(1000) DEFAULT NULL COMMENT 'eip名',
  `association_id` longtext COMMENT '地址关联的ID',
  `domain` longtext COMMENT '地址用于EC2-Classic还是VPC',
  `instance_id` varchar(1000) DEFAULT NULL COMMENT '地址关联的实例ID',
  `private_ip_address` longtext COMMENT '内网IP',
  `public_ip` longtext COMMENT '公网IP',
  `network_interface_id` longtext,
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  KEY `idx_resource_aws_eip_region` (`region`),
  KEY `idx_resource_aws_eip_resource_id` (`resource_id`),
  KEY `idx_resource_aws_eip_company` (`company`),
  KEY `idx_resource_aws_eip_account_id` (`account_id`),
  KEY `idx_resource_aws_eip_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws eip 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_elb`
--

DROP TABLE IF EXISTS `resource_aws_elb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_elb` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `dns_name` varchar(500) DEFAULT NULL COMMENT 'dns名字',
  KEY `idx_resource_aws_elb_resource_id` (`resource_id`),
  KEY `idx_resource_aws_elb_instance_name` (`instance_name`),
  KEY `idx_resource_aws_elb_private_ip` (`private_ip`),
  KEY `idx_resource_aws_elb_e_ip` (`e_ip`),
  KEY `idx_resource_aws_elb_account_id` (`account_id`),
  KEY `idx_resource_aws_elb_cloud` (`cloud`),
  KEY `idx_resource_aws_elb_region` (`region`),
  KEY `idx_resource_aws_elb_instance_id` (`instance_id`),
  KEY `idx_resource_aws_elb_instance_status` (`instance_status`),
  KEY `idx_resource_aws_elb_company` (`company`),
  KEY `idx_resource_aws_elb_public_ip` (`public_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='负载均衡表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_memcached`
--

DROP TABLE IF EXISTS `resource_aws_memcached`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_memcached` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `nodes` bigint(20) DEFAULT NULL COMMENT '集群节点数',
  `zone` longtext COMMENT 'zone',
  `endpoint_address` longtext COMMENT 'address',
  `endpoint_port` int(11) DEFAULT NULL COMMENT 'port',
  KEY `idx_resource_aws_memcached_company` (`company`),
  KEY `idx_resource_aws_memcached_resource_id` (`resource_id`),
  KEY `idx_resource_aws_memcached_account_id` (`account_id`),
  KEY `idx_resource_aws_memcached_cloud` (`cloud`),
  KEY `idx_resource_aws_memcached_region` (`region`),
  KEY `idx_resource_aws_memcached_instance_id` (`instance_id`),
  KEY `idx_resource_aws_memcached_instance_name` (`instance_name`),
  KEY `idx_resource_aws_memcached_instance_status` (`instance_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws memcached 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_rds`
--

DROP TABLE IF EXISTS `resource_aws_rds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_rds` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cpu` longtext COMMENT 'cpu',
  `memory` longtext COMMENT '内存',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '引擎版本',
  `engine` varchar(255) DEFAULT NULL COMMENT '数据库引擎',
  `endpoint` varchar(255) DEFAULT NULL COMMENT '地址',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  KEY `idx_resource_aws_rds_region` (`region`),
  KEY `idx_resource_aws_rds_instance_id` (`instance_id`),
  KEY `idx_resource_aws_rds_instance_name` (`instance_name`),
  KEY `idx_resource_aws_rds_instance_status` (`instance_status`),
  KEY `idx_resource_aws_rds_company` (`company`),
  KEY `idx_resource_aws_rds_resource_id` (`resource_id`),
  KEY `idx_resource_aws_rds_account_id` (`account_id`),
  KEY `idx_resource_aws_rds_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='关系型数据库单实例表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_redis`
--

DROP TABLE IF EXISTS `resource_aws_redis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_redis` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cluster_enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用集群',
  `shards` bigint(20) DEFAULT NULL COMMENT 'number of shards',
  `nodes` bigint(20) DEFAULT NULL COMMENT 'number of nodes',
  KEY `idx_resource_aws_redis_instance_id` (`instance_id`),
  KEY `idx_resource_aws_redis_instance_name` (`instance_name`),
  KEY `idx_resource_aws_redis_instance_status` (`instance_status`),
  KEY `idx_resource_aws_redis_company` (`company`),
  KEY `idx_resource_aws_redis_resource_id` (`resource_id`),
  KEY `idx_resource_aws_redis_account_id` (`account_id`),
  KEY `idx_resource_aws_redis_cloud` (`cloud`),
  KEY `idx_resource_aws_redis_region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws redis 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_s3`
--

DROP TABLE IF EXISTS `resource_aws_s3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_s3` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  KEY `idx_resource_aws_s3_instance_name` (`instance_name`),
  KEY `idx_resource_aws_s3_instance_status` (`instance_status`),
  KEY `idx_resource_aws_s3_company` (`company`),
  KEY `idx_resource_aws_s3_resource_id` (`resource_id`),
  KEY `idx_resource_aws_s3_account_id` (`account_id`),
  KEY `idx_resource_aws_s3_cloud` (`cloud`),
  KEY `idx_resource_aws_s3_region` (`region`),
  KEY `idx_resource_aws_s3_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws s3 buckey 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_security_group`
--

DROP TABLE IF EXISTS `resource_aws_security_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_security_group` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `description` varchar(2000) DEFAULT NULL,
  KEY `idx_resource_aws_security_group_instance_name` (`instance_name`),
  KEY `idx_resource_aws_security_group_instance_status` (`instance_status`),
  KEY `idx_resource_aws_security_group_company` (`company`),
  KEY `idx_resource_aws_security_group_resource_id` (`resource_id`),
  KEY `idx_resource_aws_security_group_account_id` (`account_id`),
  KEY `idx_resource_aws_security_group_cloud` (`cloud`),
  KEY `idx_resource_aws_security_group_region` (`region`),
  KEY `idx_resource_aws_security_group_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws security group 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_subnet`
--

DROP TABLE IF EXISTS `resource_aws_subnet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_subnet` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `vpc_id` varchar(200) DEFAULT NULL COMMENT 'vpc id',
  `cidr` varchar(255) DEFAULT NULL COMMENT 'cidr',
  KEY `idx_resource_aws_subnet_account_id` (`account_id`),
  KEY `idx_resource_aws_subnet_cloud` (`cloud`),
  KEY `idx_resource_aws_subnet_region` (`region`),
  KEY `idx_resource_aws_subnet_instance_id` (`instance_id`),
  KEY `idx_resource_aws_subnet_instance_name` (`instance_name`),
  KEY `idx_resource_aws_subnet_instance_status` (`instance_status`),
  KEY `idx_resource_aws_subnet_company` (`company`),
  KEY `idx_resource_aws_subnet_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws subnet 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_aws_vpc`
--

DROP TABLE IF EXISTS `resource_aws_vpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_aws_vpc` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cidr_block` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  KEY `idx_resource_aws_vpc_cloud` (`cloud`),
  KEY `idx_resource_aws_vpc_region` (`region`),
  KEY `idx_resource_aws_vpc_instance_id` (`instance_id`),
  KEY `idx_resource_aws_vpc_instance_name` (`instance_name`),
  KEY `idx_resource_aws_vpc_instance_status` (`instance_status`),
  KEY `idx_resource_aws_vpc_company` (`company`),
  KEY `idx_resource_aws_vpc_resource_id` (`resource_id`),
  KEY `idx_resource_aws_vpc_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws vpc 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_company_tag`
--

DROP TABLE IF EXISTS `resource_company_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_company_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `type` varchar(1000) NOT NULL COMMENT '标签来源',
  `tid` bigint(20) unsigned NOT NULL COMMENT 'tag id',
  PRIMARY KEY (`id`),
  KEY `idx_resource_company_tag_company` (`company`),
  KEY `idx_resource_company_tag_type` (`type`),
  KEY `idx_resource_company_tag_tid` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=12022 DEFAULT CHARSET=utf8 COMMENT='公司tag表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_cloud_disk`
--

DROP TABLE IF EXISTS `resource_huawei_cloud_disk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_cloud_disk` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `size` bigint(20) NOT NULL DEFAULT '0' COMMENT '云盘大小',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_huawei_cloud_disk_company` (`company`),
  KEY `idx_resource_huawei_cloud_disk_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_cloud_disk_account_id` (`account_id`),
  KEY `idx_resource_huawei_cloud_disk_cloud` (`cloud`),
  KEY `idx_resource_huawei_cloud_disk_region` (`region`),
  KEY `idx_resource_huawei_cloud_disk_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_cloud_disk_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_cloud_disk_instance_status` (`instance_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei 云磁盘 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_dcs`
--

DROP TABLE IF EXISTS `resource_huawei_dcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_dcs` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  KEY `idx_resource_huawei_dcs_account_id` (`account_id`),
  KEY `idx_resource_huawei_dcs_cloud` (`cloud`),
  KEY `idx_resource_huawei_dcs_region` (`region`),
  KEY `idx_resource_huawei_dcs_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_dcs_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_dcs_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_dcs_company` (`company`),
  KEY `idx_resource_huawei_dcs_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei dcs 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_dds`
--

DROP TABLE IF EXISTS `resource_huawei_dds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_dds` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `engine` varchar(255) DEFAULT NULL COMMENT '数据库引擎',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  KEY `idx_resource_huawei_dds_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_dds_company` (`company`),
  KEY `idx_resource_huawei_dds_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_dds_account_id` (`account_id`),
  KEY `idx_resource_huawei_dds_cloud` (`cloud`),
  KEY `idx_resource_huawei_dds_region` (`region`),
  KEY `idx_resource_huawei_dds_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_dds_instance_name` (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei dds 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_ecs`
--

DROP TABLE IF EXISTS `resource_huawei_ecs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_ecs` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  KEY `idx_resource_huawei_ecs_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_ecs_company` (`company`),
  KEY `idx_resource_huawei_ecs_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_ecs_account_id` (`account_id`),
  KEY `idx_resource_huawei_ecs_cloud` (`cloud`),
  KEY `idx_resource_huawei_ecs_region` (`region`),
  KEY `idx_resource_huawei_ecs_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_ecs_instance_name` (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei ecs 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_eip`
--

DROP TABLE IF EXISTS `resource_huawei_eip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_eip` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `private_ip_address` longtext COMMENT '内网IP',
  `public_ip` longtext COMMENT '公网IP',
  KEY `idx_resource_huawei_eip_account_id` (`account_id`),
  KEY `idx_resource_huawei_eip_cloud` (`cloud`),
  KEY `idx_resource_huawei_eip_region` (`region`),
  KEY `idx_resource_huawei_eip_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_eip_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_eip_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_eip_company` (`company`),
  KEY `idx_resource_huawei_eip_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei eip 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_elb`
--

DROP TABLE IF EXISTS `resource_huawei_elb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_elb` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  KEY `idx_resource_huawei_elb_cloud` (`cloud`),
  KEY `idx_resource_huawei_elb_region` (`region`),
  KEY `idx_resource_huawei_elb_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_elb_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_elb_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_elb_company` (`company`),
  KEY `idx_resource_huawei_elb_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_elb_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei elb 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_kafka`
--

DROP TABLE IF EXISTS `resource_huawei_kafka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_kafka` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `version` varchar(255) DEFAULT NULL COMMENT '版本',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_huawei_kafka_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_kafka_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_kafka_company` (`company`),
  KEY `idx_resource_huawei_kafka_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_kafka_account_id` (`account_id`),
  KEY `idx_resource_huawei_kafka_cloud` (`cloud`),
  KEY `idx_resource_huawei_kafka_region` (`region`),
  KEY `idx_resource_huawei_kafka_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei ecs 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_kubernetes`
--

DROP TABLE IF EXISTS `resource_huawei_kubernetes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_kubernetes` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `version` varchar(255) DEFAULT NULL COMMENT '版本',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_huawei_kubernetes_region` (`region`),
  KEY `idx_resource_huawei_kubernetes_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_kubernetes_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_kubernetes_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_kubernetes_company` (`company`),
  KEY `idx_resource_huawei_kubernetes_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_kubernetes_account_id` (`account_id`),
  KEY `idx_resource_huawei_kubernetes_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei kubernetes 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_nat_gateway`
--

DROP TABLE IF EXISTS `resource_huawei_nat_gateway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_nat_gateway` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `spec` longtext COMMENT '公网NAT网关的规格',
  `router_id` longtext COMMENT 'VPC的id',
  `network_id` longtext COMMENT '子网ID',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_huawei_nat_gateway_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_nat_gateway_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_nat_gateway_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_nat_gateway_company` (`company`),
  KEY `idx_resource_huawei_nat_gateway_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_nat_gateway_account_id` (`account_id`),
  KEY `idx_resource_huawei_nat_gateway_cloud` (`cloud`),
  KEY `idx_resource_huawei_nat_gateway_region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei nat gateway 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_object_storage`
--

DROP TABLE IF EXISTS `resource_huawei_object_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_object_storage` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `size` bigint(20) DEFAULT NULL COMMENT '节点数',
  `object_number` bigint(20) DEFAULT NULL COMMENT '对象数量',
  KEY `idx_resource_huawei_object_storage_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_object_storage_account_id` (`account_id`),
  KEY `idx_resource_huawei_object_storage_cloud` (`cloud`),
  KEY `idx_resource_huawei_object_storage_region` (`region`),
  KEY `idx_resource_huawei_object_storage_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_object_storage_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_object_storage_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_object_storage_company` (`company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei 对象存储 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_rds`
--

DROP TABLE IF EXISTS `resource_huawei_rds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_rds` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `engine` varchar(255) DEFAULT NULL COMMENT '数据库引擎',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '引擎版本',
  KEY `idx_resource_huawei_rds_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_rds_account_id` (`account_id`),
  KEY `idx_resource_huawei_rds_cloud` (`cloud`),
  KEY `idx_resource_huawei_rds_region` (`region`),
  KEY `idx_resource_huawei_rds_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_rds_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_rds_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_rds_company` (`company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei rds 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_service_mrs`
--

DROP TABLE IF EXISTS `resource_huawei_service_mrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_service_mrs` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `vpc` longtext COMMENT 'vpc',
  `totalNodeNum` longtext COMMENT '节点数',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_huawei_service_mrs_account_id` (`account_id`),
  KEY `idx_resource_huawei_service_mrs_cloud` (`cloud`),
  KEY `idx_resource_huawei_service_mrs_region` (`region`),
  KEY `idx_resource_huawei_service_mrs_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_service_mrs_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_service_mrs_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_service_mrs_company` (`company`),
  KEY `idx_resource_huawei_service_mrs_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei mrs 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_sfs`
--

DROP TABLE IF EXISTS `resource_huawei_sfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_sfs` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `size` double DEFAULT NULL COMMENT '共享容量',
  `used_size` double DEFAULT NULL COMMENT '已使用容量',
  `type` longtext COMMENT '类型',
  `description` longtext COMMENT '共享的描述',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY `idx_resource_huawei_sfs_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_sfs_account_id` (`account_id`),
  KEY `idx_resource_huawei_sfs_cloud` (`cloud`),
  KEY `idx_resource_huawei_sfs_region` (`region`),
  KEY `idx_resource_huawei_sfs_instance_id` (`instance_id`),
  KEY `idx_resource_huawei_sfs_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_sfs_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_sfs_company` (`company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei sfs 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_sg`
--

DROP TABLE IF EXISTS `resource_huawei_sg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_sg` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  KEY `idx_resource_huawei_sg_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_sg_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_sg_company` (`company`),
  KEY `idx_resource_huawei_sg_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_sg_account_id` (`account_id`),
  KEY `idx_resource_huawei_sg_cloud` (`cloud`),
  KEY `idx_resource_huawei_sg_region` (`region`),
  KEY `idx_resource_huawei_sg_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei sg 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_subnet`
--

DROP TABLE IF EXISTS `resource_huawei_subnet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_subnet` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `cidr` longtext,
  `vpc_id` longtext,
  KEY `idx_resource_huawei_subnet_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_subnet_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_subnet_company` (`company`),
  KEY `idx_resource_huawei_subnet_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_subnet_account_id` (`account_id`),
  KEY `idx_resource_huawei_subnet_cloud` (`cloud`),
  KEY `idx_resource_huawei_subnet_region` (`region`),
  KEY `idx_resource_huawei_subnet_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei subnet 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_huawei_vpc`
--

DROP TABLE IF EXISTS `resource_huawei_vpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_huawei_vpc` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `project_id` longtext COMMENT '项目ID',
  `enterprise_project_id` longtext COMMENT '企业项目ID',
  `cidr_block` varchar(255) DEFAULT NULL,
  KEY `idx_resource_huawei_vpc_instance_name` (`instance_name`),
  KEY `idx_resource_huawei_vpc_instance_status` (`instance_status`),
  KEY `idx_resource_huawei_vpc_company` (`company`),
  KEY `idx_resource_huawei_vpc_resource_id` (`resource_id`),
  KEY `idx_resource_huawei_vpc_account_id` (`account_id`),
  KEY `idx_resource_huawei_vpc_cloud` (`cloud`),
  KEY `idx_resource_huawei_vpc_region` (`region`),
  KEY `idx_resource_huawei_vpc_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='huawei vpc 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_instance_status`
--

DROP TABLE IF EXISTS `resource_instance_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_instance_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `service` varchar(32) NOT NULL COMMENT '云服务',
  `sub_service` varchar(32) DEFAULT NULL COMMENT '子服务',
  `instance_id` varchar(255) NOT NULL COMMENT '实例唯一标识',
  `project` varchar(255) DEFAULT NULL COMMENT '项目',
  PRIMARY KEY (`id`),
  KEY `idx_resource_instance_status_service` (`service`),
  KEY `idx_resource_instance_status_sub_service` (`sub_service`),
  KEY `idx_resource_instance_status_instance_id` (`instance_id`),
  KEY `idx_resource_instance_status_company` (`company`),
  KEY `idx_resource_instance_status_account_id` (`account_id`),
  KEY `idx_resource_instance_status_cloud` (`cloud`),
  KEY `idx_resource_instance_status_region` (`region`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='实例状态同步表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_instance_tag`
--

DROP TABLE IF EXISTS `resource_instance_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_instance_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `service` varchar(100) NOT NULL COMMENT '云服务',
  `instance` varchar(1000) NOT NULL COMMENT '实例ID',
  `tag_id` bigint(20) unsigned NOT NULL COMMENT 'tag id',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  PRIMARY KEY (`id`),
  KEY `idx_resource_instance_tag_company` (`company`),
  KEY `idx_resource_instance_tag_cloud` (`cloud`),
  KEY `idx_resource_instance_tag_service` (`service`),
  KEY `idx_resource_instance_tag_instance` (`instance`),
  KEY `idx_resource_instance_tag_tag_id` (`tag_id`),
  KEY `idx_resource_instance_tag_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13383539 DEFAULT CHARSET=utf8 COMMENT='资源标签关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_cdb`
--

DROP TABLE IF EXISTS `resource_qcloud_cdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_cdb` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cpu` longtext COMMENT 'cpu',
  `memory` longtext COMMENT '内存',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '引擎版本',
  `engine` varchar(255) DEFAULT NULL COMMENT '数据库引擎',
  `endpoint` varchar(255) DEFAULT NULL COMMENT '地址',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  KEY `idx_resource_qcloud_cdb_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_cdb_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_cdb_company` (`company`),
  KEY `idx_resource_qcloud_cdb_resource_id` (`resource_id`),
  KEY `idx_resource_qcloud_cdb_account_id` (`account_id`),
  KEY `idx_resource_qcloud_cdb_cloud` (`cloud`),
  KEY `idx_resource_qcloud_cdb_region` (`region`),
  KEY `idx_resource_qcloud_cdb_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud cdb 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_clb`
--

DROP TABLE IF EXISTS `resource_qcloud_clb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_clb` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `dns_name` varchar(500) DEFAULT NULL COMMENT 'dns名字',
  KEY `idx_resource_qcloud_clb_region` (`region`),
  KEY `idx_resource_qcloud_clb_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_clb_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_clb_company` (`company`),
  KEY `idx_resource_qcloud_clb_e_ip` (`e_ip`),
  KEY `idx_resource_qcloud_clb_resource_id` (`resource_id`),
  KEY `idx_resource_qcloud_clb_cloud` (`cloud`),
  KEY `idx_resource_qcloud_clb_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_clb_public_ip` (`public_ip`),
  KEY `idx_resource_qcloud_clb_private_ip` (`private_ip`),
  KEY `idx_resource_qcloud_clb_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='负载均衡表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_cos`
--

DROP TABLE IF EXISTS `resource_qcloud_cos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_cos` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  KEY `idx_resource_qcloud_cos_cloud` (`cloud`),
  KEY `idx_resource_qcloud_cos_region` (`region`),
  KEY `idx_resource_qcloud_cos_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_cos_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_cos_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_cos_company` (`company`),
  KEY `idx_resource_qcloud_cos_resource_id` (`resource_id`),
  KEY `idx_resource_qcloud_cos_account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud cos buckey 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_cvm`
--

DROP TABLE IF EXISTS `resource_qcloud_cvm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_cvm` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `cpu` longtext COMMENT 'cpu',
  `memory` longtext COMMENT '内存',
  KEY `idx_resource_qcloud_cvm_resource_id` (`resource_id`),
  KEY `idx_resource_qcloud_cvm_account_id` (`account_id`),
  KEY `idx_resource_qcloud_cvm_cloud` (`cloud`),
  KEY `idx_resource_qcloud_cvm_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_cvm_company` (`company`),
  KEY `idx_resource_qcloud_cvm_e_ip` (`e_ip`),
  KEY `idx_resource_qcloud_cvm_region` (`region`),
  KEY `idx_resource_qcloud_cvm_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_cvm_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_cvm_public_ip` (`public_ip`),
  KEY `idx_resource_qcloud_cvm_private_ip` (`private_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud cvm 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_eip`
--

DROP TABLE IF EXISTS `resource_qcloud_eip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_eip` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `binded_instance_id` varchar(255) NOT NULL COMMENT '绑定该 eip 的实例的 ID',
  `private_ip` longtext COMMENT '内网IP',
  `public_ip` longtext COMMENT '公网IP',
  KEY `idx_resource_qcloud_eip_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_eip_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_eip_account_id` (`account_id`),
  KEY `idx_resource_qcloud_eip_cloud` (`cloud`),
  KEY `idx_resource_qcloud_eip_region` (`region`),
  KEY `idx_resource_qcloud_eip_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_eip_company` (`company`),
  KEY `idx_resource_qcloud_eip_binded_instance_id` (`binded_instance_id`),
  KEY `idx_resource_qcloud_eip_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud eip 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_mongo`
--

DROP TABLE IF EXISTS `resource_qcloud_mongo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_mongo` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  KEY `idx_resource_qcloud_mongo_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_mongo_company` (`company`),
  KEY `idx_resource_qcloud_mongo_resource_id` (`resource_id`),
  KEY `idx_resource_qcloud_mongo_account_id` (`account_id`),
  KEY `idx_resource_qcloud_mongo_cloud` (`cloud`),
  KEY `idx_resource_qcloud_mongo_region` (`region`),
  KEY `idx_resource_qcloud_mongo_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_mongo_instance_name` (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud mongo 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_redis`
--

DROP TABLE IF EXISTS `resource_qcloud_redis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_redis` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  KEY `idx_resource_qcloud_redis_region` (`region`),
  KEY `idx_resource_qcloud_redis_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_redis_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_redis_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_redis_company` (`company`),
  KEY `idx_resource_qcloud_redis_resource_id` (`resource_id`),
  KEY `idx_resource_qcloud_redis_account_id` (`account_id`),
  KEY `idx_resource_qcloud_redis_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud redis 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_securitygroup`
--

DROP TABLE IF EXISTS `resource_qcloud_securitygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_securitygroup` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `description` varchar(2000) DEFAULT NULL,
  KEY `idx_resource_qcloud_securitygroup_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_securitygroup_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_securitygroup_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_securitygroup_company` (`company`),
  KEY `idx_resource_qcloud_securitygroup_resource_id` (`resource_id`),
  KEY `idx_resource_qcloud_securitygroup_account_id` (`account_id`),
  KEY `idx_resource_qcloud_securitygroup_cloud` (`cloud`),
  KEY `idx_resource_qcloud_securitygroup_region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud security group 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_subnet`
--

DROP TABLE IF EXISTS `resource_qcloud_subnet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_subnet` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `vpc_id` varchar(200) DEFAULT NULL COMMENT 'vpc id',
  `cidr` varchar(255) DEFAULT NULL COMMENT 'cidr',
  KEY `idx_resource_qcloud_subnet_account_id` (`account_id`),
  KEY `idx_resource_qcloud_subnet_cloud` (`cloud`),
  KEY `idx_resource_qcloud_subnet_region` (`region`),
  KEY `idx_resource_qcloud_subnet_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_subnet_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_subnet_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_subnet_company` (`company`),
  KEY `idx_resource_qcloud_subnet_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud subnet 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qcloud_vpc`
--

DROP TABLE IF EXISTS `resource_qcloud_vpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qcloud_vpc` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cidr_block` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  KEY `idx_resource_qcloud_vpc_account_id` (`account_id`),
  KEY `idx_resource_qcloud_vpc_cloud` (`cloud`),
  KEY `idx_resource_qcloud_vpc_region` (`region`),
  KEY `idx_resource_qcloud_vpc_instance_id` (`instance_id`),
  KEY `idx_resource_qcloud_vpc_instance_name` (`instance_name`),
  KEY `idx_resource_qcloud_vpc_instance_status` (`instance_status`),
  KEY `idx_resource_qcloud_vpc_company` (`company`),
  KEY `idx_resource_qcloud_vpc_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qcloud vpc 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_bucket`
--

DROP TABLE IF EXISTS `resource_qingcloud_bucket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_bucket` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  KEY `idx_resource_qingcloud_bucket_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_bucket_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_bucket_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_bucket_region` (`region`),
  KEY `idx_resource_qingcloud_bucket_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_bucket_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_bucket_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_bucket_company` (`company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws s3 buckey 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_computing`
--

DROP TABLE IF EXISTS `resource_qingcloud_computing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_computing` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `cpu` longtext COMMENT 'cpu',
  `memory` longtext COMMENT '内存',
  `zone` longtext COMMENT 'zone',
  KEY `idx_resource_qingcloud_computing_private_ip` (`private_ip`),
  KEY `idx_resource_qingcloud_computing_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_computing_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_computing_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_computing_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_computing_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_computing_company` (`company`),
  KEY `idx_resource_qingcloud_computing_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_computing_region` (`region`),
  KEY `idx_resource_qingcloud_computing_public_ip` (`public_ip`),
  KEY `idx_resource_qingcloud_computing_e_ip` (`e_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qingcloud computing 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_eip`
--

DROP TABLE IF EXISTS `resource_qingcloud_eip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_eip` (
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `allocation_id` longtext COMMENT '地址分配的ID',
  `address_name` varchar(1000) DEFAULT NULL COMMENT 'eip名',
  `status` longtext COMMENT 'status',
  `instance_id` varchar(1000) DEFAULT NULL COMMENT 'eip的ID',
  `private_ip_address` longtext COMMENT '内网IP',
  `public_ip` longtext COMMENT '公网IP',
  `network_interface_id` longtext,
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  KEY `idx_resource_qingcloud_eip_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_eip_company` (`company`),
  KEY `idx_resource_qingcloud_eip_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_eip_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_eip_region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qingcloud eip 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_loadbalance`
--

DROP TABLE IF EXISTS `resource_qingcloud_loadbalance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_loadbalance` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `public_ip` varchar(191) DEFAULT NULL COMMENT '实例公网IP',
  `private_ip` varchar(191) DEFAULT NULL COMMENT '实例内网IP',
  `e_ip` varchar(191) DEFAULT NULL COMMENT '实例内网EIP',
  `dns_name` varchar(500) DEFAULT NULL COMMENT 'dns名字',
  KEY `idx_resource_qingcloud_loadbalance_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_loadbalance_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_loadbalance_company` (`company`),
  KEY `idx_resource_qingcloud_loadbalance_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_loadbalance_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_loadbalance_public_ip` (`public_ip`),
  KEY `idx_resource_qingcloud_loadbalance_private_ip` (`private_ip`),
  KEY `idx_resource_qingcloud_loadbalance_e_ip` (`e_ip`),
  KEY `idx_resource_qingcloud_loadbalance_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_loadbalance_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_loadbalance_region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='青云负载均衡表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_memcached`
--

DROP TABLE IF EXISTS `resource_qingcloud_memcached`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_memcached` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `nodes` bigint(20) DEFAULT NULL COMMENT '集群节点数',
  `zone` longtext COMMENT 'zone',
  `endpoint_address` longtext COMMENT 'address',
  `endpoint_port` int(11) DEFAULT NULL COMMENT 'port',
  KEY `idx_resource_qingcloud_memcached_company` (`company`),
  KEY `idx_resource_qingcloud_memcached_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_memcached_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_memcached_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_memcached_region` (`region`),
  KEY `idx_resource_qingcloud_memcached_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_memcached_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_memcached_instance_status` (`instance_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qingcloud memcached 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_mongodb`
--

DROP TABLE IF EXISTS `resource_qingcloud_mongodb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_mongodb` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `engine` longtext COMMENT '引擎',
  `engine_version` longtext COMMENT '引擎版本',
  `size` bigint(20) DEFAULT NULL COMMENT '节点数',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `subnet_group` longtext COMMENT '子网组',
  KEY `idx_resource_qingcloud_mongodb_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_mongodb_company` (`company`),
  KEY `idx_resource_qingcloud_mongodb_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_mongodb_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_mongodb_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_mongodb_region` (`region`),
  KEY `idx_resource_qingcloud_mongodb_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_mongodb_instance_name` (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='aws documentdb 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_mysql`
--

DROP TABLE IF EXISTS `resource_qingcloud_mysql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_mysql` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cpu` longtext COMMENT 'cpu',
  `memory` longtext COMMENT '内存',
  `engine_version` varchar(255) DEFAULT NULL COMMENT '引擎版本',
  `engine` varchar(255) DEFAULT NULL COMMENT '数据库引擎',
  `endpoint` varchar(255) DEFAULT NULL COMMENT '地址',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  `nodes` bigint(20) DEFAULT NULL,
  KEY `idx_resource_qingcloud_mysql_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_mysql_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_mysql_region` (`region`),
  KEY `idx_resource_qingcloud_mysql_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_mysql_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_mysql_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_mysql_company` (`company`),
  KEY `idx_resource_qingcloud_mysql_resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='mysql instance';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_redis`
--

DROP TABLE IF EXISTS `resource_qingcloud_redis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_redis` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cluster_enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用集群',
  `shards` bigint(20) DEFAULT NULL COMMENT 'number of shards',
  `nodes` bigint(20) DEFAULT NULL COMMENT 'number of nodes',
  KEY `idx_resource_qingcloud_redis_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_redis_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_redis_company` (`company`),
  KEY `idx_resource_qingcloud_redis_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_redis_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_redis_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_redis_region` (`region`),
  KEY `idx_resource_qingcloud_redis_instance_id` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qingcloud redis 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_security_group`
--

DROP TABLE IF EXISTS `resource_qingcloud_security_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_security_group` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `description` varchar(2000) DEFAULT NULL,
  KEY `idx_resource_qingcloud_security_group_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_security_group_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_security_group_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_security_group_company` (`company`),
  KEY `idx_resource_qingcloud_security_group_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_security_group_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_security_group_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_security_group_region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qingcloud security group 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_subnet`
--

DROP TABLE IF EXISTS `resource_qingcloud_subnet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_subnet` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `vpc_id` varchar(200) DEFAULT NULL COMMENT 'vpc id',
  `cidr` varchar(255) DEFAULT NULL COMMENT 'cidr',
  KEY `idx_resource_qingcloud_subnet_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_subnet_company` (`company`),
  KEY `idx_resource_qingcloud_subnet_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_subnet_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_subnet_cloud` (`cloud`),
  KEY `idx_resource_qingcloud_subnet_region` (`region`),
  KEY `idx_resource_qingcloud_subnet_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_subnet_instance_name` (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qingcloud subnet 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_qingcloud_vpc`
--

DROP TABLE IF EXISTS `resource_qingcloud_vpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_qingcloud_vpc` (
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `resource_id` varchar(191) DEFAULT NULL COMMENT '资源唯一标识',
  `account_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '云账号ID',
  `cloud` varchar(32) NOT NULL COMMENT '云厂商',
  `region` varchar(32) NOT NULL COMMENT '区域',
  `instance_id` varchar(1000) NOT NULL COMMENT '实例唯一标识',
  `instance_name` varchar(1000) DEFAULT NULL COMMENT '实例名',
  `instance_status` varchar(32) DEFAULT NULL COMMENT '实例状态',
  `instance_type` longtext COMMENT '实例类型',
  `charge_type` varchar(32) DEFAULT NULL COMMENT '付费类型',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `company` varchar(255) NOT NULL COMMENT '所属公司',
  `cidr_block` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  KEY `idx_resource_qingcloud_vpc_region` (`region`),
  KEY `idx_resource_qingcloud_vpc_instance_id` (`instance_id`),
  KEY `idx_resource_qingcloud_vpc_instance_name` (`instance_name`),
  KEY `idx_resource_qingcloud_vpc_instance_status` (`instance_status`),
  KEY `idx_resource_qingcloud_vpc_company` (`company`),
  KEY `idx_resource_qingcloud_vpc_resource_id` (`resource_id`),
  KEY `idx_resource_qingcloud_vpc_account_id` (`account_id`),
  KEY `idx_resource_qingcloud_vpc_cloud` (`cloud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='qingcloud vpc 资源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_tag`
--

DROP TABLE IF EXISTS `resource_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(1000) NOT NULL COMMENT 'tag key',
  `value` varchar(1000) NOT NULL COMMENT 'tag value',
  PRIMARY KEY (`id`),
  KEY `idx_resource_tag_key` (`key`),
  KEY `idx_resource_tag_value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=7001 DEFAULT CHARSET=utf8 COMMENT='资源标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zhongxin_purchase`
--

DROP TABLE IF EXISTS `zhongxin_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zhongxin_purchase` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` varchar(191) NOT NULL COMMENT '中信订单ID',
  `request_id` varchar(191) NOT NULL,
  `purchase_status` longtext COMMENT '中信订单状态',
  `auto_pay` tinyint(1) DEFAULT NULL,
  `cloud_order_id` longtext COMMENT '云厂商订单ID',
  `instance_id` longtext COMMENT '云厂商实例ID',
  `cloud_order_status` longtext COMMENT '云厂商订单状态',
  PRIMARY KEY (`id`),
  KEY `idx_zhongxin_purchase_purchase_id` (`purchase_id`),
  KEY `idx_zhongxin_purchase_request_id` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='中信订单表，包括云厂商订单信息';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-21 18:47:24
