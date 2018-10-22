/*
 * Created on Feb 16, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.spring;

import com.lch.struts.actions.BaseAction;


/**
 * @author Gopi
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public interface SQLQueries {

	static final String LOGINCHECKSQL = "select usersTable.businessId as businessId,usersTable.clientId as clientId, usersTable.approvalStatus, usersTable.idUser as userId, usersTable.login as userName, usersTable.role as role, usersTable.timeSheetConfiguredTo as timeSheetConfiguredTo, userPersonalDataTable.firstName as firstName, userPersonalDataTable.categoryId as categoryId, usersTable.isEmailValidated as isEmailValidated, lchBusinessTable.businessName as employerName, usersTable.personalDetailsId,userPersonalDataTable.contactEmail as employeeEmail from users usersTable, userpersonaldata userPersonalDataTable, lch_business lchBusinessTable where usersTable.login=? and usersTable.password=MD5(?) and usersTable.personalDetailsId = userPersonalDataTable.iduserdata and lchBusinessTable.businessId= usersTable.businessId";
	static final String LOAD_USER_DETAILS_BY_LOGIN_NAME= "select *,(select upa.contactEmail from userpersonaldata upa where upa.iduserData=(select personalDetailsId from users where businessId=? and role='ADMIN' )) as employerEmail from users u, userpersonaldata up, lch_business bus, addressinfo a where u.login=? and u.personalDetailsId = up.iduserdata and bus.businessId= u.businessId and up.myaddressid=a.idAddressInfo";
	static final String SESSION_UPDATE_SQL = "select usersTable.approvalstatus as approvalstatus, usersTable.businessId as businessId, usersTable.isEmailValidated as isEmailValidated, usersTable.clientId as clientId, usersTable.idUser as userId, usersTable.login as userName, usersTable.role as role, usersTable.timeSheetConfiguredTo as timeSheetConfiguredTo, userPersonalDataTable.firstName as firstName, userPersonalDataTable.categoryId as categoryId, lchBusinessTable.isValidated as isValidated, lchBusinessTable.businessName as employerName, usersTable.personalDetailsId,userPersonalDataTable.contactEmail as employeeEmail from users usersTable, userpersonaldata userPersonalDataTable, lch_business lchBusinessTable where usersTable.idUser=? and usersTable.personalDetailsId = userPersonalDataTable.iduserdata and lchBusinessTable.businessId= usersTable.businessId and usersTable.approvalstatus=1";
	static final String SEARCHOPTIONSFOREMPLOYEE = "retriveUserSearchDetails";
	static final String CLIENTWORKINGFORLIST = "select distinct(clientsList.clientName) clientWorkingFor from users u, userclientslist clientsList where u.businessId=? and clientsList.clientId=u.clientId and u.role<>'ADMIN'";
	static final String CITYLIST = "select distinct(a.city) from users u, userpersonaldata up, addressinfo a where u.businessId=? and u.personalDetailsId=up.iduserData and u.role<>'ADMIN' and a.idAddressInfo=up.myaddressId";
	static final String COUNTRYLIST = "select distinct(a.country) from users u, userpersonaldata up, addressinfo a where u.businessId=? and u.personalDetailsId=up.iduserData and u.role<>'ADMIN' and a.idAddressInfo=up.myaddressId";
	static final String STATELIST = "select distinct(a.state) from users u, userpersonaldata up, addressinfo a where u.businessId=? and u.personalDetailsId=up.iduserData and u.role<>'ADMIN' and a.idAddressInfo=up.myaddressId";
	static final String INSERTHRS = "insert into weeklyhrs (  weekNumber ,  weekStartDate,  weekEndDate,  SUNDAY,  MONDAY,  TUESDAY,  WEDNESDAY,  THURSDAY,  FRIDAY,  SATURDAY,  submissionType,  year,  idUser,  idBusiness,  total,  month, submissionConfiguredTo, submissionFor, weeklyHrsSummaryId) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	static final String INSERT_WEEKLY_HRS_SUMMARY = "insert into weeklyhrssummary (  userId ,  businessId,  month,  year,  totalHrsSubmitted,  status,  totalRegularHrs,  totalOvertimeHrs,  submittedDate, clientId, submissionConfiguredTo, submissionFor,totalHolidayHrs,startWeekDate,endWeekDate, categoryId, hasOnlyMonthlyHours) values (:userId,:businessId,:month,:year,:totalHrsSubmitted,:status,:totalRegularHrs,:totalOvertimeHrs,:submittedDate, :clientId, :submissionConfiguredTo, :submissionFor, :totalHolidayHrs, :startWeekDate, :endWeekDate, :categoryId, :hasOnlyMonthlyHours)";
	static final String UPDATE_MONTHLY_HRS_SUMMARY = "UPDATE weeklyhrssummary set status=:status, actionDate=:actionDate, comments=:comments where userId=:userId and businessId=:businessId and weeklyHrsSummaryId=:weeklyHrsSummaryId";

	static final String GET_ADMIN_SETTINGS = "select * from adminsettings where businessId=?";
	static final String INSERT_TIME_SHEET_CONFIGURATION = "INSERT INTO `adminsettings` (`businessId`,`name`,`value`) VALUES (:businessId,:name,:value)";
	static final String INSERT_ADMIN_SETTING = "INSERT INTO `adminsettings` (`businessId`,`name`,`value`) VALUES (:businessId,:name,:value)";
	static final String UPDATE_TIME_SHEET_CONFIGURATION = "update adminsettings set value=? where name=? and businessId=?";
	static final String GET_ADMIN_TIME_SHEET_CONFIG_VALUE= "select value from adminsettings where businessId=? and name=?";
	
	// Business Registration Process - begin
	static final String INSERTADDRESS = "INSERT INTO `addressinfo` (`address1`,`address2`,`city`,`state`,`country`,`zipcode`,`landmark`) VALUES (:address1,:address2,:city,:state,:country,:zip,:landMark)";
	static final String INSERTLCH_BUSINESS = "INSERT INTO `lch_business` (`businessName`,`businessAddressId`,`websiteURL`,`registeredByUserId`,`isValidated`) VALUES (:businessName,:businessAddressId,:websiteURL,:registeredByUserId,:isValidated)";
	static final String INSERTUSERPERSONALDATA = "INSERT INTO `userpersonaldata` (`firstName`,`lastName`,`middleName`,`clientAddressId`,`myAddressId`,`contactEmail`,`phoneNumber`,`fatherName`,`countryCitizenship`,`homeCountryAddressId`,`profilePath`,`gendar`, `dob`,`categoryId`) VALUES (:firstName,:lastName,:middleName,:clientAddressId,:myAddressId,:contactEmail,:phoneNumber,:fatherName,:countryCitizenship,:homeCountryAddressId,:profilePath,:gendar, :dobDate, :categoryId)";
	static final String INSERTUSER = "INSERT INTO `users` (`login`,`password`,`isPwdChangeRequired`,`expairyDate`,`registeredDate`,`businessId`,`role`,`personalDetailsId`,`clientId`,`timeSheetConfiguredTo`) VALUES (:login, MD5(:password),:isPwdChangeRequired,:expairyDate,:registeredDate,:businessId,:role,:personalDetailsId,:clientId, :timeSheetConfiguredTo)";
	static final String INSERTUSER_WITH_APPROVAL_STATUS = "INSERT INTO `users` (`login`,`password`,`isPwdChangeRequired`,`expairyDate`,`registeredDate`,`businessId`,`role`,`personalDetailsId`,`clientId`,`approvalStatus`,`isEmailValidated`,`timeSheetConfiguredTo`) VALUES (:login,MD5(:password),:isPwdChangeRequired,:expairyDate,:registeredDate,:businessId,:role,:personalDetailsId,:clientId,:approvalStatus, :isEmailValidated, :timeSheetConfiguredTo)";
	static final String INSERT_USER_CLIENTS_LIST = "INSERT INTO `userclientslist` (`clientName`,`isCurrent`,`startDate`,`expectedEndDate`,`actualEndDate`) VALUES (:clientName,:isCurrent,:startDate,:expectedEndDate,:actualEndDate)";
	// Business Registration Process - end

	// LIST ALL EMPLOYEES - BEGIN
	static final String LISTALLEMPLOYEES = " select *," + "(SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs,'  --  ',startWeekDate,'-',endWeekDate) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=u.idUser)) as recentHrs, " + "(select concat(address1,', ',address2,', ',city,', ',state,', ',zipcode)  from addressinfo a where a.idAddressInfo=up.clientAddressId) as cleintAddress, " + "(select concat(address1,', ',address2,', ',city,', ',state,', ',zipcode)  from addressinfo a where a.idAddressInfo=up.myAddressId) as personalAddress " + "from (users u, userpersonaldata up, userclientslist cl) left join immigrationdetails i on (u.iduser=i.userId) where u.personalDetailsId=up.iduserData and u.businessId=? and u.role='MEMBER' AND cl.clientId=u.clientId";
	static final String LISTALLEMPLOYEES_ID_NAME = "select iduser, firstName from userpersonaldata up, users u where u.businessid = ? and u.personalDetailsId = up.iduserData and  u.role='MEMBER'";
	// LIST ALL EMPLOYEES - END

	//static final String LIST_BUSINESSES = "select l.businessId, l.businessName, count(u.iduser) noOfEmployees, v.contactEmail, v.phoneNumber, u.approvalStatus from lch_business l, users u, userpersonaldata v where u.role='ADMIN' and l.businessId=u.businessId and u.personalDetailsId=v.iduserData  group by l.businessId";
	//static final String LIST_BUSINESSES ="select l.businessId, l.businessName, up.contactEmail, up.phoneNumber, u.approvalStatus, count(1) noOfEmployees from  users u join  lch_business l on u.businessId = l.businessId join  userpersonaldata up on u.iduser = up.iduserData and u.role in ('MEMBER') group by businessId";
	static final String LIST_BUSINESSES ="Select l.businessId, l.businessName, v.contactEmail, v.phoneNumber, u.iduser, u.role, u.approvalStatus,(Select count(*) from users u where u.businessId=l.businessId and u.role in('MEMBER')) noOfEmployees from lch_business l, users u, userpersonaldata v where l.businessId=u.businessId and u.personalDetailsId=v.iduserData and u.role in('ADMIN')";
	static final String LIST_MY_EMPLOYEE_EMAILS = "select  up.contactEmail from users u, userpersonaldata up where u.businessId = ? and u.personalDetailsId = up.idUserData and u.role='MEMBER'";
	static final String LIST_MY_ENABLED_EMPLOYEE_EMAILS = "select  up.contactEmail from users u, userpersonaldata up where u.businessId = ? and u.personalDetailsId = up.idUserData and u.approvalStatus=1";
	static final String LIST_MY_ENABLED_EMPLOYEE_EMAILS_BY_TIME_SHEET_CONFIGURATION = "select  up.contactEmail from users u, userpersonaldata up where u.businessId = ? and u.personalDetailsId = up.idUserData and u.approvalStatus=1 and u.timeSheetConfiguredTo=?";
	static final String LIST_MY_ENABLED_EMPLOYEE_EMAILS_BY_CATEGORY = "select  up.contactEmail from users u, userpersonaldata up, categories c where u.businessId = ? and u.personalDetailsId = up.idUserData and u.approvalStatus=1 and c.idcategories=up.categoryId and  up.categoryId=?";
	static final String LIST_EMPLOYEES_FOR_TREE = "select u.iduser as id, (select concat(up.firstName,' ',up.lastName,' - ', ucl.clientName)) as text from users u, userpersonaldata up, userclientslist ucl where u.businessId = ? and u.personalDetailsId = up.idUserData and u.role='MEMBER' and ucl.clientId = u.clientId";
	
	static final String BUSINESS_NAME = "select businessName from lch_business where businessId=?";
	static final String CHECK_USR_AVAILABLITY = "select count(1) from users usersTable where login=?";
	static final String CHECK_EMAILCONTENT_NAME_AVAILABILITY = "select count(1) from timercontents where contentName=?";
	static final String CHECK_EMAIL_AVAILABITY = "select count(1) from userpersonaldata u where contactEmail=?";
	static final String USER_COUNT_BY_EMAIL_FOR_TEST = "select count(1) from users u, userpersonaldata up where u.personalDetailsId=up.iduserData and u.login=? and up.contactEmail=?";
	static final String RESET_FORGOT_PASSWORD = "update users u, userpersonaldata up set u.password=MD5(?) where u.personalDetailsId=up.iduserData and up.contactEmail=?;";
	static final String USER_COUNT_BY_SUPERADMIN = "select count(1) from users u where role='SUPERADMIN'";
	static final String USER_COUNT_BY_DEMO_EMPLOYER = "select count(1) from users u where role='ADMIN' and login='ilchemployer@gmail.com'";
	static final String USER_COUNT_BY_DEMO_EMPLOYEE = "select count(1) from users u where role='MEMBER' and login in ('employeeWeekly', 'employeeMonthly', 'employeeBiWeekly', 'employeeDays15')";
	static final String USER_COUNT = "select count(1) from users";
	static final String USER_COUNT_BY_BUSINESSID = "select count(1) from users u where u.businessId=? and u.approvalStatus=1 and u.role='MEMBER'";
	static final String ACTIVE_ADMIN_USER_ID = "select iduser from users u where u.businessId=? and u.approvalStatus=1 and u.role='ADMIN'";
	static final String BUSINESS_DETAILS_BY_USER = "select  l.*,u.*, up.* from lch_business l, userpersonaldata up, users u where up.iduserData = u.personalDetailsId and u.businessId = (SELECT businessId FROM users u where iduser = ?) and u.role='ADMIN' and l.businessId=u.businessId";
	static final String BUSINESS_DETAILS_BY_BUSINESS_USER_ITSELF = "select l.*,u.*, up.* from lch_business l, users u ,userpersonaldata up where l.businessId=u.businessId and u.businessId = ? and (u.role = 'ADMIN' OR u.role = 'CHILDADMIN') and up.iduserData = u.personalDetailsId and u.idUser= ?";
	static final String BUSINESS_DETAILS_BY_BUSINESS_ID = "select l.*,u.*, up.* from lch_business l, users u ,userpersonaldata up where l.businessId=u.businessId and l.businessId = ? and u.businessId=? and u.personalDetailsId=up.iduserData and u.role = 'ADMIN'";
	static final String BUSINESS_ADDRESS_BY_BUSINESS_ID = "select af.* from addressinfo af,lch_business l where l.businessId = ? and l.businessAddressId = af.idAddressInfo";
	static final String GET_CONTACT_EMAIL_FOR_ADMIN_ = "select contactEmail from users u,  userpersonaldata up  where u.businessId=? and u.role='ADMIN' and up.iduserData = u.personalDetailsId";
	static final String GET_SUPER_CONTACT_EMAIL_FOR_ADMIN = "select contactEmail from users u,  userpersonaldata up  where u.businessId=? and u.role='SUPERADMIN' and up.iduserData = u.personalDetailsId";
	//static final String VALIDATE_BUSINESS = "update lch_business SET isValidated=1 where businessId=?";
	static final String VALIDATE_BUSINESS = "update users set isEmailValidated = 1 where businessId =? and role = 'ADMIN'";
	static final String APPROVE_BUSINESS_USER_BY_ADMIN = "update users set isEmailValidated = 1, approvalStatus = 1 where idUser =?";
	//static final String PENDING_USER_BY_ADMIN = "update users set approvalStatus = 0 where idUser =?";
	static final String CHNAGE_EMPLOYER = "update users set businessId=?, approvalStatus=2  where idUser=?";
	static final String VALIDATE_USER_EMAIL = "update users set isEmailValidated = 1 where idUser =?";

	// TIMER - BEGIN
	static final String LIST_TIMERS = "select * from scheduledtimers b,timercontents br where br.userId=? and br.businessId=? and br.contentId=b.contentId";
	static final String LIST_DELETABLE_EMAIL_CONTENTS = "select t.* from timercontents t left join  scheduledtimers s on (t.contentId = s.contentId) where t.userId=? and t.businessId=? and s.contentId is null";
	static final String LIST_NON_DELETABLE_EMAIL_CONTENTS = "select t.* from timercontents t inner join  scheduledtimers s on (t.contentId = s.contentId) where t.userId=? and t.businessId=?";
	static final String GET_TIMER_BY_ID = "select * from scheduledtimers b,timercontents br where br.contentId=b.contentId and b.timerId=?";
	static final String GET_TIMER_CONTENT_DETAILS_BY_ID = "select * from timercontents br where br.contentId=?";
	static final String DELETE_TIMER_BY_ID = "delete from scheduledtimers where timerId=?";
	static final String DELETE_EMAIL_CONTENT_BY_ID = "delete from timercontents where contentId=?";
	static final String CHECK_TIMER_STATUS = "select b.status from scheduledtimers b,timercontents br where b.timerId=? and  br.userId=? and br.businessId=? and br.contentId=b.contentId ";
	static final String UPDATE_TIMER_STATUS = "update scheduledtimers b set b.status=:status where b.timerId=:timerId";
	static final String DELETE_TIMER = "delete b.* from scheduledtimers b,timercontents br  where br.userId=:userId and br.businessId=:businessId and br.contentId=b.contentId and b.timerId=:timerId";
	static final String GET_TIMER_CONTENT_FOR_UPDATE = "select b.*,e.emailReminderType,br.contentName from scheduledtimers b,timercontents br,emailremindertypes e where br.userId=:userId and br.businessId=:businessId and br.contentId=b.contentId and b.timerTypeId=e.emailReminderTypeId and b.timerId=:timerId";
	static final String UPDATE_TIMER_ATTACHEMENT = "update timercontents set attachmentId=? where contentId=?";
	static final String UPDATE_TIMER_EMAIL_CONTENTS = "update timercontents set emailContent=?, contentName=?, dateCreated=?, signature=?, subject=? where contentId=?";

	static final String LIST_TIMER_TYPES = "SELECT * FROM emailremindertypes e";
	static final String GET_TIMER_CONTENT_FOR_NOTIFICATION = "select br.emailContent,br.attachment,br.signature from timercontents br where br.contentId=? and br.businessId=?";
	static final String LIST_TIMER_CONTENTS = "SELECT * FROM timercontents b where b.businessId=?";
	static final String CREATE_TIMER = "INSERT INTO `scheduledtimers` (`contentId`,`cronExpression`,`userId`,`dateCreated`,`timerName`,`status`) VALUES (:contentId,:cronExpression,:userId,:dateCreated,:timerName,:status)";
	static final String CREATE_TIMER_CONTENT = "INSERT INTO `timercontents` (`emailContent`,`contentName`,`userId`,`dateCreated`,`signature`,`businessId`,`subject`) VALUES (:emailContent,:contentName,:userId,:dateCreated,:signature,:businessId,:subject)";
	static final String UPDATE_TIMER_STATUS_BY_USER = "update scheduledtimers b set b.status=:status where b.userid=:userid";
	static final String SELECT_ADMIN_IDUSER_BY_BUSINESSID = "select u.iduser from users u where u.role='ADMIN' and u.businessId=?";
	static final String CHECK_SCHEDULE_TIMERNAME_AVAILABLITY = "select count(1) from scheduledtimers schedTimersTable where schedTimersTable.timerName = ?";
	// TIMER - END

	static final String LIST_NEWS = "SELECT message FROM news";
	static final String LIST_COUNTRIES = "SELECT name FROM country";

	// TIMESHEET PENDING APPROVALS - BEGIN
	// static final String EMPLOYEE_TIMESHEET_PENDING_APPROVALS_4_ADMIN =
	// "SELECT upd.firstName, upd.middleName, upd.lastName, clientsList.clientName clientWorkingFor,w.supportingDocIds,w.totalHrsSubmitted submittedHrs, w.weeklyHrsSummaryId, w.month, w.year, w.totalRegularHrs, w.totalHolidayHrs, w.totalOvertimeHrs, w.startWeekDate, w.endWeekDate, w.submissionFor, w.status, u.idUser userId, u.timeSheetConfiguredTo timeSheetConfiguredTo FROM weeklyhrssummary w, users u, userpersonaldata upd, userclientslist clientsList where w.businessId=? and u.idUser=w.userId and upd.iduserData=u.personalDetailsId and w.status='PENDING' and clientsList.clientId=u.clientId";
	static final String EMPLOYEE_TIMESHEET_PENDING_APPROVALS_4_ADMIN = "SELECT upd.firstName, upd.middleName, upd.lastName, clientsList.clientName clientWorkingFor,w.supportingDocIds,w.totalHrsSubmitted submittedHrs, w.weeklyHrsSummaryId, w.hasOnlyMonthlyHours, w.month, w.year, w.totalRegularHrs, w.totalHolidayHrs, w.totalOvertimeHrs, w.startWeekDate, w.endWeekDate, w.submissionFor, w.status, u.idUser userId, u.clientId clientId, w.submissionConfiguredTo timeSheetConfiguredTo, w.hasOnlyMonthlyHours FROM weeklyhrssummary w, users u, userpersonaldata upd, userclientslist clientsList where w.businessId=? and u.idUser=w.userId and upd.iduserData=u.personalDetailsId and w.status='PENDING' and clientsList.clientId=w.clientId";
	static final String LIST_EMPLOYEE_TIMESHEETS_FOR_ADMIN = "SELECT upd.firstName, upd.middleName, upd.lastName, clientsList.clientName clientWorkingFor,w.supportingDocIds,w.totalHrsSubmitted submittedHrs, w.weeklyHrsSummaryId, w.month, w.year, w.totalRegularHrs, w.totalHolidayHrs, w.totalOvertimeHrs, w.startWeekDate, w.endWeekDate, w.submissionFor, w.status, u.idUser userId, u.clientId clientId, u.timeSheetConfiguredTo timeSheetConfiguredTo, w.hasOnlyMonthlyHours FROM weeklyhrssummary w, users u, userpersonaldata upd, userclientslist clientsList where w.businessId=? and u.idUser=w.userId and upd.iduserData=u.personalDetailsId and clientsList.clientId=w.clientId and u.idUser=? and w.status<>'PENDING' and w.status<>'SAVEDASDRAFT'";
	// TIMESHEET PENDING APPROVALS - END

	static final String LIST_EMPLOYEE_TIMESHEETS = "SELECT c.clientName, w.*,(SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs,'  --  ',startWeekDate,' : ',endWeekDate) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=u.idUser)) as recentHrs FROM weeklyhrssummary w, users u, userclientslist c where w.userId = u.idUser and w.clientId = c.clientId and w.userId = ? and w.status<>'SAVEDASDRAFT'";
	static final String LIST_EMPLOYEE_CONDITIONAL_TIMESHEETS = "SELECT c.clientName, w.*, (SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs,'  --  ',startWeekDate,'-',endWeekDate) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=u.idUser)) as recentHrs FROM weeklyhrssummary w, users u, userclientslist c where w.userId = u.idUser and u.clientId = c.clientId and w.userId = ? and w.status = ?";

	static final String LIST_WEEKLY_SUMMARY_HRS = "SELECT * FROM weeklyhrssummary where weeklyHrsSummaryId = ?";
	//static final String LIST_USER_RATE_DETAILS = "select clientsList.clientId as clientId, clientsList.clientName, (SELECT a.userActualRate FROM useraccounts a where a.userId=:userId and a.businessId=:businessId) userActualRate,(SELECT a.userGivenRate FROM useraccounts a where a.userId=:userId and a.businessId=:businessId) userGivenRate from users users,userpersonaldata userpersonaldataTable,userclientslist clientsList where users.idUser=:userId and users.personalDetailsId = userpersonaldataTable.idUserdata and users.role<>'ADMIN' and users.businessId=:businessId and clientsList.clientId=users.clientId and clientsList.isCurrent='true'";
	static final String INSERT_USER_ACCOUNTS = "INSERT INTO `useraccounts` (`userId`,`userActualRate`,`userGivenRate`,`userRateTypeId`,`userClientId`,`businessId`) VALUES (:userId,:userActualRate,:userGivenRate,:userRateTypeId,:userClientId,:businessId)";
	static final String INSERT_FILE_DETAILS = "INSERT INTO `attacheddocs` (`userId`,`businessId`,`docType`,`docAPath`,`docRPath`,`attachedDate`,`docName`,`docSavedName`) VALUES (:userId,:businessId,:docType,:docAPath,:docRPath,:attachedDate,:docName,:docSavedName)";
	static final String INSERT_DOCS_ATTACHED = "insert into `docsattched` (`docName`,`doc`,`dateAttached`) values (?,?,?)";
	// static final String INSERT_DOCS_FOR_SUPPORTING =
	// "INSERT INTO `docsforsupporting` (  `userId`,  `docIds` ,  `docTypeId` ,  `businessId`) values (:userId,:docIds,:docTypeId,:businessId)";
	static final String LIST_BUSINESS_USER_EMAIL_IDS = "select * from lch_business bus,users users, userpersonaldata u where users.personalDetailsId = u.iduserData and users.idUser=? and users.businessId = bus.businessId";
	static final String GET_USER_EMAIL_ID = "select contactEmail from users users, userpersonaldata u where users.personalDetailsId = u.iduserData and users.idUser=?";
	static final String GET_EMAIL_VERIFICATION_STATUS= "select isEmailValidated from users users, userpersonaldata u where users.personalDetailsId = u.iduserData and users.idUser=?";
	static final String GET_BUSINESS_EMAIL_VERIFICATION_STATUS= "select isEmailValidated from users users, userpersonaldata u where users.personalDetailsId = u.iduserData and users.idUser= (select idUser from users where role=? and businessId =?)";
	static final String GET_USER_DISPLAY_NAME = "select concat(firstName, lastName) from users users, userpersonaldata u where users.personalDetailsId = u.iduserData and users.idUser=?";
	// static final String LIST_USER_ALREDAY_SUBMITTED_HRS =
	// "SELECT count(1) FROM weeklyhrssummary w where w.userId=? and w.businessId=? and w.year=? and w.month=? and w.totalHrsSubmitted is not null";
	static final String LIST_USERS_WHO_SUBMITTED_HRS = "SELECT * FROM weeklyhrssummary w where w.userId=? and w.businessId=? and w.year=? and w.month=? and w.totalHrsSubmitted is not null and w.submissionConfiguredTo=?";
	static final String LIST_USERS_WHO_SUBMITTED_HRS_WEEKLY = "SELECT * FROM weeklyhrssummary w where w.userId=? and w.businessId=? and w.startWeekDate=? and w.endWeekDate=? and w.totalHrsSubmitted is not null and w.submissionConfiguredTo=?";
	static final String UPDATE_WEEKLY_HRS_SUMMARY = "update weeklyhrssummary w set w.supportingDocIds=? where weeklyHrsSummaryId=?";
	static final String GET_SUPPORTINGDOCS_WEEKLY_HRS_SUMMARY = "select supportingDocIds from weeklyhrssummary w where w. weeklyHrsSummaryId=?";
	static final String GET_USER_PERSONAL_DATA = "SELECT * FROM userpersonaldata u where u.iduserData=?";
	static final String GET_USER_PERSONAL_DATA_BY_USER_ID = "SELECT * FROM userpersonaldata u, users us where u.iduserData=us.personalDetailsId and us.iduser=?";
	static final String GET_CLIENT_DETAILS = "select cl.* from userclientslist cl  where (select clientId from users where iduser=?) = cl.clientId";

	static final String LIST_BUSINESS_USERS_PENDING_APPROVALS = "select * from lch_business bus,users users, userpersonaldata u,userclientslist clientsList  where clientsList.clientId=users.clientId and clientsList.isCurrent='true' and users.personalDetailsId = u.iduserData and users.businessId = bus.businessId and bus.businessId=? and users.approvalStatus in (0)";

	static final String UPDATE_USRPERSONALDATA_USR_PROFILE_ATTACHED_DOC_IDS = "update userpersonaldata up, users u set up.profilePath=? where up.iduserData=u.personalDetailsId and u.iduser=?";
	static final String UPDATE_LCH_BUSINESS_LOGO_AND_PROFILE = "update lch_business set logo=?, businessProfile=? where businessId=?";
	static final String UPDATE_LCH_BUSINESS_LOGO = "update lch_business set logo=? where businessId=?";
	static final String UPDATE_LCH_BUSINESS_PROFILE = "update lch_business set businessProfile=? where businessId=?";

	// REPORT DOWNLOADING - BEGIN

	static final String DOWNLOADALLEMPLOYEES = " select *," + "(SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=u.idUser)) as recentHrs, " + "(select concat(address1,', ',address2,', ',city,', ',state,', ',zipcode)  from addressinfo a where a.idAddressInfo=up.myAddressId) as personalAddress " + "from users u, userpersonaldata up, userclientslist cl where u.personalDetailsId=up.iduserData and u.businessId=? and u.role<>'ADMIN' AND cl.clientId=u.clientId";

	// static final String DOWNLOADALLEMPLOYEES =
	// "select * from users ut, userclientslist clientsList, userpersonaldata upt, addressinfo at , (SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs,'  --  ',startWeekDate,'-',endWeekDate) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=ut.iduser)) as recentHrs  where clientsList.clientId=ut.clientId and ut.personalDetailsId=upt.iduserData and upt.myAddressId=at.idAddressInfo and ut.businessId=? and role<>'ADMIN'";
	static final String EMPLOYEESUBMITHOURSMONTHLY = "select up.firstName,up.middleName,up.lastName,uc.clientName,w.totalHrsSubmitted,w.month,w.year from userpersonaldata up,users u,userclientslist uc,weeklyhrssummary w where w.clientId=uc.clientId and uc.clientId=u.clientId and u.personalDetailsId=up.iduserData and u.businessId=?";
	static final String EMPLOYEE_LIST_BASED_EXPERTISE = "select up.firstName,up.lastName,a.address1,a.address2,a.city,a.state,a.country,a.zipcode,a.landmark from userpersonaldata up,users u,addressinfo a where u.personalDetailsId=up.iduserData and up.myAddressId=a.idaddressInfo and u.businessId=? ";
	static final String SEARCH_DOWNLOAD_MONTHLY_HRS = "select up.firstName,up.middleName,up.lastName,uc.clientName,w.totalHrsSubmitted,w.month,w.year from userpersonaldata up,users u,userclientslist uc,weeklyhrssummary w where w.clientId=uc.clientId and uc.clientId=u.clientId and u.personalDetailsId=up.iduserData and u.businessId=? and u.iduser=? ";
	static final String EMPLOYEE_LIST_BASED_EXPERIANCE = "select up.firstName,up.middleName,up.lastName from userpersonaldata up,users u where u.personalDetailsId=up.iduserData  and u.businessId=?  order by totalYearsOfExperiance DESC";
	static final String EMPLOYEESUBMITHRSWEEKLY = "select up.firstName,up.middleName,up.lastName,uc.clientName,w.total,w.weekNumber,w.month,w.year from userpersonaldata up,users u,userclientslist uc,weeklyhrs w where  uc.clientId=u.clientId and u.personalDetailsId=up.iduserData and u.businessId=?";
	// REPORT DOWNLOADING - END

	// TO FETCH EMPLOYEE PERSONAL DETAILS FOR UPDATION - BEGIN
	static final String FETCH_EMPLOYEE_PERSONAL_ADDRESS = "select af.* from addressinfo af,userpersonaldata up,users u where af.idAddressInfo= up.myAddressId and u.personalDetailsId=up.iduserData and u.iduser=? and u.businessId=?";
	static final String FETCH_EMPLOYEE_CLIENT_ADDRESS = "select af.* from addressinfo af,userpersonaldata up,users u where af.idAddressInfo= up.clientAddressId and u.personalDetailsId=up.iduserData and u.iduser=? and u.businessId=?";
	static final String FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS = "select af.* from addressinfo af,userpersonaldata up,users u where af.idAddressInfo= up.homeCountryAddressId and u.personalDetailsId=up.iduserData and u.iduser=? and u.businessId=?";
	static final String FETCH_EMPLOYEE_PERSONAL_DETAILS = "select up.*,u.businessId as businessId from userpersonaldata up,users u where u.personalDetailsId=up.iduserData and u.iduser=? and u.businessId=?";
	static final String FETCH_EMPLOYEE_CLIENT_DETAILS = "select * from userclientslist clientList, users usersTable where  usersTable.clientId= clientList.clientId and clientList.isCurrent='true' and usersTable.idUser=? and usersTable.businessId=?";
	static final String FETCH_BUSINESS_NAME = "select businessName from lch_business lb, users u where u.businessId=lb.businessId and u.iduser=? and u.businessId=?";

	static final String UPDATE_STARTDATE = "update userclientslist uc,users u set uc.startDate=:startDate ,uc.clientName=:clientName where u.clientId= uc.clientId and u.iduser=:userId and u.businessId=:businessId";
	static final String UPDATE_ADDRESS = "UPDATE addressinfo af SET af.address1=:address1, af.address2=:address2, af.city=:city, af.state=:state, af.country=:country, af.zipcode=:zip where af.idAddressInfo=:idAddressInfo";
	static final String UPDATE_PERSONAL = "update userpersonaldata up,users u set u.timeSheetConfiguredTo =:timeSheetConfiguredTo, up.firstName=:firstName, up.middleName=:middleName, up.lastName=:lastName,  up.contactEmail=:contactEmail,up.phoneNumber=:phoneNumber,up.fatherName=:fatherName,up.countryCitizenship=:countryCitizenship,up.dob=:dob where up.iduserData=u.personalDetailsId and u.iduser=:userId and u.businessId=:businessId";
	// TO FETCH EMPLOYEE PERSONAL DETAILS FOR UPDATION - END

	static final String UPDATE_CLIENTID_IN_USRES_TABLE = "update users u,userpersonaldata up set u.clientId=:clientId,up.clientAddressId=:clientAddressId where up.iduserData=u.personalDetailsId and u.iduser=:userId and u.businessId=:businessId";

	// static final String FETCH_EMPLOYEE_RESUME =
	// "select docsList.doc doc, docsList.docName docName from userpersonaldata up,users u,docsattched docsList where u.personalDetailsId=up.iduserData and  u.iduser=? and u.businessId=? and up.profilePath = docsList.attachedDocId";
	static final String LIST_TIMESHEET_ATTACHED_DOC_IDS = "SELECT supportingDocIds FROM weeklyhrssummary w where w.weeklyHrsSummaryId=?";
	static final String LIST_TIMESHEET_ATTACHED_DOC_PATH = "SELECT * FROM attacheddocs a where idattacheddocs in ";
	static final String GET_ATTACHED_DOC = "SELECT * FROM attacheddocs a where idattacheddocs=? ";
	//static final String LIST_ALL_ATTACHED_DOCS_USER = "SELECT * FROM attacheddocs a where businessId=? and userId=? ";
	static final String LIST_ALL_ATTACHED_DOCS_USER = "SELECT a.*, MONTHNAME(STR_TO_DATE(w.month + 1, '%m')) as month FROM attacheddocs a LEFT JOIN weeklyhrssummary w ON a.userId = w.userid AND FIND_IN_SET(a.idattacheddocs,REPLACE(w.supportingDocIds, '''', '')) <> 0 ";
	static final String LIST_ALL_TIMESHEETS_USER = "SELECT * FROM weeklyhrssummary where businessId=? and userId=? ";
	static final String LIST_EMPLOYEE_RESUMES = "SELECT * FROM attacheddocs a where a.businessId=? and a.userId=? and docType='UserProfile'";
	static final String LIST_EMPLOYEE_PROFILE_DETAILS = "SELECT * FROM attacheddocs a where a.idattacheddocs = ?";
	static final String LIST_EMPLOYEE_IMMIGRATION_DETAILS = "SELECT * FROM immigrationdetails a where a.userId = ?";
	static final String INSERTUSERCONTACTDATA = "INSERT INTO `usercontactdata` (`firstName`,`lastName`,`company`,`address`,`city`,`state`,`zip`,`phone`,`email`,`subject`,`comment`) VALUES (:firstName,:lastName,:company,:address,:city,:state,:zip,:phone,:email,:subject,:comment)";

	static final String ACTIVATE_DEACTIVATE_BUSINESS = "update users set approvalStatus=? where businessId=?";

	static final String APPROVE_OR_REJECT_EMPLOYEE_REGISTRATION = "update users set approvalStatus=? where idUser=?";
	static final String DEACTIVATE_EMPLOYEE = "update users set approvalStatus=?, businessId=? where idUser=?";
	static final String GET_CURRENT_USER_RATE = "SELECT rate FROM userrate where userId=? and businessId=? and clientId=?";
	static final String GET_TIME_SHEET_USER_RATE = "SELECT userRate FROM weeklyhrssummary where weeklyHrsSummaryId=?";
	static final String GET_COUNT_CURRENT_USER_RATE = "SELECT count(1) FROM userrate where userId=? and businessId=? and clientId=?";
	static final String INSERT_USE_RATE = "INSERT INTO `userrate` (`userId`, `clientId`, `businessId`, `rate`) VALUES (?,?, ?, ?)";
	static final String UPDATE_USER_RATE = "update userrate u set u.rate=? where u.userId=? and u.clientId=? and u.businessId=?";
	static final String UPDATE_TIMESHEET_SUMMARY_RATE = "update weeklyhrssummary u set u.userRate=? where u.weeklyHrsSummaryId = ?";
	
	static final String APPROVE_OR_REJECT_EMPLOYEE_TIMESHEET = "UPDATE weeklyhrssummary set status=?, actionDate=? where weeklyHrsSummaryId=?";
	static final String LIST_INVESTMENT_TYPES = "select * from bus_investmenttypeonemployee b";
	static final String LIST_USER_EMAILS = "SELECT contactEmail FROM userpersonaldata p, users u where u.personalDetailsId = p.iduserData and u.iduser in ";
	static final String LIST_USER_EMAILS_BY_WEEKLYHRSIDS = "SELECT contactEmail FROM userpersonaldata p, users u, weeklyhrssummary w where u.personalDetailsId = p.iduserData and u.iduser = w.userId and weeklyHrsSummaryId in ";
	static final String FETCH_INVESTMENTDATE_AMOUNT = "SELECT ie.invstedDate,ie.amount from investedamountonemp ie,users u,bus_investmenttypeonemployee bi where u.iduser=ie.userId  and bi.idbus_investmentonEmployee=ie.investmentTypeId and bi.idbus_investmentonEmployee=? and u.role='ADMIN' and u.iduser=? and u.businessId=?";
	static final String UPDATE_INVESTED_AMOUNT_ON_EMPLOYEE = "update investedamountonemp ie,bus_investmenttypeonemployee bi,users u set ie.invstedDate=:investedDate,ie.amount=:amount where u.iduser=ie.userId and ie.investmentTypeId=bi.idbus_investmentonEmployee and bi.idbus_investmentonEmployee=:investmentType and u.role='ADMIN' and u.iduser=:userId and u.businessId=:businessId";
	static final String LIST_EMPLOYEE_HISTORY = "select address.*, (a.userActualRate*sum(totalHrsSubmitted)) as actualIncome, (a.userGivenRate*sum(totalHrsSubmitted)) as subtractableIncome, u.startDate, u.actualEndDate, u.clientName, w.clientId, w.userId, sum(totalHrsSubmitted) as totalHrsSubmitted from weeklyhrssummary w, userclientslist u, useraccounts a, addressinfo address, userpersonaldata upd, users users where w.userId =? and u.clientId = w.clientId and w.businessId=? and a.userClientId=w.clientId and users.personalDetailsId = upd.idUserData and upd.clientAddressId = address.idAddressInfo group by clientId";
	static final String GET_CLIENT_NAME = "select clientsList.clientName from userclientslist clientsList where clientsList.clientId=? ";

	static final String FETCH_UPDATE_CLIENT = "SELECT clientsList.clientName,af.*,clientsList.startDate	FROM userclientslist clientsList, addressinfo af, userpersonaldata pdata, users users where pdata.iduserdata = users.personalDetailsId and pdata.clientAddressId = af.idAddressInfo and users.idUser = ? and users.clientId = clientsList.clientId and users.businessId =?";
	static final String FETCH_CLIENTSLIST_OF_A_BUSINESS = "SELECT clientsList.clientName FROM userclientslist clientsList , userpersonaldata pdata, users users where pdata.iduserdata = users.personalDetailsId and users.clientId = clientsList.clientId and users.businessId =? group by clientsList.clientName";
	static final String UPDATE_CLIENT_DATA = "update userclientslist uc, users u set uc.startDate=:startDate where uc.clientId=u.clientId and u.iduser=:userId and u.businessId=:businessId";

	static final String FETCH_FORGOT_PASSWORD = "SELECT MD5(password) FROM userpersonaldata u, users uu where u.contactEmail=? and uu.personalDetailsId=u.iduserData";
	static final String USER_COUNT_BY_EMAIL = "SELECT count(1) FROM userpersonaldata u, users uu where u.contactEmail=? and uu.personalDetailsId=u.iduserData";
	static final String EMPLOYER_COUNT_BY_BUSINESS_ID = "select count(*) from lch_business where businessId=? and isValidated=1";
	static final String GET_VALIDATED_BUSINESS_NAME_BY_ID = "select businessName from lch_business where businessId=? and isValidated=1";
	
	static final String ENABLE_AN_EMPLOYEE = "update users u set u.approvalStatus=1 where u.role='MEMBER' and u.iduser=:userId and u.businessId=:businessId";
	static final String DISABLE_AN_EMPLOYEE = "update users u set u.approvalStatus=3 where u.role='MEMBER' and u.iduser=:userId and u.businessId=:businessId";
	static final String FETCH_BUSINESS_ADMINS = "SELECT * from userpersonaldata up,users u where u.personalDetailsId=up.iduserData and u.role='CHILDADMIN' and u.businessId=? and approvalStatus not in (3)";
	static final String UPDATE_MEMBER_DETAILS = "update userpersonaldata up,users u set up.firstName=:firstName, up.gendar=:gendar, up.middleName=:middleName, up.lastName=:lastName, up.phoneNumber=:phoneNumber,up.fatherName=:fatherName,up.countryCitizenship=:countryCitizenship, u.timeSheetConfiguredTo=:timeSheetConfiguredTo where up.iduserData=u.personalDetailsId and u.iduser=:userId and u.businessId=:businessId";
	static final String FETCH_EMPLOYEE_PROFILE_DETAILS = "select up.firstName,up.lastname,up.middlename,up.phoneNumber,up.contactEmail,up.gendar,up.fatherName,up.countryCitizenship, u.timeSheetConfiguredTo  from userpersonaldata up,users u where u.personalDetailsId=up.iduserData and u.role='MEMBER'and u.iduser=? and u.businessId=? ";

	static final String KILL_BUSINESS_ACCOUNT = "update users u set u.approvalStatus=3 where u.iduser=? and u.businessId=?";
	static final String GET_PASSWORD_FOR_AN_ACCOUNT = "select MD5(u.password),up.contactEmail from users u,userpersonaldata up where u.personalDetailsId=up.iduserData and u.iduser=? and u.businessId=?";
	static final String RESET_ACCOUNT_PASSWORD = "update users u set u.password=MD5(:password) where u.iduser=:userId and u.businessId=:businessId";
	

	static final String SAVE_EXCEPTION_TRACE = "insert into `exceptiontrace` (`exception`,`exceptionMessage`,`occuredDateTime`) values (:exception,:exceptionMessage,:occuredDateTime)";
	static final String GET_LOGGEDIN_USER_BUSINESS_LOGO_PATH = "SELECT concat(d.docRPath,'/',d.docSavedName) FROM attacheddocs d, lch_business b where d.businessId =b.businessId and d.docType ='BusinessLogo' and b.businessId=? and b.logo = d.idattacheddocs";

	// Time Sheet Data Delete - Begin
	static final String DELETE_MONTHLY_HRS_SUMMARY = "DELETE FROM weeklyhrssummary where userId=:userId and year=:year and month=:month and businessId=:businessId  and startWeekDate=:startWeekDate and submissionConfiguredTo=:submissionConfiguredTo";
	static final String SELECT_MONTHLY_HRS_SUMMARY = "SELECT weeklyHrsSummaryId FROM weeklyhrssummary where userId=:userId and year=:year and month=:month and businessId=:businessId  and startWeekDate=:startWeekDate and submissionConfiguredTo=:submissionConfiguredTo";
	//static final String DELETE_WEEKLY_HRS = "DELETE FROM weeklyhrs where idUser=:userId and year=:year and month=:month and idBusiness=:businessId and submissionConfiguredTo=:submissionConfiguredTo";
	static final String DELETE_WEEKLY_HRS = "DELETE FROM weeklyhrs where weeklyHrsSummaryId = ?";
	//static final String DELETE_WEEKLY_HRS_BY_WEEK_START_DATE = "DELETE FROM weeklyhrs where idUser=:userId and year=:year and month=:month and idBusiness=:businessId and weekStartDate=:weekStartDate and submissionConfiguredTo=:submissionConfiguredTo";
	//static final String DELETE_WEEKLY_HRS_DAYS15 = "DELETE FROM weeklyhrs where idUser=:userId and year=:year and month=:month and idBusiness=:businessId and submissionFor=:submissionFor and submissionConfiguredTo=:submissionConfiguredTo";
	// Time Sheet Data Delete - End
	static final String GET_SUMMARY_HRS_BY_ID = "SELECT *  FROM weeklyhrssummary where weeklyHrsSummaryId =?";
	static final String GET_SUMMARY_HRS = "SELECT status FROM weeklyhrssummary where userId=? and  businessId=? and year=? and month= ? and submissionConfiguredTo=? and startWeekDate=? and totalHrsSubmitted is not null";
	// static final String GET_WEEKDAYS_HRS =
	// "SELECT weekNumber, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY FROM weeklyhrs where idUser =? and year =? and month =? and submissionType =?";
	// static final String GET_WEEKLY_HRS =
	// "SELECT SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY FROM weeklyhrs where idUser=? and year=? and submissionType=? and weekStartDate=? ";
	// static final String GET_HALF_OF_MONTH_HRS =
	// "SELECT weekNumber, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY FROM weeklyhrs where idUser = ?  and year = ?  and month = ?  and submissionType = ?  and weekNumber in (?)";
	// static final String GET_HALF_OF_MONTH_HRS =
	// "SELECT weekNumber, SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY FROM weeklyhrs where idUser = :idUser  and year = :year  and month = :month  and submissionType = :submissionType  and weekNumber in (:weekNumber)";
	static final String GET_HALF_OF_MONTH_HRS = "SELECT * FROM weeklyhrs where idUser = :idUser  and year = :year  and month = :month and  submissionFor = :submissionFor and weekNumber in (:weekNumber)";
	static final String GET_MONTHLY_SUBMITTED_HRS = "SELECT * FROM weeklyhrs where idUser =? and year =? and month =?";
	static final String GET_WEEKLY_SUBMITTED_HRS = "SELECT * FROM weeklyhrs where idUser=? and year=? and weekStartDate=? ";
	static final String GET_BI_WEEKLY_SUBMITTED_HRS = "SELECT * FROM weeklyhrs where idUser=? and year=? and weekStartDate in (?,?) ";

	static final String DELETE_ADDRESS_FOR_APPROVAL_REJECTED_EMPLOYEES = "delete from addressinfo where idAddressInfo in ((select up.clientAddressId from users u, userpersonaldata up where u.businessId=? and u.approvalStatus =2 and up.idUserData = u.personalDetailsId), (select up.myAddressId from users u, userpersonaldata up where u.businessId=? and u.approvalStatus =2 and up.idUserData = u.personalDetailsId), (select up.homeCountryAddressId from users u, userpersonaldata up where u.businessId=? and u.approvalStatus =2 and up.idUserData = u.personalDetailsId))";
	static final String DELETE_USER_PERSONAL_DETAILS_FOR_APPROVAL_REJECTED_EMPLOYEES = "delete from userpersonaldata where idUserData in (select personalDetailsId from users u where u.businessId=? and u.approvalStatus =2)";
	static final String DELETE_USER_FOR_APPROVAL_REJECTED_EMPLOYEES = "delete from users where businessId=? and approvalStatus =2";

	static final String LIST_BDAY_USERS = "SELECT * FROM userpersonaldata up, users u where dob = ? and isBdayWished <> 1  and u.personalDetailsId = up.iduserData and u.approvalStatus =1 and u.role<>'SUPERADMIN'";
	static final String RESET_BDAY_REMINDERS = "update userpersonaldata u set u.isbdayWished=0";
	static final String UPDATE_BDAY_REMINDER_BY_BUSINESS = "update userpersonaldata up, users u set up.isbdayWished=1 where u.personalDetailsId = up.iduserData and u.businessId=?";

	static final String LIST_SUPER_SETTINGS = "SELECT * FROM supersettings";
	static final String REMOVE_SUPER_SETTINGS = "delete FROM supersettings where type=?";
	static final String REMOVE_RESUMES = "delete FROM attacheddocs where userId = ? and docType='UserProfile'";
	static final String INSERTSUPERSETTINGS = "INSERT INTO `supersettings` (`info`, `type`) VALUES (?,?)";
	static final String INSERT_LOG = "INSERT INTO `log` (`log`, `logType`) VALUES (?,?)";
	static final String EMAIL_SENT_COUNT = "select count(*) from log where logType='"+BaseAction.LOGTYPE.EMAIL+"'";
	static final String RESET_LOGO = "update lch_business l SET l.logo=? where l.businessId=?";
	static final String TEST_BUSINESS_USER_ID = "SELECT businessId FROM lch_business l where businessName = 'AlliBilli'";
	static final String TEST_BUSINESS_USER_ID_SUPER_ADMIN = "SELECT businessId FROM lch_business l where businessName = 'SuperAdmin' and websiteURL='http://www.runningticker.com'";
	static final String DELETE_LOGO = "delete from attacheddocs where docType=? and businessId=? and userId=?";
	static final String DELETE_SUPPORTING_DOC = "delete from attacheddocs where idattacheddocs=?";
	
	
	static final String INSERT_IMMIGRATION_DETAILS = "INSERT INTO `immigrationdetails` (`visaType`,`passportExpiryDate`,`visaIssuedDate`,`visaExpiryDate`,`passportIssueDate`,`passportNumber`,`userId`) VALUES (:visaType,:passportExpiryDate,:visaIssuedDate,:visaExpiryDate,:passportIssueDate,:passportNumber,:userId)";
	static final String UPDATE_IMMIGRATION_DETAILS = "update immigrationdetails i set i.visaType=:visaType,i.passportExpiryDate=:passportExpiryDate,i.visaIssuedDate=:visaIssuedDate,i.visaExpiryDate=:visaExpiryDate,i.passportIssueDate=:passportIssueDate,i.passportNumber=:passportNumber where i.userId=:userId";
	static final String COUNT_IMMIGRATION_USER = "select count(1) from immigrationdetails where userId=?";
	static final String LIST_IMMIGRATION_USER = "select * from immigrationdetails where userId=?";

	static final String INSERT_SKILLTAGS_DETAILS = "INSERT INTO `skillTags` (`tags`,`userId`) VALUES (:tags,:userId)";
	static final String UPDATE_SKILLTAGS_DETAILS = "update skillTags i set i.tags=:tags where i.userId=:userId";	
	static final String LIST_SKILLTAGS_USER = "select * from skillTags where userId=?";
	static final String COUNT_SKILLTAGS_USER = "select count(1) from skillTags where userId=?";
	static final String LIST_MY_EMPLOYEE_EMAILS_HAVING_IMMIGRATION_DETAILS = "select  * from (users u, userpersonaldata up) left join immigrationdetails i on(u.iduser = i.userId) where u.businessId = ? and u.personalDetailsId = up.idUserData and u.role='MEMBER' and i.idimmigrationdetails is not null";
	static final String LIST_MY_EMPLOYEE_EMAILS_NOT_HAVING_IMMIGRATION_DETAILS = "select  * from (users u, userpersonaldata up) left join immigrationdetails i on(u.iduser = i.userId) where u.businessId = ? and u.personalDetailsId = up.idUserData and u.role='MEMBER' and i.idimmigrationdetails is null";
	
	//static final String FETCH_BUSINESS_CATEGORIES = "select c.*,count(u.iduserData) as numberOfEmployees from categories c, userpersonaldata u where c.idcategories = u.categoryId and c.businessId=? group by c.name";
	
	static final String FETCH_BUSINESS_CATEGORIES = "select c.*, (select count(1) from userpersonaldata where categoryId = c.idcategories) as numberOfEmployees from categories c where c.businessId=? group by c.idcategories";
	static final String UPDATE_BUSINESS_CATEGORIY = "update categories b set b.name=:name, b.description=:description where idcategories=:idcategories";
	static final String ADD_BUSINESS_CATEGORIY = "INSERT INTO `categories` (`name`,`description`,`businessId`) values (:name,:description,:businessId)";
	//static final String DELETE_CATEGORIY = "delete from categories where idcategories=?";
	//static final String LIST_ALL_EMPLOYEES= "select  * from users u, userpersonaldata up where u.businessId = 5 and u.personalDetailsId = up.idUserData and u.role='MEMBER';";
	static final String LIST_ALL_EMPLOYEES= "select  * from users u, userpersonaldata up left outer join categories c on c.idcategories = up.categoryId where u.businessId = ? and u.personalDetailsId = up.idUserData and u.role='MEMBER'";
	static final String GET_CATEGORY_DETAILS= "select * from categories where idcategories=?";
	static final String GET_SYSTEM_DEFAULT_CATEGORY_DETAILS= "select idcategories from categories where businessId=? and name='SystemDefault'";
	//static final String LIST_ALL_CATEGORY_TIMESEETS_AND_EMPLOYEES= "select s.status, s.submissionFor, w.weekNumber, w.SUNDAY,w.MONDAY,w.TUESDAY,w.WEDNESDAY,w.THURSDAY,w.FRIDAY,w.SATURDAY, s.categoryId, u.iduser,  cl.clientName, w.weekStartDate, w.weekEndDate, s.totalRegularHrs, s.totalHrsSubmitted, s.totalOvertimeHrs, s.totalHolidayHrs, concat(up.firstName, ' ', up.lastName) as name from userclientslist cl, weeklyhrs w, weeklyhrssummary s, users u, userpersonaldata up left outer join categories c on c.idcategories = up.categoryId where u.businessId = ? and u.personalDetailsId = up.iduserData and u.role='MEMBER' and w.idUser = u.iduser and s.userId = u.iduser and s.clientId = cl.clientId and w.month in (?, ?) and w.year in (?,?)";
	//static final String LIST_ALL_CATEGORY_TIMESEETS_AND_EMPLOYEES= "select s.status, w.submissionType, w.submissionType, s.submissionFor, w.SUNDAY,w.MONDAY,w.TUESDAY,w.WEDNESDAY,w.THURSDAY,w.FRIDAY,w.SATURDAY, s.categoryId, u.iduser, up.iduserdata, cl.clientName, w.weekStartDate, w.weekEndDate,	s.totalRegularHrs, s.totalHrsSubmitted, s.totalOvertimeHrs, s.totalHolidayHrs, concat(up.firstName, ' ', up.lastName) as name from categories c, userclientslist cl, userpersonaldata up, users u, weeklyhrs w left outer join weeklyhrssummary s on w.weeklyHrsSummaryId = s.weeklyHrsSummaryId where w.idUser =u.iduser and c.idcategories = s.categoryId and cl.clientId = u.clientId and u.role='MEMBER' and u.personalDetailsId = up.iduserData and w.month in (?,?) and w.year in (?,?) and u.businessId = ?";
	static final String LIST_ALL_CATEGORY_TIMESEETS_AND_EMPLOYEES="select s.status, w.submissionType, s.submissionFor, w.SUNDAY,w.MONDAY,w.TUESDAY,w.WEDNESDAY,w.THURSDAY,w.FRIDAY,w.SATURDAY, s.categoryId, u.iduser,	up.iduserdata, cl.clientName, w.weekStartDate, w.weekEndDate, s.totalRegularHrs, s.totalHrsSubmitted, s.totalOvertimeHrs, s.totalHolidayHrs, concat(up.firstName, ' ', up.lastName) as name from categories c, users u, userpersonaldata up, userclientslist cl, weeklyhrssummary s	right join weeklyhrs w on w.weeklyHrsSummaryId = s.weeklyHrsSummaryId where s.status<>'SAVEDASDRAFT' and c.idcategories = s.categoryId and u.idUser = w.idUser and u.personalDetailsId = up.iduserData and cl.clientId = s.clientId and w.month in (?,?) and w.year in (?,?) and w.idBusiness=?";
	static final String LIST_ALL_CATEGORY_TIMESEETS_AND_EMPLOYEES_SPECIFIC_TO_USER= LIST_ALL_CATEGORY_TIMESEETS_AND_EMPLOYEES + " and u.idUser= ?";

}