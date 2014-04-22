
DROP FUNCTION IF EXISTS `deleteCategory`;

DELIMITER $$

CREATE FUNCTION `deleteCategory`(inputId INT) RETURNS int(11)
BEGIN
	DECLARE retval INT;
	SELECT count(1) INTO retval from userpersonaldata where categoryId=inputId;
	update userpersonaldata set categoryId=0 where categoryId=inputId;
	update weeklyhrssummary set categoryId=0 where categoryId=inputId;
	delete from categories where idcategories=inputId;
	return retval;
END $$

DELIMITER ;

DROP FUNCTION IF EXISTS `updateAsscoiations` ;

DELIMITER $$

CREATE FUNCTION `updateAsscoiations`(ids TEXT, catId VARCHAR(45), busId int) RETURNS int(11)
BEGIN
	DECLARE retval INT;
	DECLARE defaultCatId INT;
	select idcategories into defaultCatId from categories where businessId=busId and name='SystemDefault';
	update userpersonaldata set categoryId=defaultCatId where categoryId=catId;
	update userpersonaldata set categoryId=catId where FIND_IN_SET(iduserdata, ids);
	select count(1) into retval from userpersonaldata where categoryId=catId;
	return retval;
END $$

DELIMITER ;
DROP FUNCTION IF EXISTS `disableBusiness`;

DELIMITER $$

CREATE  FUNCTION `disableBusiness`(busId INT) RETURNS int(4)
BEGIN
	DECLARE countOfUsers INT(4);
	update users set approvalStatus=0 where businessId = busId;
	select count(1) into countOfUsers from users where businessId = busId;
	return countOfUsers;
END $$

DELIMITER ;
DROP FUNCTION IF EXISTS `enableBusiness`;

DELIMITER $$

CREATE  FUNCTION `enableBusiness`(busId INT) RETURNS int(4)
BEGIN
	DECLARE countOfUsers INT(4);
	update users u set u.approvalStatus=1 where u.businessId = busId;
	select count(1) into countOfUsers from users where businessId = busId;
	return countOfUsers;
END $$

DELIMITER ;
DROP FUNCTION IF EXISTS `makeAllUsersValid`;

DELIMITER $$


CREATE  FUNCTION `makeAllUsersValid`() RETURNS int(11)
BEGIN update users set isEmailValidated=1, approvalStatus=1; update lch_business set isValidated=1; return 0; END $$

DELIMITER ;
DROP FUNCTION IF EXISTS `deleteUsersAndHours`;

DELIMITER $$

CREATE FUNCTION `deleteUsersAndHours`() RETURNS int(11)
BEGIN delete FROM lch_business ; delete FROM users ; delete FROM userpersonaldata ; delete FROM weeklyhrs ; delete FROM weeklyhrssummary ; delete FROM userclientslist ; delete FROM addressinfo ; delete FROM attacheddocs ; return 0; END $$

DELIMITER ;
DROP FUNCTION IF EXISTS `enbleBusinessForTestingPurpose`;

DELIMITER $$

CREATE FUNCTION `enbleBusinessForTestingPurpose`() RETURNS int(11)
BEGIN
	update users set approvalStatus=1 where iduser=129;
	update users set isEmailValidated=1 where iduser=129;
	update users set isEmailValidated=1 where iduser=130;
	update users set isEmailValidated=1 where iduser=131;
	update users set isEmailValidated=1 where iduser=132;
	update users set isEmailValidated=1 where iduser=133;
	update lch_business set isValidated=1 where businessId=5; 
	return 1; 
END $$

DELIMITER ;
