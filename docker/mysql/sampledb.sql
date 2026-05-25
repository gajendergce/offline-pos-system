-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: agrtl_offline
-- ------------------------------------------------------
-- Server version	5.7.44

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1377 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=4012 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  PRIMARY KEY (`id`),
  KEY `custom_logs_level_index` (`level`),
  KEY `custom_logs_channel_index` (`channel`)
) ENGINE=InnoDB AUTO_INCREMENT=13080524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `rank_sorting` int(11) DEFAULT NULL,
  `cc_token` text,
  PRIMARY KEY (`id`),
  KEY `customer_store_id_index` (`store_id`),
  KEY `customer_cust_id_index` (`CUST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=143962 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_invoice`
--

DROP TABLE IF EXISTS `customer_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_invoice` (
  `station_id` int(11) NOT NULL,
  `TENDERED` double(8,2) DEFAULT NULL,
  `CHANGE` double(8,2) DEFAULT NULL,
  `TAXAMNT` double(8,2) NOT NULL,
  `SLSTOTAL` double(8,2) NOT NULL,
  `cash_rounding` decimal(6,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_invoiceitems`
--

DROP TABLE IF EXISTS `customer_invoiceitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_invoiceitems` (
  `station_id` int(11) NOT NULL,
  `tr_id` int(11) NOT NULL,
  `INVENTORYID` int(11) NOT NULL,
  `QUANTITY` decimal(8,3) NOT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PRICE` decimal(8,3) NOT NULL,
  `EXTENDED` double(8,2) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `apply_amount` double(8,2) NOT NULL,
  `voided` tinyint(1) DEFAULT '0',
  `store_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=4329 DEFAULT CHARSET=utf8;
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
  `trackserial` int(10) NOT NULL DEFAULT '0',
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  `allowrecurring` tinyint(1) DEFAULT '0',
  `item_artg` tinyint(1) NOT NULL DEFAULT '0',
  `artg_httplink` varchar(255) DEFAULT '',
  `item_media_retail` tinyint(1) NOT NULL DEFAULT '0',
  `item_locally` tinyint(1) NOT NULL DEFAULT '0',
  `item_shopify` tinyint(1) NOT NULL DEFAULT '0',
  `tobesync_shopify` tinyint(1) NOT NULL DEFAULT '0',
  `tobesync` tinyint(1) NOT NULL DEFAULT '0',
  `update_from` varchar(255) DEFAULT NULL,
  `update_by_id` bigint(20) DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `store_id` int(10) NOT NULL DEFAULT '0',
  `taxrate_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `variant_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_store_id_index` (`store_id`),
  KEY `invenid_store_id` (`INVENTORYID`,`store_id`),
  KEY `inventory_variant_id_index` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=520082 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `is_sync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `invoice_store_id_index` (`store_id`),
  KEY `invoice_invoicenbr_index` (`INVOICENBR`),
  KEY `invoice_tmp_invoicenbr_index` (`TMP_INVOICENBR`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
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
  `VND1ORDNUM` varchar(18) DEFAULT '',
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `LOGDATETIME` datetime DEFAULT NULL,
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
  KEY `logonlog_store_id_index` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6541518 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lupcodes`
--

DROP TABLE IF EXISTS `lupcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lupcodes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `LUP_ID` int(11) DEFAULT NULL,
  `LUP_NAME` varchar(20) DEFAULT '',
  `store_id` int(10) NOT NULL DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lupcodes_store_id_index` (`store_id`),
  KEY `lupcodes_lup_id_index` (`LUP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7147 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `token` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
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
  `status_msg` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rewardcust`
--

DROP TABLE IF EXISTS `rewardcust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewardcust` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rewardcust_store_id_index` (`store_id`),
  KEY `rewardcust_custrwid_index` (`CUSTRWID`),
  KEY `rewardcust_rewardid_index` (`REWARDID`),
  KEY `rewardcust_cust_id_index` (`CUST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rewards`
--

DROP TABLE IF EXISTS `rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rewards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
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
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rewards_store_id_index` (`store_id`),
  KEY `rewards_rewardid_index` (`REWARDID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NOT NULL,
  `permission_id` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `usehandheld` tinyint(1) DEFAULT '0',
  `invmodintg` tinyint(1) DEFAULT NULL,
  `intgmenu` tinyint(4) NOT NULL DEFAULT '0',
  `intgshopify` tinyint(4) NOT NULL DEFAULT '0',
  `intglocally` tinyint(4) NOT NULL DEFAULT '0',
  `intgquickbooks` tinyint(4) NOT NULL DEFAULT '0',
  `intgnewmediaretailer` tinyint(4) NOT NULL DEFAULT '0',
  `intgpriceboard` tinyint(4) NOT NULL DEFAULT '0',
  `alwitemonrecurring` tinyint(1) DEFAULT NULL,
  `alwrecurringsales` tinyint(1) DEFAULT '0',
  `alwrecurracptpayments` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `ALWNEGQ_P` tinyint(1) DEFAULT '0',
  `alwpricechngeprcnt` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `security_store_id_index` (`store_id`),
  KEY `security_securityid_index` (`SECURITYID`)
) ENGINE=InnoDB AUTO_INCREMENT=1539 DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`id`),
  KEY `sequences_store_id_table_name_column_name_index` (`store_id`,`table_name`,`column_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  PRIMARY KEY (`id`),
  KEY `serialnbrs_store_id_index` (`store_id`),
  KEY `serialnbrs_invenid_index` (`INVENID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `store_id` int(11) DEFAULT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `states_id_index` (`id`)
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
  `LastPrn` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `LastlblType` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  PRIMARY KEY (`id`),
  KEY `stations_id_index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `migration_detail` json DEFAULT NULL,
  `allowimportinv` tinyint(1) DEFAULT '0',
  `allowlinetax` tinyint(1) NOT NULL DEFAULT '0',
  `tax_update_status` tinyint(1) NOT NULL DEFAULT '0',
  `db_connection_info` text COMMENT 'Encrypted JSON: {host, port, database, username, password}',
  `alwlocally` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemsettings`
--

DROP TABLE IF EXISTS `systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemsettings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
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
  `ORGLAUTORC` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`id`),
  KEY `users_store_id_index` (`store_id`),
  KEY `users_company_id_index` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1628 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`VENDOR`,`VCUST_NO`,`CONTACT`),
  KEY `vendors_store_id_index` (`store_id`),
  KEY `vendors_vendorid_index` (`VENDORID`)
) ENGINE=InnoDB AUTO_INCREMENT=10850 DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`id`),
  KEY `whrticket_store_id_index` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-25 10:32:48
