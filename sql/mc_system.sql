-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: mc_system
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

--
-- Current Database: `mc_system`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mc_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `mc_system`;

--
-- Table structure for table `platform_app`
--

DROP TABLE IF EXISTS `platform_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform_app` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `app_name` varchar(100) NOT NULL COMMENT '应用名称',
  `app_key` varchar(100) NOT NULL COMMENT '应用key',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `domain` varchar(20) NOT NULL DEFAULT '' COMMENT '公司',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='平台应用表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform_app`
--

LOCK TABLES `platform_app` WRITE;
/*!40000 ALTER TABLE `platform_app` DISABLE KEYS */;
INSERT INTO `platform_app` VALUES (1,'openc3','f2d5833efd0548568959fd57238084c4','2022-04-25 11:06:13','','openc3'),(2,'citic','71f1302555ca4e68b4a69bc73ee907a9','2022-05-13 06:52:46','','citic client');
/*!40000 ALTER TABLE `platform_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_domain_menu`
--

DROP TABLE IF EXISTS `sys_domain_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_domain_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `menu_code` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单code',
  `version_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '菜单版本id',
  PRIMARY KEY (`id`),
  KEY `idx_sys_domain_menu_domain_id` (`domain_id`),
  KEY `idx_sys_domain_menu_menu_code` (`menu_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='系统主体开通模块记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_domain_menu`
--

LOCK TABLES `sys_domain_menu` WRITE;
/*!40000 ALTER TABLE `sys_domain_menu` DISABLE KEYS */;
INSERT INTO `sys_domain_menu` VALUES (1,7,'',2),(2,2,'',2),(3,8,'',2),(4,6,'',2),(5,5,'',92),(6,3,'',2);
/*!40000 ALTER TABLE `sys_domain_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `product` varchar(20) NOT NULL DEFAULT '' COMMENT '产品',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `code` varchar(100) NOT NULL DEFAULT '' COMMENT '代码',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '层级',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序标记',
  `disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否在列表隐藏',
  `svg` varchar(100) NOT NULL DEFAULT '' COMMENT 'svg',
  `meta` varchar(200) NOT NULL DEFAULT '' COMMENT 'meta',
  `link` varchar(200) NOT NULL DEFAULT '' COMMENT '连接地址',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sys_menu_code` (`code`),
  KEY `idx_sys_menu_pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=90501 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'business','资源服务','resources',0,1,0,0,'','{\"left\":true}','/resources'),(2,'business','费用服务','cost',0,1,10,0,'','{\"left\":true}','/cost'),(3,'business','监控告警','monitor',0,1,0,0,'','{\"left\":true}','/monitor'),(4,'business','发布服务','deploy',0,1,20,1,'','{\"left\":true}',''),(5,'business','工单管理','workOrder',0,1,25,0,'','{\"left\":true}','/workOrder'),(6,'business','流程服务','bpm',0,1,30,1,'','{\"left\":true}',''),(7,'business','KubeStar','kubestar',0,1,0,0,'','{\"left\":true}','/kubestar'),(8,'business','云治理','gover',0,1,40,1,'','{\"left\":true}',''),(9,'system','基础服务','base',0,1,0,0,'','{\"left\":true,\"title\":\"基础服务\"}','/base'),(10,'system','消息服务','message',0,1,5,0,'','{\"left\":true,\"title\":\"消息服务\"}','/message'),(11,'system','系统设置','setting',0,1,10,0,'','{\"left\":true,\"title\":\"系统设置\"}','/setting'),(12,'system','文档服务','document',0,1,15,1,'','{\"left\":true,\"title\":\"文档服务\"}',''),(13,'system','开发者中心','developer',0,1,20,1,'','{\"left\":true,\"title\":\"开发者中心\"}',''),(14,'system','客户中心','customer',0,1,0,1,'','{\"left\":true,\"title\":\"客户中心\"}','/customer'),(15,'system','日志管理','log',0,1,30,0,'','{\"left\":true,\"title\":\"日志管理\"}','/log'),(16,'system','平台管理','platform',0,1,35,0,'','{\"left\":true,\"title\":\"平台管理\"}','/platform'),(100,'business','资源总览','resources.overview',1,2,0,0,'resources-overview','{\"left\":true,\"title\":\"资源总览\"}','/resources/overview'),(101,'business','资源检索','resources.retrieval',1,2,0,0,'resources-retrieval','{\"left\":treu,\"title\":\"资源检索\"}','/resources/retrieval'),(102,'business','资源服务配置','resources.config',1,2,5,0,'resources-config','{\"left\":true,\"title\":\"资源服务配置\"}','/resources/config'),(103,'business','主机','resources.compute',1,2,10,0,'resources-compute','{\"left\":true,\"title\":\"云服务器\"}','/resources/compute/cloudServer'),(104,'business','网络','resources.networking',1,2,15,0,'resources-network','{\"left\":true,\"title\":\"网络\"}','/resources/networking/securityGroup'),(105,'business','数据库','resources.dataBase',1,2,20,0,'resources-dataBase','{\"left\":true,\"title\":\"数据库\"}','/resources/dataBase/mysql'),(106,'business','对象存储','resources.storage',1,2,25,0,'resources-storage','{\"left\":true,\"title\":\"对象存储\"}','/resources/storage/bucket'),(108,'business','配额管理','resources.quota',1,2,8,0,'cost-base','{\\\"left\\\":true,\\\"title\\\":\\\"配额管理\\\"}','/resources/quota'),(109,'business','资源引导','resources.guide',1,2,0,0,'resources-guide','{\"left\":true,\"title\":\"资源引导\"}','/resources/guide'),(111,'business','硬盘','resources.disk',1,2,11,0,'resources-disk','{\"left\":true,\"title\":\"硬盘\"}','/resources/disk'),(200,'business','账单数据概览','cost.billData',2,2,5,1,'saas-bill-data','{\"left\":true,\"title\":\"账单数据概览\"}','/cost/billData'),(201,'business','服务配置','cost.config',2,2,0,0,'saas-config','{\"left\":true,\"title\":\"服务配置\"}','/cost/config'),(202,'business','基础配置','cost.base',2,2,15,0,'saas-base','{\"left\":true,\"title\":\"基础配置\"}','/cost/base/discount'),(204,'business','账单管理','cost.bill',2,2,25,0,'saas-bill','{\"left\":true,\"title\":\"账单管理\"}','/cost/bill'),(205,'business','信息统计查询','cost.statistics',2,2,30,0,'saas-bill-statistics','{\"left\":true,\"title\":\"信息统计查询\"}','/cost/statistics'),(300,'','监控配置','monitor.config',3,2,1,0,'monitor-config','null','/monitor/config'),(301,'','云监控','monitor.cloud',3,2,0,0,'monitor-cloud','null','/monitor/cloud'),(302,'','服务配置','monitor.server',3,2,0,0,'monitor-server','null','/monitor/server'),(303,'','监控组管理','monitor.group',3,2,3,0,'monitor-group','null','/monitor/group'),(304,'','值班管理(OnCall)','monitor.onDuty',3,2,4,0,'monitor-onDuty','null','/monitor/onDuty'),(305,'','邮件监控','monitor.email',3,2,5,0,'monitor-email','null','/monitor/email'),(306,'','监控告警报告','monitor.report',3,2,6,0,'monitor-report','null','/monitor/report'),(500,'business','工单总览','workOrder.home',5,2,0,0,'order-home','{}','/workOrder/home'),(501,'business','工单管理','workOrder.workOrderMGMT',5,2,5,0,'order-list','{}','/workOrder/workOrderMGMT'),(502,'business','审批管理','workOrder.approvalMGMT',5,2,10,0,'order-approval','{}','/workOrder/approvalMGMT'),(503,'business','后台管理','workOrder.manage',5,2,15,0,'order-manage','{}','/workOrder/manage'),(700,'business','总览','kubestar.overview',7,2,0,0,'kubestar-overview','null','/kubestar/overview'),(701,'','应用','kubestar.app',7,2,0,0,'kubestar-app','null','/kubestar/app'),(702,'','集群','kubestar.cluster',7,2,0,0,'cluster','null','/kubestar/cluster'),(703,'','命名空间','kubestar.namespace',7,2,0,0,'namespace','null','/kubestar/namespace'),(704,'','存储卷','kubestar.volume',7,2,0,0,'persistentVolume','null','/kubestar/volume'),(705,'','存储类型','kubestar.storageClass',7,2,0,0,'storageClass','null','/kubestar/storageClass'),(706,'','服务','kubestar.service',7,2,0,0,'service','null','/kubestar/service'),(707,'','配置','kubestar.config',7,2,0,0,'configMap','null','/kubestar/config'),(708,'','Dashboard','kubestar.dashboard',7,2,0,0,'dashboard','null','/kubestar/dashboard'),(709,'','IAM','kubestar.iam',7,2,0,0,'role','null','/kubestar/iam'),(710,'','镜像仓库管理','kubestar.image',7,2,0,0,'image','null','/kubestar/image'),(711,'','集群管理','kubestar.clusterManage',7,2,0,0,'cluster','null','/kubestar/clusterManage'),(712,'','工具集','kubestar.tool',7,2,0,0,'tool','null','/kubestar/tool'),(900,'system','用户管理','base.user',9,2,0,0,'saas-user1','{\"left\":true,\"title\":\"用户管理\"}','/base/user'),(901,'system','角色管理','base.role',9,2,4,0,'saas-role1','{\"left\":true,\"title\":\"角色管理\"}','/base/role'),(902,'system','组织机构','base.organization',9,2,2,0,'saas-org','{\"left\":true,\"title\":\"组织机构\"}','/base/organization'),(903,'system','云账号管理','base.account',9,2,3,0,'saas-cloud','{\"left\":true,\"title\":\"云账号管理\"}','/base/account'),(904,'system','身份提供商','base.identity',9,2,5,0,'saas-project','{\"left\":true,\"title\":\"身份提供商\"}','/base/identity'),(905,'system','外部身份源','base.identitySource',9,2,7,0,'saas-identity','{\"left\":true,\"title\":\"外部身份源\"}','/base/identitySource'),(906,'system','用户组管理','base.group',9,2,0,0,'userGroup','null','/base/group'),(907,'','堡垒机','base.bastionhost',9,2,6,0,'base-bastionhost','null','/base/bastionhost'),(1003,'system','消息设置','message.setting',10,2,15,0,'saas-bill-statistics','{\"left\":true,\"title\":\"消息设置\"}','/message/setting'),(1100,'system','邮箱管理','setting.email',11,2,0,0,'','{\"left\":true,\"title\":\"邮箱管理\"}','/setting/email'),(1400,'business','客户信息中心','cost.base.customer',202,3,10,0,'saas-info','{\"left\":true,\"title\":\"平台客户中心\"}','/cost/base/customer'),(1500,'system','操作日志','log.operation',15,2,0,0,'saas-info','{\"left\":true,\"title\":\"操作日志\"}','/log/operation'),(1600,'system','企业列表','platform.list',16,2,0,0,'saas-info','{\"left\":true,\"title\":\"企业列表\"}','/platform/list'),(1601,'system','企业权限','platform.role',16,2,5,0,'saas-info','{\"left\":true,\"title\":企业权限}','/platform/role'),(1602,'system','菜单管理','platform.menu',16,2,10,0,'','{}','/platform/menu'),(10100,'business','项目管理','resources.config.project',102,3,0,0,'','{\"left\":true,\"title\":\"项目管理\"}','/resources/config/project'),(10101,'business','服务树管理','resources.config.tree',102,3,5,0,'','{\"left\":true,\"title\":\"服务树管理\"}','/resources/config/tree'),(10102,'business','标签','resources.config.labelManagement',102,3,10,0,'','{\"left\":true,\"title\":\"标签\"}','/resources/config/labelManagement'),(10200,'business','云服务器','resources.compute.cloudServer',103,3,0,0,'','{\"left\":true,\"title\":\"云服务器\"}','/resources/compute/cloudServer'),(10300,'business','安全组','resources.networking.securityGroup',104,3,0,0,'','{\"left\":true,\"title\":\"安全组\"}','/resources/networking/securityGroup'),(10301,'business','VPC','resources.networking.vpc',104,3,5,0,'','{\"left\":true,\"title\":\"VPC\"}','/resources/networking/vpc'),(10302,'business','子网','resources.networking.subnet',104,3,10,0,'','{\"left\":true,\"title\":\"子网\"}','/resources/networking/subnet'),(10303,'business','LB','resources.networking.lb',104,3,15,0,'','{\"left\":true,\"title\":\"LB\"}','/resources/networking/lb'),(10304,'business','弹性公网IP','resources.networking.eip',104,3,20,0,'','{\"left\":true,\"title\":\"弹性公网IP\"}','/resources/networking/eip'),(10400,'business','mysql','resources.dataBase.mysql',105,3,0,0,'','{\"left\":true,\"title\":\"mysql\"}','/resources/dataBase/mysql'),(10401,'business','mongoDB','resources.dataBase.mongoDB',105,3,5,0,'','{\"left\":true,\"title\":\"mongoDB\"}','/resources/dataBase/mongoDB'),(10402,'business','memcached','resources.dataBase.memcached',105,3,10,0,'','{\"left\":true,\"title\":\"memcached\"}','/resources/dataBase/memcached'),(10403,'business','redis','resources.dataBase.redis',105,3,15,0,'','{\"left\":true,\"title\":\"redis\"}','/resources/dataBase/redis'),(10406,'business','oceanBase','resources.networking.sharedBandwidth',104,3,30,0,'','{}','/resources/networking/sharedBandwidth'),(10500,'business','存储桶','resources.storage.bucket',106,3,0,0,'','{\"left\":true,\"title\":\"存储桶\"}','/resources/storage/bucket'),(10504,'business','oceanBase','resources.dataBase.oceanBase',105,3,20,0,'','{}','/resources/dataBase/oceanBase'),(10505,'business','polarDB','resources.dataBase.polarDB',105,3,20,0,'','{}','/resources/dataBase/polarDB'),(10800,'business','应用配额','resources.quota.appQuota',108,3,0,0,'','{\\\"left\\\":true,\\\"title\\\":\\\"应用配额\\\"}','/resources/quota/appQuota'),(11100,'business','云硬盘','resources.disk.cloudDrive',111,3,0,0,'','{\"left\":true,\"title\":\"云硬盘\"}','/resources/disk/cloudDrive'),(20202,'business','账单模版管理','cost.base.template',202,3,20,1,'','{\"left\":true,\"title\":\"账单模版管理\"}','/cost/base/template'),(20203,'business','签约主体管理','cost.base.contract',202,3,3,0,'','{\"left\":true,\"title\":\"签约主体管理\"}','/cost/base/contract'),(20204,'business','折扣拆分配置','cost.base.discountSplit',202,3,15,0,'','{}','/cost/base/discountSplit'),(20205,'business','账单数据同步','cost.base.billSync',202,3,0,0,'','{}','/cost/base/billSync'),(20500,'business','账单查询','cost.statistics.bill',205,3,0,0,'','{\"left\":true,\"title\":\"账单查询\"}','/cost/statistics/bill'),(20501,'business','预付款查询','cost.statistics.payment',205,3,5,0,'','{\"left\":true,\"title\":\"预付款查询\"}','/cost/statistics/payment'),(20502,'business','预警信息查询','cost.statistics.warning',205,3,10,0,'','{\"left\":true,\"title\":\"预警信息查询\"}','/cost/statistics/warning'),(20503,'business','代金券查询','cost.statistics.credit',205,3,15,0,'','{\"left\":true,\"title\":\"代金券查询\"}','/cost/statistics/credit'),(50300,'business','工作组管理','workOrder.manage.workGroupMGMT',503,3,0,0,'personal-setting','{}','/workOrder/manage/workGroupMGMT'),(50301,'business','岗位管理','workOrder.manage.jobsMGMT',503,3,5,0,'personal-setting','{}','/workOrder/manage/jobsMGMT'),(50302,'business','SLA管理','workOrder.manage.slaMGMT',503,3,10,0,'personal-setting','{}','/workOrder/manage/slaMGMT'),(50303,'business','配置C.T.I','workOrder.manage.configCTI',503,3,15,0,'personal-setting','{}','/workOrder/manage/configCTI'),(70100,'','无状态应用','kubestar.app.Deployment',701,3,0,0,'','null','/kubestar/app/Deployment'),(70101,'','有状态应用','kubestar.app.StatefulSet',701,3,0,0,'','null','/kubestar/app/StatefulSet'),(70102,'','定时任务','kubestar.app.CronJob',701,3,0,0,'','null','/kubestar/app/CronJob'),(70103,'','守护者进程','kubestar.app.DaemonSet',701,3,0,0,'','null','/kubestar/app/DaemonSet'),(70200,'','集群列表','kubestar.cluster.list',702,3,0,0,'','null','/kubestar/cluster/list'),(70300,'','命名空间列表','kubestar.namespace.list',703,3,0,0,'','null','/kubestar/namespace/list'),(70400,'','存储卷列表','kubestar.volume.list',704,3,0,0,'','null','/kubestar/volume/list'),(70401,'','存储卷申请','kubestar.volume.apply',704,3,0,0,'','null','/kubestar/volume/apply'),(70500,'','存储类型列表','kubestar.storageClass.list',705,3,0,0,'','null','/kubestar/storageClass/list'),(70600,'','服务列表','kubestar.service.list',706,3,0,0,'','null','/kubestar/service/list'),(70601,'','Ingress','kubestar.service.ingress',706,3,0,0,'','null','/kubestar/ingress/list'),(70700,'','配置列表','kubestar.config.list',707,3,0,0,'','null','/kubestar/config/list'),(70701,'','秘钥','kubestar.config.secret',707,3,0,0,'','null','/kubestar/config/secret'),(70800,'','自定义监控面板','kubestar.dashboard.custom',708,3,0,0,'','null','/kubestar/dashboard/custom/category'),(70900,'','企业列表','kubestar.iam.enterprise',709,3,0,0,'','null','/kubestar/iam/enterprise/list'),(70901,'','用户组列表','kubestar.iam.group',709,3,0,0,'','null','/kubestar/iam/group/list'),(70902,'','角色列表','kubestar.iam.role',709,3,0,0,'','null','/kubestar/iam/role/list'),(70903,'','用户列表','kubestar.iam.user',709,3,0,0,'','null','/kubestar/iam/user/list'),(71000,'','镜像仓库列表','kubestar.image.list',710,3,0,0,'','null','/kubestar/image/list'),(71001,'','添加镜像仓库','kubestar.image.add',710,3,0,0,'','null','/kubestar/image/add'),(71100,'','集群列表','kubestar.clusterManage.list',711,3,0,0,'','null','/kubestar/clusterManage/list'),(71101,'','添加集群','kubestar.clusterManage.add',711,3,0,0,'','null','/kubestar/clusterManage/add'),(71200,'','集群监控','kubestar.tool.cluster',712,3,0,0,'','null','/kubestar/tool/cluster'),(71201,'','一键发布','kubestar.tool.publish',712,3,0,0,'','null','/kubestar/tool/publish'),(90500,'system','企业身份源','base.identitySource.enterprise',905,3,0,0,'','','/base/identitySource/enterprise');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu_version`
--

DROP TABLE IF EXISTS `sys_menu_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu_version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '版本名称',
  `domain_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '公司类型',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='菜单版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu_version`
--

LOCK TABLES `sys_menu_version` WRITE;
/*!40000 ALTER TABLE `sys_menu_version` DISABLE KEYS */;
INSERT INTO `sys_menu_version` VALUES (1,'用户',1,'2022-05-23 08:15:52'),(2,'企业版',2,'2022-05-23 08:15:52'),(3,'超管',3,'2022-05-23 08:15:52'),(92,'基础服务测试',0,'2022-06-02 06:44:06');
/*!40000 ALTER TABLE `sys_menu_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu_version_detail`
--

DROP TABLE IF EXISTS `sys_menu_version_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu_version_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `code` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单编码',
  `version_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '版本id',
  PRIMARY KEY (`id`),
  KEY `idx_sys_menu_version_detail_code` (`code`),
  KEY `idx_sys_menu_version_detail_version_id` (`version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8 COMMENT='菜单版本详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu_version_detail`
--

LOCK TABLES `sys_menu_version_detail` WRITE;
/*!40000 ALTER TABLE `sys_menu_version_detail` DISABLE KEYS */;
INSERT INTO `sys_menu_version_detail` VALUES (1,'base',1),(2,'base.user',1),(3,'base.role',1),(4,'base.organization',1),(5,'base.account',1),(6,'base.identity',1),(14,'resources.overview',2),(15,'resources.retrieval',2),(23,'cost.config',2),(26,'cost.bill',2),(28,'base.user',2),(29,'base.role',2),(30,'base.organization',2),(31,'base.account',2),(32,'base.identity',2),(33,'message.setting',2),(34,'setting.email',2),(35,'cost.base.customer',2),(36,'log.operation',2),(37,'resources.config.project',2),(38,'resources.config.tree',2),(39,'resources.config.labelManagement',2),(40,'resources.compute.cloudServer',2),(41,'resources.networking.securityGroup',2),(42,'resources.networking.vpc',2),(43,'resources.networking.subnet',2),(44,'resources.networking.lb',2),(45,'resources.networking.eip',2),(46,'resources.dataBase.mysql',2),(47,'resources.dataBase.mongoDB',2),(48,'resources.dataBase.memcached',2),(49,'resources.dataBase.redis',2),(50,'resources.storage.bucket',2),(54,'cost.base.contract',2),(55,'cost.statistics.bill',2),(56,'cost.statistics.payment',2),(57,'cost.statistics.warning',2),(58,'cost.statistics.credit',2),(60,'base.user',3),(61,'base.role',3),(63,'platform.list',3),(64,'platform.role',3),(66,'resources.quota.appQuota',2),(85,'base.identitySource',1),(86,'base.identitySource.enterprise',2),(108,'resources.guide',2),(110,'resources.disk.cloudDrive',2),(111,'cost.base.discountSplit',2),(112,'cost.base.billSync',2),(113,'base.user',92),(114,'base.role',92),(115,'base.organization',92),(116,'base.account',92),(117,'base.identity',92),(119,'workOrder.home',2),(121,'workOrder.workOrderMGMT',2),(122,'workOrder.approvalMGMT',2),(124,'workOrder.manage.workGroupMGMT',2),(125,'workOrder.manage.jobsMGMT',2),(126,'workOrder.manage.slaMGMT',2),(127,'workOrder.manage.configCTI',2),(128,'platform.menu',3),(131,'kubestar.overview',2),(132,'kubestar.app.Deployment',2),(133,'kubestar.app.StatefulSet',2),(134,'kubestar.app.CronJob',2),(135,'kubestar.app.DaemonSet',2),(136,'kubestar.cluster.list',2),(137,'kubestar.namespace.list',2),(138,'kubestar.volume.list',2),(139,'kubestar.volume.apply',2),(140,'kubestar.storageClass.list',2),(141,'kubestar.service.list',2),(142,'kubestar.service.ingress',2),(143,'kubestar.config.list',2),(144,'kubestar.config.secret',2),(145,'kubestar.dashboard.custom',2),(146,'kubestar.iam.enterprise',2),(147,'kubestar.iam.group',2),(148,'kubestar.iam.role',2),(149,'kubestar.iam.user',2),(150,'kubestar.image.list',2),(151,'kubestar.image.add',2),(152,'kubestar.clusterManage.list',2),(153,'kubestar.clusterManage.add',2),(154,'kubestar.tool.cluster',2),(155,'kubestar.tool.publish',2),(156,'base.group',2),(157,'base.bastionhost',2),(158,'monitor.config',2),(159,'monitor.cloud',2),(160,'monitor.server',2),(161,'monitor.group',2),(162,'monitor.onDuty',2),(163,'monitor.email',2),(164,'monitor.report',2);
/*!40000 ALTER TABLE `sys_menu_version_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_permission`
--

DROP TABLE IF EXISTS `sys_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `module` varchar(100) NOT NULL DEFAULT '' COMMENT '模块名称',
  `action` varchar(100) NOT NULL COMMENT '操作名称',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '权限名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8 COMMENT='权限信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permission`
--

LOCK TABLES `sys_permission` WRITE;
/*!40000 ALTER TABLE `sys_permission` DISABLE KEYS */;
INSERT INTO `sys_permission` VALUES (1,'base.organization','create','新增组织'),(2,'base.organization','get','查询组织'),(3,'base.organization','update','编辑组织'),(4,'base.organization','delete','删除组织'),(5,'base.role','create','新增角色'),(6,'base.role','get','查询角色'),(7,'base.role','update','编辑角色'),(8,'base.role','delete','删除角色'),(9,'base.role','configPerm','配置操作权限'),(10,'base.role','configAccount','配置云账号'),(11,'base.user','get','查询用户'),(13,'base.user','update','编辑用户'),(14,'base.user','delete','删除用户'),(16,'base.user','freezeThaw','冻结/解冻'),(17,'base.user','invite','邀请协作者'),(18,'base.user','resetPwd','重置密码'),(21,'base.group','create','新增用户组'),(22,'base.group','update','编辑用户组'),(23,'base.group','delete','删除用户组'),(24,'base.account','get','查询云账号'),(25,'base.account','create','添加云账号'),(26,'base.account','update','编辑云账号'),(27,'base.account','delete','删除云账号'),(28,'base.account','import','导入云账号'),(29,'base.account','configBill','账单存储配置'),(30,'base.account','configSSO','SSO登录配置'),(31,'base.identity','get','查询提供商'),(32,'base.identity','create','新建提供商'),(33,'base.identity','update','编辑提供商'),(34,'base.identity','delete','删除提供商'),(35,'base.identity','download','下载元文件'),(36,'cost.base.customer','get','查询客户信息'),(37,'cost.base.customer','create','新增客户信息'),(38,'cost.base.customer','update','编辑客户信息'),(39,'cost.base.customer','delete','删除客户信息'),(40,'cost.base.customer','import','导入客户信息'),(41,'cost.base.discount','get','查看折扣规则'),(42,'cost.base.discount','create','新增折扣规则'),(43,'cost.base.discount','update','编辑折扣规则'),(44,'cost.base.discount','delete','删除折扣规则'),(45,'cost.base.discount','copy','复制折扣规则'),(46,'cost.base.discount','start','启用折扣规则'),(47,'cost.base.discount','stop','停用折扣规则'),(48,'cost.base.split','get','查看拆分规则'),(49,'cost.base.split','create','新增拆分规则'),(50,'cost.base.split','update','编辑拆分规则'),(51,'cost.base.split','delete','删除拆分规则'),(52,'cost.base.split','copy','复制拆分规则'),(53,'cost.base.split','start','启用拆分规则'),(54,'cost.base.split','stop','停用拆分规则'),(55,'cost.base.template','get','查看模板'),(56,'cost.base.template','create','新增模板'),(57,'cost.base.template','update','编辑模板'),(58,'cost.base.template','delete','删除模板'),(59,'cost.base.template','copy','复制模板'),(60,'cost.base.template','start','启用模板'),(61,'cost.base.template','stop','停用模板'),(62,'cost.base.contract','get','查看账单主体'),(63,'cost.base.contract','create','新增账单主体'),(64,'cost.base.contract','update','编辑账单主体'),(65,'cost.base.contract','delete','删除账单主体'),(66,'cost.data','sync','同步账单'),(67,'cost.bill','get','账单管理-查看账单'),(68,'cost.bill','create','账单管理-生成账单'),(69,'cost.bill','delete','账单管理-删除已生成账单'),(70,'cost.bill','download','账单管理-下载账单'),(71,'cost.bill','email','账单管理-邮件发送'),(72,'cost.bill','config','账单管理-产品折扣配置'),(73,'cost.statistics.payment','get','预付款管理-查看预付款账单'),(74,'cost.statistics.payment','recharge','预付款管理-预付款充值'),(75,'cost.statistics.payment','config','预付款管理-更新预警策略'),(76,'cost.statistics.bill','get','账单查询-查看账单'),(77,'cost.statistics.warning','get','账单预警-查看预警信息'),(78,'cost.statistics.credit','get','代金券查询-查看代金券'),(79,'resources.overview','get','资源总览-查看资源'),(80,'resources.config.project','get','项目管理-查看项目'),(81,'resources.config.project','create','项目管理-新增项目'),(82,'resources.config.project','update','项目管理-编辑项目'),(83,'resources.config.project','delete','项目管理-删除项目'),(84,'resources.config.project','createApp','项目管理-创建应用'),(85,'resources.config.project','updateApp','项目管理-编辑应用'),(86,'resources.config.project','deleteApp','项目管理-删除应用'),(87,'resources.config.project','configRule','项目管理-配置规则'),(88,'resources.config.project','removeRule','项目管理-移出规则'),(89,'resources.config.project','createRes','项目管理-添加资源'),(90,'resources.config.project','removeRes','项目管理-移除资源'),(91,'resources.config.tree','get','服务树-查看服务树'),(92,'resources.config.tree','addProject','服务树-添加项目'),(93,'resources.config.tree','removeProject','服务树-移除项目'),(94,'resources.config.tree','addLeader','服务树-添加负责人'),(95,'resources.config.tree','removeLeader','服务树-移除负责人'),(96,'resources.compute.cloudServer','get','云服务器-查看云服务器'),(97,'resources.compute.cloudServer','export','云服务器-导出资源清单'),(98,'resources.networking.securityGroup','get','安全组-查看资源'),(99,'resources.networking.vpc','get','VPC-查看资源'),(100,'resources.networking.subnet','get','子网-查看资源'),(101,'resources.networking.lb','get','负载均衡-查看资源'),(102,'resources.networking.eip','get','弹性IP-查看资源'),(103,'resources.dataBase.mysql','get','mysql-查看资源'),(104,'resources.dataBase.mongoDB','get','mongoDB-查看资源'),(105,'resources.dataBase.memcached','get','memcached-查看资源'),(106,'resources.dataBase.redis','get','redis-查看资源'),(107,'resources.storage.bucket','get','存储桶-查看资源'),(108,'message.setting','config','消息设置-配置消息'),(109,'setting.email','get','邮箱设置-查看邮箱'),(110,'log.operation','get','操作日志-查看操作日志'),(111,'resources.retrieval','get','资源检索'),(112,'resources.apply','get','资源申请'),(113,'resources.apply','create','资源申请-创建'),(114,'resources.quota.appQuota','get','应用配额'),(115,'base.identitySource.enterprise','get','企业身份源-查看'),(116,'base.organization','transfer',' 组织转移'),(117,'base.role','configGroup','配置用户组'),(118,'base.role','configUser','配置用户'),(119,'base.group','addUser','添加用户'),(120,'base.group','removeUser','移除用户'),(121,'resources.guide','get','资源引导-查看'),(122,'cost.config','get','服务配置-查看'),(123,'resources.disk','get','硬盘-查看'),(124,'resources.disk.cloudDrive','get','云硬盘-查看'),(125,'cost.base.discountSplit','get','折扣拆分配置-查看'),(126,'cost.base.billSync','get','账单数据同步-查看'),(127,'resources.networking.sharedBandwidth','get','oceanBase-查看'),(128,'resources.dataBase.oceanBase','get','oceanBase-查看'),(129,'resources.dataBase.polarDB','get','polarDB-查看'),(130,'workOrder.home','get','工单总览-查看'),(131,'workOrder.workOrderMGMT','get','工单管理-查看'),(132,'workOrder.approvalMGMT','get','审批管理-查看'),(134,'workOrder.manage.workGroupMGMT','get','工作组管理-查看'),(135,'workOrder.manage.jobsMGMT','get','岗位管理-查看'),(136,'workOrder.manage.slaMGMT','get','SLA管理-查看'),(137,'workOrder.manage.configCTI','get','配置C.T.I-查看'),(139,'platform.menu','get','菜单管理-查看'),(140,'base.group','get','用户组管理-查看'),(142,'kubestar.overview','get','总览-查看'),(143,'kubestar.app','get','应用-查看'),(144,'kubestar.app.Deployment','get','无状态应用-查看'),(145,'kubestar.app.StatefulSet','get','有状态应用-查看'),(146,'kubestar.app.CronJob','get','定时任务-查看'),(147,'kubestar.app.DaemonSet','get','守护者进程-查看'),(148,'kubestar.cluster','get','集群-查看'),(149,'kubestar.cluster.list','get','集群列表-查看'),(150,'kubestar.namespace','get','命名空间-查看'),(151,'kubestar.namespace.list','get','命名空间列表-查看'),(152,'kubestar.volume','get','存储卷-查看'),(153,'kubestar.volume.list','get','存储卷列表-查看'),(154,'kubestar.volume.apply','get','存储卷申请-查看'),(155,'kubestar.storageClass','get','存储类型-查看'),(156,'kubestar.storageClass.list','get','存储类型列表-查看'),(157,'kubestar.service','get','服务-查看'),(158,'kubestar.service.list','get','服务列表-查看'),(159,'kubestar.service.ingress','get','Ingress-查看'),(160,'kubestar.config','get','配置-查看'),(161,'kubestar.config.list','get','配置列表-查看'),(162,'kubestar.config.secret','get','秘钥-查看'),(163,'kubestar.dashboard','get','Dashboard-查看'),(164,'kubestar.dashboard.custom','get','自定义监控面板-查看'),(165,'kubestar.iam','get','IAM-查看'),(166,'kubestar.iam.enterprise','get','企业列表-查看'),(167,'kubestar.iam.group','get','用户组列表-查看'),(168,'kubestar.iam.role','get','角色列表-查看'),(169,'kubestar.iam.user','get','用户列表-查看'),(170,'kubestar.image','get','镜像仓库管理-查看'),(171,'kubestar.image.list','get','镜像仓库列表-查看'),(172,'kubestar.image.add','get','添加镜像仓库-查看'),(173,'kubestar.clusterManage','get','集群管理-查看'),(174,'kubestar.clusterManage.list','get','集群列表-查看'),(175,'kubestar.clusterManage.add','get','添加集群-查看'),(176,'kubestar.tool','get','工具集-查看'),(177,'kubestar.tool.cluster','get','集群监控-查看'),(178,'kubestar.tool.publish','get','一键发布-查看'),(179,'base.bastionhost','get','堡垒机-查看'),(180,'monitor.config','get','监控配置-查看'),(183,'openc3','openc3_job_read','读取job的信息【服务树相关】'),(184,'openc3','openc3_job_write','修改job的配置【服务树相关】'),(185,'openc3','openc3_job_delete','删除job的配置【服务树相关】'),(186,'openc3','openc3_job_vssh','使用虚拟终端【服务树相关】'),(187,'openc3','openc3_job_read','读取job的信息【服务树相关】'),(188,'openc3','openc3_job_write','修改job的配置【服务树相关】'),(189,'openc3','openc3_job_delete','删除job的配置【服务树相关】'),(190,'openc3','openc3_job_vssh','使用虚拟终端【服务树相关】'),(191,'openc3','openc3_job_read','读取job的信息【服务树相关】'),(192,'openc3','openc3_job_write','修改job的配置【服务树相关】'),(193,'openc3','openc3_job_delete','删除job的配置【服务树相关】'),(194,'openc3','openc3_job_vssh','使用虚拟终端【服务树相关】'),(195,'openc3','openc3_job_vsshnobody','使用nobody用户的虚拟终端【服务树相关】'),(196,'openc3','openc3_job_control','操作job【服务树相关】'),(197,'openc3','openc3_job_root','job管理员【服务树无关】'),(198,'openc3','openc3_jobx_read','读取jobx的信息【服务树相关】'),(199,'openc3','openc3_jobx_write','修改jobx的配置 【服务树相关】'),(200,'openc3','openc3_jobx_delete','删除jobx的配置【服务树相关】'),(201,'openc3','openc3_jobx_control','操作jobx【服务树相关】'),(202,'openc3','openc3_jobx_root','jobx管理员【服务树无关】'),(203,'openc3','openc3_ci_read','读取ci的信息【服务树相关】'),(204,'openc3','openc3_ci_write','修改ci的配置【服务树相关】'),(205,'openc3','openc3_ci_delete','删除ci的配置【服务树相关】'),(206,'openc3','openc3_ci_control','操作ci【服务树相关】'),(207,'openc3','openc3_ci_root','ci管理员【服务树无关】'),(208,'openc3','openc3_agent_read','读取agent的信息【服务树相关】'),(209,'openc3','openc3_agent_write','修改agent的配置【服务树相关】'),(210,'openc3','openc3_agent_delete','删除agent的配置【服务树相关】'),(211,'openc3','openc3_agent_root','agent管理员【服务树无关】'),(212,'openc3','openc3_connector_read','读取connector的信息【服务树相关】'),(213,'openc3','openc3_connector_write','修改conector的配置【服务树相关】'),(214,'openc3','openc3_connector_delete','删除connector的配置【服务树相关】'),(215,'openc3','openc3_connector_root','connector管理员【服务树无关】'),(216,'base.user','getAll','查看企业所有用户'),(217,'base.organization','getAll','查看企业所有组织'),(218,'base.account','getAll','查看企业所有云账号'),(219,'monitor.cloud','get','云监控-查看'),(220,'monitor.server','get','服务配置-查看'),(221,'monitor.group','get','监控组管理-查看'),(222,'monitor.onDuty','get','值班管理(OnCall)-查看'),(223,'monitor.email','get','邮件监控-查看'),(224,'monitor.report','get','监控告警报告-查看');
/*!40000 ALTER TABLE `sys_permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-26 12:02:20
