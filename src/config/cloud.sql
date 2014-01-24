

DROP TABLE IF EXISTS `country`;
CREATE TABLE  `country` (
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
--
-- Definition of table `actionstatuses`
--
DROP TABLE IF EXISTS `adminsettings`;
DROP TABLE IF EXISTS `adminsettings`;
CREATE TABLE `adminsettings` (
  `idadminsettings` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `businessId` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  PRIMARY KEY (`idadminsettings`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `actionstatuses`;
CREATE TABLE `actionstatuses` (
  `actionStatusId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actionStatus` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`actionStatusId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `actionstatuses`
--

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

/*!40000 ALTER TABLE `actionstatuses` DISABLE KEYS */;
INSERT INTO `actionstatuses` (`actionStatusId`,`actionStatus`) VALUES 
 (1,'ENABLE'),
 (2,'DISABLE'),
 (3,'UPDATE'),
 (4,'DELETE');
/*!40000 ALTER TABLE `actionstatuses` ENABLE KEYS */;


--
-- Definition of table `addressinfo`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `addressinfo`
--

/*!40000 ALTER TABLE `addressinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `addressinfo` ENABLE KEYS */;


--
-- Definition of table `attacheddocs`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attacheddocs`
--

/*!40000 ALTER TABLE `attacheddocs` DISABLE KEYS */;
/*!40000 ALTER TABLE `attacheddocs` ENABLE KEYS */;


--
-- Definition of table `docsforsupporting`
--

DROP TABLE IF EXISTS `docsforsupporting`;
CREATE TABLE `docsforsupporting` (
  `supportingDocId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `docIds` varchar(45) NOT NULL DEFAULT '',
  `docTypeId` int(10) unsigned NOT NULL DEFAULT '0',
  `businessId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`supportingDocId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `docsforsupporting`
--

/*!40000 ALTER TABLE `docsforsupporting` DISABLE KEYS */;
/*!40000 ALTER TABLE `docsforsupporting` ENABLE KEYS */;


--
-- Definition of table `doctypes`
--

DROP TABLE IF EXISTS `doctypes`;
CREATE TABLE `doctypes` (
  `docTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documentType` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`docTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctypes`
--

/*!40000 ALTER TABLE `doctypes` DISABLE KEYS */;
INSERT INTO `doctypes` (`docTypeId`,`documentType`) VALUES 
 (1,'userProfile'),
 (2,'businessProfile'),
 (3,'HrsSubmissionSupportingDoc'),
 (4,'businessLogo');
/*!40000 ALTER TABLE `doctypes` ENABLE KEYS */;


--
-- Definition of table `emailremindertypes`
--

DROP TABLE IF EXISTS `emailremindertypes`;
CREATE TABLE `emailremindertypes` (
  `emailReminderTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `emailReminderType` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`emailReminderTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emailremindertypes`
--

/*!40000 ALTER TABLE `emailremindertypes` DISABLE KEYS */;
INSERT INTO `emailremindertypes` (`emailReminderTypeId`,`emailReminderType`) VALUES 
 (1,'Weekly'),
 (2,'Monthly'),
 (3,'Yearly'),
 (4,'Daily'),
 (5,'Hourly');
/*!40000 ALTER TABLE `emailremindertypes` ENABLE KEYS */;


--
-- Definition of table `exceptiontrace`
--

DROP TABLE IF EXISTS `exceptiontrace`;
CREATE TABLE `exceptiontrace` (
  `idexceptionTrace` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exception` text NOT NULL,
  `exceptionMessage` text NOT NULL,
  `occuredDateTime` varchar(80) NOT NULL,
  PRIMARY KEY (`idexceptionTrace`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exceptiontrace`
--

/*!40000 ALTER TABLE `exceptiontrace` DISABLE KEYS */;
/*!40000 ALTER TABLE `exceptiontrace` ENABLE KEYS */;


--
-- Definition of table `lch_business`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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

--
-- Dumping data for table `scheduledtimers`
--

/*!40000 ALTER TABLE `scheduledtimers` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduledtimers` ENABLE KEYS */;

DROP TABLE IF EXISTS `supersettings`;
CREATE TABLE `supersettings` (
  `idsuperSettings` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `info` text NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`idsuperSettings`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supersettings`
--

/*!40000 ALTER TABLE `supersettings` DISABLE KEYS */;
INSERT INTO `supersettings` (`idsuperSettings`,`info`,`type`) VALUES 
 (2,'ILCH is about to have an upgrade and will be down during Mon Sep 16 2013, 12:00 AM to 3:00 AM CDT.','OUTAGE');
/*!40000 ALTER TABLE `supersettings` ENABLE KEYS */;


--
-- Definition of table `timercontents`
--

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

--
-- Dumping data for table `timercontents`
--

/*!40000 ALTER TABLE `timercontents` DISABLE KEYS */;
/*!40000 ALTER TABLE `timercontents` ENABLE KEYS */;


--
-- Definition of table `timesheetconfigurations`
--

DROP TABLE IF EXISTS `timesheetconfigurations`;
CREATE TABLE `timesheetconfigurations` (
  `idtimesheetconfigurations` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timeSheetConfigured` varchar(45) NOT NULL,
  PRIMARY KEY (`idtimesheetconfigurations`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `timesheetconfigurations`
--

/*!40000 ALTER TABLE `timesheetconfigurations` DISABLE KEYS */;
INSERT INTO `timesheetconfigurations` (`idtimesheetconfigurations`,`timeSheetConfigured`) VALUES 
 (1,'BIWEEKLY'),
 (2,'MONTHLY'),
 (3,'WEEKLY'),
 (4,'DAYS15');
/*!40000 ALTER TABLE `timesheetconfigurations` ENABLE KEYS */;


--
-- Definition of table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `idUSER_ROLES` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`idUSER_ROLES`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_roles`
--

/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;


--
-- Definition of table `userclientslist`
--

DROP TABLE IF EXISTS `userclientslist`;
CREATE TABLE `userclientslist` (
  `clientId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clientName` varchar(45) NOT NULL DEFAULT '',
  `isCurrent` varchar(45) DEFAULT NULL,
  `startDate` varchar(45) DEFAULT NULL,
  `expectedEndDate` varchar(45) DEFAULT NULL,
  `actualEndDate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`clientId`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userclientslist`
--

/*!40000 ALTER TABLE `userclientslist` DISABLE KEYS */;
/*!40000 ALTER TABLE `userclientslist` ENABLE KEYS */;


--
-- Definition of table `userpersonaldata`
--

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
  PRIMARY KEY (`iduserData`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userpersonaldata`
--

/*!40000 ALTER TABLE `userpersonaldata` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpersonaldata` ENABLE KEYS */;


--
-- Definition of table `users`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 11264 kB; (`idBusiness`) REFER `lch/lch_busines';

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `userstatus`
--

DROP TABLE IF EXISTS `userstatus`;
CREATE TABLE `userstatus` (
  `iduserstatus` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`iduserstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userstatus`
--

/*!40000 ALTER TABLE `userstatus` DISABLE KEYS */;
INSERT INTO `userstatus` (`iduserstatus`,`status`) VALUES 
 (1,'APPROVED'),
 (2,'DISABLED'),
 (3,'DELETED'),
 (5,'PENDING');
/*!40000 ALTER TABLE `userstatus` ENABLE KEYS */;


--
-- Definition of table `weeklyhrs`
--

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
  PRIMARY KEY (`idweeklyHrs`,`year`,`idUser`,`month`,`idBusiness`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weeklyhrs`
--

/*!40000 ALTER TABLE `weeklyhrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `weeklyhrs` ENABLE KEYS */;


--
-- Definition of table `weeklyhrssummary`
--

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
  PRIMARY KEY (`weeklyHrsSummaryId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;


-- Definition of table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `idlog` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log` text NOT NULL,
  `logType` varchar(45) NOT NULL,
  PRIMARY KEY (`idlog`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log`
--

/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` (`idlog`,`log`,`logType`) VALUES 
 (1,'From : contact@allibilli.comSubject :Your TimeSheet StatusContent :<html>\r\n\r\n<body link=\"#00FFFF\" vlink=\"#FFFFFF\" alink=\"#008080\">\r\n\r\n<table border=\"0\" width=\"100%\" height=\"351\" style=\"font-family: Tahoma\">\r\n	<tr>\r\n		<td bgcolor=\"#224F90\">\r\n		<table border=\"0\" width=\"100%\" cellpadding=\"15\" cellspacing=\"0\">\r\n			<tr>\r\n				<td width=\"100%\" style=\"color: #FFFFFF\" align=\"right\"><b>\r\n				<font size=\"2\">ILCH</font></b></td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td bgcolor=\"#946EA9\" align=\"left\" valign=\"top\">\r\n		<table border=\"0\" width=\"100%\" height=\"100%\" cellpadding=\"55\" id=\"table1\">\r\n			<tr>\r\n				<td width=\"100%\" height=\"100%\" style=\"color: #224F90\" bgcolor=\"#946EA9\">\r\n				<font ><font color=\"#FFFFFF\"><span style=\"font-weight: 700; \">\r\n				<font size=\"2\">Dear User,</font></span><ul>\r\n					<p><font size=\"2\">\r\n					<span style=\"line-height: 150%\"><font color=\"#FFFFFF\">Your approval request submitted for time sheet is now approved by your employer.</span></font></font></p>\r\n				</ul>\r\n				\r\n				</font>\r\n				<p><font color=\"#FFFFFF\"><span style=\"font-weight: 700; \"><br>\r\n				</span><font size=\"2\" >Thank you,</font></p>\r\n				<p><font size=\"2\" color=\"#FFFFFF\">Team AlliBilli.</font></font></p>\r\n				</td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td bgcolor=\"#224F90\">\r\n		<table border=\"0\" width=\"100%\" cellpadding=\"15\" cellspacing=\"0\">\r\n			<tr>\r\n				<td width=\"100%\" style=\"color: #C0C0C0; font-size:8pt; font-family:Tahoma\" align=\"center\">\r\n				All Rights Reserved. A Product of AlliBilli.com</td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n</table>\r\n\r\n</body>\r\n\r\n</html>','EMAIL'),
 (2,'From : contact@allibilli.comSubject :Your TimeSheet StatusContent :<html>\r\n\r\n<body link=\"#00FFFF\" vlink=\"#FFFFFF\" alink=\"#008080\">\r\n\r\n<table border=\"0\" width=\"100%\" height=\"351\" style=\"font-family: Tahoma\">\r\n	<tr>\r\n		<td bgcolor=\"#224F90\">\r\n		<table border=\"0\" width=\"100%\" cellpadding=\"15\" cellspacing=\"0\">\r\n			<tr>\r\n				<td width=\"100%\" style=\"color: #FFFFFF\" align=\"right\"><b>\r\n				<font size=\"2\">ILCH</font></b></td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td bgcolor=\"#946EA9\" align=\"left\" valign=\"top\">\r\n		<table border=\"0\" width=\"100%\" height=\"100%\" cellpadding=\"55\" id=\"table1\">\r\n			<tr>\r\n				<td width=\"100%\" height=\"100%\" style=\"color: #224F90\" bgcolor=\"#946EA9\">\r\n				<font ><font color=\"#FFFFFF\"><span style=\"font-weight: 700; \">\r\n				<font size=\"2\">Dear User,</font></span><ul>\r\n					<p><font size=\"2\">\r\n					<span style=\"line-height: 150%\"><font color=\"#FFFFFF\">Your approval request submitted for time sheet is now approved by your employer.</span></font></font></p>\r\n				</ul>\r\n				\r\n				</font>\r\n				<p><font color=\"#FFFFFF\"><span style=\"font-weight: 700; \"><br>\r\n				</span><font size=\"2\" >Thank you,</font></p>\r\n				<p><font size=\"2\" color=\"#FFFFFF\">Team AlliBilli.</font></font></p>\r\n				</td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td bgcolor=\"#224F90\">\r\n		<table border=\"0\" width=\"100%\" cellpadding=\"15\" cellspacing=\"0\">\r\n			<tr>\r\n				<td width=\"100%\" style=\"color: #C0C0C0; font-size:8pt; font-family:Tahoma\" align=\"center\">\r\n				All Rights Reserved. A Product of AlliBilli.com</td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n</table>\r\n\r\n</body>\r\n\r\n</html>','EMAIL'),
 (3,'From : contact@allibilli.comSubject :Your TimeSheet StatusContent :<html>\r\n\r\n<body link=\"#00FFFF\" vlink=\"#FFFFFF\" alink=\"#008080\">\r\n\r\n<table border=\"0\" width=\"100%\" height=\"351\" style=\"font-family: Tahoma\">\r\n	<tr>\r\n		<td bgcolor=\"#224F90\">\r\n		<table border=\"0\" width=\"100%\" cellpadding=\"15\" cellspacing=\"0\">\r\n			<tr>\r\n				<td width=\"100%\" style=\"color: #FFFFFF\" align=\"right\"><b>\r\n				<font size=\"2\">ILCH</font></b></td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td bgcolor=\"#946EA9\" align=\"left\" valign=\"top\">\r\n		<table border=\"0\" width=\"100%\" height=\"100%\" cellpadding=\"55\" id=\"table1\">\r\n			<tr>\r\n				<td width=\"100%\" height=\"100%\" style=\"color: #224F90\" bgcolor=\"#946EA9\">\r\n				<font ><font color=\"#FFFFFF\"><span style=\"font-weight: 700; \">\r\n				<font size=\"2\">Dear User,</font></span><ul>\r\n					<p><font size=\"2\">\r\n					<span style=\"line-height: 150%\"><font color=\"#FFFFFF\">Your approval request submitted for time sheet is rejected by your employer. Please edit and re submit accordingly. If you have any issues please contact your employer.</span></font></font></p>\r\n				</ul>\r\n				\r\n				</font>\r\n				<p><font color=\"#FFFFFF\"><span style=\"font-weight: 700; \"><br>\r\n				</span><font size=\"2\" >Thank you,</font></p>\r\n				<p><font size=\"2\" color=\"#FFFFFF\">Team AlliBilli.</font></font></p>\r\n				</td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td bgcolor=\"#224F90\">\r\n		<table border=\"0\" width=\"100%\" cellpadding=\"15\" cellspacing=\"0\">\r\n			<tr>\r\n				<td width=\"100%\" style=\"color: #C0C0C0; font-size:8pt; font-family:Tahoma\" align=\"center\">\r\n				All Rights Reserved. A Product of AlliBilli.com</td>\r\n			</tr>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n</table>\r\n\r\n</body>\r\n\r\n</html>','EMAIL');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;


--
-- Definition of table `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `idnews` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  PRIMARY KEY (`idnews`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `news`
--

--
-- Dumping data for table `news`
--

/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`idnews`,`message`) VALUES 
 (1,'Made in USA.'),
 (2,'Be a part of CLOUD. Secured hosting on RedHat OpenShift Cloud.'),
 (3,'We do NOT share your data. Period.'),
 (4,'Qualtiy & Security tests performed in USA');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

