-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: mc_org
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
-- Current Database: `mc_org`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mc_org` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `mc_org`;

--
-- Table structure for table `auth_captcha`
--

DROP TABLE IF EXISTS `auth_captcha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_captcha` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `method` varchar(10) NOT NULL DEFAULT '' COMMENT '验证方式',
  `business_type` varchar(10) NOT NULL DEFAULT '' COMMENT '业务类型',
  `num` varchar(255) NOT NULL DEFAULT '' COMMENT '验证号码',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT '验证地址ip',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '验证码',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `expired_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  `try_count` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  PRIMARY KEY (`id`),
  KEY `idx_auth_captcha_deleted_at` (`deleted_at`),
  KEY `num_code` (`num`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_mfa_record`
--

DROP TABLE IF EXISTS `auth_mfa_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_mfa_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '验证地址url',
  `secret` varchar(100) NOT NULL DEFAULT '' COMMENT '验证秘钥',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_auth_mfa_record_user_id` (`user_id`),
  KEY `idx_auth_mfa_record_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='MFA生成记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_account`
--

DROP TABLE IF EXISTS `cloud_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  `cloud` varchar(20) NOT NULL DEFAULT '' COMMENT '云厂商',
  `uuid` varchar(20) NOT NULL DEFAULT '' COMMENT '云账号编码',
  `domain` varchar(20) NOT NULL DEFAULT '' COMMENT '所在主体',
  `payer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是付费账号',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '云账号名称',
  `account_id` varchar(100) NOT NULL DEFAULT '' COMMENT '云账号id｜腾讯云appId',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `data` text COMMENT '云账号数据',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cloud_account_uuid` (`uuid`),
  KEY `idx_cloud_account_deleted_at` (`deleted_at`),
  KEY `idx_cloud_account_domain` (`domain`),
  KEY `idx_cloud_account_creator` (`creator`),
  KEY `idx_cloud_account_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8 COMMENT='云账号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_account_bill_config`
--

DROP TABLE IF EXISTS `cloud_account_bill_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_account_bill_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `cloud` varchar(20) NOT NULL DEFAULT '' COMMENT '云厂商',
  `domain` varchar(20) NOT NULL DEFAULT '' COMMENT '所在主体',
  `account` varchar(20) NOT NULL DEFAULT '' COMMENT '云账号uuid',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人uuid',
  `bucket` varchar(100) NOT NULL DEFAULT '' COMMENT '账单存储桶',
  `region` varchar(20) NOT NULL DEFAULT '' COMMENT '账单存储桶所在地区',
  `report_name` varchar(255) NOT NULL DEFAULT '' COMMENT '账单报告名称',
  `report_prefix` varchar(255) NOT NULL DEFAULT '' COMMENT '账单报告前缀',
  PRIMARY KEY (`id`),
  KEY `idx_cloud_account_bill_config_domain` (`domain`),
  KEY `idx_cloud_account_bill_config_account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='云账号账单配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_account_sso_config`
--

DROP TABLE IF EXISTS `cloud_account_sso_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_account_sso_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `cloud` varchar(20) NOT NULL DEFAULT '' COMMENT '云厂商',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所在主体',
  `account` varchar(20) NOT NULL DEFAULT '' COMMENT '云账号uuid',
  `role` varchar(100) NOT NULL DEFAULT '' COMMENT '角色',
  `provider` varchar(100) NOT NULL DEFAULT '' COMMENT '登录提供商',
  `provider_id` varchar(20) NOT NULL DEFAULT '' COMMENT '登录提供商id',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人uuid',
  PRIMARY KEY (`id`),
  KEY `idx_cloud_account_sso_config_domain_id` (`domain_id`),
  KEY `idx_cloud_account_sso_config_account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='云账号SSO配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_identity_cert`
--

DROP TABLE IF EXISTS `cloud_identity_cert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_identity_cert` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain` varchar(20) NOT NULL DEFAULT '' COMMENT '主体',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expired_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  `certificate` text COMMENT '证书',
  `private_key` text COMMENT '私钥',
  PRIMARY KEY (`id`),
  KEY `idx_cloud_identity_cert_domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='云提供商证书表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cloud_identity_provider`
--

DROP TABLE IF EXISTS `cloud_identity_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cloud_identity_provider` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uuid` varchar(50) NOT NULL DEFAULT '' COMMENT 'uuid',
  `domain` varchar(20) NOT NULL DEFAULT '' COMMENT '主体',
  `provider` varchar(50) NOT NULL DEFAULT '' COMMENT '提供商',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `expired_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  `cert_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '证书id',
  `remark` varchar(300) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cloud_identity_provider_uuid` (`uuid`),
  KEY `idx_cloud_identity_provider_domain` (`domain`),
  KEY `idx_cloud_identity_provider_cert_id` (`cert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='云提供商信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_domain`
--

DROP TABLE IF EXISTS `org_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_domain` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL,
  `disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '公司名',
  `code` varchar(100) DEFAULT NULL COMMENT '公司字母简称',
  `second_verify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启了二次验证',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `domain_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '主体类型,0-个人｜1-公司',
  `creator_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `credited_code` varchar(100) NOT NULL DEFAULT '' COMMENT '信用机构代码',
  `license` varchar(255) NOT NULL DEFAULT '' COMMENT '营业执照',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_org_domain_code` (`code`),
  KEY `idx_org_domain_deleted_at` (`deleted_at`),
  KEY `idx_org_domain_name` (`name`),
  KEY `idx_org_domain_creator_id` (`creator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='主体信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_domain_configure`
--

DROP TABLE IF EXISTS `org_domain_configure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_domain_configure` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `domain` varchar(100) NOT NULL DEFAULT '' COMMENT '主体code',
  `name` varchar(191) NOT NULL DEFAULT '' COMMENT '配置名称',
  `detail` text COMMENT '配置值',
  PRIMARY KEY (`id`),
  KEY `idx_org_domain_configure_domain_id` (`domain_id`),
  KEY `idx_org_domain_configure_domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='主体配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_domain_menu`
--

DROP TABLE IF EXISTS `org_domain_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_domain_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `menu_code` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单code',
  PRIMARY KEY (`id`),
  KEY `idx_org_domain_menu_domain_id` (`domain_id`),
  KEY `idx_org_domain_menu_menu_code` (`menu_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主体开通模块记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_group`
--

DROP TABLE IF EXISTS `org_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL,
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '组名',
  `remark` varchar(320) NOT NULL DEFAULT '' COMMENT '组描述',
  `creator` varchar(100) NOT NULL DEFAULT '' COMMENT '创建人',
  `disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`id`),
  KEY `idx_org_group_deleted_at` (`deleted_at`),
  KEY `idx_org_group_domain_id` (`domain_id`),
  KEY `idx_org_group_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='用户组信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_group_role`
--

DROP TABLE IF EXISTS `org_group_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_group_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `idx_org_group_role_domain_id` (`domain_id`),
  KEY `idx_org_group_role_group_id` (`group_id`),
  KEY `idx_org_group_role_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COMMENT='用户组-角色关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_group_sso`
--

DROP TABLE IF EXISTS `org_group_sso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_group_sso` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组id',
  `sso_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'sso角色id',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_sso_domain_id` (`domain_id`),
  KEY `idx_org_user_sso_group_id` (`group_id`),
  KEY `idx_org_user_sso_sso_id` (`sso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='组-SSO关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_role`
--

DROP TABLE IF EXISTS `org_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL,
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '角色名',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '角色描述',
  `clouds` longtext,
  `creator` varchar(100) NOT NULL DEFAULT '' COMMENT '创建人',
  `disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否系统角色',
  PRIMARY KEY (`id`),
  KEY `idx_org_role_deleted_at` (`deleted_at`),
  KEY `idx_org_role_domain_id` (`domain_id`),
  KEY `idx_org_role_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_role_cloud_account`
--

DROP TABLE IF EXISTS `org_role_cloud_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_role_cloud_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  `account` varchar(20) NOT NULL DEFAULT '' COMMENT '云账号标识',
  `account_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '云账号id',
  PRIMARY KEY (`id`),
  KEY `idx_org_role_cloud_account_domain_id` (`domain_id`),
  KEY `idx_org_role_cloud_account_role_id` (`role_id`),
  KEY `idx_org_role_cloud_account_account` (`account`),
  KEY `idx_org_role_cloud_account_account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8 COMMENT='角色-云账号关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_role_permission`
--

DROP TABLE IF EXISTS `org_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_role_permission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  `perm_code` varchar(50) NOT NULL DEFAULT '' COMMENT '权限模块',
  `perm_action` varchar(50) NOT NULL DEFAULT '' COMMENT '权限动作',
  PRIMARY KEY (`id`),
  KEY `idx_org_role_permission_domain_id` (`domain_id`),
  KEY `idx_org_role_permission_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3387 DEFAULT CHARSET=utf8 COMMENT='角色-模块关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_structure`
--

DROP TABLE IF EXISTS `org_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_structure` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL,
  `disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `domain_id` bigint(20) unsigned DEFAULT NULL COMMENT '主体id',
  `code` varchar(100) DEFAULT NULL COMMENT '机构代码',
  `accounting_level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '核算级别，0-无，1-一级，2-二级，3-三级，4-四级，5-成本中心，6-利润中心',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级节点id',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '层级',
  `path` varchar(200) NOT NULL DEFAULT '' COMMENT '机构组织路径',
  `creator_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `leader_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '负责人',
  `remark` varchar(300) NOT NULL DEFAULT '' COMMENT '机构描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`domain_id`,`code`),
  KEY `idx_org_structure_name` (`name`),
  KEY `idx_org_structure_pid` (`pid`),
  KEY `idx_org_structure_creator_id` (`creator_id`),
  KEY `idx_org_structure_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='组织机构信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user`
--

DROP TABLE IF EXISTS `org_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uuid` varchar(36) DEFAULT NULL COMMENT '唯一标识',
  `email` varchar(255) DEFAULT NULL COMMENT 'email地址',
  `mobile` varchar(50) NOT NULL DEFAULT '' COMMENT '用户电话',
  `login_account` varchar(50) NOT NULL DEFAULT '' COMMENT '登录账号',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户姓名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '用户密码',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL,
  `icon` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `mfa` varchar(255) NOT NULL DEFAULT '' COMMENT 'MFA',
  `language` tinyint(3) unsigned DEFAULT '0' COMMENT '语言版本0-中文｜1-英文｜2-日语｜3-韩文',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_org_user_uuid` (`uuid`),
  KEY `idx_org_user_mobile` (`mobile`),
  KEY `idx_org_user_name` (`name`),
  KEY `idx_org_user_deleted_at` (`deleted_at`),
  KEY `idx_org_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_collected_menu`
--

DROP TABLE IF EXISTS `org_user_collected_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_collected_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `menu_code` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单代码',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '取消收藏时间',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_collected_menu_menu_code` (`menu_code`),
  KEY `idx_org_user_collected_menu_user_id` (`user_id`),
  KEY `idx_org_user_collected_menu_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='用户收藏菜单记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_domain`
--

DROP TABLE IF EXISTS `org_user_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_domain` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入公司时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新信息时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_type` varchar(20) NOT NULL DEFAULT '' COMMENT '用户类型admin|standard|teamworker|inviter',
  `disable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '状态inviting|joined',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_domain_domain_id` (`domain_id`),
  KEY `idx_org_user_domain_deleted_at` (`deleted_at`),
  KEY `idx_org_user_domain_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8 COMMENT='用户-主体关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_group`
--

DROP TABLE IF EXISTS `org_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新信息时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组id',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_group_user_id` (`user_id`),
  KEY `idx_org_user_group_group_id` (`group_id`),
  KEY `idx_org_user_group_deleted_at` (`deleted_at`),
  KEY `idx_org_user_group_domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 COMMENT='用户-用户组关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_invite`
--

DROP TABLE IF EXISTS `org_user_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_invite` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '邀请时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `user_email` varchar(255) NOT NULL DEFAULT '' COMMENT '邀请人邮箱',
  `structures` varchar(255) NOT NULL DEFAULT '' COMMENT '组织结构id',
  `roles` varchar(255) NOT NULL DEFAULT '' COMMENT '角色id',
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '验证码',
  `invite_type` varchar(20) NOT NULL DEFAULT '' COMMENT '邀请类型',
  `is_complete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否完成',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_invite_domain_id` (`domain_id`),
  KEY `idx_org_user_invite_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='用户邀请表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_log`
--

DROP TABLE IF EXISTS `org_user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `module` varchar(255) DEFAULT '' COMMENT '模块名称',
  `op` varchar(50) DEFAULT '' COMMENT '操作类型',
  `user` varchar(50) DEFAULT '' COMMENT '操作人',
  `ip` varchar(50) DEFAULT '' COMMENT '操作人IP',
  `agent` varchar(255) DEFAULT '' COMMENT '操作人代理',
  `is_complete` tinyint(1) DEFAULT '0' COMMENT '是否完成',
  `msg` varchar(255) DEFAULT '' COMMENT '操作描述',
  `request_id` varchar(100) DEFAULT '' COMMENT '请求ID',
  `detail` text COMMENT '操作详情',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_log_user` (`user`),
  KEY `idx_org_user_log_created_at` (`created_at`),
  KEY `idx_org_user_log_domain_id` (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8549 DEFAULT CHARSET=utf8 COMMENT='用户操作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_login`
--

DROP TABLE IF EXISTS `org_user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_login` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `ip` varchar(255) NOT NULL DEFAULT '' COMMENT '登录ip',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT '登录userAgent',
  `login_type` varchar(20) NOT NULL DEFAULT '' COMMENT '登录类型：login｜switch',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_login_domain_id` (`domain_id`),
  KEY `idx_org_user_login_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3184 DEFAULT CHARSET=utf8 COMMENT='用户登录记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_role`
--

DROP TABLE IF EXISTS `org_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_role_domain_id` (`domain_id`),
  KEY `idx_org_user_role_user_id` (`user_id`),
  KEY `idx_org_user_role_group_id` (`group_id`),
  KEY `idx_org_user_role_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8 COMMENT='用户-角色关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_sso`
--

DROP TABLE IF EXISTS `org_user_sso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_sso` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `sso_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'sso角色id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组id',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_sso_domain_id` (`domain_id`),
  KEY `idx_org_user_sso_user_id` (`user_id`),
  KEY `idx_org_user_sso_sso_id` (`sso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='用户-SSO关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_user_structure`
--

DROP TABLE IF EXISTS `org_user_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_user_structure` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入公司时间',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `structure_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组织结构id',
  PRIMARY KEY (`id`),
  KEY `idx_org_user_structure_domain_id` (`domain_id`),
  KEY `idx_org_user_structure_user_id` (`user_id`),
  KEY `idx_org_user_structure_structure_id` (`structure_id`)
) ENGINE=InnoDB AUTO_INCREMENT=324 DEFAULT CHARSET=utf8 COMMENT='用户-组织结构关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `upload_file`
--

DROP TABLE IF EXISTS `upload_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_file` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `business` varchar(10) NOT NULL DEFAULT '' COMMENT '业务类型',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `uuid` varchar(100) NOT NULL DEFAULT '' COMMENT '文件uuid',
  `file_path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `domain_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主体id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用',
  PRIMARY KEY (`id`),
  KEY `idx_upload_file_uuid` (`uuid`),
  KEY `idx_upload_file_file_path` (`file_path`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='上传文件表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-26 11:43:55
