
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
update users set approvalStatus=1 where iduser=129;
update users set isEmailValidated=1 where iduser=129;

 update users set isEmailValidated=1 where iduser=130;
update users set isEmailValidated=1 where iduser=131;
update users set isEmailValidated=1 where iduser=132;
update users set isEmailValidated=1 where iduser=133;
update lch_business set isValidated=1 where businessId=5; return 1; END $$



