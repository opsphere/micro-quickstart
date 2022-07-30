-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: 10.60.79.233    Database: mc_customer
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

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mc_customer` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
use mc_customer;

--
-- Table structure for table `customer_detail`
--

DROP TABLE IF EXISTS `customer_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain` varchar(32) NOT NULL DEFAULT '' COMMENT '公司',
  `code` varchar(32) NOT NULL DEFAULT '' COMMENT '客户编号',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '客户名称',
  `short_name` varchar(128) NOT NULL DEFAULT '' COMMENT '客户简称',
  `addr` varchar(500) NOT NULL DEFAULT '' COMMENT '客户地址',
  `receipt` varchar(128) NOT NULL DEFAULT '' COMMENT '发票主体',
  `payment_period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '客户支付账期',
  `signing_subject` varchar(128) NOT NULL DEFAULT '' COMMENT '客户签约主体',
  `contact_email` varchar(200) NOT NULL DEFAULT '' COMMENT '客户联系人邮箱',
  `contact_mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '客户联系人手机',
  `contact` varchar(128) NOT NULL DEFAULT '' COMMENT '客户联系人',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `fee` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '平台服务费*100',
  `if_oversea_customer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否海外客户',
  `manager_list` varchar(500) NOT NULL DEFAULT '{}' COMMENT '客户管理员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_customer_detail_code` (`code`),
  KEY `domain_name` (`domain`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台客户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_related_account`
--

DROP TABLE IF EXISTS `customer_related_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_related_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `customer` varchar(32) NOT NULL DEFAULT '' COMMENT '客户编号',
  `cloud` varchar(32) NOT NULL DEFAULT '' COMMENT '云厂商',
  `payer_account` varchar(20) NOT NULL DEFAULT '' COMMENT '客户支付账号',
  `link_account` varchar(300) NOT NULL DEFAULT '' COMMENT '客户使用账号',
  `billing_rule` varchar(20) NOT NULL DEFAULT '' COMMENT '计费规则：cost-原价|discount-折后价',
  `fee_type` varchar(20) NOT NULL DEFAULT '' COMMENT '计费类型',
  PRIMARY KEY (`id`),
  KEY `idx_customer_related_account_customer` (`customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='平台客户关联账号表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-13 14:44:34
