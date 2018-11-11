
CREATE DATABASE IF NOT EXISTS ilch;
USE ilch;

DROP TABLE IF EXISTS `actionstatuses`;
CREATE TABLE `actionstatuses` (
  `actionStatusId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actionStatus` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`actionStatusId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


INSERT INTO `actionstatuses` (`actionStatusId`,`actionStatus`) VALUES 
 (1,'ENABLE'),
 (2,'DISABLE'),
 (3,'UPDATE'),
 (4,'DELETE');


DROP TABLE IF EXISTS `addressinfo`;
CREATE TABLE `addressinfo` (
  `idAddressInfo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address1` varchar(45) NOT NULL DEFAULT '',
  `address2` varchar(45) NOT NULL DEFAULT '',
  `city` varchar(45) NOT NULL DEFAULT '',
  `state` varchar(45) NOT NULL DEFAULT '',
  `country` varchar(45) NOT NULL DEFAULT '',
  `zipcode` varchar(45) NOT NULL DEFAULT '',
  `landmark` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`idAddressInfo`)
) ENGINE=InnoDB AUTO_INCREMENT=395 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `adminsettings`;
CREATE TABLE `adminsettings` (
  `idadminsettings` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `businessId` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  PRIMARY KEY (`idadminsettings`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `attacheddocs`;
CREATE TABLE `attacheddocs` (
  `idattacheddocs` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL,
  `businessId` int(10) unsigned NOT NULL,
  `docType` varchar(250) NOT NULL,
  `docAPath` text NOT NULL,
  `docRPath` text NOT NULL,
  `attachedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `docName` text NOT NULL,
  `docSavedName` text NOT NULL,
  PRIMARY KEY (`idattacheddocs`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `idcategories` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `businessId` int(10) unsigned NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`idcategories`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `idcountry` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idcountry`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;


INSERT INTO `country` (`idcountry`,`name`) VALUES 
 (1,'USA'),
 (2,'UK'),
 (3,'India'),
 (4,'Singapore'),
 (5,'Philippines'),
 (6,'Australia');


DROP TABLE IF EXISTS `docsforsupporting`;
CREATE TABLE `docsforsupporting` (
  `supportingDocId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `docIds` varchar(45) NOT NULL DEFAULT '',
  `docTypeId` int(10) unsigned NOT NULL DEFAULT '0',
  `businessId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`supportingDocId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `doctypes`;
CREATE TABLE `doctypes` (
  `docTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentType` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`docTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


INSERT INTO `doctypes` (`docTypeId`,`documentType`) VALUES 
 (1,'userProfile'),
 (2,'businessProfile'),
 (3,'HrsSubmissionSupportingDoc'),
 (4,'businessLogo');


DROP TABLE IF EXISTS `emailremindertypes`;
CREATE TABLE `emailremindertypes` (
  `emailReminderTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `emailReminderType` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`emailReminderTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


INSERT INTO `emailremindertypes` (`emailReminderTypeId`,`emailReminderType`) VALUES 
 (1,'Weekly'),
 (2,'Monthly'),
 (3,'Yearly'),
 (4,'Daily'),
 (5,'Hourly');

DROP TABLE IF EXISTS `exceptiontrace`;
CREATE TABLE `exceptiontrace` (
  `idexceptionTrace` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exception` text NOT NULL,
  `exceptionMessage` text NOT NULL,
  `occuredDateTime` varchar(80) NOT NULL,
  PRIMARY KEY (`idexceptionTrace`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `immigrationdetails`;
CREATE TABLE `immigrationdetails` (
  `idimmigrationdetails` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `visaType` varchar(45) NOT NULL,
  `passportExpiryDate` date NOT NULL,
  `visaIssuedDate` date DEFAULT NULL,
  `visaExpiryDate` date NOT NULL,
  `passportIssueDate` date DEFAULT NULL,
  `passportNumber` varchar(45) DEFAULT NULL,
  `userId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idimmigrationdetails`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `lch_business`;
CREATE TABLE `lch_business` (
  `businessId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `businessName` varchar(45) NOT NULL,
  `businessAddressId` varchar(45) NOT NULL DEFAULT '',
  `websiteURL` varchar(100) NOT NULL DEFAULT '',
  `registeredByUserId` int(11) NOT NULL DEFAULT '0',
  `logo` varchar(45) DEFAULT NULL,
  `businessProfile` varchar(45) DEFAULT NULL,
  `isValidated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`businessId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `idlog` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log` text NOT NULL,
  `logType` varchar(45) NOT NULL,
  PRIMARY KEY (`idlog`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `idnews` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  PRIMARY KEY (`idnews`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `news` (`idnews`,`message`) VALUES 
 (1,'Made in USA.'),
 (2,'Be a part of CLOUD. Secured hosting on RedHat OpenShift Cloud.'),
 (3,'We do NOT share your data. Period.'),
 (4,'Qualtiy & Security tests performed in USA');



DROP TABLE IF EXISTS `scheduledtimers`;
CREATE TABLE `scheduledtimers` (
  `timerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contentId` varchar(45) NOT NULL,
  `cronExpression` varchar(45) NOT NULL,
  `userId` varchar(45) NOT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `timerName` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`timerId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `supersettings`;
CREATE TABLE `supersettings` (
  `idsuperSettings` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `info` text NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`idsuperSettings`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timercontents`;
CREATE TABLE `timercontents` (
  `contentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `businessId` int(11) DEFAULT NULL,
  `emailContent` text,
  `contentName` varchar(45) DEFAULT NULL,
  `userId` int(10) unsigned DEFAULT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `signature` varchar(450) DEFAULT NULL,
  `attachmentId` varchar(45) DEFAULT NULL,
  `subject` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`contentId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `taskcontents`;
CREATE TABLE `taskcontents` (
  `taskId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `businessId` int(11) DEFAULT NULL,
  `taskContent` text,
  `taskName` varchar(45) DEFAULT NULL,
  `userId` int(10) unsigned DEFAULT NULL,
  `dateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `additionalDetails` varchar(450) DEFAULT NULL,
  `attachmentId` varchar(45) DEFAULT NULL,
  `taskDescription` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`taskId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `taskcontents`;
CREATE TABLE `taskhistory` (
  `taskId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `businessId` int(11) DEFAULT NULL,
  `userId` int(10) unsigned DEFAULT NULL,
  `actionTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actionDetails` varchar(450) DEFAULT NULL,
  `attachmentId` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`taskId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `timesheetconfigurations`;
CREATE TABLE `timesheetconfigurations` (
  `idtimesheetconfigurations` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timeSheetConfigured` varchar(45) NOT NULL,
  PRIMARY KEY (`idtimesheetconfigurations`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `timesheetconfigurations` (`idtimesheetconfigurations`,`timeSheetConfigured`) VALUES 
 (1,'BIWEEKLY'),
 (2,'MONTHLY'),
 (3,'WEEKLY'),
 (4,'DAYS15');


DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `NAME` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `user_roles` (`NAME`) VALUES 
 ('ADMIN'),
 ('CHILDADMIN'),
 ('MEMBER'),
 ('SUPERADMIN');

DROP TABLE IF EXISTS `userclientslist`;
CREATE TABLE `userclientslist` (
  `clientId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clientName` varchar(45) NOT NULL DEFAULT '',
  `isCurrent` varchar(45) DEFAULT NULL,
  `startDate` varchar(45) DEFAULT NULL,
  `expectedEndDate` varchar(45) DEFAULT NULL,
  `actualEndDate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`clientId`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS `usercontactdata`;
CREATE TABLE `usercontactdata` (
  `idusercontact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `company` varchar(45) DEFAULT NULL,
  `address` text,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(450) DEFAULT NULL,
  `subject` varchar(450) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`idusercontact`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `userpersonaldata`;
CREATE TABLE `userpersonaldata` (
  `iduserData` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL DEFAULT '',
  `lastName` varchar(45) DEFAULT NULL,
  `middleName` varchar(45) DEFAULT NULL,
  `clientAddressId` varchar(45) DEFAULT NULL,
  `myAddressId` varchar(45) DEFAULT NULL,
  `contactEmail` varchar(45) DEFAULT NULL,
  `phoneNumber` varchar(45) DEFAULT NULL,
  `fatherName` varchar(45) DEFAULT NULL,
  `countryCitizenship` varchar(45) DEFAULT NULL,
  `homeCountryAddressId` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT '1000-01-01',
  `profilePath` varchar(45) DEFAULT '-1',
  `gendar` varchar(45) DEFAULT NULL,
  `isBdayWished` tinyint(1) NOT NULL DEFAULT '0',
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`iduserData`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `userrate`;
CREATE TABLE `userrate` (
  `iduserrate` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clientId` int(10) unsigned NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `rate` varchar(45) NOT NULL,
  `businessId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`iduserrate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `iduser` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `isPwdChangeRequired` tinyint(1) NOT NULL,
  `expairyDate` varchar(45) NOT NULL,
  `registeredDate` varchar(45) NOT NULL,
  `businessId` int(10) NOT NULL DEFAULT '0',
  `role` varchar(45) NOT NULL DEFAULT 'MEMBER',
  `personalDetailsId` varchar(45) NOT NULL DEFAULT '',
  `approvalStatus` int(10) unsigned NOT NULL DEFAULT '0',
  `clientId` int(10) unsigned NOT NULL DEFAULT '0',
  `timeSheetConfiguredTo` varchar(45) NOT NULL DEFAULT 'MONTHLY',
  `isEmailValidated` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 11264 kB; (`idBusiness`) REFER `lch/lch_busines';


DROP TABLE IF EXISTS `userstatus`;
CREATE TABLE `userstatus` (
  `iduserstatus` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`iduserstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `userstatus` (`iduserstatus`,`status`) VALUES 
 (1,'APPROVED'),
 (2,'DISABLED'),
 (3,'DELETED'),
 (5,'PENDING');

DROP TABLE IF EXISTS `weeklyhrs`;
CREATE TABLE `weeklyhrs` (
  `idweeklyHrs` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `weekNumber` int(10) unsigned NOT NULL DEFAULT '0',
  `weekStartDate` date NOT NULL DEFAULT '0000-00-00',
  `weekEndDate` date NOT NULL DEFAULT '0000-00-00',
  `SUNDAY` double NOT NULL DEFAULT '0',
  `MONDAY` double NOT NULL DEFAULT '0',
  `TUESDAY` double NOT NULL DEFAULT '0',
  `WEDNESDAY` double NOT NULL DEFAULT '0',
  `THURSDAY` double NOT NULL DEFAULT '0',
  `FRIDAY` double NOT NULL DEFAULT '0',
  `SATURDAY` double NOT NULL DEFAULT '0',
  `submissionType` varchar(45) NOT NULL DEFAULT '0',
  `year` int(10) unsigned NOT NULL DEFAULT '0',
  `idUser` int(10) unsigned NOT NULL,
  `idBusiness` int(10) unsigned NOT NULL,
  `total` double NOT NULL,
  `month` int(10) unsigned NOT NULL DEFAULT '0',
  `status` varchar(45) NOT NULL DEFAULT 'pending',
  `submissionConfiguredTo` varchar(45) NOT NULL,
  `submissionFor` varchar(45) NOT NULL,
  `weeklyHrsSummaryId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idweeklyHrs`,`year`,`idUser`,`month`,`idBusiness`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `weeklyhrssummary`;
CREATE TABLE `weeklyhrssummary` (
  `weeklyHrsSummaryId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `businessId` int(10) unsigned NOT NULL DEFAULT '0',
  `month` int(10) unsigned NOT NULL DEFAULT '0',
  `year` int(10) unsigned NOT NULL DEFAULT '0',
  `totalHrsSubmitted` double NOT NULL DEFAULT '0',
  `supportingDocIds` varchar(1000) NOT NULL DEFAULT '0',
  `status` varchar(45) NOT NULL DEFAULT '',
  `totalRegularHrs` double NOT NULL DEFAULT '0',
  `totalOvertimeHrs` double NOT NULL DEFAULT '0',
  `submittedDate` datetime DEFAULT NULL,
  `actionDate` datetime DEFAULT NULL,
  `clientId` int(10) unsigned NOT NULL DEFAULT '0',
  `submissionConfiguredTo` varchar(45) NOT NULL DEFAULT 'MONTHLY',
  `submissionFor` varchar(45) NOT NULL DEFAULT 'FIRST',
  `totalHolidayHrs` double NOT NULL DEFAULT '0',
  `startWeekDate` varchar(45) NOT NULL DEFAULT '0',
  `endWeekDate` varchar(45) NOT NULL DEFAULT '0',
  `comments` text,
  `userRate` decimal(10,0) DEFAULT NULL,
  `categoryId` int(10) unsigned NOT NULL DEFAULT '0',
  `hasOnlyMonthlyHours` integer NOT NULL DEFAULT '0',
  PRIMARY KEY (`weeklyHrsSummaryId`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

CREATE TABLE `skillTags` (
  `idskilltags` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `userId` INTEGER UNSIGNED NOT NULL DEFAULT 0,
  `tags` MEDIUMTEXT ,
  PRIMARY KEY(`idskilltags`)
) ENGINE = InnoDB;


INSERT INTO `lch_business` VALUES (6,'SuperAdmin','395','http://www.runningticker.com',-1,NULL,NULL,1),(7,'ALLIBILLI','397','www.allibilli.com',-1,NULL,NULL,1),(8,'ICONSOFT INC.','411','http://www.iconsoft.net',0,NULL,NULL,NULL),(9,'Test Employer','413','http://',0,NULL,NULL,NULL);
INSERT INTO `users` VALUES (134,'superadmin','499b399bf02a9b428cfc8d347fa59a89',0,'Thu Jun 05 21:57:52 EDT 2014','Thu Jun 05 21:57:52 EDT 2014',6,'SUPERADMIN','134',1,0,'',1),(135,'employer','499b399bf02a9b428cfc8d347fa59a89',0,'Thu Jun 05 21:59:33 EDT 2014','Thu Jun 05 21:59:33 EDT 2014',7,'ADMIN','135',1,0,'BIWEEKLY',1),(136,'employeeBiWeekly','499b399bf02a9b428cfc8d347fa59a89',0,'Thu Jun 05 21:59:34 EDT 2014','Thu Jun 05 21:59:34 EDT 2014',7,'MEMBER','136',1,129,'BIWEEKLY',1),(137,'employeeWeekly','499b399bf02a9b428cfc8d347fa59a89',0,'Thu Jun 05 21:59:36 EDT 2014','Thu Jun 05 21:59:36 EDT 2014',7,'MEMBER','137',1,130,'WEEKLY',1),(138,'employeeMonthly','499b399bf02a9b428cfc8d347fa59a89',0,'Thu Jun 05 21:59:38 EDT 2014','Thu Jun 05 21:59:38 EDT 2014',7,'MEMBER','138',1,131,'MONTHLY',1),(139,'employeeDays15','499b399bf02a9b428cfc8d347fa59a89',0,'Thu Jun 05 21:59:40 EDT 2014','Thu Jun 05 21:59:40 EDT 2014',7,'MEMBER','139',1,132,'DAYS15',1),(140,'ravi@iconsoft.net','cd696cf04a8744a0adf59211a3221880',0,'Fri Jun 06 16:59:49 EDT 2014','Fri Jun 06 16:59:49 EDT 2014',8,'ADMIN','140',1,0,'MONTHLY',0),(141,'reachtsr@gmail.com','499b399bf02a9b428cfc8d347fa59a89',0,'Fri Jun 06 17:07:16 EDT 2014','Fri Jun 06 17:07:16 EDT 2014',9,'ADMIN','141',1,0,'MONTHLY',1);
INSERT INTO `userpersonaldata` VALUES (134,'Gopi','Last Name','Middle Name','0','396','haigopi@gmail.com','1231231233','KVS Prasada Rao','USA','0','2014-06-05',NULL,'MALE',0,0),(135,'Employer FirstName','Last Name','Middle Name','0','398','ilchemployer@gmail.com','1231231233','EmployerFather','USA','0','2014-06-05',NULL,'MALE',0,0),(136,'User ','1','Middle Name','401','399','ilchbiweekly@gmail.com','1231231233','FATHER','USA','400','2014-06-05',NULL,'MALE',0,10),(137,'User ','2','Middle Name','404','402','ilchweekly@gmail.com','1231231233','FATHER','USA','403','2014-06-05',NULL,'MALE',0,10),(138,'User ','3','Middle Name','407','405','ilchmonthly@gmail.com','1231231233','FATHER','USA','406','2014-06-05',NULL,'MALE',0,10),(139,'User ','4','Middle Name','410','408','ilchdays15@gmail.com','1231231233','FATHER','USA','409','2014-06-05',NULL,'MALE',0,10),(140,'Ravi','Meruva','Kumar','0','412','ravi@iconsoft.net','8882054614',NULL,'','0','2014-06-06',NULL,NULL,0,0),(141,'Sri','Thig','','0','414','reachtsr@gmail.com','7036470216',NULL,'','0','2014-06-06',NULL,NULL,0,0);
INSERT INTO `addressinfo` VALUES (395,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(396,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(397,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(398,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(399,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(400,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(401,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(402,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(403,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(404,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(405,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(406,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(407,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(408,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(409,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(410,'411 Buckingham Rd','Apt 212','Richardson','TX','USA','75081',''),(411,'101 Cambridge Street Suite 360','','Burlington','MA','USA','01803','Massachusetts'),(412,'101 Cambridge Street Suite 360','','Burlington','MA','USA','01803','Massachusetts'),(413,'315 West Side Dr 304','','Gaithersburg','MD','USA','20878','MD'),(414,'315 West Side Dr 304','','Gaithersburg','MD','USA','20878','MD');

