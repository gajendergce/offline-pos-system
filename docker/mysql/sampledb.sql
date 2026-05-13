-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: db
-- ------------------------------------------------------
-- Server version	5.7.42-0ubuntu0.18.04.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ACCOUNTID` int(11) NOT NULL DEFAULT '0',
  `CUST_ID` int(11) DEFAULT NULL,
  `TOTAL_DUE` decimal(15,2) DEFAULT NULL,
  `DAYS_LATE` smallint(6) DEFAULT NULL,
  `PREV_BAL` decimal(15,2) DEFAULT NULL,
  `BAL_FOR` decimal(15,2) DEFAULT NULL,
  `CURRENT` decimal(15,2) DEFAULT NULL,
  `THIRTY` decimal(15,2) DEFAULT NULL,
  `SIXTY` decimal(15,2) DEFAULT NULL,
  `NINTY` decimal(15,2) DEFAULT NULL,
  `ONETWENTY` decimal(15,2) DEFAULT NULL,
  `NEW_FC` decimal(15,2) DEFAULT NULL,
  `FC_BAL30` decimal(15,2) DEFAULT NULL,
  `FC_BAL60` decimal(15,2) DEFAULT NULL,
  `FC_BAL90` decimal(15,2) DEFAULT NULL,
  `FC_BAL120` decimal(15,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_store_id_index` (`store_id`),
  KEY `account_cust_id_index` (`CUST_ID`),
  KEY `account_accountid_index` (`ACCOUNTID`)
) ENGINE=InnoDB AUTO_INCREMENT=2548 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acctupdt_history`
--

DROP TABLE IF EXISTS `acctupdt_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acctupdt_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cust_id` int(11) DEFAULT NULL,
  `datetime` datetime NOT NULL,
  `prv_due` decimal(15,2) DEFAULT '0.00',
  `entity_amt` decimal(15,2) DEFAULT '0.00',
  `current_due` decimal(15,2) DEFAULT '0.00',
  `logreason_id` int(11) DEFAULT NULL,
  `logreason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1692 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acctupdtlog`
--

DROP TABLE IF EXISTS `acctupdtlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acctupdtlog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ACCOUNTID` int(11) NOT NULL DEFAULT '0',
  `CUST_ID` int(11) DEFAULT NULL,
  `MODIDATE` date DEFAULT NULL,
  `MODITIME` varchar(8) DEFAULT '',
  `modidatetime` datetime DEFAULT NULL,
  `EMPLOYEE` varchar(200) DEFAULT '',
  `EMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `OTTLDUE` decimal(15,2) DEFAULT NULL,
  `OCURRENT` decimal(15,2) DEFAULT NULL,
  `OPREVBAL` decimal(15,2) DEFAULT NULL,
  `OBALFOR` decimal(15,2) DEFAULT NULL,
  `OTHIRTY` decimal(15,2) DEFAULT NULL,
  `OSIXTY` decimal(15,2) DEFAULT NULL,
  `ONINETY` decimal(15,2) DEFAULT NULL,
  `O1TWENTY` decimal(15,2) DEFAULT NULL,
  `NTTLDUE` decimal(15,2) DEFAULT NULL,
  `NCURRENT` decimal(15,2) DEFAULT NULL,
  `NPREVBAL` decimal(15,2) DEFAULT NULL,
  `NBALFOR` decimal(15,2) DEFAULT NULL,
  `NTHIRTY` decimal(15,2) DEFAULT NULL,
  `NSIXTY` decimal(15,2) DEFAULT NULL,
  `NNINETY` decimal(15,2) DEFAULT NULL,
  `N1TWENTY` decimal(15,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `acctupdtlog_store_id_index` (`store_id`),
  KEY `acctupdtlog_cust_id_index` (`CUST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` bigint(20) unsigned DEFAULT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint(20) unsigned DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` text COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_log_name_index` (`log_name`),
  KEY `subject` (`subject_id`,`subject_type`),
  KEY `causer` (`causer_id`,`causer_type`),
  KEY `activity_log_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adjitems`
--

DROP TABLE IF EXISTS `adjitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adjitems` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ADJID` int(11) DEFAULT NULL,
  `INVENID` int(11) DEFAULT NULL,
  `ONHAND` decimal(15,3) DEFAULT NULL,
  `COUNTAMNT` decimal(15,3) DEFAULT NULL,
  `PLUSMINUS` decimal(15,3) DEFAULT NULL,
  `COST` decimal(15,3) DEFAULT NULL,
  `CATEGORYID` int(11) DEFAULT NULL,
  `VENDORID` int(11) DEFAULT NULL,
  `LUP_ID` int(11) DEFAULT NULL,
  `LINENUM` bigint(20) DEFAULT NULL,
  `PRICE` decimal(15,3) DEFAULT NULL,
  `ADJMARKUP` decimal(11,2) DEFAULT NULL,
  `ADJMARGIN` decimal(9,2) DEFAULT NULL,
  `IHTAXRATE` varchar(255) DEFAULT NULL,
  `IHNONTAXABLE` varchar(255) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `adjitems_store_id_index` (`store_id`),
  KEY `adjitems_adjid_index` (`ADJID`),
  KEY `adjitems_invenid_index` (`INVENID`)
) ENGINE=InnoDB AUTO_INCREMENT=2930 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_role`
--

DROP TABLE IF EXISTS `admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_role_admin_id_foreign` (`admin_id`),
  CONSTRAINT `admin_role_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ag2agprice`
--

DROP TABLE IF EXISTS `ag2agprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ag2agprice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MATNO` varchar(14) DEFAULT '',
  `FORMULA` varchar(14) DEFAULT '',
  `PRODUCT` varchar(40) DEFAULT '',
  `REF` varchar(10) DEFAULT '',
  `PRODFORM` varchar(20) DEFAULT '',
  `SIZE` varchar(20) DEFAULT '',
  `PRICE` decimal(16,3) DEFAULT NULL,
  `CHANGE` decimal(16,3) DEFAULT NULL,
  `FULLTUNIT` decimal(16,3) DEFAULT NULL,
  `TRUCKLOAD` decimal(16,3) DEFAULT NULL,
  `BESTPRICE` decimal(16,3) DEFAULT NULL,
  `COSTCHNG` tinyint(1) DEFAULT NULL,
  `INVENCASE` bigint(20) DEFAULT NULL,
  `INVENCOST` decimal(16,3) DEFAULT NULL,
  `INVENMRKP` decimal(11,2) DEFAULT NULL,
  `INVENPRICE` decimal(16,3) DEFAULT NULL,
  `NEWPRICE` decimal(16,3) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ag2agprice_store_id_index` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analysisproductlist`
--

DROP TABLE IF EXISTS `analysisproductlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysisproductlist` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PRODUCTNBR` varchar(15) DEFAULT '',
  `PRODUCT` varchar(40) DEFAULT '',
  `SPECIESGRP` varchar(30) DEFAULT '',
  `METRICS` varchar(10) DEFAULT '',
  `PRODDASH` varchar(10) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `analysisproductlist_store_id_index` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bcdinput`
--

DROP TABLE IF EXISTS `bcdinput`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bcdinput` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `BCD_ID` int(11) DEFAULT NULL,
  `BCD_DATE` date DEFAULT NULL,
  `BCD_DR_NO` varchar(2) DEFAULT '',
  `BCD_EMP_NAME` varchar(255) DEFAULT NULL,
  `BCD_EMP_ID` varchar(8) DEFAULT '',
  `BCD_START` decimal(14,2) DEFAULT NULL,
  `BCD_CASH` decimal(14,2) DEFAULT NULL,
  `BCD_CHECK` decimal(14,2) DEFAULT NULL,
  `BCD_CHARGE` decimal(14,2) DEFAULT NULL,
  `BCD_CCCHAR` decimal(14,2) DEFAULT NULL,
  `BCD_ACH` decimal(14,2) DEFAULT NULL,
  `ACCT_RCVD` decimal(14,2) DEFAULT NULL,
  `CASH_RCVD` decimal(14,2) DEFAULT NULL,
  `CHECK_RCVD` decimal(14,2) DEFAULT NULL,
  `CREDIT_RCV` decimal(14,2) DEFAULT NULL,
  `ACH_RCVD` decimal(14,2) DEFAULT NULL,
  `BCD_C_OUT` decimal(14,2) DEFAULT NULL,
  `BCD_M_INC` decimal(14,2) DEFAULT NULL,
  `BCD_DRAWER` decimal(14,2) DEFAULT NULL,
  `COUNT_100` decimal(13,2) DEFAULT NULL,
  `COUNT_50` decimal(13,2) DEFAULT NULL,
  `COUNT_20` decimal(13,2) DEFAULT NULL,
  `COUNT_10` decimal(13,2) DEFAULT NULL,
  `COUNT_5` decimal(13,2) DEFAULT NULL,
  `COUNT_1` decimal(13,2) DEFAULT NULL,
  `COUNT_025` decimal(13,2) DEFAULT NULL,
  `COUNT_010` decimal(13,2) DEFAULT NULL,
  `COUNT_005` decimal(13,2) DEFAULT NULL,
  `COUNT_001` decimal(13,2) DEFAULT NULL,
  `TTL_CASH` decimal(14,2) DEFAULT NULL,
  `TTL_CHECKS` decimal(14,2) DEFAULT NULL,
  `TTL_DRAWER` decimal(14,2) DEFAULT NULL,
  `DIFFERENCE` decimal(14,2) DEFAULT NULL,
  `NDSB_100` decimal(13,2) DEFAULT NULL,
  `NDSB_50` decimal(13,2) DEFAULT NULL,
  `NDSB_20` decimal(13,2) DEFAULT NULL,
  `NDSB_10` decimal(13,2) DEFAULT NULL,
  `NDSB_5` decimal(13,2) DEFAULT NULL,
  `NDSB_1` decimal(13,2) DEFAULT NULL,
  `NDSB_025` decimal(13,2) DEFAULT NULL,
  `NDSB_010` decimal(13,2) DEFAULT NULL,
  `NDSB_005` decimal(13,2) DEFAULT NULL,
  `NDSB_001` decimal(13,2) DEFAULT NULL,
  `NDSB_TTL` decimal(14,2) DEFAULT NULL,
  `NEXT_TTL` decimal(14,2) DEFAULT NULL,
  `CASH_DEPO` decimal(14,2) DEFAULT NULL,
  `CHECK_DEPO` decimal(14,2) DEFAULT NULL,
  `MISC_DEPO` decimal(14,2) DEFAULT NULL,
  `TTL_DEPO` decimal(14,2) DEFAULT NULL,
  `DOUBLE_CHK` decimal(14,2) DEFAULT NULL,
  `TTL_CREDIT` decimal(14,2) DEFAULT NULL,
  `TTL_ACH` decimal(14,2) DEFAULT NULL,
  `CNT_100` smallint(6) DEFAULT NULL,
  `CNT_50` smallint(6) DEFAULT NULL,
  `CNT_20` smallint(6) DEFAULT NULL,
  `CNT_10` smallint(6) DEFAULT NULL,
  `CNT_5` smallint(6) DEFAULT NULL,
  `CNT_1` smallint(6) DEFAULT NULL,
  `CNT_025` smallint(6) DEFAULT NULL,
  `CNT_010` smallint(6) DEFAULT NULL,
  `CNT_005` smallint(6) DEFAULT NULL,
  `CNT_001` smallint(6) DEFAULT NULL,
  `NXTCNT_100` smallint(6) DEFAULT NULL,
  `NXTCNT_50` smallint(6) DEFAULT NULL,
  `NXTCNT_20` smallint(6) DEFAULT NULL,
  `NXTCNT_10` smallint(6) DEFAULT NULL,
  `NXTCNT_5` smallint(6) DEFAULT NULL,
  `NXTCNT_1` smallint(6) DEFAULT NULL,
  `NXTCNT_025` smallint(6) DEFAULT NULL,
  `NXTCNT_010` smallint(6) DEFAULT NULL,
  `NXTCNT_005` smallint(6) DEFAULT NULL,
  `NXTCNT_001` smallint(6) DEFAULT NULL,
  `CASH` decimal(14,2) DEFAULT NULL,
  `CASHDIFF` decimal(14,2) DEFAULT NULL,
  `CHECKS` decimal(14,2) DEFAULT NULL,
  `CHECKDIFF` decimal(14,2) DEFAULT NULL,
  `CRDCARDS` decimal(14,2) DEFAULT NULL,
  `ACH` decimal(14,2) DEFAULT NULL,
  `CRDCDIFF` decimal(14,2) DEFAULT NULL,
  `ACHDIFF` decimal(14,2) DEFAULT NULL,
  `CTTL_CRD` decimal(14,2) DEFAULT NULL,
  `DBL_CHKTTL` decimal(14,2) DEFAULT NULL,
  `CTTL_DRWR` decimal(14,2) DEFAULT NULL,
  `CTTL_ECASH` decimal(14,2) DEFAULT NULL,
  `NXTDAYUPDT` decimal(14,2) DEFAULT NULL,
  `NXTDAYDATE` date DEFAULT NULL,
  `TTL_CPNS` decimal(14,2) DEFAULT NULL,
  `CTTL_CPN` decimal(14,2) DEFAULT NULL,
  `CPNDIFF` decimal(14,2) DEFAULT NULL,
  `BCD_CPNS` decimal(14,2) DEFAULT NULL,
  `COUPONS` decimal(14,2) DEFAULT NULL,
  `MI_CASH` decimal(14,2) DEFAULT NULL,
  `MI_CHECK` decimal(14,2) DEFAULT NULL,
  `MI_CCARDS` decimal(14,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `BCD_GIFTC` decimal(14,2) DEFAULT NULL,
  `GIFTCARDS` decimal(14,2) DEFAULT NULL,
  `TTL_GIFT` decimal(14,2) DEFAULT NULL,
  `GIFTDIFF` decimal(14,2) DEFAULT NULL,
  `CTTL_GIFT` decimal(14,2) DEFAULT NULL,
  `CTTL_ACH` decimal(14,2) DEFAULT NULL,
  `is_sent_to_qb` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `bcdinput_store_id_index` (`store_id`),
  KEY `bcdinput_bcd_id_index` (`BCD_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `BILL_ID` int(11) DEFAULT NULL,
  `BILLINST_ID` int(11) NOT NULL DEFAULT '0',
  `transdatetime` datetime DEFAULT NULL,
  `BILL_DATE` date DEFAULT NULL,
  `DUE_DATE` date DEFAULT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `PAST_BAL` decimal(15,2) DEFAULT NULL,
  `TTL_DUE` decimal(15,2) DEFAULT NULL,
  `TRANSDATE` date DEFAULT NULL,
  `TRANSTIME` varchar(10) DEFAULT '',
  `ROANBR` int(11) DEFAULT NULL,
  `ROATOTAL` decimal(15,2) DEFAULT NULL,
  `INVOICENBR` int(11) DEFAULT NULL,
  `SLSTOTAL` decimal(15,2) DEFAULT NULL,
  `SRVCHRG` tinyint(1) DEFAULT NULL,
  `SPLTCHRGBA` tinyint(1) DEFAULT NULL,
  `ROASURCHRG` decimal(7,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_store_id_index` (`store_id`),
  KEY `billing_bill_id_index` (`BILL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=118995 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billingtemp`
--

DROP TABLE IF EXISTS `billingtemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billingtemp` (
  `CUST_ID` int(11) DEFAULT NULL,
  `datetime` datetime NOT NULL,
  `INVOICE_NBR` int(11) DEFAULT NULL,
  `INVOICE_DATE` date DEFAULT NULL,
  `INVOICE_TIME` varchar(8) DEFAULT '',
  `invoicedatetime` datetime DEFAULT NULL,
  `SLS_TOTAL` decimal(11,2) DEFAULT NULL,
  `SRVCHRG` tinyint(1) DEFAULT NULL,
  `ROANBR` int(11) DEFAULT NULL,
  `ROADATE` date DEFAULT NULL,
  `ROATIME` varchar(8) DEFAULT '',
  `roadatetime` datetime DEFAULT NULL,
  `ROATOTAL` decimal(11,2) DEFAULT NULL,
  `TRANSDATE` date DEFAULT NULL,
  `TRANSTIME` varchar(8) DEFAULT '',
  `transdatetime` datetime DEFAULT NULL,
  `SPLTBALANC` decimal(11,2) DEFAULT NULL,
  `SPLTCRGBAL` tinyint(1) DEFAULT NULL,
  `SCSIGIMAGE` blob,
  `newacctbal` decimal(15,2) DEFAULT NULL,
  `prvacctbal` decimal(15,2) DEFAULT NULL,
  `surcharge` decimal(7,2) DEFAULT NULL,
  `unique_id` int(11) NOT NULL DEFAULT '0',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blnginst`
--

DROP TABLE IF EXISTS `blnginst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blnginst` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `BILLINST_ID` int(11) NOT NULL DEFAULT '0',
  `RUN` date DEFAULT NULL,
  `CUTOFF` date DEFAULT NULL,
  `DUE` date DEFAULT NULL,
  `USER` varchar(10) DEFAULT '',
  `USER_ID` int(11) NOT NULL DEFAULT '0',
  `TIME` varchar(8) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blnginst_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashout`
--

DROP TABLE IF EXISTS `cashout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashout` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CASHOUTID` int(11) DEFAULT NULL,
  `CODATE` date DEFAULT NULL,
  `COTIME` varchar(8) DEFAULT '',
  `codatetime` datetime DEFAULT NULL,
  `CODRAWER` varchar(2) DEFAULT '',
  `COEMPLOYEE` varchar(200) DEFAULT '',
  `COEMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `COAMOUNT` decimal(13,2) DEFAULT NULL,
  `COREASON` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cashout_store_id_index` (`store_id`),
  KEY `cashout_cashoutid_index` (`CASHOUTID`)
) ENGINE=InnoDB AUTO_INCREMENT=4260 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORYID` int(11) NOT NULL DEFAULT '0',
  `CATEGORY` varchar(2) DEFAULT '',
  `CATNAME` varchar(25) DEFAULT '',
  `MASTER_ID` bigint(20) DEFAULT NULL,
  `EXMPTLIST` tinyint(1) DEFAULT NULL,
  `ALLOWDISC` tinyint(1) DEFAULT NULL,
  `DFLTPRCNT` tinyint(4) DEFAULT NULL,
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(10) DEFAULT NULL,
  `store_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_store_id_index` (`store_id`),
  KEY `category_categoryid_index` (`CATEGORYID`)
) ENGINE=InnoDB AUTO_INCREMENT=1395 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cities_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48759 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(10) NOT NULL,
  `description` text,
  `user_id` int(11) DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CUST_ID` int(11) DEFAULT NULL,
  `BOOKED` decimal(15,3) DEFAULT NULL,
  `BOOK_PRICE` decimal(16,3) DEFAULT NULL,
  `BOOK_MEMO` longtext,
  `BOOK_DATE` date DEFAULT NULL,
  `USED` decimal(15,3) DEFAULT NULL,
  `PRICE` decimal(15,2) DEFAULT NULL,
  `ITEMID` varchar(14) DEFAULT '',
  `INVENTORYID` int(11) NOT NULL DEFAULT '0',
  `VENDORID` int(11) DEFAULT NULL,
  `AVGCOST` decimal(21,5) DEFAULT NULL,
  `CONTRACTID` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contracts_store_id_index` (`store_id`),
  KEY `contracts_contractid_index` (`CONTRACTID`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phonecode` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `countries_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custaddlist`
--

DROP TABLE IF EXISTS `custaddlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custaddlist` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CUSTADDID` int(11) DEFAULT NULL,
  `LISTDESC` varchar(20) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `custaddlist_store_id_index` (`store_id`),
  KEY `custaddlist_custaddid_index` (`CUSTADDID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custloyalty`
--

DROP TABLE IF EXISTS `custloyalty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custloyalty` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `LOYALTYID` int(11) NOT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `STARTDATE` date DEFAULT NULL,
  `EMPLOYEE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `INVENID` int(11) DEFAULT NULL,
  `BUYQTY` decimal(6,2) DEFAULT NULL,
  `FREEQTY` decimal(6,2) DEFAULT NULL,
  `NEXTFREE` decimal(6,2) DEFAULT NULL,
  `LSTFREEINV` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `custloyalty_store_id_index` (`store_id`),
  KEY `custloyalty_loyaltyid_index` (`LOYALTYID`),
  KEY `custloyalty_employee_id_index` (`EMPLOYEE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_logs`
--

DROP TABLE IF EXISTS `custom_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `channel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_datetime` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `formatted` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5606 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CUST_ID` int(11) NOT NULL DEFAULT '0',
  `FIRSTNAME` varchar(200) DEFAULT NULL,
  `MI` varchar(100) DEFAULT NULL,
  `LASTNAME` varchar(20) DEFAULT '',
  `COMPANY` varchar(200) DEFAULT NULL,
  `ADDRESS` varchar(200) DEFAULT NULL,
  `CITY` varchar(200) DEFAULT NULL,
  `STATE` varchar(200) DEFAULT NULL,
  `ZIP` varchar(100) DEFAULT NULL,
  `SHIPTOMAIL` tinyint(1) DEFAULT '0',
  `SHIPADDRESS` varchar(200) DEFAULT '',
  `SHIPCITY` varchar(200) DEFAULT NULL,
  `SHIPSTATE` varchar(200) DEFAULT NULL,
  `SHIPZIP` varchar(100) DEFAULT NULL,
  `WPHONE` varchar(100) DEFAULT NULL,
  `HPHONE` varchar(100) DEFAULT NULL,
  `CELLNBR` varchar(100) DEFAULT NULL,
  `FAXNBR` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(200) DEFAULT NULL,
  `ENDDATE` date DEFAULT NULL,
  `SUSPENDED` tinyint(1) DEFAULT '0',
  `PROBATION` tinyint(1) DEFAULT '0',
  `CUST_MEMO` longtext,
  `CANCHRG` tinyint(1) DEFAULT '0',
  `CRDTLIMIT` decimal(13,2) DEFAULT NULL,
  `CANINVOICE` tinyint(1) DEFAULT '0',
  `PAYINVOICELIMIT` decimal(13,2) DEFAULT NULL,
  `CHRG_FNC` tinyint(1) DEFAULT NULL,
  `PRN_STMNT` tinyint(1) NOT NULL DEFAULT '0',
  `NONTAXABLE` tinyint(1) DEFAULT NULL,
  `EXEMPT_NBR` varchar(16) DEFAULT '',
  `CARDTYPE` varchar(24) DEFAULT '',
  `CRGCARDNBR` varchar(24) DEFAULT '',
  `CARDEXP` varchar(10) DEFAULT '',
  `SSID` varchar(10) DEFAULT '',
  `DL_NBR` bigint(20) DEFAULT NULL,
  `DL_STATE` varchar(100) DEFAULT '',
  `MAIL_1` varchar(25) DEFAULT '',
  `MAIL_2` varchar(25) DEFAULT '',
  `MAIL_3` varchar(25) DEFAULT '',
  `MAIL_4` varchar(25) DEFAULT '',
  `MAIL_5` varchar(25) DEFAULT '',
  `INACTIVE` int(11) DEFAULT '0',
  `PRICELVL` tinyint(4) DEFAULT NULL,
  `EXEMPTCATS` longtext,
  `MAILID1` int(11) DEFAULT NULL,
  `MAILID2` varchar(200) DEFAULT NULL,
  `MAILID3` int(11) DEFAULT NULL,
  `MAILID4` int(11) DEFAULT NULL,
  `MAILID5` int(11) DEFAULT NULL,
  `EXEMPT_EXP` varchar(200) DEFAULT NULL,
  `exmptaxable` int(11) NOT NULL DEFAULT '0',
  `exemption` varchar(200) DEFAULT NULL,
  `ADDLIST1` int(11) DEFAULT NULL,
  `ADDTIONAL1` varchar(20) DEFAULT '',
  `ADDTIONAL1ID` int(11) DEFAULT NULL,
  `ADDEXP1` date DEFAULT NULL,
  `ADDLIST2` int(11) DEFAULT NULL,
  `ADDTIONAL2` varchar(20) DEFAULT '',
  `ADDTIONAL2ID` int(11) DEFAULT NULL,
  `ADDEXP2` date DEFAULT NULL,
  `ADDLIST3` int(11) DEFAULT NULL,
  `ADDTIONAL3` varchar(20) DEFAULT '',
  `ADDTIONAL3ID` int(11) DEFAULT NULL,
  `ADDEXP3` date DEFAULT NULL,
  `ADDLIST4` int(11) DEFAULT NULL,
  `ADDTIONAL4` varchar(20) DEFAULT '',
  `ADDTIONAL4ID` int(11) DEFAULT NULL,
  `ADDEXP4` date DEFAULT NULL,
  `ADDLIST5` int(11) DEFAULT NULL,
  `ADDTIONAL5` varchar(20) DEFAULT '',
  `ADDTIONAL5ID` int(11) DEFAULT NULL,
  `ADDEXP5` date DEFAULT NULL,
  `JDMRCHNBRS` longtext,
  `JDAUTHBYRS` longtext,
  `CARDZIP` varchar(200) DEFAULT '',
  `CARDADDNBR` varchar(6) DEFAULT '',
  `EMAILSTMNT` varchar(200) DEFAULT NULL,
  `EMAILINV` tinyint(11) DEFAULT '0',
  `REWARDID1` varchar(200) DEFAULT NULL,
  `REWARDDESCRID` int(11) DEFAULT NULL,
  `REWARDID2` int(11) DEFAULT NULL,
  `REWARDID3` int(11) DEFAULT NULL,
  `VFDQTY1` int(11) DEFAULT NULL,
  `VFDQTY2` int(11) DEFAULT NULL,
  `VFDQTY3` int(11) DEFAULT NULL,
  `VFDQTY4` int(11) DEFAULT NULL,
  `VFDQTY5` int(11) DEFAULT NULL,
  `VFDQTYUSD1` varchar(200) DEFAULT NULL,
  `VFDQTYUSD2` varchar(200) DEFAULT NULL,
  `VFDQTYUSD3` varchar(200) DEFAULT NULL,
  `VFDQTYUSD4` varchar(200) DEFAULT NULL,
  `VFDQTYUSD5` varchar(200) DEFAULT NULL,
  `OK2CHRG` longtext,
  `ALLOWDISC` tinyint(1) DEFAULT '0',
  `DISCPRCNT` tinyint(4) DEFAULT NULL,
  `DISCTYPE` varchar(200) DEFAULT '',
  `note_data` text,
  `billingzip` varchar(200) DEFAULT NULL,
  `billingstreet` varchar(200) DEFAULT NULL,
  `confirm_num` varchar(200) DEFAULT NULL,
  `recurring` tinyint(1) DEFAULT '0',
  `store_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `STARTDATE` date DEFAULT NULL,
  `chg_type` varchar(45) DEFAULT NULL,
  `chg_startdate` datetime DEFAULT NULL,
  `cc_token` text,
  `rank_sorting` int(11) DEFAULT NULL,
  `multipledbcol` int(11) NOT NULL,
  `multipledbcol2` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chg_startdate_UNIQUE` (`chg_startdate`),
  KEY `customer_store_id_index` (`store_id`),
  KEY `customer_cust_id_index` (`CUST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33513 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_invoice`
--

DROP TABLE IF EXISTS `customer_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_invoice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `TENDERED` double(8,2) DEFAULT NULL,
  `CHANGE` double(8,2) DEFAULT NULL,
  `TAXAMNT` double(8,2) NOT NULL,
  `SLSTOTAL` double(8,2) NOT NULL,
  `cash_rounding` decimal(6,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_invoiceitems`
--

DROP TABLE IF EXISTS `customer_invoiceitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_invoiceitems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `tr_id` int(11) NOT NULL,
  `INVENTORYID` int(11) NOT NULL,
  `QUANTITY` decimal(8,3) NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PRICE` decimal(8,3) NOT NULL,
  `EXTENDED` double(8,2) NOT NULL,
  `store_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edifilelog`
--

DROP TABLE IF EXISTS `edifilelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edifilelog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `VENDORID` int(11) DEFAULT NULL,
  `FILENAME` varchar(240) DEFAULT '',
  `MODIDNT` datetime DEFAULT NULL,
  `DWNLDDIR` varchar(30) DEFAULT '',
  `DWNLDDNT` datetime DEFAULT NULL,
  `FILETYPE` varchar(20) DEFAULT '',
  `PROCESSED` tinyint(1) DEFAULT NULL,
  `PROCDNT` datetime DEFAULT NULL,
  `VOUCHERNUM` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `edifilelog_store_id_index` (`store_id`),
  KEY `edifilelog_vendorid_index` (`VENDORID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `editlog`
--

DROP TABLE IF EXISTS `editlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editlog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ACTION` varchar(1) DEFAULT '',
  `NAME` varchar(10) DEFAULT '',
  `INVNUM` int(11) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `TIME` varchar(8) DEFAULT '',
  `datetime` datetime DEFAULT NULL,
  `LOGIN` varchar(10) DEFAULT '',
  `ATTEMPT` tinyint(1) DEFAULT NULL,
  `COMPUTERID` varchar(30) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `editlog_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1165 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emailsentlog`
--

DROP TABLE IF EXISTS `emailsentlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emailsentlog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `EMAIL_ID` int(11) DEFAULT NULL,
  `SDATETIME` datetime DEFAULT NULL,
  `SENTTO` varchar(250) DEFAULT '',
  `SENTFROM` varchar(50) DEFAULT '',
  `SUBJECT` varchar(50) DEFAULT '',
  `CMESSAGE` longtext,
  `ATT` longtext,
  `NETNAME` varchar(50) DEFAULT '',
  `LOGGEDIN` varchar(200) DEFAULT '',
  `SENDFAIL` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `entityid` int(11) DEFAULT NULL,
  `entityname` varchar(45) DEFAULT NULL,
  `cc_email` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emailsentlog_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14377 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `errorcap`
--

DROP TABLE IF EXISTS `errorcap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `errorcap` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `DATE` date DEFAULT NULL,
  `TIME` varchar(8) DEFAULT '',
  `ERRORNUM` varchar(5) DEFAULT '',
  `ERRORMSG` varchar(200) DEFAULT '',
  `PROGRAM` varchar(50) DEFAULT '',
  `LINE` varchar(5) DEFAULT '',
  `LINERELATV` varchar(5) DEFAULT '',
  `ERRORCODE` varchar(200) DEFAULT '',
  `DATAFILE` varchar(100) DEFAULT '',
  `VARIABLE` varchar(20) DEFAULT '',
  `MEMORY` varchar(10) DEFAULT '',
  `ALLMEMORY` varchar(10) DEFAULT '',
  `DISKSPACE` varchar(20) DEFAULT '',
  `PROCESSOR` varchar(50) DEFAULT '',
  `NETNAME` varchar(50) DEFAULT '',
  `LOGGEDIN` varchar(10) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `errorcap_store_id_index` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_order_line_items`
--

DROP TABLE IF EXISTS `external_order_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_order_line_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `shopify_line_item_id` bigint(20) unsigned DEFAULT NULL,
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned DEFAULT NULL,
  `quantity_sold` int(11) DEFAULT NULL,
  `inventory_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_discount` decimal(10,2) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `tax_rate` decimal(5,4) DEFAULT NULL,
  `tax_title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_line_items_order_id_foreign` (`order_id`),
  CONSTRAINT `order_line_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `external_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_orders`
--

DROP TABLE IF EXISTS `external_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal_price` decimal(10,2) DEFAULT NULL,
  `total_tax` decimal(10,2) DEFAULT NULL,
  `total_discounts` decimal(10,2) DEFAULT NULL,
  `discount_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_shipping_price` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `financial_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fulfillment_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancel_reason` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `integration_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `customer_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_store_index` (`order_id`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `farmplan`
--

DROP TABLE IF EXISTS `farmplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmplan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MRCHNTNBRS` longtext,
  `DISCLOSURE` longtext,
  `IVRPHONE` varchar(13) DEFAULT '',
  `RVWPHONE` varchar(13) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `farmplan_store_id_index` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcostlog`
--

DROP TABLE IF EXISTS `fcostlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fcostlog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVNUM` int(11) DEFAULT NULL,
  `EMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `EMP_NAME` varchar(50) DEFAULT '',
  `INVDATE` date DEFAULT NULL,
  `INVTIME` varchar(8) DEFAULT '',
  `invdatetime` datetime DEFAULT NULL,
  `FIXDATE` date DEFAULT NULL,
  `FIXTIME` varchar(8) DEFAULT '',
  `fixdatetime` datetime DEFAULT NULL,
  `ADJ_ITEM` varchar(30) DEFAULT '',
  `ORIGCOST` decimal(18,5) DEFAULT NULL,
  `FIXCOST` decimal(18,5) DEFAULT NULL,
  `INVENID` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fcostlog_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1672 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fpp_data`
--

DROP TABLE IF EXISTS `fpp_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fpp_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `FPP_ID` bigint(20) DEFAULT NULL,
  `TYPE` varchar(10) DEFAULT '',
  `INVEN_ID` int(11) DEFAULT NULL,
  `BUY` smallint(6) DEFAULT NULL,
  `FREE` tinyint(4) DEFAULT NULL,
  `FPP_PNAME` varchar(30) DEFAULT '',
  `SETUP_BY` varchar(8) DEFAULT '',
  `SETUP_DATE` date DEFAULT NULL,
  `SETUP_TIME` varchar(8) DEFAULT '',
  `MODI_BY` varchar(8) DEFAULT '',
  `MODI_DATE` date DEFAULT NULL,
  `MODI_TIME` varchar(8) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fpp_data_store_id_index` (`store_id`),
  KEY `fpp_data_fpp_id_index` (`FPP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfkanalysis`
--

DROP TABLE IF EXISTS `gfkanalysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gfkanalysis` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `YEAR` smallint(6) DEFAULT NULL,
  `WEEK` tinyint(4) DEFAULT NULL,
  `STARTDATE` date DEFAULT NULL,
  `ENDDATE` date DEFAULT NULL,
  `EMPLOYEE` varchar(10) DEFAULT '',
  `DATESENT` datetime DEFAULT NULL,
  `SENT` tinyint(1) DEFAULT NULL,
  `NOSALES` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gfkanalysis_store_id_index` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `giftcards`
--

DROP TABLE IF EXISTS `giftcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giftcards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `GIFTCARDID` int(11) DEFAULT NULL,
  `GFTCARDNBR` varchar(20) DEFAULT '',
  `ACTIVITY` longtext,
  `BALANCE` decimal(12,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `giftcards_store_id_index` (`store_id`),
  KEY `giftcards_giftcardid_index` (`GIFTCARDID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gunlog`
--

DROP TABLE IF EXISTS `gunlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gunlog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `GUNLOGID` int(11) DEFAULT NULL,
  `GUNMAKE` varchar(30) DEFAULT '',
  `MODEL` varchar(20) DEFAULT '',
  `SERIALNBR` varchar(20) DEFAULT '',
  `GUNTYPE` varchar(20) DEFAULT '',
  `CALIBER` varchar(10) DEFAULT '',
  `LOGDATE` date DEFAULT NULL,
  `LOGTIME` varchar(8) DEFAULT '',
  `VENDOR` longtext,
  `SOLDDATE` date DEFAULT NULL,
  `INVOICENBR` int(11) DEFAULT NULL,
  `SOLDTO` longtext,
  `DOB` date DEFAULT NULL,
  `IDNUMBER` varchar(20) DEFAULT '',
  `ALIENDOC` varchar(20) DEFAULT '',
  `FORM4473NO` int(11) DEFAULT NULL,
  `EMPLOYEE` varchar(10) DEFAULT '',
  `DELGUN` tinyint(1) DEFAULT NULL,
  `DELBY` varchar(10) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `mdb1` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gunlog_store_id_index` (`store_id`),
  KEY `gunlog_gunlogid_index` (`GUNLOGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hold`
--

DROP TABLE IF EXISTS `hold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hold` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `HOLDID` int(11) DEFAULT NULL,
  `HOLDCODE` varchar(30) DEFAULT '',
  `HOLDDATE` date DEFAULT NULL,
  `HOLDTIME` varchar(8) DEFAULT '',
  `holddatetime` datetime DEFAULT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `EMP_ID` varchar(200) DEFAULT '',
  `EMPLOYEE_ID` int(11) DEFAULT NULL,
  `DRAWER` varchar(2) DEFAULT '',
  `TAXRATE` decimal(10,3) DEFAULT NULL,
  `RATEDESC` varchar(10) DEFAULT '',
  `MOPCASH` tinyint(1) DEFAULT NULL,
  `MOPCHECK` tinyint(1) DEFAULT NULL,
  `CHECK_NBR` varchar(6) DEFAULT '',
  `MOPSPLIT` tinyint(1) DEFAULT NULL,
  `MOPCRDTCARD` tinyint(1) NOT NULL DEFAULT '0',
  `CC_TYPE` varchar(16) DEFAULT '',
  `MOPCHARGE` tinyint(1) DEFAULT NULL,
  `SUBTOTAL` decimal(13,2) DEFAULT NULL,
  `TAXAMNT` decimal(13,2) DEFAULT NULL,
  `SLSTOTAL` decimal(13,2) DEFAULT NULL,
  `TENDERED` decimal(13,2) DEFAULT NULL,
  `SLSCHANGE` decimal(13,2) DEFAULT NULL,
  `PRICELVL` tinyint(4) DEFAULT NULL,
  `SLSSTATUS` varchar(15) DEFAULT '',
  `SLSNOTE` longtext,
  `WHR_NOTE` tinyint(1) DEFAULT NULL,
  `SPLTCASH` decimal(13,2) DEFAULT NULL,
  `SPLTCHECK` decimal(13,2) DEFAULT NULL,
  `SPLTCHKNBR` varchar(6) DEFAULT '',
  `SPLTCCARD1` decimal(13,2) DEFAULT NULL,
  `SPLTCTYPE1` varchar(16) DEFAULT '',
  `SPLTCCARD2` decimal(13,2) DEFAULT NULL,
  `SPLTCTYPE2` varchar(16) DEFAULT '',
  `SPLTBALANCE` decimal(13,2) DEFAULT NULL,
  `SPLTTENDTTL` decimal(13,2) DEFAULT NULL,
  `SCPNCNT` tinyint(4) DEFAULT NULL,
  `SCPNTTL` decimal(11,2) DEFAULT NULL,
  `SCPN1` decimal(10,2) DEFAULT NULL,
  `SCPN2` decimal(10,2) DEFAULT NULL,
  `SCPN3` decimal(10,2) DEFAULT NULL,
  `SCPN4` decimal(10,2) DEFAULT NULL,
  `SCPN5` decimal(10,2) DEFAULT NULL,
  `SPLTCHRGBAL` tinyint(1) NOT NULL DEFAULT '0',
  `XCACCOUNT` varchar(20) DEFAULT '',
  `XCAPPROVAL` varchar(15) DEFAULT '',
  `XCCARDTYPE` varchar(20) DEFAULT '',
  `XCEXPIRE` varchar(10) DEFAULT '',
  `XCNAME` varchar(35) DEFAULT '',
  `XCSIGIMAGE` longtext,
  `XCTRANSID` varchar(10) DEFAULT '',
  `SRVCHRG` tinyint(1) DEFAULT NULL,
  `INVENTORYID` int(11) NOT NULL DEFAULT '0',
  `LINENUM` int(11) DEFAULT NULL,
  `QTY` decimal(14,3) DEFAULT NULL,
  `NONTAXABLE` tinyint(1) DEFAULT NULL,
  `BOOKEDID` int(11) DEFAULT NULL,
  `UNIT` varchar(3) DEFAULT '',
  `DISCOUNT` tinyint(4) DEFAULT NULL,
  `COST` decimal(18,5) DEFAULT NULL,
  `CWT` tinyint(1) DEFAULT NULL,
  `SOLDPRICE` decimal(14,3) DEFAULT NULL,
  `ORIGPRICE` decimal(14,3) DEFAULT NULL,
  `PRICEFROM` varchar(11) DEFAULT '',
  `PRNTOWHR` tinyint(1) DEFAULT NULL,
  `NONINVITEM` varchar(30) DEFAULT '',
  `DSCAPPROVE` varchar(10) DEFAULT '',
  `DSCNOTE` longtext,
  `OVRAPPROVE` varchar(10) DEFAULT '',
  `OVRNOTE` longtext,
  `XMPAPPROVE` varchar(10) DEFAULT '',
  `XMPNOTE` longtext,
  `ORIGNONTAX` tinyint(1) DEFAULT NULL,
  `INVOICEPO` varchar(30) DEFAULT '',
  `SERIALNBR` varchar(20) DEFAULT '',
  `VND1ORDNUM` varchar(20) DEFAULT '',
  `RTLPRICE` decimal(16,3) DEFAULT NULL,
  `REWARDOK` tinyint(1) DEFAULT NULL,
  `VFDSLSID` int(11) DEFAULT NULL,
  `VFDMAXQTY` int(11) DEFAULT NULL,
  `VFDAVLQTY` int(11) DEFAULT NULL,
  `VFDNUMBER` varchar(20) DEFAULT '',
  `VFDEXPIRE` date DEFAULT NULL,
  `ACTUALCOST` decimal(18,5) DEFAULT NULL,
  `DCML3` tinyint(1) DEFAULT NULL,
  `QTYLIMIT` int(11) DEFAULT NULL,
  `QTYDISCPCT` tinyint(4) DEFAULT NULL,
  `QTYDISCDLR` decimal(14,2) DEFAULT NULL,
  `ITMPHOTO1` varchar(100) DEFAULT '',
  `ITMPHOTO2` varchar(100) DEFAULT '',
  `ITMPHOTO3` varchar(100) DEFAULT '',
  `ITEMONHAND` decimal(16,3) DEFAULT NULL,
  `DISCOUNTBL` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `LWQTYAPPRV` varchar(100) DEFAULT NULL,
  `INACTAPPRV` varchar(100) DEFAULT NULL,
  `VFDNOTE` varchar(20) DEFAULT NULL,
  `TRADEITEM` tinyint(4) DEFAULT NULL,
  `ADDTRADE` tinyint(4) DEFAULT NULL,
  `TRADELID` int(11) DEFAULT NULL,
  `TRADECID` int(11) DEFAULT NULL,
  `TRADEVID` int(11) DEFAULT NULL,
  `TRADERTL` decimal(11,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hold_store_id_index` (`store_id`),
  KEY `hold_holdid_index` (`HOLDID`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inputpayment_invoices`
--

DROP TABLE IF EXISTS `inputpayment_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inputpayment_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `paymentnbr` int(11) NOT NULL,
  `invoicenbr` int(11) NOT NULL,
  `apply_amount` decimal(13,2) NOT NULL,
  `voided` tinyint(1) DEFAULT '0',
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_adj`
--

DROP TABLE IF EXISTS `inv_adj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_adj` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ADJID` int(11) DEFAULT NULL,
  `ADJDATE` date DEFAULT NULL,
  `ADJTIME` varchar(8) DEFAULT '',
  `EMPNAME` varchar(10) DEFAULT '',
  `EMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `POSTED` tinyint(1) DEFAULT NULL,
  `ADJTYPE` varchar(40) DEFAULT '',
  `POSTEDBY` varchar(200) DEFAULT '',
  `POSTDATE` date DEFAULT NULL,
  `POSTTIME` varchar(8) DEFAULT '',
  `postdatetime` datetime DEFAULT NULL,
  `ADJDNT` datetime DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inv_adj_store_id_index` (`store_id`),
  KEY `inv_adj_adjid_index` (`ADJID`),
  KEY `inv_adj_employee_id_index` (`EMPLOYEE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_adv_field`
--

DROP TABLE IF EXISTS `inv_adv_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_adv_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryid` bigint(20) unsigned NOT NULL,
  `shopify_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shopify_description` longtext COLLATE utf8mb4_unicode_ci,
  `shopify_category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shopify_shipping` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inv_adv_field_inventoryid_index` (`inventoryid`),
  KEY `inv_adv_field_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invaltuom`
--

DROP TABLE IF EXISTS `invaltuom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invaltuom` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENID` int(11) DEFAULT NULL,
  `ALTQTYFCTR` decimal(18,5) DEFAULT NULL,
  `ALTPRICE` decimal(16,3) DEFAULT NULL,
  `ALTPRICEP` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invaltuom_store_id_index` (`store_id`),
  KEY `invaltuom_invenid_index` (`INVENID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invenaltuom`
--

DROP TABLE IF EXISTS `invenaltuom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invenaltuom` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENID` int(11) DEFAULT NULL,
  `ALTQTY` decimal(18,5) DEFAULT NULL,
  `ALTRETAIL` decimal(16,3) DEFAULT NULL,
  `ALTUOM` varchar(45) DEFAULT NULL,
  `ALTMARKUP` decimal(16,3) DEFAULT NULL,
  `ALTMARGIN` decimal(16,3) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invaltuom_store_id_index` (`store_id`),
  KEY `invaltuom_invenid_index` (`INVENID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invenplu`
--

DROP TABLE IF EXISTS `invenplu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invenplu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENID` int(11) DEFAULT NULL,
  `PLU` varchar(30) DEFAULT '',
  `PLUTYPE` varchar(3) DEFAULT '',
  `TYPEID` int(11) DEFAULT NULL,
  `PLUINACT` tinyint(1) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `store_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invenplu_store_id_index` (`store_id`),
  KEY `plutype` (`PLUTYPE`),
  KEY `plu_store_id` (`PLU`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1302968 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENTORYID` int(11) NOT NULL DEFAULT '0',
  `DESCRIPTION` varchar(30) DEFAULT '',
  `ON_HAND` decimal(16,3) DEFAULT NULL,
  `LASTCOST` decimal(17,4) DEFAULT NULL,
  `ITEMFRIEGHT` decimal(15,4) DEFAULT NULL,
  `ACTUALCOST` decimal(17,4) DEFAULT NULL,
  `PRICE1` decimal(16,3) DEFAULT NULL,
  `P1PRCNT` decimal(11,2) DEFAULT NULL,
  `P1MRGN` decimal(9,2) DEFAULT NULL,
  `REORDER` int(11) DEFAULT NULL,
  `MAXINV` int(11) DEFAULT NULL,
  `INV_MEMO` longtext,
  `INV_DISCLAIMER_MEMO` longtext,
  `PRIMARYUPC` varchar(14) DEFAULT '',
  `SECONDARY` varchar(14) DEFAULT '',
  `CWT` int(1) DEFAULT '0',
  `NONTAXABLE` int(1) DEFAULT '0',
  `SALEBYUNIT` varchar(5) DEFAULT '',
  `UNIT_MKUP` decimal(11,2) DEFAULT NULL,
  `AVG_COST` decimal(21,5) DEFAULT NULL,
  `WHR_ITEM` int(1) DEFAULT NULL,
  `INACTIVE` int(1) DEFAULT '0',
  `NOTE_ATOS` int(1) DEFAULT '0',
  `VENDOR1ID` int(11) DEFAULT NULL,
  `VENDOR1ORDNUM` varchar(200) DEFAULT '',
  `VENDOR1COST` decimal(10,4) DEFAULT NULL,
  `VENDOR1CASEQTY` smallint(6) DEFAULT NULL,
  `VENDOR2ID` int(11) DEFAULT NULL,
  `VENDOR2ORDNUM` varchar(15) DEFAULT '',
  `VENDOR2COST` decimal(10,4) DEFAULT NULL,
  `VENDOR2CASEQTY` smallint(6) DEFAULT NULL,
  `VENDOR3ID` int(11) DEFAULT NULL,
  `VENDOR3ORDNUM` varchar(15) DEFAULT '',
  `VENDOR3COST` decimal(10,4) DEFAULT NULL,
  `VENDOR3CASEQTY` smallint(6) DEFAULT NULL,
  `LASTVENDORID` int(11) DEFAULT NULL,
  `CATEGORYID` int(11) DEFAULT NULL,
  `PRICE2` decimal(16,3) DEFAULT NULL,
  `P2PRCNT` decimal(11,2) DEFAULT NULL,
  `P2MRGN` decimal(9,2) DEFAULT NULL,
  `PRICE3` decimal(16,3) DEFAULT NULL,
  `P3PRCNT` decimal(11,2) DEFAULT NULL,
  `P3MRGN` decimal(9,2) DEFAULT NULL,
  `INACTDATE` date DEFAULT NULL,
  `THREEDCMLPRICE` int(1) DEFAULT '0',
  `SAMPLE` int(11) DEFAULT NULL,
  `WEIGHT` decimal(13,3) DEFAULT NULL,
  `ENDRETAILVAL` varchar(1) DEFAULT '',
  `KITITEM` int(1) DEFAULT NULL,
  `LUP_ID` int(11) DEFAULT NULL,
  `CODENAME` varchar(20) DEFAULT '',
  `SALESETUP` varchar(100) DEFAULT '',
  `SALESTART` date DEFAULT NULL,
  `SALEEND` date DEFAULT NULL,
  `SALEPRICE` decimal(14,2) DEFAULT NULL,
  `SALEDLR` decimal(10,2) DEFAULT NULL,
  `SALEPRCNT` decimal(9,2) DEFAULT NULL,
  `SALEDNT` datetime DEFAULT NULL,
  `ONSALE` int(1) DEFAULT NULL,
  `USEONHAND` int(1) DEFAULT NULL,
  `TRACKSRL` int(1) DEFAULT NULL,
  `INVLOC1ID` int(11) DEFAULT NULL,
  `INVLOC2ID` int(11) DEFAULT NULL,
  `SLSQTYSRCH` smallint(6) DEFAULT NULL,
  `PRMPT4EXT` int(1) DEFAULT NULL,
  `WEIGHITEM` int(1) DEFAULT NULL,
  `QTYLIMIT` int(11) DEFAULT NULL,
  `QTYDISCPCT` tinyint(4) DEFAULT NULL,
  `QTYDISCDLR` decimal(14,2) DEFAULT NULL,
  `ALLOWREWRD` int(1) DEFAULT NULL,
  `VFD01ID` int(11) DEFAULT NULL,
  `VFD02ID` int(11) DEFAULT NULL,
  `VFD03ID` int(11) DEFAULT NULL,
  `VFDNOTE` varchar(20) DEFAULT '',
  `ITMPHOTO1` varchar(100) DEFAULT '',
  `ITMPHOTO2` varchar(100) DEFAULT '',
  `ITMPHOTO3` varchar(100) DEFAULT '',
  `DSCONTNUED` int(1) DEFAULT NULL,
  `DSCONDATE` date DEFAULT NULL,
  `REORDCOST` decimal(16,3) DEFAULT NULL,
  `DISCOUNTBL` int(1) DEFAULT NULL,
  `DISCPRCNT` tinyint(4) DEFAULT NULL,
  `KITLSTITMS` tinyint(4) DEFAULT NULL,
  `INVLOCDESC` varchar(255) DEFAULT NULL,
  `INVLOCDESC2` varchar(255) DEFAULT NULL,
  `note_data` text,
  `newprice` decimal(15,4) DEFAULT NULL,
  `newmargin` decimal(15,4) DEFAULT NULL,
  `newmarkup` decimal(15,4) DEFAULT NULL,
  `itemphoto` varchar(255) DEFAULT NULL,
  `plunote_text` text,
  `trackserial` int(10) NOT NULL DEFAULT '0',
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  `allowrecurring` tinyint(1) DEFAULT '0',
  `item_artg` tinyint(1) NOT NULL DEFAULT '0',
  `artg_httplink` varchar(255) DEFAULT '',
  `item_media_retail` tinyint(1) NOT NULL DEFAULT '0',
  `item_locally` tinyint(1) NOT NULL DEFAULT '0',
  `item_shopify` tinyint(1) NOT NULL DEFAULT '0',
  `tobesync_shopify` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `store_id` int(10) NOT NULL DEFAULT '0',
  `taxrate_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tobesync` tinyint(1) NOT NULL DEFAULT '0',
  `update_from` varchar(255) DEFAULT NULL,
  `update_by_id` bigint(20) DEFAULT '0',
  `variant_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_store_id_index` (`store_id`),
  KEY `invenid_store_id` (`INVENTORYID`,`store_id`),
  KEY `inventory_variant_id_index` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79739 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_history`
--

DROP TABLE IF EXISTS `inventory_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_history` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `ACTION` varchar(45) DEFAULT '',
  `INVENTORYID` int(11) DEFAULT NULL,
  `LASTCOST` decimal(17,4) DEFAULT NULL,
  `OLDLASTCOST` decimal(17,4) DEFAULT NULL,
  `ACTUALCOST` decimal(17,4) DEFAULT NULL,
  `OLDACTUALCOST` decimal(17,4) DEFAULT NULL,
  `ON_HAND` decimal(16,3) DEFAULT NULL,
  `OLDON_HAND` decimal(16,3) DEFAULT NULL,
  `PRICE1` decimal(16,3) DEFAULT NULL,
  `OLDPRICE1` decimal(16,3) DEFAULT NULL,
  `P1PRCNT` decimal(11,2) DEFAULT NULL,
  `OLDP1PRCNT` decimal(11,2) DEFAULT NULL,
  `P1MRGN` decimal(9,2) DEFAULT NULL,
  `OLDP1MRGN` decimal(9,2) DEFAULT NULL,
  `AVG_COST` decimal(21,5) DEFAULT NULL,
  `OLDAVG_COST` decimal(21,5) DEFAULT NULL,
  `ITEMFRIEGHT` decimal(15,4) DEFAULT NULL,
  `OLDITEMFRIEGHT` decimal(15,4) DEFAULT NULL,
  `LASTVENDORID` int(11) DEFAULT NULL,
  `OLDLASTVENDORID` int(11) DEFAULT NULL,
  `new_update_from` varchar(255) DEFAULT NULL,
  `o_update_from` varchar(255) DEFAULT NULL,
  `new_update_id` bigint(20) DEFAULT '0',
  `o_update_id` bigint(20) DEFAULT '0',
  `USEONHAND` tinyint(1) DEFAULT NULL,
  `O_USEONHAND` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51479 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invlocation`
--

DROP TABLE IF EXISTS `invlocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invlocation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVLOCID` int(11) DEFAULT NULL,
  `INVLOCDESC` varchar(200) DEFAULT '',
  `store_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invlocation_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVOICENBR` int(11) DEFAULT NULL,
  `TMP_INVOICENBR` varchar(32) DEFAULT NULL,
  `INVOICEDATE` date DEFAULT NULL,
  `INVOICETIME` varchar(8) DEFAULT NULL,
  `invoicedatetime` datetime DEFAULT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `EMP_ID` varchar(100) DEFAULT '',
  `EMPLOYEE_ID` int(11) DEFAULT NULL,
  `DRAWER` varchar(2) DEFAULT '',
  `TAXRATE` decimal(10,3) DEFAULT NULL,
  `MOPCASH` tinyint(1) DEFAULT NULL,
  `MOPCHECK` tinyint(1) DEFAULT NULL,
  `CHECK_NBR` varchar(6) DEFAULT '',
  `MOPSPLIT` tinyint(1) DEFAULT NULL,
  `MOPCRDTCARD` tinyint(1) DEFAULT NULL,
  `CC_TYPE` varchar(16) DEFAULT '',
  `MOPCHARGE` tinyint(1) DEFAULT NULL,
  `SUBTOTAL` decimal(15,2) DEFAULT NULL,
  `TAXAMNT` decimal(15,2) DEFAULT NULL,
  `SLSTOTAL` decimal(15,2) DEFAULT NULL,
  `TENDERED` decimal(15,2) DEFAULT NULL,
  `SLSCHANGE` decimal(15,2) DEFAULT NULL,
  `BILL_ID` int(11) DEFAULT NULL,
  `PRICELVL` tinyint(4) DEFAULT NULL,
  `SLSSTATUS` varchar(15) DEFAULT '',
  `SLSNOTE` longtext,
  `WHR_NOTE` tinyint(1) DEFAULT NULL,
  `SPLTCASH` decimal(15,2) DEFAULT NULL,
  `SPLTCHECK` decimal(15,2) DEFAULT NULL,
  `SPLTCHKNBR` varchar(6) DEFAULT '',
  `SPLTCCARD1` decimal(15,2) DEFAULT NULL,
  `SPLTCTYPE1` varchar(16) DEFAULT '',
  `SPLTCCARD2` decimal(15,2) DEFAULT NULL,
  `SPLTCTYPE2` varchar(16) DEFAULT '',
  `SPLTBALANCE` decimal(15,2) DEFAULT NULL,
  `SPLTTENDTTL` decimal(15,2) DEFAULT NULL,
  `SCPNCNT` tinyint(4) DEFAULT NULL,
  `SCPNTTL` decimal(11,2) DEFAULT NULL,
  `SCPN1` decimal(10,2) DEFAULT NULL,
  `SCPN2` decimal(10,2) DEFAULT NULL,
  `SCPN3` decimal(10,2) DEFAULT NULL,
  `SCPN4` decimal(10,2) DEFAULT NULL,
  `SCPN5` decimal(10,2) DEFAULT NULL,
  `SPLTCHRGBAL` tinyint(1) DEFAULT NULL,
  `XCACCOUNT` varchar(20) DEFAULT '',
  `XCAPPROVAL` varchar(15) DEFAULT '',
  `XCCARDTYPE` varchar(20) DEFAULT '',
  `XCEXPIRE` varchar(10) DEFAULT '',
  `XCNAME` varchar(35) DEFAULT '',
  `XCTRANSID` varchar(50) DEFAULT '',
  `SRVCHRG` tinyint(1) DEFAULT NULL,
  `XCACCNTID` varchar(255) DEFAULT '',
  `XCVOIDID` varchar(50) DEFAULT '',
  `XCCARDBAL` decimal(14,2) DEFAULT NULL,
  `LOADEDBY` varchar(10) DEFAULT '',
  `TCHRGAPRV` varchar(10) DEFAULT '',
  `TCHRGNOTE` longtext,
  `MOPJDF` tinyint(1) DEFAULT NULL,
  `JDFAPPROVAL` varchar(10) DEFAULT '',
  `JDFREPAYTERMS` longtext,
  `JDFTERMINAL` varchar(15) DEFAULT '',
  `JDFINVREFNBR` varchar(15) DEFAULT '',
  `JDFBOGUSACCT` varchar(10) DEFAULT '',
  `SPLTJDFBAL` tinyint(1) DEFAULT NULL,
  `JDFCPN` varchar(107) DEFAULT '',
  `JDFDBC` varchar(107) DEFAULT '',
  `CC2ACCT` varchar(20) DEFAULT '',
  `CC2APPRVL` varchar(15) DEFAULT '',
  `CC2TYPE` varchar(20) DEFAULT '',
  `CC2EXPIRE` varchar(10) DEFAULT '',
  `CC2NAME` varchar(35) DEFAULT '',
  `CC2TRANSID` varchar(50) DEFAULT '',
  `CC2ACCTID` varchar(255) DEFAULT '',
  `CC2VOIDID` varchar(50) DEFAULT '',
  `CC2CRDBAL` decimal(14,2) DEFAULT NULL,
  `COMPUTERID` varchar(30) DEFAULT '',
  `EMAILTO` varchar(40) DEFAULT '',
  `INVOICEPO` varchar(30) DEFAULT '',
  `TRATEDESC` varchar(30) DEFAULT '',
  `SPLTREWARD` decimal(14,2) DEFAULT NULL,
  `CSTRWDID` int(11) DEFAULT NULL,
  `OK2CHRG` varchar(30) DEFAULT '',
  `OVRLMTAPRV` varchar(10) DEFAULT NULL,
  `newacctbal` decimal(15,2) DEFAULT NULL,
  `prvacctbal` decimal(15,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `AVSCARD1` varchar(100) DEFAULT NULL,
  `AVSCARD2` varchar(100) DEFAULT NULL,
  `CSVCARD1` varchar(100) DEFAULT NULL,
  `CSVCARD2` varchar(100) DEFAULT NULL,
  `SURCHARGE1` decimal(15,2) DEFAULT NULL,
  `SURCHARGE2` decimal(15,2) DEFAULT NULL,
  `C1ENTRYMD` varchar(50) DEFAULT NULL,
  `C1APPLBL` varchar(50) DEFAULT NULL,
  `C1AID` varchar(50) DEFAULT NULL,
  `C1TVR` varchar(50) DEFAULT NULL,
  `C1TSI` varchar(50) DEFAULT NULL,
  `C2ENTRYMD` varchar(50) DEFAULT NULL,
  `C2APPLBL` varchar(50) DEFAULT NULL,
  `C2AID` varchar(50) DEFAULT NULL,
  `C2TVR` varchar(50) DEFAULT NULL,
  `C2TSI` varchar(50) DEFAULT NULL,
  `moppaybyinv` tinyint(1) DEFAULT NULL,
  `chg_inv_status` tinyint(1) DEFAULT '1',
  `recurring` tinyint(1) DEFAULT '0',
  `save_amount` decimal(15,2) DEFAULT NULL,
  `xc_processor` tinyint(1) DEFAULT NULL,
  `xc_ref_number` varchar(255) DEFAULT NULL,
  `cc2_ref_number` varchar(255) DEFAULT NULL,
  `cash_rounding` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_store_id_index` (`store_id`),
  KEY `invoice_invoicenbr_index` (`INVOICENBR`),
  KEY `invoice_tmp_invoicenbr_index` (`TMP_INVOICENBR`)
) ENGINE=InnoDB AUTO_INCREMENT=3542 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoiceitems`
--

DROP TABLE IF EXISTS `invoiceitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoiceitems` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVOICENBR` int(11) DEFAULT NULL,
  `INVENTORYID` int(11) DEFAULT NULL,
  `QTY` decimal(14,3) DEFAULT NULL,
  `NONTAXABLE` tinyint(1) DEFAULT NULL,
  `SOLDPRICE` decimal(16,3) DEFAULT NULL,
  `BOOKEDID` int(11) DEFAULT NULL,
  `UNIT` varchar(3) DEFAULT '',
  `DISCOUNT` decimal(16,2) DEFAULT NULL,
  `COST` decimal(18,5) DEFAULT NULL,
  `CWT` tinyint(1) DEFAULT NULL,
  `ORIGPRICE` decimal(16,3) DEFAULT NULL,
  `PRICEFROM` varchar(30) DEFAULT '',
  `RECSTATUS` varchar(15) DEFAULT '',
  `PRNTOWHR` tinyint(1) DEFAULT NULL,
  `NONINVITEM` varchar(30) DEFAULT '',
  `DSCAPPROVE` varchar(100) DEFAULT '',
  `DSCNOTE` longtext,
  `OVRAPPROVE` varchar(100) DEFAULT '',
  `OVRNOTE` longtext,
  `XMPAPPROVE` varchar(100) DEFAULT '',
  `XMPNOTE` longtext,
  `EXTENAMNT` decimal(15,2) DEFAULT NULL,
  `LINENUM` int(11) DEFAULT NULL,
  `ORIGNONTAX` tinyint(1) DEFAULT NULL,
  `SERIALNBR` varchar(20) DEFAULT '',
  `VND1ORDNUM` varchar(14) DEFAULT '',
  `RTLPRICE` decimal(16,3) DEFAULT NULL,
  `REWARDOK` tinyint(1) DEFAULT NULL,
  `VFDSLSID` int(11) DEFAULT NULL,
  `VFDMAXQTY` int(11) DEFAULT NULL,
  `VFDAVLQTY` int(11) DEFAULT NULL,
  `VFDNUMBER` varchar(20) DEFAULT '',
  `VFDEXPIRE` date DEFAULT NULL,
  `VFDNOTE` varchar(20) DEFAULT '',
  `LOYALTYNTE` varchar(45) DEFAULT NULL,
  `INACTAPPRV` varchar(100) DEFAULT NULL,
  `LWQTYAPPRV` varchar(10) DEFAULT '',
  `KITLSTITMS` tinyint(4) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `lntaxrate` decimal(15,3) DEFAULT NULL,
  `lntaxdesc` varchar(255) DEFAULT NULL,
  `lntaxamnt` decimal(15,3) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoiceitems_store_id_index` (`store_id`),
  KEY `invoiceitems_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB AUTO_INCREMENT=1627262 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invupdt`
--

DROP TABLE IF EXISTS `invupdt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invupdt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENTORYID` int(11) NOT NULL DEFAULT '0',
  `IHCOST` decimal(16,3) DEFAULT NULL,
  `IHPERCENT` decimal(11,2) DEFAULT NULL,
  `VENDORID` int(11) DEFAULT NULL,
  `EMPLOYEE` varchar(255) DEFAULT '',
  `EMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `IHDATE` date DEFAULT NULL,
  `IHTIME` time DEFAULT NULL,
  `ihdatetime` datetime DEFAULT NULL,
  `INV_NOTE` varchar(30) DEFAULT '',
  `IHPRICE1` decimal(16,3) DEFAULT NULL,
  `IHAVGCOST` decimal(18,5) DEFAULT NULL,
  `IHCOSTADJ` decimal(18,5) DEFAULT NULL,
  `IHQTYADJ` decimal(16,3) DEFAULT NULL,
  `IHONHAND` decimal(16,3) DEFAULT NULL,
  `IHMARGIN` decimal(11,2) DEFAULT NULL,
  `IHTAXRATE` varchar(255) DEFAULT NULL,
  `IHNONTAXABLE` varchar(255) DEFAULT NULL,
  `CATEGORYID` int(11) DEFAULT NULL,
  `ADJFROM` varchar(20) DEFAULT '',
  `markup` varchar(255) DEFAULT NULL,
  `store_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invupdt_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103623 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invupdt_stock`
--

DROP TABLE IF EXISTS `invupdt_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invupdt_stock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `invenid` int(11) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `old_onhand` decimal(8,3) DEFAULT NULL,
  `entity_onhand` decimal(8,3) DEFAULT NULL,
  `new_onhand` decimal(8,3) DEFAULT NULL,
  `logreason_id` int(11) DEFAULT NULL,
  `logreason` text COLLATE utf8mb4_unicode_ci,
  `user_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1044 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemupc`
--

DROP TABLE IF EXISTS `itemupc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemupc` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENID` int(11) DEFAULT NULL,
  `UPC` varchar(14) DEFAULT '',
  `UPCINACT` tinyint(1) DEFAULT NULL,
  `ISPRIME` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `itemupc_store_id_index` (`store_id`),
  KEY `itemupc_invenid_index` (`INVENID`)
) ENGINE=InnoDB AUTO_INCREMENT=143875 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jdfinancial`
--

DROP TABLE IF EXISTS `jdfinancial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jdfinancial` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `MRCHNTNBR` varchar(8) DEFAULT '',
  `DISCLOSURE` longtext,
  `IVRPHONE` varchar(13) DEFAULT '',
  `RVWPHONE` varchar(13) DEFAULT '',
  `PLANID` int(11) DEFAULT NULL,
  `CREDITPLAN` varchar(5) DEFAULT '',
  `PLANDESC` varchar(100) DEFAULT '',
  `STARTDATE` date DEFAULT NULL,
  `ENDINGDATE` date DEFAULT NULL,
  `RECTYPE` varchar(8) DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `jdfinancial_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kititems`
--

DROP TABLE IF EXISTS `kititems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kititems` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENID` int(11) DEFAULT NULL,
  `QTY` decimal(16,3) DEFAULT NULL,
  `AVGCOST` decimal(18,5) DEFAULT NULL,
  `RETAIL` decimal(16,4) DEFAULT NULL,
  `KITCOST` decimal(18,5) DEFAULT NULL,
  `KITRETAIL` decimal(16,3) DEFAULT NULL,
  `COSTPRCNT` decimal(14,4) DEFAULT NULL,
  `CALCRETAIL` decimal(16,3) DEFAULT NULL,
  `CALCCOST` decimal(16,3) DEFAULT NULL,
  `INPUTRTL` decimal(16,3) DEFAULT '0.000',
  `PRICEBY` varchar(10) DEFAULT '',
  `KITLINENO` tinyint(4) DEFAULT NULL,
  `KITID` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1551 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kitsales`
--

DROP TABLE IF EXISTS `kitsales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kitsales` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `KITID` int(11) DEFAULT NULL,
  `INVENID` int(11) DEFAULT NULL,
  `QTYSOLD` decimal(10,3) DEFAULT NULL,
  `VENDORDNBR` varchar(16) DEFAULT NULL,
  `KITITEMDSC` varchar(30) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kk_files`
--

DROP TABLE IF EXISTS `kk_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kk_files` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `STATUS` int(1) NOT NULL DEFAULT '0',
  `FILENAME` varchar(45) DEFAULT NULL,
  `FILEPATH` varchar(100) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `latepay`
--

DROP TABLE IF EXISTS `latepay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `latepay` (
  `id` bigint(20) unsigned NOT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `TOTAL_DUE` decimal(15,2) DEFAULT NULL,
  `DAYS_LATE` smallint(6) DEFAULT NULL,
  `PREV_BAL` decimal(15,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logonlog`
--

DROP TABLE IF EXISTS `logonlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logonlog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CURLOGGED` varchar(10) DEFAULT '',
  `CURLOGGED_ID` int(11) DEFAULT NULL,
  `LOGDATETIME` date DEFAULT NULL,
  `LOGIN` varchar(60) DEFAULT '',
  `LOGIN_ID` int(11) DEFAULT NULL,
  `SUCCESS` tinyint(1) DEFAULT NULL,
  `PWATTEMPT` varchar(8) DEFAULT '',
  `NEWLOGON` tinyint(1) DEFAULT NULL,
  `SYSLOGON` tinyint(1) DEFAULT NULL,
  `QUICKLOGON` tinyint(1) DEFAULT NULL,
  `QLOGINTO` varchar(20) DEFAULT '',
  `COMPUTERID` varchar(30) DEFAULT '',
  `store_id` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17343 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lupcodes`
--

DROP TABLE IF EXISTS `lupcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lupcodes` (
  `id` bigint(20) unsigned NOT NULL,
  `LUP_ID` int(11) DEFAULT NULL,
  `LUP_NAME` varchar(20) DEFAULT '',
  `store_id` int(10) NOT NULL DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `masterct`
--

DROP TABLE IF EXISTS `masterct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `masterct` (
  `id` int(11) NOT NULL,
  `MASTER_ID` bigint(20) unsigned DEFAULT NULL,
  `MASTERNAME` varchar(25) DEFAULT '',
  `store_id` int(10) NOT NULL DEFAULT '0',
  `created_by` int(10) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_to_id` int(11) NOT NULL,
  `user_from_id` int(11) NOT NULL,
  `message_text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT '1',
  `store_id` int(11) NOT NULL,
  `read_datetime` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=473 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `miscincome`
--

DROP TABLE IF EXISTS `miscincome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `miscincome` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MISCINCID` int(11) DEFAULT NULL,
  `MIDATE` date DEFAULT NULL,
  `MITIME` varchar(8) DEFAULT '',
  `midatetime` datetime DEFAULT NULL,
  `MIDRAWER` varchar(2) DEFAULT '',
  `MIEMPLOYEE` varchar(200) DEFAULT '',
  `MIEMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `MIAMOUNT` decimal(13,2) DEFAULT NULL,
  `MICASH` tinyint(1) DEFAULT NULL,
  `MICHECK` tinyint(1) DEFAULT NULL,
  `MICHKNMBR` varchar(6) DEFAULT '',
  `MICCARD` tinyint(1) DEFAULT NULL,
  `MICRDTTYPE` varchar(16) DEFAULT '',
  `MIREASON` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `xc_ref_number` varchar(255) DEFAULT NULL,
  `cc2_ref_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=571 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mnth_cap`
--

DROP TABLE IF EXISTS `mnth_cap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mnth_cap` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `STARTDATE` date DEFAULT NULL,
  `ENDDATE` date DEFAULT NULL,
  `GRD_TTL` decimal(20,2) DEFAULT NULL,
  `TTL_PREV` decimal(20,2) DEFAULT NULL,
  `TTL_CUR` decimal(20,2) DEFAULT NULL,
  `TTL_30` decimal(20,2) DEFAULT NULL,
  `TTL_60` decimal(20,2) DEFAULT NULL,
  `TTL_90` decimal(20,2) DEFAULT NULL,
  `TTL_120` decimal(20,2) DEFAULT NULL,
  `TTL_AVG_CO` decimal(20,2) DEFAULT NULL,
  `COST` decimal(20,2) DEFAULT NULL,
  `PRICE` decimal(20,2) DEFAULT NULL,
  `DISCOUNT` decimal(20,2) DEFAULT NULL,
  `EXTENDED` decimal(20,2) DEFAULT NULL,
  `PROFIT` decimal(20,2) DEFAULT NULL,
  `MARKUP` decimal(20,2) DEFAULT NULL,
  `TAXRATE` varchar(5) DEFAULT '',
  `SUBTOTAL` decimal(20,2) DEFAULT NULL,
  `TOTAL` decimal(20,2) DEFAULT NULL,
  `TAX` decimal(20,2) DEFAULT NULL,
  `TAXABLE` decimal(20,2) DEFAULT NULL,
  `NTAXABLE` decimal(20,2) DEFAULT NULL,
  `MARGIN` decimal(20,2) DEFAULT NULL,
  `TIME` varchar(8) DEFAULT '',
  `TTLRTLVAL` decimal(20,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_authentication`
--

DROP TABLE IF EXISTS `mydbr_authentication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_authentication` (
  `module` varchar(20) NOT NULL,
  `mask` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_favourite_folders`
--

DROP TABLE IF EXISTS `mydbr_favourite_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_favourite_folders` (
  `id` int(11) NOT NULL,
  `user` varchar(128) DEFAULT NULL,
  `authentication` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_favourite_reports`
--

DROP TABLE IF EXISTS `mydbr_favourite_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_favourite_reports` (
  `id` int(11) NOT NULL,
  `user` varchar(128) DEFAULT NULL,
  `authentication` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `url` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_folders`
--

DROP TABLE IF EXISTS `mydbr_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_folders` (
  `folder_id` int(11) NOT NULL,
  `mother_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `invisible` tinyint(4) DEFAULT NULL,
  `reportgroup` int(11) NOT NULL DEFAULT '1',
  `explanation` varchar(4096) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_folders_priv`
--

DROP TABLE IF EXISTS `mydbr_folders_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_folders_priv` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `username` varchar(128) NOT NULL,
  `group_id` int(11) NOT NULL,
  `authentication` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_geocode`
--

DROP TABLE IF EXISTS `mydbr_geocode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_geocode` (
  `md5hash` char(32) NOT NULL,
  `latitude` decimal(12,9) DEFAULT NULL,
  `longitude` decimal(12,9) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_groups`
--

DROP TABLE IF EXISTS `mydbr_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_groups` (
  `group_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_groupsusers`
--

DROP TABLE IF EXISTS `mydbr_groupsusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_groupsusers` (
  `group_id` int(11) NOT NULL,
  `user` varchar(128) NOT NULL,
  `authentication` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_key_column_usage`
--

DROP TABLE IF EXISTS `mydbr_key_column_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_key_column_usage` (
  `table_schema` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `column_name` varchar(64) NOT NULL,
  `referenced_table_schema` varchar(64) DEFAULT NULL,
  `referenced_table_name` varchar(64) DEFAULT NULL,
  `referenced_column_name` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_languages`
--

DROP TABLE IF EXISTS `mydbr_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_languages` (
  `lang_locale` char(5) NOT NULL,
  `language` varchar(30) DEFAULT NULL,
  `date_format` varchar(10) DEFAULT NULL,
  `time_format` varchar(10) DEFAULT NULL,
  `thousand_separator` varchar(2) DEFAULT NULL,
  `decimal_separator` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_licenses`
--

DROP TABLE IF EXISTS `mydbr_licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_licenses` (
  `id` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `license_key` varchar(80) NOT NULL,
  `db` varchar(10) NOT NULL,
  `expiration` date NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_localization`
--

DROP TABLE IF EXISTS `mydbr_localization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_localization` (
  `lang_locale` char(5) NOT NULL,
  `keyword` varchar(50) NOT NULL,
  `translation` varchar(1024) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_log`
--

DROP TABLE IF EXISTS `mydbr_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_log` (
  `id` int(11) NOT NULL,
  `user` varchar(128) DEFAULT NULL,
  `log_time` datetime DEFAULT NULL,
  `log_ip` varchar(40) DEFAULT NULL,
  `log_title` varchar(30) DEFAULT NULL,
  `log_message` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_login_fail_blocks`
--

DROP TABLE IF EXISTS `mydbr_login_fail_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_login_fail_blocks` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(39) DEFAULT NULL,
  `blocked_until` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_login_fail_log`
--

DROP TABLE IF EXISTS `mydbr_login_fail_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_login_fail_log` (
  `id` int(11) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `ip_address` varchar(39) DEFAULT NULL,
  `username` varchar(128) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_agent_hash` varchar(50) DEFAULT NULL,
  `ad_domain_controller` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_notifications`
--

DROP TABLE IF EXISTS `mydbr_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_notifications` (
  `id` int(11) NOT NULL,
  `notification` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_options`
--

DROP TABLE IF EXISTS `mydbr_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_options` (
  `user` varchar(128) NOT NULL,
  `authentication` int(11) NOT NULL DEFAULT '0',
  `name` varchar(30) NOT NULL,
  `value` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_organizations`
--

DROP TABLE IF EXISTS `mydbr_organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_organizations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_param_queries`
--

DROP TABLE IF EXISTS `mydbr_param_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_param_queries` (
  `name` varchar(50) NOT NULL,
  `query` varchar(4096) DEFAULT NULL,
  `coltype` tinyint(4) NOT NULL,
  `options` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_params`
--

DROP TABLE IF EXISTS `mydbr_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_params` (
  `proc_name` varchar(100) NOT NULL,
  `param` varchar(100) NOT NULL,
  `query_name` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `default_value` varchar(50) DEFAULT NULL,
  `optional` int(11) NOT NULL DEFAULT '0',
  `only_default` int(11) NOT NULL DEFAULT '0',
  `suffix` varchar(255) DEFAULT NULL,
  `options` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_password_reset`
--

DROP TABLE IF EXISTS `mydbr_password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_password_reset` (
  `user` varchar(128) NOT NULL,
  `perishable_token` varchar(128) NOT NULL,
  `request_time` datetime NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_progress`
--

DROP TABLE IF EXISTS `mydbr_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_progress` (
  `id` int(11) NOT NULL,
  `task` varchar(20) NOT NULL,
  `maximum` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_remote_servers`
--

DROP TABLE IF EXISTS `mydbr_remote_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_remote_servers` (
  `id` int(11) NOT NULL,
  `server` varchar(128) NOT NULL,
  `url` varchar(255) NOT NULL,
  `hash` varchar(40) NOT NULL,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_report_extensions`
--

DROP TABLE IF EXISTS `mydbr_report_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_report_extensions` (
  `proc_name` varchar(100) NOT NULL,
  `extension` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_reportgroups`
--

DROP TABLE IF EXISTS `mydbr_reportgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_reportgroups` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `sortorder` int(11) NOT NULL,
  `color` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_reports`
--

DROP TABLE IF EXISTS `mydbr_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_reports` (
  `report_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `proc_name` varchar(100) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `explanation` varchar(4096) DEFAULT NULL,
  `reportgroup` int(11) NOT NULL DEFAULT '1',
  `sortorder` int(11) DEFAULT NULL,
  `runreport` varchar(50) DEFAULT NULL,
  `autoexecute` tinyint(4) DEFAULT NULL,
  `parameter_help` varchar(10000) DEFAULT NULL,
  `export` varchar(10) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_reports_priv`
--

DROP TABLE IF EXISTS `mydbr_reports_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_reports_priv` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `username` varchar(128) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `authentication` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_scheduled_tasks`
--

DROP TABLE IF EXISTS `mydbr_scheduled_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_scheduled_tasks` (
  `id` int(11) NOT NULL,
  `description` varchar(2028) DEFAULT NULL,
  `url` varchar(2028) DEFAULT NULL,
  `timing` varchar(255) NOT NULL,
  `last_run` datetime DEFAULT NULL,
  `disabled` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_snippets`
--

DROP TABLE IF EXISTS `mydbr_snippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_snippets` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `code` text,
  `shortcut` varchar(20) DEFAULT NULL,
  `cright` int(11) DEFAULT NULL,
  `cdown` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_statistics`
--

DROP TABLE IF EXISTS `mydbr_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_statistics` (
  `proc_name` varchar(100) NOT NULL,
  `username` varchar(128) DEFAULT NULL,
  `authentication` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `query` longtext,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent_hash` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_styles`
--

DROP TABLE IF EXISTS `mydbr_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_styles` (
  `name` varchar(30) NOT NULL,
  `colstyle` tinyint(4) NOT NULL,
  `definition` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_sync_exclude`
--

DROP TABLE IF EXISTS `mydbr_sync_exclude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_sync_exclude` (
  `username` varchar(128) NOT NULL,
  `authentication` int(11) NOT NULL,
  `proc_name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_template_folders`
--

DROP TABLE IF EXISTS `mydbr_template_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_template_folders` (
  `id` int(11) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_templates`
--

DROP TABLE IF EXISTS `mydbr_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_templates` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `header` text,
  `rowdata` text,
  `footer` text,
  `folder_id` int(11) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_twofa_secrets`
--

DROP TABLE IF EXISTS `mydbr_twofa_secrets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_twofa_secrets` (
  `provider` varchar(100) NOT NULL,
  `username` varchar(128) NOT NULL,
  `authentication` int(11) NOT NULL,
  `secret` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_ui_category_collapse`
--

DROP TABLE IF EXISTS `mydbr_ui_category_collapse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_ui_category_collapse` (
  `username` varchar(128) NOT NULL,
  `authentication` int(11) NOT NULL,
  `mother_id` int(11) NOT NULL,
  `reportgroup` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_update`
--

DROP TABLE IF EXISTS `mydbr_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_update` (
  `latest_version` varchar(10) NOT NULL,
  `next_check` int(11) DEFAULT NULL,
  `download_link` varchar(200) DEFAULT NULL,
  `info_link` varchar(200) DEFAULT NULL,
  `last_successful_check` int(11) DEFAULT NULL,
  `signature` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_user_agents`
--

DROP TABLE IF EXISTS `mydbr_user_agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_user_agents` (
  `hash` varchar(50) NOT NULL,
  `user_agent` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_user_logins`
--

DROP TABLE IF EXISTS `mydbr_user_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_user_logins` (
  `username` varchar(128) NOT NULL,
  `authentication` int(11) NOT NULL,
  `session_hash` varchar(40) NOT NULL,
  `login_at` datetime DEFAULT NULL,
  `logout_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_userlogin`
--

DROP TABLE IF EXISTS `mydbr_userlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_userlogin` (
  `user` varchar(128) NOT NULL,
  `password` char(255) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `admin` tinyint(4) NOT NULL DEFAULT '0',
  `passworddate` datetime DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telephone` varchar(100) DEFAULT NULL,
  `authentication` int(11) NOT NULL DEFAULT '2',
  `ask_pw_change` int(11) NOT NULL DEFAULT '0',
  `organization_id` int(11) DEFAULT NULL,
  `disabled` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mydbr_version`
--

DROP TABLE IF EXISTS `mydbr_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mydbr_version` (
  `version` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ocr_vendors`
--

DROP TABLE IF EXISTS `ocr_vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ocr_vendors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_mappings` longtext COLLATE utf8mb4_unicode_ci,
  `all_fields` longtext COLLATE utf8mb4_unicode_ci,
  `uploaded_file` text COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pdfco',
  `text_context` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offline_sales`
--

DROP TABLE IF EXISTS `offline_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offline_sales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `items_count` int(10) unsigned NOT NULL DEFAULT '0',
  `total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `synced` tinyint(1) NOT NULL DEFAULT '0',
  `synced_at` datetime DEFAULT NULL,
  `source` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'offline',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offline_sales_uuid_unique` (`uuid`),
  KEY `offline_sales_store_id_index` (`store_id`),
  KEY `offline_sales_user_id_index` (`user_id`),
  KEY `offline_sales_synced_index` (`synced`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orgillcatalog`
--

DROP TABLE IF EXISTS `orgillcatalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orgillcatalog` (
  `id` bigint(20) unsigned NOT NULL,
  `ORGILLSKU` varchar(8) DEFAULT '',
  `ITEMDESC` varchar(30) DEFAULT '',
  `UPC11DIGIT` varchar(11) DEFAULT '',
  `PLVL1COST` decimal(16,3) DEFAULT NULL,
  `VP1COST` decimal(16,3) DEFAULT NULL,
  `VP2COST` decimal(16,3) DEFAULT NULL,
  `ADVCOST` decimal(16,3) DEFAULT NULL,
  `SUGRETAIL` decimal(16,3) DEFAULT NULL,
  `SELLUOM` varchar(5) DEFAULT '',
  `WEIGHT` decimal(13,3) DEFAULT NULL,
  `BREAKPACK` tinyint(1) DEFAULT NULL,
  `MINORDQTY` int(11) DEFAULT NULL,
  `DIVISION` smallint(6) DEFAULT NULL,
  `BUYINGDEPT` varchar(1) DEFAULT '',
  `RPTGROUP` varchar(3) DEFAULT '',
  `RTLCLASS` int(11) DEFAULT NULL,
  `CATPGNO` varchar(8) DEFAULT '',
  `VENDORNBR` varchar(30) DEFAULT NULL,
  `FACTORYNBR` varchar(17) DEFAULT '',
  `RETAILUOM` varchar(5) DEFAULT '',
  `RTLCONVFLG` varchar(1) DEFAULT '',
  `RTLCONVFCT` int(11) DEFAULT NULL,
  `RTLSNSCODE` varchar(1) DEFAULT '',
  `QTYRNDOPT` varchar(1) DEFAULT '',
  `RECCHNGFLG` varchar(1) DEFAULT '',
  `SHELFPACK` int(11) DEFAULT NULL,
  `RTLUPCNBR` varchar(14) DEFAULT '',
  `UPC12DIGIT` varchar(12) DEFAULT '',
  `UPCFILLER` varchar(2) DEFAULT '',
  `DSCONTNUED` tinyint(1) DEFAULT NULL,
  `DSCONDATE` date DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  KEY `idx_orgillcatalog_sku_store` (`ORGILLSKU`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orgillclass`
--

DROP TABLE IF EXISTS `orgillclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orgillclass` (
  `id` bigint(20) unsigned NOT NULL,
  `DEPT` varchar(8) DEFAULT '',
  `DEPTDESC` varchar(23) DEFAULT '',
  `CLASS` varchar(8) DEFAULT '',
  `CLASSDESC` varchar(32) DEFAULT '',
  `RTLCLS` varchar(8) DEFAULT '',
  `RTLCLSDESC` varchar(32) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orgillfm`
--

DROP TABLE IF EXISTS `orgillfm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orgillfm` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ORGILLSKU` varchar(8) DEFAULT '',
  `ITEMDESC` varchar(30) DEFAULT '',
  `UPC11DIGIT` varchar(11) DEFAULT '',
  `PLVL1COST` decimal(16,3) DEFAULT NULL,
  `VP1COST` decimal(16,3) DEFAULT NULL,
  `VP2COST` decimal(16,3) DEFAULT NULL,
  `ADVCOST` decimal(16,3) DEFAULT NULL,
  `SUGRETAIL` decimal(16,3) DEFAULT NULL,
  `SELLUOM` varchar(5) DEFAULT '',
  `WEIGHT` decimal(13,3) DEFAULT NULL,
  `BREAKPACK` tinyint(1) DEFAULT NULL,
  `MINORDQTY` int(11) DEFAULT NULL,
  `DIVISION` smallint(6) DEFAULT NULL,
  `BUYINGDEPT` varchar(1) DEFAULT '',
  `RPTGROUP` varchar(3) DEFAULT '',
  `RTLCLASS` int(11) DEFAULT NULL,
  `CATPGNO` varchar(8) DEFAULT '',
  `VENDORNBR` varchar(30) DEFAULT NULL,
  `FACTORYNBR` varchar(17) DEFAULT '',
  `RETAILUOM` varchar(5) DEFAULT '',
  `RTLCONVFLG` varchar(1) DEFAULT '',
  `RTLCONVFCT` int(11) DEFAULT NULL,
  `RTLSNSCODE` varchar(1) DEFAULT '',
  `QTYRNDOPT` varchar(1) DEFAULT '',
  `RECCHNGFLG` varchar(1) DEFAULT '',
  `SHELFPACK` int(11) DEFAULT NULL,
  `RTLUPCNBR` varchar(14) DEFAULT '',
  `UPC12DIGIT` varchar(12) DEFAULT '',
  `UPCFILLER` varchar(2) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_orgillfm_sku_store` (`ORGILLSKU`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1626 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `token` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pax_logs`
--

DROP TABLE IF EXISTS `pax_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pax_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `request_type` int(11) DEFAULT NULL,
  `sub_request_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `entity_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `request` longtext COLLATE utf8mb4_unicode_ci,
  `response` longtext COLLATE utf8mb4_unicode_ci,
  `transaction_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `station_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status_msg` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4099 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payables`
--

DROP TABLE IF EXISTS `payables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payables` (
  `id` bigint(20) unsigned NOT NULL,
  `PAYABLEID` int(11) DEFAULT NULL,
  `VENDORID` int(11) DEFAULT NULL,
  `AMOUNT` decimal(15,2) DEFAULT NULL,
  `INVNBR` varchar(15) DEFAULT '',
  `VOUCHERID` int(11) DEFAULT NULL,
  `PYBLDATE` date DEFAULT NULL,
  `PYBLTIME` varchar(8) DEFAULT '',
  `DUEDATE` date DEFAULT NULL,
  `PAIDDATE` date DEFAULT NULL,
  `TRANSTYPE` varchar(10) DEFAULT '',
  `CHECKNBR` varchar(10) DEFAULT '',
  `EMPLOYEE` varchar(255) DEFAULT '',
  `EMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `qb_bill_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paybyinv_activity`
--

DROP TABLE IF EXISTS `paybyinv_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paybyinv_activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cust_id` int(11) NOT NULL,
  `a_datetime` datetime NOT NULL,
  `entity_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_number` int(11) NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(8,2) NOT NULL,
  `prev_bal` double(8,2) NOT NULL,
  `new_bal` double(8,2) NOT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paybyinv_invoice`
--

DROP TABLE IF EXISTS `paybyinv_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paybyinv_invoice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `invoicenbr` int(11) NOT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `master` tinyint(1) NOT NULL DEFAULT '0',
  `reference_no` int(11) DEFAULT NULL,
  `recurring` tinyint(1) NOT NULL DEFAULT '0',
  `repeat_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_weekday` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repeat_day` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_from` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_to` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom_message` text COLLATE utf8mb4_unicode_ci,
  `payment_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duedate` datetime DEFAULT NULL,
  `duedate_option` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `end_option` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enddate` datetime DEFAULT NULL,
  `end_afterinv` int(11) DEFAULT NULL,
  `end_reason` text COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paybyinv_payment`
--

DROP TABLE IF EXISTS `paybyinv_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paybyinv_payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `invoicenbr` int(11) NOT NULL,
  `paymentnbr` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `p_datetime` datetime NOT NULL,
  `p_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `p_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `p_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(8,2) NOT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ROANBR` int(11) DEFAULT NULL,
  `ROADATE` date DEFAULT NULL,
  `ROATIME` varchar(8) DEFAULT '',
  `raodatetime` datetime DEFAULT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `EMPLOYEE` varchar(255) DEFAULT NULL,
  `EMP_ID` varchar(8) DEFAULT '',
  `ROATOTAL` decimal(15,2) DEFAULT NULL,
  `CASH_AMT` decimal(15,2) DEFAULT NULL,
  `CHECK_AMT` decimal(15,2) DEFAULT NULL,
  `ACH_AMT` decimal(9,2) NOT NULL DEFAULT '0.00',
  `CHECK_NBR` varchar(6) DEFAULT '',
  `ACH_REQUEST_ID` varchar(30) DEFAULT NULL,
  `CREDIT_AMT` decimal(15,2) DEFAULT NULL,
  `CC_TYPE` varchar(16) DEFAULT '',
  `DRAWER` varchar(2) DEFAULT '',
  `NOTE` longtext,
  `BILL_ID` int(11) DEFAULT NULL,
  `PRVACCTBAL` decimal(15,2) DEFAULT NULL,
  `NEWACCTBAL` decimal(15,2) DEFAULT NULL,
  `XCACCOUNT` varchar(20) DEFAULT '',
  `XCAPPROVAL` varchar(15) DEFAULT '',
  `XCCARDTYPE` varchar(20) DEFAULT '',
  `XCNAME` varchar(35) DEFAULT '',
  `XCSIGIMAGE` longtext,
  `XCTRANSID` varchar(50) DEFAULT '',
  `XCEXPIRE` varchar(10) DEFAULT '',
  `XCACCNTID` varchar(255) DEFAULT '',
  `XCCARDBAL` decimal(14,2) DEFAULT NULL,
  `COMPUTERID` varchar(30) DEFAULT '',
  `ROAADJUST` decimal(15,2) DEFAULT NULL,
  `VOIDED` tinyint(1) DEFAULT NULL,
  `VOIDEDBY` varchar(10) DEFAULT '',
  `voiddatetime` datetime DEFAULT NULL,
  `VOIDDATE` date DEFAULT NULL,
  `VOIDTIME` varchar(8) DEFAULT '',
  `VOIDID` varchar(10) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `SURCHARGE` decimal(15,2) DEFAULT NULL,
  `EMAILTO` varchar(100) DEFAULT NULL,
  `AVSRESPNS` varchar(100) DEFAULT NULL,
  `CSVRESPNS` varchar(100) DEFAULT NULL,
  `is_used` tinyint(1) DEFAULT NULL,
  `xc_processor` tinyint(1) DEFAULT NULL,
  `XCTSI` varchar(50) DEFAULT NULL,
  `XCTVR` varchar(50) DEFAULT NULL,
  `XCAID` varchar(50) DEFAULT NULL,
  `XCAPPLBL` varchar(100) DEFAULT NULL,
  `XCENTRYMD` varchar(50) DEFAULT NULL,
  `xc_ref_number` varchar(255) DEFAULT NULL,
  `cc2_ref_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7882 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pdfinstall`
--

DROP TABLE IF EXISTS `pdfinstall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pdfinstall` (
  `id` bigint(20) unsigned NOT NULL,
  `FILENAME` varchar(120) DEFAULT '',
  `DIR` varchar(10) DEFAULT '',
  `CONTENTS` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poitems`
--

DROP TABLE IF EXISTS `poitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `poitems` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `POID` int(11) DEFAULT NULL,
  `POINVENID` int(11) DEFAULT NULL,
  `VNDORDNUM` varchar(14) DEFAULT '',
  `QTY2ORDER` decimal(15,3) DEFAULT NULL,
  `ONHAND` decimal(15,3) DEFAULT NULL,
  `QTYSOLD` decimal(15,3) DEFAULT NULL,
  `CATEGORYID` int(11) DEFAULT NULL,
  `WEIGHT` decimal(13,3) DEFAULT NULL,
  `CASEQTY` smallint(6) DEFAULT NULL,
  `INACTIVE` tinyint(1) DEFAULT NULL,
  `COST` decimal(15,3) DEFAULT NULL,
  `ADDONITEM` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=798552 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `povchitem`
--

DROP TABLE IF EXISTS `povchitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `povchitem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `VOUCHNUM` int(11) DEFAULT NULL,
  `INVENID` int(11) DEFAULT NULL,
  `RCVQTY` decimal(16,3) DEFAULT NULL,
  `ORGONHAND` decimal(16,3) DEFAULT NULL,
  `RCVONHAND` decimal(16,3) DEFAULT NULL,
  `ORGCOST` decimal(17,4) DEFAULT NULL,
  `RCVCOST` decimal(17,4) DEFAULT NULL,
  `RCVLFRGHT` decimal(13,4) DEFAULT NULL,
  `ORGPRICE` decimal(16,3) DEFAULT NULL,
  `RCVPRICE` decimal(16,3) DEFAULT NULL,
  `PRICECHNG` tinyint(1) DEFAULT NULL,
  `ORGAVGCOST` decimal(21,5) DEFAULT NULL,
  `RCVAVGCOST` decimal(21,5) DEFAULT NULL,
  `ORGMARKUP` decimal(11,2) DEFAULT NULL,
  `RCVMARKUP` decimal(11,2) DEFAULT NULL,
  `ORGMARGIN` decimal(9,2) DEFAULT NULL,
  `RCVMARGIN` decimal(9,2) DEFAULT NULL,
  `CWT` tinyint(1) DEFAULT NULL,
  `UNITMKUP` decimal(11,2) DEFAULT NULL,
  `WEIGHT` decimal(13,3) DEFAULT NULL,
  `ENDRTLVAL` varchar(1) DEFAULT '',
  `L3DECRTL` tinyint(1) DEFAULT NULL,
  `LINENUM` bigint(20) DEFAULT NULL,
  `SGSTPRICE` decimal(16,3) DEFAULT NULL,
  `ORDERNUM` varchar(14) DEFAULT '',
  `SERIALNBR` varchar(20) DEFAULT '',
  `new_item` varchar(255) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `povoucher`
--

DROP TABLE IF EXISTS `povoucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `povoucher` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `VENDORID` int(11) DEFAULT NULL,
  `EMPLOYEE` varchar(255) DEFAULT '',
  `RCVDATE` date DEFAULT NULL,
  `RCVTIME` varchar(8) DEFAULT '',
  `INVDATE` date DEFAULT NULL,
  `RCVINUM` varchar(15) DEFAULT '',
  `FREIGHT` decimal(15,2) DEFAULT NULL,
  `TTLCOST` decimal(15,2) DEFAULT NULL,
  `VCHTOTAL` decimal(15,2) DEFAULT NULL,
  `RECEIVED` tinyint(1) DEFAULT NULL,
  `FRGHTRATE` decimal(15,4) DEFAULT NULL,
  `FLATRATE` tinyint(1) DEFAULT NULL,
  `DISTFRGHT` tinyint(1) DEFAULT NULL,
  `EDITMODE` tinyint(1) DEFAULT NULL,
  `POID` int(11) DEFAULT NULL,
  `RCVNOTE` longtext,
  `EDINOTE` longtext,
  `EDITOTAL` decimal(15,2) DEFAULT NULL,
  `EDIVENDOR` varchar(20) DEFAULT '',
  `store_id` int(10) DEFAULT '0',
  `user_id` int(10) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcchnglog`
--

DROP TABLE IF EXISTS `prcchnglog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prcchnglog` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `INVENID` int(11) DEFAULT NULL,
  `EMP_ID` int(11) DEFAULT NULL,
  `EMP` varchar(20) DEFAULT '',
  `AUDIT_DATE` date DEFAULT NULL,
  `AUDIT_TIME` varchar(8) DEFAULT '',
  `DATETIME` datetime DEFAULT NULL,
  `PRCNTCHNG` decimal(2,0) DEFAULT NULL,
  `PRICE1` decimal(11,3) DEFAULT NULL,
  `P1PRCNT` decimal(7,2) DEFAULT NULL,
  `P1MRGN` decimal(5,2) DEFAULT NULL,
  `ACTUALCOST` decimal(11,4) DEFAULT NULL,
  `ORGPRICE` decimal(11,3) DEFAULT NULL,
  `ORGPRCNT` decimal(11,3) DEFAULT NULL,
  `ORGMRGN` decimal(5,2) DEFAULT NULL,
  `CATEGORYID` int(11) DEFAULT NULL,
  `SRCHMETHOD` varchar(20) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prchorders`
--

DROP TABLE IF EXISTS `prchorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prchorders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `POID` int(11) DEFAULT NULL,
  `PODATE` date DEFAULT NULL,
  `POTIME` varchar(8) DEFAULT '',
  `POEMPLOYEE` varchar(10) DEFAULT '',
  `POEMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `POVENDORID` int(11) DEFAULT NULL,
  `POCLOSEDATE` date DEFAULT NULL,
  `POSTRTDATE` date DEFAULT NULL,
  `POENDDATE` date DEFAULT NULL,
  `CLOSEDBY` varchar(10) DEFAULT '',
  `PODNT` datetime DEFAULT NULL,
  `VOUCHNUM` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `PONBR` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11607 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prospect`
--

DROP TABLE IF EXISTS `prospect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prospect` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PROS_ID` int(11) NOT NULL DEFAULT '0',
  `PROSITEM` varchar(23) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purinapricelist`
--

DROP TABLE IF EXISTS `purinapricelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purinapricelist` (
  `id` bigint(20) unsigned NOT NULL,
  `LISTNBR` varchar(15) DEFAULT '',
  `PLANT` varchar(10) DEFAULT '',
  `EFFECTIVE` date DEFAULT NULL,
  `EXPIRATION` date DEFAULT NULL,
  `FREQUENCY` varchar(20) DEFAULT '',
  `CATEGORY` varchar(40) DEFAULT '',
  `MATNO` varchar(14) DEFAULT '',
  `FORMULA` varchar(14) DEFAULT '',
  `PRODUCT` varchar(40) DEFAULT '',
  `REF` varchar(10) DEFAULT '',
  `PRODFORM` varchar(20) DEFAULT '',
  `SIZE` varchar(20) DEFAULT '',
  `FOB_DLV` varchar(10) DEFAULT '',
  `CHANGE` decimal(16,3) DEFAULT NULL,
  `LISTPRICE` decimal(16,3) DEFAULT NULL,
  `DISCOUNT` decimal(16,3) DEFAULT NULL,
  `BULKDISC` decimal(16,3) DEFAULT NULL,
  `NETPRICE` decimal(16,3) DEFAULT NULL,
  `COSTCHNG` tinyint(1) DEFAULT NULL,
  `INVENCASE` bigint(20) DEFAULT NULL,
  `INVENCOST` decimal(16,3) DEFAULT NULL,
  `INVENMRKP` decimal(11,2) DEFAULT NULL,
  `INVENPRICE` decimal(16,3) DEFAULT NULL,
  `NEWPRICE` decimal(16,3) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qbilldata`
--

DROP TABLE IF EXISTS `qbilldata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qbilldata` (
  `unique_id` int(11) NOT NULL DEFAULT '0',
  `BILL_ID` int(11) DEFAULT NULL,
  `BILL_DATE` date DEFAULT NULL,
  `DUE_DATE` date DEFAULT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `PAST_BAL` decimal(11,2) DEFAULT NULL,
  `TTLDUE` decimal(11,2) DEFAULT NULL,
  `TRANSDATE` date DEFAULT NULL,
  `TRANSTIME` varchar(8) DEFAULT '',
  `ROANBR` int(11) DEFAULT NULL,
  `ROATOTAL` decimal(11,2) DEFAULT NULL,
  `INVOICE_NBR` int(11) DEFAULT NULL,
  `SLS_TOTAL` decimal(11,2) DEFAULT NULL,
  `SRVCHRG` tinyint(1) DEFAULT NULL,
  `TTLSLS` decimal(11,2) DEFAULT NULL,
  `TTLROA` decimal(11,2) DEFAULT NULL,
  `SPLTCRGBAL` tinyint(1) DEFAULT NULL,
  `OFPAGE` decimal(3,0) DEFAULT NULL,
  `ROADATE` date DEFAULT NULL,
  `ROATIME` varchar(8) DEFAULT '',
  `roasurcharge` decimal(7,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quickbooks_accounts`
--

DROP TABLE IF EXISTS `quickbooks_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quickbooks_accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `qb_account_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fully_qualified_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_sub_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `currency_ref` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `classification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sync_token` int(11) NOT NULL DEFAULT '0',
  `qb_created_at` timestamp NULL DEFAULT NULL,
  `qb_updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `store_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quickbooks_accounts_qb_account_id_index` (`qb_account_id`),
  KEY `quickbooks_accounts_account_type_index` (`account_type`),
  KEY `quickbooks_accounts_active_index` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quickbooks_deposits`
--

DROP TABLE IF EXISTS `quickbooks_deposits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quickbooks_deposits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` bigint(20) unsigned NOT NULL,
  `deposit_date` date NOT NULL,
  `qb_deposit_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'QuickBooks Cash Deposit ID',
  `cash_amount` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Cash Deposit Amount',
  `cc_amount` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT 'Credit Card Deposit Amount',
  `data` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Serialized income data',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_store_date` (`store_id`,`deposit_date`),
  KEY `quickbooks_deposits_store_id_index` (`store_id`),
  KEY `quickbooks_deposits_deposit_date_index` (`deposit_date`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quickbooks_tokens`
--

DROP TABLE IF EXISTS `quickbooks_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quickbooks_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `realm_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `refresh_token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_expires_at` timestamp NULL DEFAULT NULL,
  `refresh_token_expires_at` timestamp NULL DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `store_id` int(11) NOT NULL,
  `payable_account_id` bigint(20) unsigned DEFAULT NULL,
  `terms` json DEFAULT NULL,
  `qb_term_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_methods` json DEFAULT NULL,
  `bank_deposit_account_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_account_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cash_payment_method_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_card_payment_method_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `check_payment_method_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quickbooks_tokens_realm_id_unique` (`realm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quickbooks_vendors`
--

DROP TABLE IF EXISTS `quickbooks_vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quickbooks_vendors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `qb_vendor_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `given_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `family_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_on_check_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `primary_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_email_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_addr_line1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_addr_line2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_addr_city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_addr_state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_addr_postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_addr_country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_1099` tinyint(1) NOT NULL DEFAULT '0',
  `sync_token` int(11) NOT NULL DEFAULT '0',
  `qb_created_at` timestamp NULL DEFAULT NULL,
  `qb_updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `store_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quickbooks_vendors_qb_vendor_id_index` (`qb_vendor_id`),
  KEY `quickbooks_vendors_display_name_index` (`display_name`),
  KEY `quickbooks_vendors_active_index` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurring_activity`
--

DROP TABLE IF EXISTS `recurring_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurring_activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `recurring_nbr` int(11) DEFAULT NULL,
  `cust_id` int(11) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `entity_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_number` int(11) DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(8,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1213 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurring_invoice_payment`
--

DROP TABLE IF EXISTS `recurring_invoice_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurring_invoice_payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PAYMENTNBR` int(11) NOT NULL,
  `RECURRINGNBR` int(11) NOT NULL,
  `INVOICENBR` int(11) NOT NULL,
  `DATETIME` datetime NOT NULL,
  `DRAWER_ID` int(11) NOT NULL,
  `CUST_ID` int(11) NOT NULL,
  `EMP_ID` int(11) NOT NULL,
  `AMOUNT` double(8,2) NOT NULL,
  `TYPE` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CHECKNBR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CC_TYPE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `XCACCOUNT` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `XCAPPROVAL` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `XCEXPIRE` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `XCTRANSID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `XCCARDTYPE` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `XCACCNTID` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `XCCARDBAL` double(14,2) DEFAULT NULL,
  `XCNAME` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurring_invoice_po`
--

DROP TABLE IF EXISTS `recurring_invoice_po`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurring_invoice_po` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PONBR` int(11) NOT NULL,
  `RECURRING_NBR` int(11) DEFAULT NULL,
  `INVOICENBR` int(11) DEFAULT NULL,
  `DUEDATE` datetime DEFAULT NULL,
  `STATUS` int(11) NOT NULL DEFAULT '0',
  `IS_PAID` int(11) NOT NULL DEFAULT '0',
  `CUST_ID` int(11) DEFAULT NULL,
  `EMP_ID` int(11) DEFAULT NULL,
  `DRAWER` int(11) DEFAULT NULL,
  `TAXRATE` double(8,2) DEFAULT NULL,
  `SUBTOTAL` double(8,2) DEFAULT NULL,
  `TAXAMNT` double(8,2) DEFAULT NULL,
  `SLSTOTAL` double(8,2) DEFAULT NULL,
  `PRICELVL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SLSNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `WHR_NOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `COMPUTERID` int(11) DEFAULT NULL,
  `TRATEDESC` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=531 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurring_invoice_poitems`
--

DROP TABLE IF EXISTS `recurring_invoice_poitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurring_invoice_poitems` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PONBR` int(11) NOT NULL,
  `INVENTORYID` int(11) DEFAULT NULL,
  `QTY` double(8,2) DEFAULT NULL,
  `NONTAXABLE` tinyint(1) NOT NULL DEFAULT '0',
  `SOLDPRICE` double(8,2) DEFAULT NULL,
  `BOOKEDID` int(11) DEFAULT NULL,
  `UNIT` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DISCOUNT` double(8,2) DEFAULT NULL,
  `COST` double(8,2) DEFAULT NULL,
  `CWT` tinyint(1) NOT NULL DEFAULT '0',
  `ORIGPRICE` double(8,2) DEFAULT NULL,
  `PRICEFROM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RECSTATUS` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PRNTOWHR` tinyint(1) NOT NULL DEFAULT '0',
  `NONINVITEM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DSCAPPROVE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DSCNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OVRAPPROVE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OVRNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `XMPAPPROVE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `XMPNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EXTENAMNT` double(8,2) DEFAULT NULL,
  `LINENUM` int(11) DEFAULT NULL,
  `ORIGNONTAX` tinyint(1) NOT NULL DEFAULT '0',
  `SERIALNBR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VND1ORDNUM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RTLPRICE` double(8,2) DEFAULT NULL,
  `REWARDOK` tinyint(1) NOT NULL DEFAULT '0',
  `VFDSLSID` int(11) DEFAULT NULL,
  `VFDMAXQTY` int(11) DEFAULT NULL,
  `VFDAVLQTY` int(11) DEFAULT NULL,
  `VFDNUMBER` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VFDEXPIRE` datetime DEFAULT NULL,
  `VFDNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LOYALTYNTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `INACTAPPRV` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LWQTYAPPRV` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `KITLSTITMS` tinyint(1) NOT NULL DEFAULT '0',
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=526 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurring_invoice_setup`
--

DROP TABLE IF EXISTS `recurring_invoice_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurring_invoice_setup` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `RECURRING_NBR` int(11) NOT NULL,
  `TITLE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `INACTIVE` int(11) NOT NULL DEFAULT '0',
  `CUST_ID` int(11) DEFAULT NULL,
  `EMP_ID` int(11) DEFAULT NULL,
  `DRAWER` int(11) DEFAULT NULL,
  `TAXRATE` double(8,2) DEFAULT NULL,
  `SUBTOTAL` double(8,2) DEFAULT NULL,
  `TAXAMNT` double(8,2) DEFAULT NULL,
  `SLSTOTAL` double(8,2) DEFAULT NULL,
  `PRICELVL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SLSNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `WHR_NOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `COMPUTERID` int(11) DEFAULT NULL,
  `REPEAT_TYPE` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `REPEAT_WEEKDAY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `REPEAT_MONTH` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `REPEAT_DAY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SEND_TO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CUSTOM_MESSAGE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PAYMENT_LINK` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DUEDATE` datetime DEFAULT NULL,
  `END_OPTION` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ENDDATE` datetime DEFAULT NULL,
  `END_AFTERINV` int(11) DEFAULT NULL,
  `END_REASON` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `STARTDATE` datetime DEFAULT NULL,
  `can_use_cardonfile` tinyint(1) DEFAULT '0',
  `can_use_charge` tinyint(1) DEFAULT '0',
  `apprvrecurringby` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `due_option` tinyint(1) DEFAULT NULL,
  `due_custom_day` int(11) DEFAULT NULL,
  `last_run` date DEFAULT NULL,
  `TRATEDESC` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurring_invoiceitems_setup`
--

DROP TABLE IF EXISTS `recurring_invoiceitems_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurring_invoiceitems_setup` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `RECURRING_NBR` int(11) NOT NULL,
  `INVENTORYID` int(11) DEFAULT NULL,
  `QTY` double(8,2) DEFAULT NULL,
  `NONTAXABLE` tinyint(1) NOT NULL DEFAULT '0',
  `SOLDPRICE` double(8,2) DEFAULT NULL,
  `BOOKEDID` int(11) DEFAULT NULL,
  `UNIT` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DISCOUNT` double(8,2) DEFAULT NULL,
  `COST` double(8,2) DEFAULT NULL,
  `CWT` tinyint(1) NOT NULL DEFAULT '0',
  `ORIGPRICE` double(8,2) DEFAULT NULL,
  `PRICEFROM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RECSTATUS` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PRNTOWHR` tinyint(1) NOT NULL DEFAULT '0',
  `NONINVITEM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DSCAPPROVE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DSCNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OVRAPPROVE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OVRNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `XMPAPPROVE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `XMPNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EXTENAMNT` double(8,2) DEFAULT NULL,
  `LINENUM` int(11) DEFAULT NULL,
  `ORIGNONTAX` tinyint(1) NOT NULL DEFAULT '0',
  `SERIALNBR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VND1ORDNUM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RTLPRICE` double(8,2) DEFAULT NULL,
  `REWARDOK` tinyint(1) NOT NULL DEFAULT '0',
  `VFDSLSID` int(11) DEFAULT NULL,
  `VFDMAXQTY` int(11) DEFAULT NULL,
  `VFDAVLQTY` int(11) DEFAULT NULL,
  `VFDNUMBER` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VFDEXPIRE` datetime DEFAULT NULL,
  `VFDNOTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LOYALTYNTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `INACTAPPRV` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LWQTYAPPRV` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `KITLSTITMS` tinyint(1) NOT NULL DEFAULT '0',
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_view_handler`
--

DROP TABLE IF EXISTS `report_view_handler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_view_handler` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rewardcust`
--

DROP TABLE IF EXISTS `rewardcust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewardcust` (
  `id` bigint(20) unsigned NOT NULL,
  `CUSTRWID` int(11) DEFAULT NULL,
  `REWARDID` int(11) DEFAULT NULL,
  `CUST_ID` int(11) DEFAULT NULL,
  `SPENTBAL` decimal(15,2) DEFAULT NULL,
  `EARNEDDATE` date DEFAULT NULL,
  `EARNEDINV` int(11) DEFAULT NULL,
  `STARTDAY` date DEFAULT NULL,
  `EXPIREDAY` date DEFAULT NULL,
  `REWARDBAL` int(11) DEFAULT NULL,
  `REDEEMDATE` date DEFAULT NULL,
  `REDEEMINV` int(11) DEFAULT NULL,
  `BUYBAL` int(11) DEFAULT NULL,
  `LSTBUYERND` date DEFAULT NULL,
  `LSTBUYINV` int(11) DEFAULT NULL,
  `LSTRWDINV` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rewards`
--

DROP TABLE IF EXISTS `rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards` (
  `id` bigint(20) unsigned NOT NULL,
  `REWARDID` int(11) DEFAULT NULL,
  `REWARDDESC` varchar(40) DEFAULT '',
  `REWARDTYPE` varchar(10) DEFAULT '',
  `DATENTIME` datetime DEFAULT NULL,
  `EMPLOYEE` varchar(200) DEFAULT '',
  `EMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `ALLCUST` tinyint(1) DEFAULT NULL,
  `SPENDGOAL` int(11) DEFAULT NULL,
  `REWARDAMNT` int(11) DEFAULT NULL,
  `STARTDAYS` tinyint(4) DEFAULT NULL,
  `EXPIREDAYS` smallint(6) DEFAULT NULL,
  `INVENQTY` tinyint(1) DEFAULT NULL,
  `INVENID1` int(11) DEFAULT NULL,
  `INVENID2` int(11) DEFAULT NULL,
  `INVENID3` int(11) DEFAULT NULL,
  `INVENID4` int(11) DEFAULT NULL,
  `INVENID5` int(11) DEFAULT NULL,
  `INVENID6` int(11) DEFAULT NULL,
  `INVENID7` int(11) DEFAULT NULL,
  `INVENID8` int(11) DEFAULT NULL,
  `INVENID9` int(11) DEFAULT NULL,
  `INVENID10` int(11) DEFAULT NULL,
  `INVENID11` int(11) DEFAULT NULL,
  `INVENID12` int(11) DEFAULT NULL,
  `INVENQTY1` int(11) DEFAULT NULL,
  `INVENQTY2` int(11) DEFAULT NULL,
  `INVENQTY3` int(11) DEFAULT NULL,
  `INVENQTY4` int(11) DEFAULT NULL,
  `INVENQTY5` int(11) DEFAULT NULL,
  `INVENQTY6` int(11) DEFAULT NULL,
  `INVENQTY7` int(11) DEFAULT NULL,
  `INVENQTY8` int(11) DEFAULT NULL,
  `INVENQTY9` int(11) DEFAULT NULL,
  `INVENQTY10` int(11) DEFAULT NULL,
  `INVENQTY11` int(11) DEFAULT NULL,
  `INVENQTY12` int(11) DEFAULT NULL,
  `ALLOWTAX` tinyint(1) DEFAULT NULL,
  `ALLOWCHRG` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `id` int(10) NOT NULL,
  `role_id` int(10) NOT NULL,
  `permission_id` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Display name of the role',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Machine-readable role identifier',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Brief description of the role',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rptsetup`
--

DROP TABLE IF EXISTS `rptsetup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rptsetup` (
  `id` bigint(20) unsigned NOT NULL,
  `RPT_ID` smallint(6) DEFAULT NULL,
  `RPT_NAME` varchar(30) DEFAULT '',
  `RUN_RPT` tinyint(1) DEFAULT NULL,
  `RPT2PROC` varchar(20) DEFAULT '',
  `PRAM2` tinyint(1) DEFAULT NULL,
  `PRAM3` tinyint(1) DEFAULT NULL,
  `PRAM4` tinyint(1) DEFAULT NULL,
  `PRAM5` tinyint(1) DEFAULT NULL,
  `PRAM6` tinyint(1) DEFAULT NULL,
  `store_id` int(10) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rptsetup_master`
--

DROP TABLE IF EXISTS `rptsetup_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rptsetup_master` (
  `RPT_ID` smallint(6) NOT NULL,
  `RPT_NAME` varchar(30) CHARACTER SET utf8 DEFAULT '',
  `RUN_RPT` tinyint(1) DEFAULT NULL,
  `RPT2PROC` varchar(20) CHARACTER SET utf8 DEFAULT '',
  `PRAM2` bit(1) DEFAULT NULL,
  `PRAM3` bit(1) DEFAULT NULL,
  `PRAM4` bit(1) DEFAULT NULL,
  `PRAM5` bit(1) DEFAULT NULL,
  `PRAM6` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rpttime`
--

DROP TABLE IF EXISTS `rpttime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rpttime` (
  `id` bigint(20) unsigned NOT NULL,
  `STARTRPT` datetime DEFAULT NULL,
  `ENDRPT` datetime DEFAULT NULL,
  `STARTSEC` decimal(27,5) DEFAULT NULL,
  `ENDSEC` decimal(27,5) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security`
--

DROP TABLE IF EXISTS `security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `SECURITYID` int(10) unsigned NOT NULL DEFAULT '0',
  `ALWOVRLMT` tinyint(1) NOT NULL DEFAULT '0',
  `ALWLWQTYSL` tinyint(4) DEFAULT '0',
  `ALWINACTSL` tinyint(4) DEFAULT '0',
  `LOGINNAME` varchar(255) DEFAULT '',
  `PASSWORD` varchar(20) DEFAULT '',
  `QUICKLOGIN` varchar(5) DEFAULT '',
  `MYDRAWER` varchar(2) DEFAULT '',
  `ACCESMENU` tinyint(1) DEFAULT '0',
  `MAINMENU` tinyint(1) DEFAULT '0',
  `REPORTMENU` tinyint(1) DEFAULT '0',
  `BILLMENU` tinyint(1) DEFAULT '0',
  `CONFMENU` tinyint(1) DEFAULT '0',
  `DOSALES` tinyint(1) DEFAULT '0',
  `ADJINVQTY` tinyint(1) DEFAULT '0',
  `MODINVEN` tinyint(1) DEFAULT '0',
  `MODVARIANTS` tinyint(4) NOT NULL DEFAULT '0',
  `modvarianttypeoption` tinyint(4) NOT NULL DEFAULT '0',
  `MODCUST` tinyint(1) DEFAULT '0',
  `MODBCD` tinyint(1) DEFAULT '0',
  `RECEIVING` tinyint(1) DEFAULT '0',
  `MODVENDORS` tinyint(1) DEFAULT '0',
  `DOBACKUPS` tinyint(1) DEFAULT '0',
  `RPTSDAILY` tinyint(1) DEFAULT '0',
  `RPTCSTPRCH` tinyint(1) DEFAULT '0',
  `NEED2SET` tinyint(1) DEFAULT '0',
  `MODACTUPDT` tinyint(1) DEFAULT '0',
  `DOPAYMENTS` tinyint(1) DEFAULT '0',
  `MODSECURE` tinyint(1) DEFAULT '0',
  `MODSYSSTNG` tinyint(1) DEFAULT '0',
  `MODSTRTBAL` tinyint(1) DEFAULT '0',
  `MODPO` tinyint(1) DEFAULT '0',
  `MODPYBLS` tinyint(1) DEFAULT '0',
  `SLSVOID` tinyint(1) DEFAULT '0',
  `SLSCHNGPRC` tinyint(1) DEFAULT '0',
  `SLSGVDISC` tinyint(1) DEFAULT '0',
  `SLSMODXMPT` tinyint(1) DEFAULT '0',
  `DOTBLMNT` tinyint(1) DEFAULT '0',
  `CSTLBLS` tinyint(1) DEFAULT '0',
  `INVLBLS` tinyint(1) DEFAULT '0',
  `INVSLSUPDT` tinyint(1) DEFAULT '0',
  `RCPSETUP` tinyint(1) DEFAULT '0',
  `ACCTC` tinyint(1) DEFAULT '0',
  `SLSEDIT` tinyint(1) DEFAULT '0',
  `CSTSECURE` tinyint(1) DEFAULT '0',
  `CSTEXEMPT` tinyint(1) DEFAULT '0',
  `CSTFRMPLN` tinyint(1) DEFAULT '0',
  `INVMODCNP` tinyint(1) DEFAULT '0',
  `CSTACCTBAL` tinyint(1) DEFAULT '0',
  `CONTRACT` tinyint(1) DEFAULT '0',
  `CATMNGR` tinyint(1) DEFAULT '0',
  `DPTMNGR` tinyint(1) DEFAULT '0',
  `LUPMNGR` tinyint(1) DEFAULT '0',
  `PROSMNGR` tinyint(1) DEFAULT '0',
  `INVQTYADJ` tinyint(1) DEFAULT '0',
  `RPTAGING` tinyint(1) DEFAULT '0',
  `RPTCAT` tinyint(1) DEFAULT '0',
  `RPTVNDLST` tinyint(1) DEFAULT '0',
  `RPTCNTRCT` tinyint(1) DEFAULT '0',
  `RPTCSTLST` tinyint(1) DEFAULT '0',
  `RPTINV` tinyint(1) DEFAULT '0',
  `RPTINVSLS` tinyint(1) DEFAULT '0',
  `RPTREORD` tinyint(1) DEFAULT '0',
  `RPTROA` tinyint(1) DEFAULT '0',
  `RPTREINV` tinyint(1) DEFAULT '0',
  `RPTREROA` tinyint(1) DEFAULT '0',
  `RPTRERCV` tinyint(1) DEFAULT '0',
  `PREBILL` tinyint(1) DEFAULT '0',
  `PROCBILL` tinyint(1) DEFAULT '0',
  `LATEPAY` tinyint(1) DEFAULT '0',
  `BILLMSG` tinyint(1) DEFAULT '0',
  `BILLRPTS` tinyint(1) DEFAULT '0',
  `BILLSNGL` tinyint(1) DEFAULT '0',
  `BILLALL` tinyint(1) DEFAULT '0',
  `BILLBYNBR` tinyint(1) DEFAULT '0',
  `BILLISNGL` tinyint(1) DEFAULT '0',
  `BILLIALL` tinyint(1) DEFAULT '0',
  `CNFEDIT` tinyint(1) DEFAULT '0',
  `CNFVOID` tinyint(1) DEFAULT '0',
  `CNFLOG` tinyint(1) DEFAULT '0',
  `CNFSALES` tinyint(1) DEFAULT '0',
  `CNFCST` tinyint(1) DEFAULT '0',
  `CNFEMP` tinyint(1) DEFAULT '0',
  `CNFTCMNGR` tinyint(1) DEFAULT '0',
  `CNFTCRPTS` tinyint(1) DEFAULT '0',
  `CNFMNTHCAP` tinyint(1) DEFAULT '0',
  `CNFMCRPT` tinyint(1) DEFAULT '0',
  `FIXPRVCOST` tinyint(1) DEFAULT '0',
  `HLPTOOLS` tinyint(1) DEFAULT '0',
  `CNFXMPOVR` tinyint(1) DEFAULT '0',
  `CNFDSCOVR` tinyint(1) DEFAULT '0',
  `CNFOVR` tinyint(1) DEFAULT '0',
  `XMPTNOTREQ` tinyint(1) DEFAULT '0',
  `DSCNOTREQ` tinyint(1) DEFAULT '0',
  `OVRNOTREQ` tinyint(1) DEFAULT '0',
  `NOQLOGREQ` tinyint(1) DEFAULT '0',
  `DSPLYCOST` tinyint(1) DEFAULT '0',
  `SLSTMPCHRG` tinyint(1) DEFAULT '0',
  `TCHGNOTREQ` tinyint(1) DEFAULT '0',
  `AG2AG` tinyint(1) DEFAULT '0',
  `ROAVOID` tinyint(1) DEFAULT '0',
  `GFTCARDMNG` tinyint(1) DEFAULT '0',
  `ADDPYBLS` tinyint(1) DEFAULT '0',
  `CATDISCMNG` tinyint(1) DEFAULT '0',
  `alwrecurring` tinyint(1) DEFAULT '0',
  `alwitemonrecurring` tinyint(1) DEFAULT NULL,
  `alwrecurringsales` tinyint(1) DEFAULT '0',
  `alwrecurracptpayments` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `ALWNEGQ_P` tinyint(1) DEFAULT '0',
  `usehandheld` varchar(45) DEFAULT '0',
  `invmodintg` tinyint(1) DEFAULT NULL,
  `intgmenu` tinyint(4) NOT NULL DEFAULT '0',
  `intgshopify` tinyint(4) NOT NULL DEFAULT '0',
  `intglocally` tinyint(4) NOT NULL DEFAULT '0',
  `intgquickbooks` tinyint(4) NOT NULL DEFAULT '0',
  `intgnewmediaretailer` tinyint(4) NOT NULL DEFAULT '0',
  `intgpriceboard` tinyint(4) NOT NULL DEFAULT '0',
  `alwpricechngeprcnt` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=739 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `table_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sequence` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serialnbrs`
--

DROP TABLE IF EXISTS `serialnbrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serialnbrs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `INVENID` int(11) DEFAULT NULL,
  `SERIALNBR` varchar(20) DEFAULT '',
  `INVOICENBR` int(11) DEFAULT NULL,
  `INVDATE` date DEFAULT NULL,
  `VOUCHNUM` int(11) DEFAULT NULL,
  `RCVDATE` date DEFAULT NULL,
  `MODIDATE` datetime DEFAULT NULL,
  `MODIEMP` varchar(10) DEFAULT '',
  `ACTION` varchar(20) DEFAULT '',
  `voucher` varchar(100) DEFAULT '0',
  `MODINOTE` varchar(40) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `serialnbrscol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serialnbrscol_UNIQUE` (`serialnbrscol`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  `store_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shopify_collections`
--

DROP TABLE IF EXISTS `shopify_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopify_collections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `collection_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1=active, 0=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shopify_collections_collection_id_store_id_unique` (`collection_id`,`store_id`),
  KEY `shopify_collections_store_id_status_index` (`store_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shopify_mapping`
--

DROP TABLE IF EXISTS `shopify_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopify_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `variant_product_id` bigint(20) unsigned DEFAULT NULL,
  `shopify_id` bigint(20) unsigned DEFAULT NULL,
  `shopify_variant_id` bigint(20) unsigned DEFAULT NULL,
  `INVENID` bigint(20) unsigned DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shopify_shipping_profiles`
--

DROP TABLE IF EXISTS `shopify_shipping_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopify_shipping_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1=active, 0=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shopify_shipping_profiles_profile_id_unique` (`profile_id`),
  KEY `shopify_shipping_profiles_store_id_status_index` (`store_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig`
--

DROP TABLE IF EXISTS `sig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  KEY `sig_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2017q1`
--

DROP TABLE IF EXISTS `sig2017q1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2017q1` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2017q2`
--

DROP TABLE IF EXISTS `sig2017q2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2017q2` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2017q3`
--

DROP TABLE IF EXISTS `sig2017q3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2017q3` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2017q4`
--

DROP TABLE IF EXISTS `sig2017q4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2017q4` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2018q1`
--

DROP TABLE IF EXISTS `sig2018q1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2018q1` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2018q2`
--

DROP TABLE IF EXISTS `sig2018q2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2018q2` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2018q3`
--

DROP TABLE IF EXISTS `sig2018q3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2018q3` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2018q4`
--

DROP TABLE IF EXISTS `sig2018q4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2018q4` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2019q1`
--

DROP TABLE IF EXISTS `sig2019q1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2019q1` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2019q2`
--

DROP TABLE IF EXISTS `sig2019q2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2019q2` (
  `INVOICENBR` int(11) DEFAULT NULL,
  `XCSIGIMAGE` longtext,
  `CHRGSIG` longtext,
  `XMPTSIG` longtext,
  `JDFSIG` longtext,
  `CC2SIGIMG` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2022q1`
--

DROP TABLE IF EXISTS `sig2022q1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2022q1` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2022q1_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2022q2`
--

DROP TABLE IF EXISTS `sig2022q2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2022q2` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2022q2_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2022q3`
--

DROP TABLE IF EXISTS `sig2022q3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2022q3` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2022q3_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2022q4`
--

DROP TABLE IF EXISTS `sig2022q4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2022q4` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2022q4_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2023q1`
--

DROP TABLE IF EXISTS `sig2023q1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2023q1` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2023q1_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2023q2`
--

DROP TABLE IF EXISTS `sig2023q2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2023q2` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2023q2_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2023q3`
--

DROP TABLE IF EXISTS `sig2023q3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2023q3` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2023q3_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2024q1`
--

DROP TABLE IF EXISTS `sig2024q1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2024q1` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2024q1_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2024q2`
--

DROP TABLE IF EXISTS `sig2024q2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2024q2` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2024q2_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2024q3`
--

DROP TABLE IF EXISTS `sig2024q3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2024q3` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2024q3_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2024q4`
--

DROP TABLE IF EXISTS `sig2024q4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2024q4` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2024q4_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2025q1`
--

DROP TABLE IF EXISTS `sig2025q1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2025q1` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2025q1_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sig2025q2`
--

DROP TABLE IF EXISTS `sig2025q2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sig2025q2` (
  `INVOICENBR` int(11) NOT NULL,
  `XCSIGIMAGE` longtext COLLATE utf8mb4_unicode_ci,
  `CHRGSIG` longtext COLLATE utf8mb4_unicode_ci,
  `XMPTSIG` longtext COLLATE utf8mb4_unicode_ci,
  `JDFSIG` longtext COLLATE utf8mb4_unicode_ci,
  `CC2SIGIMG` longtext COLLATE utf8mb4_unicode_ci,
  `store_id` int(11) NOT NULL,
  KEY `sig2025q2_invoicenbr_index` (`INVOICENBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slideshow`
--

DROP TABLE IF EXISTS `slideshow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slideshow` (
  `id` bigint(20) unsigned NOT NULL,
  `SLIDERANK` int(11) DEFAULT NULL,
  `SLIDENAME` varchar(10) DEFAULT '',
  `SLIDEPIC` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `startingbal`
--

DROP TABLE IF EXISTS `startingbal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `startingbal` (
  `id` bigint(20) unsigned NOT NULL,
  `STRTBALID` int(11) DEFAULT NULL,
  `SBDATE` date DEFAULT NULL,
  `SBTIME` varchar(8) DEFAULT '',
  `sbdatetime` datetime DEFAULT NULL,
  `SBEMPLOYEE` varchar(200) DEFAULT '',
  `SBEMPLOYEE_ID` int(11) NOT NULL DEFAULT '0',
  `SBAMOUNT` decimal(13,2) DEFAULT NULL,
  `SBDRAWER` varchar(2) DEFAULT '',
  `SBNOTE` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `title` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `mac_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `isused` tinyint(1) DEFAULT '0',
  `used_by` int(11) NOT NULL DEFAULT '0',
  `usedatetime` datetime DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `Drawer` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `PromptfSale` tinyint(1) DEFAULT NULL,
  `UseLastDesc` tinyint(1) DEFAULT NULL,
  `UseLastCC` tinyint(1) DEFAULT NULL,
  `UseLrgPrn` tinyint(1) DEFAULT NULL,
  `DfltPrnName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `DfltPrnCopy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `UseRcptPrn` tinyint(1) DEFAULT NULL,
  `RcptPrnName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `RcptPrnCopy` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `Prompt4SecCopy` tinyint(1) DEFAULT NULL,
  `WhrPrnName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `UseWhrPrn` tinyint(1) DEFAULT NULL,
  `UseCashDrawer` tinyint(1) DEFAULT NULL,
  `CashDrawerPort` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `OpenCash` tinyint(1) DEFAULT NULL,
  `OpenCheck` tinyint(1) DEFAULT NULL,
  `OpenChrg` tinyint(1) DEFAULT NULL,
  `OpenCC` tinyint(1) DEFAULT NULL,
  `OpenCO` tinyint(1) DEFAULT NULL,
  `OpenMI` tinyint(1) DEFAULT NULL,
  `OpenF2` tinyint(1) DEFAULT NULL,
  `Use5x8Layout` tinyint(1) DEFAULT NULL,
  `xcInstalled` tinyint(1) DEFAULT NULL,
  `xcIp` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xcPort` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xcScheme` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UseSigCap` tinyint(1) DEFAULT NULL,
  `SigPadType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `useGiftCards` tinyint(1) DEFAULT '0',
  `LinkedGiftItem` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LinkedGiftItemId` int(10) DEFAULT '0',
  `TerminalId` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `Marquee` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DualDisplay` tinyint(1) DEFAULT NULL,
  `customerview_images` longtext COLLATE utf8mb4_unicode_ci,
  `lastBatchClose` datetime DEFAULT NULL,
  `lastShowBatchMsg` datetime DEFAULT NULL,
  `dcap_device_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xcWthoutMchn` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `alwfleet` tinyint(1) DEFAULT NULL,
  `alwartg` tinyint(1) DEFAULT NULL,
  `alwrecurring` tinyint(1) DEFAULT NULL,
  `inv_gap_sec` int(11) DEFAULT '60',
  `allowdcap` tinyint(1) DEFAULT '0',
  `dcaptokenkey` varchar(255) DEFAULT NULL,
  `dcapmerchantid` varchar(255) DEFAULT NULL,
  `cc_processor` varchar(45) DEFAULT NULL,
  `dcap_id_dcdirect` varchar(100) DEFAULT NULL,
  `dcap_id_dcdirect_gift` varchar(100) DEFAULT NULL,
  `login_nbr` int(11) DEFAULT NULL,
  `partial_search` tinyint(1) NOT NULL DEFAULT '0',
  `srch_result` int(11) DEFAULT '150',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `CostCode` varchar(255) DEFAULT NULL,
  `LayoutTopLeft` varchar(255) DEFAULT NULL,
  `LayoutTopRight` varchar(255) DEFAULT NULL,
  `LastPrn` varchar(255) DEFAULT NULL,
  `LastlblType` varchar(255) DEFAULT NULL,
  `migrated_at` timestamp NULL DEFAULT NULL,
  `dcsurchrg` tinyint(1) NOT NULL DEFAULT '0',
  `dcsurchrgprcnt` decimal(15,2) DEFAULT '0.00',
  `multiple_login_restrict` tinyint(1) DEFAULT '0',
  `alwshopify` tinyint(1) DEFAULT '0',
  `use_custom_categories_for_shopify` tinyint(4) NOT NULL DEFAULT '0',
  `shopify_line_categories` text,
  `shopify_shop` varchar(255) DEFAULT NULL,
  `shopify_access_token` text,
  `shopify_scope` varchar(255) DEFAULT NULL,
  `shopify_installed` tinyint(4) NOT NULL DEFAULT '0',
  `shopify_api_key` varchar(255) DEFAULT NULL,
  `shopify_api_secret` varchar(255) DEFAULT NULL,
  `alwquickbooks` tinyint(4) DEFAULT '0',
  `offline_mode` tinyint(1) NOT NULL DEFAULT '0',
  `offline_token` varchar(32) DEFAULT NULL,
  `media_retailer` tinyint(1) DEFAULT '0',
  `shopify_apikey` varchar(255) DEFAULT NULL,
  `allowimportinv` tinyint(1) DEFAULT '0',
  `allowlinetax` tinyint(1) NOT NULL DEFAULT '0',
  `tax_update_status` tinyint(1) NOT NULL DEFAULT '0',
  `db_connection_info` text COMMENT 'Encrypted JSON: {host, port, database, username, password}',
  `alwlocally` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemsettings`
--

DROP TABLE IF EXISTS `systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemsettings` (
  `id` bigint(20) NOT NULL,
  `BILLMESS1` varchar(70) DEFAULT '',
  `BILLMESS2` varchar(70) DEFAULT '',
  `BILLMESS3` varchar(70) DEFAULT '',
  `RATE1` decimal(11,3) DEFAULT NULL,
  `RATE2` decimal(11,3) DEFAULT NULL,
  `RATE3` decimal(11,3) DEFAULT NULL,
  `RATE5` decimal(11,3) DEFAULT NULL,
  `RATE6` decimal(11,3) DEFAULT NULL,
  `BILLTERM1` varchar(70) DEFAULT '',
  `BILLTERM2` varchar(70) DEFAULT '',
  `SRVFEE` tinyint(1) DEFAULT NULL,
  `SRVFEERATE` tinyint(4) DEFAULT NULL,
  `SRVFEEMIN` decimal(9,2) DEFAULT NULL,
  `BILL_PRE` tinyint(1) DEFAULT NULL,
  `NWBILLRP` tinyint(1) DEFAULT NULL,
  `DO_CAP` tinyint(1) DEFAULT NULL,
  `VERSION` varchar(29) DEFAULT '',
  `B358X612` tinyint(1) DEFAULT NULL,
  `DVENDNO` varchar(10) DEFAULT '',
  `DVCN` tinyint(1) DEFAULT NULL,
  `VCHPASS` tinyint(1) DEFAULT NULL,
  `USEBCDCALC` tinyint(1) DEFAULT NULL,
  `BCDNDAMNT` tinyint(1) DEFAULT NULL,
  `BCDSETAMNT` tinyint(1) DEFAULT NULL,
  `BCDSTRAMNT` decimal(14,2) DEFAULT NULL,
  `LAST_VLX` date DEFAULT NULL,
  `LAST_ETC` date DEFAULT NULL,
  `WHR_NOTE` tinyint(1) DEFAULT NULL,
  `USE_XCHRG` tinyint(1) DEFAULT NULL,
  `XC_PATH` varchar(35) DEFAULT '',
  `RHEADING` longtext,
  `RMSG` longtext,
  `RTERMS` longtext,
  `USEDFLTQTY` tinyint(1) DEFAULT NULL,
  `INVADTNLP` tinyint(1) DEFAULT NULL,
  `PREPRNHDNG` tinyint(1) DEFAULT NULL,
  `LOGOPATH` varchar(75) DEFAULT '',
  `RCPTLOGOPA` varchar(75) DEFAULT '',
  `RTAXTERMS` longtext,
  `RCCTERMS` longtext,
  `RTRMSIG` tinyint(1) DEFAULT NULL,
  `RTAXTRMSIG` tinyint(1) DEFAULT NULL,
  `LOCNAME` varchar(40) DEFAULT '',
  `LOCADR` varchar(40) DEFAULT '',
  `LOCCITY` varchar(25) DEFAULT '',
  `LOCSTATE` varchar(2) DEFAULT '',
  `LOCZIP` varchar(10) DEFAULT '',
  `LOCPHONE` varchar(13) DEFAULT '',
  `LOCFAX` varchar(13) DEFAULT '',
  `LOCALTPHN` varchar(13) DEFAULT '',
  `LOCWEBSITE` varchar(40) DEFAULT '',
  `LOCEMAIL` varchar(40) DEFAULT '',
  `LOCMADR` varchar(40) DEFAULT '',
  `LOCMCITY` varchar(25) DEFAULT '',
  `LOCMSTATE` varchar(2) DEFAULT '',
  `LOCMZIP` varchar(10) DEFAULT '',
  `BILLMSG` longtext,
  `BILLNEG` tinyint(1) DEFAULT NULL,
  `RCPTLOGO` longtext,
  `COLOGO` longtext,
  `PRINTLOGO` tinyint(1) DEFAULT NULL,
  `RLRGMSG` longtext,
  `USEWHRLOG` tinyint(1) DEFAULT NULL,
  `OHLOWPOP` tinyint(1) DEFAULT NULL,
  `LOCID` int(11) DEFAULT NULL,
  `SHWTAXRATE` tinyint(1) DEFAULT NULL,
  `COSTCODE` varchar(10) DEFAULT '',
  `RCVWORDER` tinyint(1) DEFAULT NULL,
  `RESETONLY` tinyint(1) DEFAULT NULL,
  `USECITYDRO` tinyint(1) DEFAULT NULL,
  `USEWHRLOAD` tinyint(1) DEFAULT NULL,
  `SMTPSERVER` varchar(30) DEFAULT '',
  `SMTPPORT` int(11) DEFAULT NULL,
  `SMTPSSL` tinyint(1) DEFAULT NULL,
  `EMAILUSER` varchar(60) DEFAULT '',
  `EMAILPW` varchar(40) DEFAULT '',
  `EMAILFROM` varchar(60) DEFAULT '',
  `EMAILPW2` varchar(40) DEFAULT '',
  `RCPTVNDNUM` tinyint(1) DEFAULT NULL,
  `RCPTLOGO2` longtext,
  `RCPTLOGOP2` varchar(75) DEFAULT '',
  `INVOICENEW` tinyint(1) DEFAULT NULL,
  `DISPHONINV` tinyint(1) DEFAULT NULL,
  `DFLTQTYLUP` tinyint(1) DEFAULT NULL,
  `DFLTDUEDAY` tinyint(4) DEFAULT NULL,
  `DFLTAVGCST` tinyint(1) DEFAULT NULL,
  `RATE4` decimal(11,3) DEFAULT NULL,
  `RATE7` decimal(11,3) DEFAULT NULL,
  `RATE8` decimal(11,3) DEFAULT NULL,
  `R2DESC` varchar(10) DEFAULT '',
  `R3DESC` varchar(10) DEFAULT '',
  `R4DESC` varchar(10) DEFAULT '',
  `R5DESC` varchar(10) DEFAULT '',
  `R6DESC` varchar(10) DEFAULT '',
  `R7DESC` varchar(10) DEFAULT '',
  `R8DESC` varchar(10) DEFAULT '',
  `CUSTHLGHT` tinyint(1) DEFAULT NULL,
  `LSTHDDBKP` datetime DEFAULT NULL,
  `LSTDRVBKP` datetime DEFAULT NULL,
  `LSTDRVPATH` varchar(250) DEFAULT '',
  `LSTDBMAINT` datetime DEFAULT NULL,
  `ORGLNBR` varchar(50) DEFAULT '',
  `ORGLPWD` varchar(50) DEFAULT '',
  `ORGLCOINFO` longtext,
  `ORGLVNDID` int(11) DEFAULT NULL,
  `ALWDUPSN` tinyint(1) DEFAULT NULL,
  `BKUP2ZIPS` tinyint(1) DEFAULT NULL,
  `NOCHRGAGNG` tinyint(1) DEFAULT NULL,
  `AGINGLIMIT` varchar(10) DEFAULT '',
  `DFCHECK` varchar(25) DEFAULT '',
  `DFENVELOPE` varchar(25) DEFAULT '',
  `SRVHLIC` varchar(20) DEFAULT '',
  `WS1HLIC` varchar(20) DEFAULT '',
  `WS2HLIC` varchar(20) DEFAULT '',
  `WS3HLIC` varchar(20) DEFAULT '',
  `WS4HLIC` varchar(20) DEFAULT '',
  `WS5HLIC` varchar(20) DEFAULT '',
  `WS6HLIC` varchar(20) DEFAULT '',
  `WS7HLIC` varchar(20) DEFAULT '',
  `WS8HLIC` varchar(20) DEFAULT '',
  `WS9HLIC` varchar(20) DEFAULT '',
  `KNKVNDID` int(11) DEFAULT NULL,
  `REORDWLESS` tinyint(1) DEFAULT NULL,
  `ORGLCNTR` varchar(30) DEFAULT '',
  `ORGLPLVL` varchar(10) DEFAULT '',
  `ORGLUPC12` tinyint(1) DEFAULT NULL,
  `USEDFLTQTY1` tinyint(1) NOT NULL DEFAULT '0',
  `APPRVLWQTY` tinyint(1) NOT NULL DEFAULT '0',
  `APPRVINACT` tinyint(1) NOT NULL DEFAULT '0',
  `APRVOVRLMT` tinyint(1) NOT NULL DEFAULT '0',
  `USECITYDROP` tinyint(1) NOT NULL DEFAULT '0',
  `APPRVNEGQTPR` tinyint(1) NOT NULL DEFAULT '0',
  `CWTSHOWSTY` tinyint(1) DEFAULT NULL,
  `SHOWUSESCALE` tinyint(1) DEFAULT NULL,
  `store_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `BTRYNBR` varchar(45) DEFAULT NULL,
  `BTRYPWD` varchar(45) DEFAULT NULL,
  `BTRYVNDID` int(11) DEFAULT NULL,
  `BTRYUPC12` tinyint(1) NOT NULL DEFAULT '0',
  `ALWNEGQ_P` tinyint(1) NOT NULL DEFAULT '0',
  `PURINADASH` tinyint(1) NOT NULL DEFAULT '0',
  `LASTPURGE` datetime DEFAULT NULL,
  `PURGEDATE` date DEFAULT NULL,
  `INVENRMV` datetime DEFAULT NULL,
  `INTCC` tinyint(4) DEFAULT NULL,
  `CCPROVIDER` varchar(30) DEFAULT NULL,
  `USEGIFT` tinyint(4) DEFAULT NULL,
  `INTGIFT` tinyint(4) DEFAULT NULL,
  `LNKGIFTID` int(11) DEFAULT NULL,
  `CCPORCSERV` varchar(13) DEFAULT NULL,
  `timezone` varchar(255) NOT NULL,
  `hideretail` tinyint(1) NOT NULL DEFAULT '0',
  `show_disclaimer_note` tinyint(1) NOT NULL DEFAULT '0',
  `use_media_rtl` tinyint(1) NOT NULL DEFAULT '0',
  `ftp_server` varchar(255) DEFAULT '',
  `ftp_port` varchar(45) DEFAULT NULL,
  `ftp_user` varchar(255) DEFAULT '',
  `ftp_pass` varchar(255) DEFAULT '',
  `notification_email` varchar(100) DEFAULT NULL,
  `fullexport` tinyint(1) NOT NULL DEFAULT '0',
  `deltaexport` tinyint(1) NOT NULL DEFAULT '0',
  `last_delta_run` timestamp NULL DEFAULT NULL,
  `thrmlhgtovrride` int(45) DEFAULT NULL,
  `newthrmlrcpt` varchar(45) NOT NULL DEFAULT '0',
  `showratename` tinyint(1) DEFAULT '0',
  `use_storelvl_mail` tinyint(1) DEFAULT '0',
  `mail_encryption` varchar(45) DEFAULT NULL,
  `mail_driver` varchar(45) DEFAULT NULL,
  `from_email` varchar(60) DEFAULT NULL,
  `cc_email` varchar(60) DEFAULT NULL,
  `cash_rounding` tinyint(1) DEFAULT NULL,
  `locally_ftp_details` varchar(255) DEFAULT NULL,
  `locally_notification_email` varchar(100) DEFAULT NULL,
  `locally_last_delta_run` timestamp NULL DEFAULT NULL,
  `ORGLAUTORC` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_cl_his`
--

DROP TABLE IF EXISTS `t_cl_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_cl_his` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `T_CLOCK_HIS_ID` int(11) NOT NULL DEFAULT '0',
  `TE_NOTE` longtext,
  `TCNAME` varchar(200) DEFAULT '',
  `TCNAME_ID` int(10) NOT NULL,
  `TCDATE` date DEFAULT NULL,
  `TCDATETIME` datetime DEFAULT NULL,
  `TCMEMO` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3094 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_clock`
--

DROP TABLE IF EXISTS `t_clock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_clock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `T_CLOCK_ID` int(11) DEFAULT NULL,
  `T_IN_OUT` varchar(3) DEFAULT '',
  `T_NAME_ID` int(10) NOT NULL,
  `T_NAME` varchar(255) DEFAULT '',
  `T_DATE` date DEFAULT NULL,
  `T_TIME` varchar(8) DEFAULT '',
  `T_DATE_TIME` datetime DEFAULT NULL,
  `T_DURATION` int(25) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tableindex`
--

DROP TABLE IF EXISTS `tableindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tableindex` (
  `TABLEID` int(11) DEFAULT NULL,
  `SEQUENCE` tinyint(4) DEFAULT NULL,
  `TAGNAME` varchar(10) DEFAULT '',
  `KEY` varchar(50) DEFAULT '',
  `FILTER` varchar(50) DEFAULT '',
  `UNIQUE` bit(1) DEFAULT NULL,
  `DESCENDING` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tablelist`
--

DROP TABLE IF EXISTS `tablelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tablelist` (
  `TABLEID` int(11) DEFAULT NULL,
  `TBLNAME` varchar(50) DEFAULT '',
  `TBLDESC` varchar(50) DEFAULT '',
  `DBMAINT` date DEFAULT NULL,
  `CLEANUP` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tablestructure`
--

DROP TABLE IF EXISTS `tablestructure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tablestructure` (
  `CRSSTRID` bigint(20) DEFAULT NULL,
  `FIELD_NAME` varchar(10) DEFAULT '',
  `FIELD_TYPE` varchar(1) DEFAULT '',
  `FIELD_LEN` smallint(6) DEFAULT NULL,
  `FIELD_DEC` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_rates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `desc` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percent` decimal(6,3) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trans2list`
--

DROP TABLE IF EXISTS `trans2list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trans2list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `TRANS2ID` int(11) DEFAULT NULL,
  `TRANSTO` varchar(20) DEFAULT '',
  `INACTIVE` tinyint(1) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `TRANSID` int(11) DEFAULT NULL,
  `TRANS2ID` int(11) DEFAULT NULL,
  `EMPLOYEE` varchar(10) DEFAULT '',
  `TRANSDNT` datetime DEFAULT NULL,
  `TRANSTOTAL` decimal(16,3) DEFAULT NULL,
  `TRANSFERED` tinyint(1) DEFAULT NULL,
  `TRANSIN` bit(1) DEFAULT NULL,
  `TRNSNOTE` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transitems`
--

DROP TABLE IF EXISTS `transitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transitems` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `TRANSID` int(11) DEFAULT NULL,
  `INVENID` int(11) DEFAULT NULL,
  `TRANSQTY` decimal(16,3) DEFAULT NULL,
  `ORGONHAND` decimal(16,3) DEFAULT NULL,
  `TRNSONHAND` decimal(16,3) DEFAULT NULL,
  `ORGCOST` decimal(17,4) DEFAULT NULL,
  `ORGPRICE` decimal(16,3) DEFAULT NULL,
  `ORGAVGCOST` decimal(21,5) DEFAULT NULL,
  `CWT` tinyint(1) DEFAULT NULL,
  `WEIGHT` decimal(13,3) DEFAULT NULL,
  `TRNSLNNBR` bigint(20) DEFAULT NULL,
  `ORDERNUM` varchar(14) DEFAULT '',
  `SERIALNBR` varchar(20) DEFAULT '',
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updatelist`
--

DROP TABLE IF EXISTS `updatelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `updatelist` (
  `UPDTPROC` varchar(15) DEFAULT '',
  `UPDTDESC` varchar(40) DEFAULT '',
  `STEPS` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(10) DEFAULT NULL,
  `store_id` int(10) DEFAULT '0',
  `company_id` int(11) NOT NULL DEFAULT '0',
  `created_by` int(10) DEFAULT NULL,
  `drawer` int(10) DEFAULT NULL,
  `quickpassword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_settings` longtext COLLATE utf8mb4_unicode_ci,
  `status` int(10) DEFAULT '1',
  `isloggedin` tinyint(1) DEFAULT '0',
  `lastaccess` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `wagesbyhr` int(11) DEFAULT '0',
  `store_admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3997 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variant_type_options`
--

DROP TABLE IF EXISTS `variant_type_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variant_type_options` (
  `vto_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vt_id` int(10) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `store_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`vto_id`),
  KEY `variant_type_options_vt_id_foreign` (`vt_id`),
  KEY `variant_type_options_store_id_index` (`store_id`),
  CONSTRAINT `variant_type_options_vt_id_foreign` FOREIGN KEY (`vt_id`) REFERENCES `variant_types` (`vt_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variant_types`
--

DROP TABLE IF EXISTS `variant_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variant_types` (
  `vt_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `store_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`vt_id`),
  KEY `variant_types_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variants_product`
--

DROP TABLE IF EXISTS `variants_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variants_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vpid` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_types` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inactive` tinyint(4) NOT NULL DEFAULT '1',
  `categoryid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lup_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor1id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nontaxable` tinyint(4) NOT NULL DEFAULT '1',
  `item_artg` tinyint(4) NOT NULL DEFAULT '0',
  `item_media_retail` tinyint(4) NOT NULL DEFAULT '0',
  `item_locally` tinyint(4) NOT NULL DEFAULT '0',
  `item_shopify` tinyint(4) NOT NULL DEFAULT '0',
  `store_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tobesync_shopify` int(2) DEFAULT '0',
  `shopify_category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variants_product_store_id_index` (`store_id`),
  KEY `vp_store_sync_shopify_index` (`store_id`,`tobesync_shopify`,`item_shopify`),
  KEY `variants_product_vpid_index` (`vpid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variants_product_item`
--

DROP TABLE IF EXISTS `variants_product_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variants_product_item` (
  `vpi_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vpid` int(10) unsigned NOT NULL,
  `vtoid1` int(10) unsigned DEFAULT NULL,
  `vtoid2` int(10) unsigned DEFAULT NULL,
  `invenid` int(10) unsigned DEFAULT NULL,
  `store_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`vpi_id`),
  KEY `variants_product_item_store_id_index` (`store_id`),
  KEY `vpi_vpid_store_id_index` (`vpid`,`store_id`),
  KEY `vpi_invenid_index` (`invenid`),
  CONSTRAINT `variants_product_item_vpid_foreign` FOREIGN KEY (`vpid`) REFERENCES `variants_product` (`vpid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vchitem`
--

DROP TABLE IF EXISTS `vchitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vchitem` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `VOUCHNUM` int(11) DEFAULT NULL,
  `INVENID` int(11) DEFAULT NULL,
  `RCVQTY` decimal(11,3) DEFAULT NULL,
  `ORGONHAND` decimal(11,3) DEFAULT NULL,
  `RCVONHAND` decimal(11,3) DEFAULT NULL,
  `ORGCOST` decimal(11,4) DEFAULT NULL,
  `RCVCOST` decimal(11,4) DEFAULT NULL,
  `RCVLFRGHT` decimal(17,4) DEFAULT NULL,
  `ORGPRICE` decimal(11,3) DEFAULT NULL,
  `RCVPRICE` decimal(11,3) DEFAULT NULL,
  `PRICECHNG` tinyint(1) DEFAULT NULL,
  `ORGAVGCOST` decimal(14,5) DEFAULT NULL,
  `RCVAVGCOST` decimal(14,5) DEFAULT NULL,
  `ORGMARKUP` decimal(7,2) DEFAULT NULL,
  `RCVMARKUP` decimal(7,2) DEFAULT NULL,
  `ORGMARGIN` decimal(5,2) DEFAULT NULL,
  `RCVMARGIN` decimal(5,2) DEFAULT NULL,
  `CWT` tinyint(1) DEFAULT NULL,
  `UNITMKUP` decimal(7,2) DEFAULT NULL,
  `WEIGHT` decimal(8,3) DEFAULT NULL,
  `ENDRTLVAL` varchar(1) DEFAULT '',
  `L3DECRTL` tinyint(1) DEFAULT NULL,
  `LINENUM` decimal(10,0) DEFAULT NULL,
  `SGSTPRICE` decimal(11,3) DEFAULT NULL,
  `ORDERNUM` varchar(200) DEFAULT NULL,
  `SERIALNBR` varchar(20) DEFAULT '',
  `CASEQTY` int(11) DEFAULT NULL,
  `CASECHANGE` tinyint(1) DEFAULT NULL,
  `new_item` varchar(255) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `PHOTO1FN` char(255) DEFAULT NULL,
  `PHOTO2FN` char(255) DEFAULT NULL,
  `PHOTO3FN` char(255) DEFAULT NULL,
  `IHTAXRATE` varchar(255) DEFAULT NULL,
  `IHNONTAXABLE` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=426893 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `VENDORID` int(11) NOT NULL DEFAULT '0',
  `VENDOR` varchar(30) DEFAULT '',
  `VCUST_NO` varchar(15) DEFAULT '',
  `CONTACT` varchar(30) DEFAULT '',
  `PHONE` varchar(20) DEFAULT '',
  `EXT` varchar(5) DEFAULT '',
  `FAX` varchar(20) DEFAULT '',
  `CELL` varchar(20) DEFAULT '',
  `ADDRESS1` varchar(30) DEFAULT '',
  `CITY` varchar(255) DEFAULT '',
  `STATE` varchar(255) DEFAULT '',
  `ZIP` varchar(10) DEFAULT '',
  `SHIPASMAIL` tinyint(1) DEFAULT NULL,
  `SHIPADDRESS` varchar(200) DEFAULT '',
  `SHIPCITY` varchar(255) DEFAULT '',
  `SHIPSTATE` varchar(255) DEFAULT '',
  `SHIPZIP` varchar(10) DEFAULT '',
  `EMAIL` varchar(200) DEFAULT '',
  `WEBSITE` varchar(40) DEFAULT '',
  `MEMO` longtext,
  `FLATRATE` decimal(10,2) DEFAULT NULL,
  `FRGHTRATE1` decimal(14,4) DEFAULT NULL,
  `FRGHTRATE2` decimal(14,4) DEFAULT NULL,
  `FRGHTRATE3` decimal(14,4) DEFAULT NULL,
  `FRGHTRATE4` decimal(14,4) DEFAULT NULL,
  `VENDNUM` varchar(10) DEFAULT '',
  `OLDVNDNUM` varchar(10) DEFAULT '',
  `INACTIVE` int(1) DEFAULT NULL,
  `INACTDATE` date DEFAULT NULL,
  `store_id` int(10) NOT NULL DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `qb_vendor_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `VOUCHNUM` int(11) NOT NULL DEFAULT '0',
  `VENDORID` int(11) DEFAULT NULL,
  `EMPLOYEE` varchar(255) DEFAULT '',
  `RCVDATE` date DEFAULT NULL,
  `RCVTIME` varchar(8) DEFAULT '',
  `rcvdatetime` datetime DEFAULT NULL,
  `INVDATE` date DEFAULT NULL,
  `RCVINUM` varchar(15) DEFAULT '',
  `FREIGHT` decimal(11,2) DEFAULT NULL,
  `TTLCOST` decimal(11,2) DEFAULT NULL,
  `VCHTOTAL` decimal(11,2) DEFAULT NULL,
  `RECEIVED` tinyint(1) DEFAULT NULL,
  `FRGHTRATE` decimal(9,4) DEFAULT NULL,
  `FLATRATE` tinyint(1) DEFAULT NULL,
  `DISTFRGHT` tinyint(1) DEFAULT NULL,
  `EDITMODE` tinyint(1) DEFAULT NULL,
  `POID` int(11) DEFAULT NULL,
  `RCVNOTE` longtext,
  `EDINOTE` longtext,
  `EDITOTAL` decimal(11,2) DEFAULT NULL,
  `EDIVENDOR` varchar(20) DEFAULT '',
  `store_id` int(10) DEFAULT '0',
  `user_id` int(10) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `PONBR` varchar(100) DEFAULT NULL,
  `received_from` varchar(100) DEFAULT NULL,
  `ocr_file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35652 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `whrticket`
--

DROP TABLE IF EXISTS `whrticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `whrticket` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `whrticket_id` int(11) DEFAULT NULL,
  `INVOICENBR` int(11) DEFAULT NULL,
  `INVDNT` datetime DEFAULT NULL,
  `CUSTOMER` varchar(30) DEFAULT '',
  `LOADEDBY` varchar(200) DEFAULT '',
  `LOADDNT` datetime DEFAULT NULL,
  `LOADNOTE` longtext,
  `store_id` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=656 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-12 10:14:59
