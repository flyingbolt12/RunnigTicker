DROP FUNCTION IF EXISTS `deleteCategory`;

DELIMITER $$

CREATE FUNCTION `deleteCategory`(inputId INT) RETURNS int(11)
BEGIN
DECLARE retval INT;
DECLARE sysdefaultcatId INT;
DECLARE busId INT;

SELECT count(1) INTO retval from userpersonaldata where categoryId=inputId;
SELECT idcategories into sysdefaultcatId FROM categories c where businessId = ( SELECT businessId FROM categories c where idcategories=inputId) and name ='SystemDefault';
SELECT businessId into busId FROM categories c where idcategories=inputId;

update userpersonaldata set categoryId=sysdefaultcatId where categoryId=inputId;
update weeklyhrssummary set categoryId=sysdefaultcatId where categoryId=inputId;
update weeklyhrssummary set categoryId=sysdefaultcatId where categoryId=0 and businessId = busId;
update userpersonaldata up, users u set up.categoryId=sysdefaultcatId where categoryId=0 and iduserData = u.personalDetailsId and u.businessId = busId and u.role = 'MEMBER';

delete from categories where idcategories=inputId;

return retval; END $$


DROP FUNCTION IF EXISTS `updateAsscoiations` $$

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

DROP FUNCTION IF EXISTS `disableBusiness`$$

CREATE  FUNCTION `disableBusiness`(busId INT) RETURNS int(4)
BEGIN
	DECLARE countOfUsers INT(4);
	update users set approvalStatus=0 where businessId = busId;
	select count(1) into countOfUsers from users where businessId = busId;
	return countOfUsers;
END $$

DROP FUNCTION IF EXISTS `enableBusiness`$$

CREATE  FUNCTION `enableBusiness`(busId INT) RETURNS int(4)
BEGIN
	DECLARE countOfUsers INT(4);
	update users u set u.approvalStatus=1 where u.businessId = busId;
	select count(1) into countOfUsers from users where businessId = busId;
	return countOfUsers;
END $$

DROP FUNCTION IF EXISTS `makeAllUsersValid`$$


CREATE  FUNCTION `makeAllUsersValid`() RETURNS int(11)
BEGIN update users set isEmailValidated=1, approvalStatus=1; update lch_business set isValidated=1; return 0; END $$


DROP FUNCTION IF EXISTS `deleteUsersAndHours`$$

CREATE FUNCTION `deleteUsersAndHours`() RETURNS int(11)
BEGIN delete FROM lch_business ; delete FROM users ; delete FROM userpersonaldata ; delete FROM weeklyhrs ; delete FROM weeklyhrssummary ; delete FROM userclientslist ; delete FROM addressinfo ; delete FROM attacheddocs ; return 0; END $$

DROP FUNCTION IF EXISTS `enbleBusinessForTestingPurpose`$$
CREATE FUNCTION `enbleBusinessForTestingPurpose`() RETURNS int(11)
BEGIN
update users set approvalStatus=1 where login='employer';
update users set isEmailValidated=1 where login='employer';
update users set isEmailValidated=1 where login='employeeWeekly';
update users set isEmailValidated=1 where login='employeeMonthly';
update users set isEmailValidated=1 where login='employeeBiWeekly';
update users set isEmailValidated=1 where login='employeeDays15';
update lch_business set isValidated=1 where businessName='AlliBilli';
	return 1; 
END $$
