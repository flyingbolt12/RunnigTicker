package com.lch.spring.BusinessComponents;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.struts.upload.FormFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.core.support.SqlLobValue;
import org.springframework.jdbc.object.SqlFunction;
import org.springframework.jdbc.object.SqlUpdate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.jdbc.support.lob.DefaultLobHandler;
import org.springframework.jdbc.support.lob.LobHandler;

import com.lch.general.constants.GeneralConstants;
import com.lch.general.dbBeans.ATTACHEDDOCS;
import com.lch.general.dbBeans.Address;
import com.lch.general.dbBeans.TimerContents;
import com.lch.general.dbBeans.ScheduledTimers;
import com.lch.general.dbBeans.DBConstants;
import com.lch.general.dbBeans.DOCSFORSUPPORTING;
import com.lch.general.dbBeans.ExceptionTrace;
import com.lch.general.dbBeans.LCH_BUSINESS;
import com.lch.general.dbBeans.USERACCOUNTS;
import com.lch.general.dbBeans.USERCLIENTSLIST;
import com.lch.general.dbBeans.USERPERSONALDATA;
import com.lch.general.dbBeans.USERS;
import com.lch.general.enums.DOCTypes;
import com.lch.general.enums.SubmissionFor;
import com.lch.general.enums.TimeSheetStatus;
import com.lch.general.enums.TimeSheetTypes;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.genericUtils.BiWeeklyTimeSheetHours;
import com.lch.general.genericUtils.DateUtils;
import com.lch.general.genericUtils.Days15TimeSheetHours;
import com.lch.general.genericUtils.MonthlyTimeSheetHours;
import com.lch.general.genericUtils.SubMissionType;
import com.lch.general.genericUtils.TimeSheetHours;
import com.lch.general.genericUtils.WeekToWeekDates;
import com.lch.general.genericUtils.WeeklyTimeSheetHours;
import com.lch.spring.SQLQueries;
import com.lch.struts.formBeans.ContactBean;
import com.lch.struts.formBeans.admin.AdminRegistrationBean;
import com.lch.struts.formBeans.admin.AdminTimerBean;
import com.lch.struts.formBeans.admin.CreateAnotherAdminBean;
import com.lch.struts.formBeans.members.AddAnEmployeeBean;
import com.lch.struts.formBeans.members.EmployeeRegistrationBean;

@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
public class DoTransaction {
	private static Logger log = LoggerFactory.getLogger(DoTransaction.class);
	JdbcTemplate jdbcTemplate;
	NamedParameterJdbcTemplate namedParameterJdbcTemplate;

	public void setAllUsersToValid() {
		if (getUserCount()>6)
		{
			log.error("Many Users Available and not safe to set all of them to valid...So ignoring this operation");
			return ;
		}
		log.info("Updating All users to Valid");
		try {
			SqlFunction sf = new SqlFunction(getJdbcTemplate().getDataSource(), "select makeAllUsersValid() from dual");
			sf.compile();
			sf.run();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Integer disableBusiness(long businessId) {
		log.info("disableBusiness and all users");
		try {

			SimpleJdbcCall funcGetActorName = new SimpleJdbcCall(jdbcTemplate).withFunctionName("disableBusiness");

			SqlParameterSource in = new MapSqlParameterSource().addValue("busId", businessId);
			Integer count = funcGetActorName.executeFunction(Integer.class, in);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public void enbleBusinessForTestingPurpose() {
		log.info("enbleBusinessForTestingPurpose");
		try {
			SqlFunction sf = new SqlFunction(getJdbcTemplate().getDataSource(), "select enbleBusinessForTestingPurpose() from dual");
			sf.compile();
			sf.run();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public long insertADDRESSINFO(Address address) {
		log.info("Start Doing Transaction - Address");
		long addressId = -1;
		KeyHolder keyHolder = new GeneratedKeyHolder();
		SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(address);
		getNamedParameterJdbcTemplate().update(SQLQueries.INSERTADDRESS, parametersSource, keyHolder);
		addressId = keyHolder.getKey().intValue();

		return addressId;
	}

	public long insertLCH_BUSINESS(AdminRegistrationBean adminRegistrationBean, UserProfile profile) {
		long businessId = -1;
		try {
			log.info("Start Doing Transaction - Business");
			LCH_BUSINESS lchBusiness = new LCH_BUSINESS();
			BeanUtils.copyProperties(lchBusiness, adminRegistrationBean);
			lchBusiness.setRegisteredByUserId(profile.getUserId());
			businessId = insertLCH_BUSINESS(lchBusiness);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return businessId;
	}

	public long insertLCH_BUSINESS(LCH_BUSINESS lchBusiness) {
		long businessId = -1;
		try {
			log.info("Start Doing Transaction - Business");
			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(lchBusiness);
			getNamedParameterJdbcTemplate().update(SQLQueries.INSERTLCH_BUSINESS, parametersSource, keyHolder);
			businessId = keyHolder.getKey().intValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return businessId;
	}

	// public long insert_DOCS_FOR_SUPPORTING(DOCSFORSUPPORTING
	// docsforsupporting) {
	// long supportingDocId = -1;
	// try {
	// log.info("Start Doing Transaction - DOCS_FOR_SUPPORTING");
	// KeyHolder keyHolder = new GeneratedKeyHolder();
	// SqlParameterSource parametersSource = new
	// BeanPropertySqlParameterSource(docsforsupporting);
	// getNamedParameterJdbcTemplate().update(SQLQueries.INSERT_DOCS_FOR_SUPPORTING,
	// parametersSource, keyHolder);
	// supportingDocId = keyHolder.getKey().intValue();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// return supportingDocId;
	// }

	public long insertUSERPERSONALDATA(AdminRegistrationBean adminRegistrationBean, UserProfile profile) {
		long userId = -1;
		try {

			log.info("Start Doing Transaction - User Personal Details");
			USERPERSONALDATA userPersonalData = new USERPERSONALDATA();
			BeanUtils.copyProperties(userPersonalData, adminRegistrationBean);

			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			Date date = (Date) formatter.parse(adminRegistrationBean.getDob());
			Timestamp s = new Timestamp(date.getTime());
			userPersonalData.setDobDate(s);

			userId = insertUSERPERSONALDATA(userPersonalData);

		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insertUSERPERSONALDATA(CreateAnotherAdminBean adminRegistrationBean, UserProfile profile) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - USERS PERSONAL - ADMIN");
			USERPERSONALDATA userPersonalData = new USERPERSONALDATA();
			BeanUtils.copyProperties(userPersonalData, adminRegistrationBean);
			DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			if(adminRegistrationBean.getDob()!=null && adminRegistrationBean.getDob().trim().length() > 0){
				Date date = (Date) formatter.parse(adminRegistrationBean.getDob());
				Timestamp s = new Timestamp(date.getTime());
				userPersonalData.setDobDate(s);
			}
			userId = insertUSERPERSONALDATA(userPersonalData);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insertUSERPERSONALDATA(USERPERSONALDATA userPersonalData) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - USERS PERSONAL ");

			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(userPersonalData);
			getNamedParameterJdbcTemplate().update(SQLQueries.INSERTUSERPERSONALDATA, parametersSource, keyHolder);
			userId = keyHolder.getKey().intValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insertUSERS(AdminRegistrationBean adminRegistrationBean, UserProfile profile) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - Users");

			USERS users = new USERS();

			BeanUtils.copyProperties(users, adminRegistrationBean);
			userId = insertUSERSWithApprovalStatus(users);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insertUSERS(CreateAnotherAdminBean adminRegistrationBean, UserProfile profile) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - Users - Another Admin");

			USERS users = new USERS();

			BeanUtils.copyProperties(users, adminRegistrationBean);
			userId = insertUSERSWithApprovalStatus(users);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insert_USER_CLIENTS_LIST(EmployeeRegistrationBean employeeRegistrationBean) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - Address");

			USERCLIENTSLIST userClientsList = new USERCLIENTSLIST();
			BeanUtils.copyProperties(userClientsList, employeeRegistrationBean);
			userClientsList.setIsCurrent("true");
			userId = insert_USER_CLIENTS_LIST(userClientsList);

		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insert_USER_CLIENTS_LIST(AddAnEmployeeBean addAnEmployeeBean) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - Address");

			USERCLIENTSLIST userClientsList = new USERCLIENTSLIST();
			BeanUtils.copyProperties(userClientsList, addAnEmployeeBean);
			userClientsList.setIsCurrent("true");
			userId = insert_USER_CLIENTS_LIST(userClientsList);

		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insert_USER_CLIENTS_LIST(USERCLIENTSLIST userClientsList) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - USERS");

			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(userClientsList);
			getNamedParameterJdbcTemplate().update(SQLQueries.INSERT_USER_CLIENTS_LIST, parametersSource, keyHolder);
			userId = keyHolder.getKey().intValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long createTimer(AdminTimerBean adminTimerBean, UserProfile profile) {
		long timerId = -1;
		try {
			log.info("Start Doing Transaction - createTimer");

			ScheduledTimers timer = new ScheduledTimers();
			BeanUtils.copyProperties(timer, adminTimerBean);
			Timestamp date = new Timestamp(Calendar.getInstance().getTimeInMillis());
			timer.setDateCreated(date);
			timer.setUserId(profile.getUserId());
			timer.setContentId((adminTimerBean.getContentId()));
			insertTimer(timer);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return timerId;
	}

	public long createTimerContent(AdminTimerBean adminTimerBean, UserProfile profile, String aFilePath, String rFilePath) {
		long contentId = -1;
		try {
			log.info("Start Doing Transaction - createTimer");
			TimerContents emailContent = new TimerContents();
			BeanUtils.copyProperties(emailContent, adminTimerBean);

			emailContent.setBusinessId(profile.getBusinessId());
			emailContent.setUserId(profile.getUserId());
			Timestamp date = new Timestamp(Calendar.getInstance().getTimeInMillis());
			emailContent.setDateCreated(date);
			contentId = insertTimerContent(emailContent);

			if (adminTimerBean.getAttachment() != null && adminTimerBean.getAttachment().getFileSize() > 0)
				handleFileAndUpdateCorrespondingTable(contentId, profile.getUserId(), DOCTypes.TimerAttachement, adminTimerBean.getAttachment(), aFilePath, rFilePath);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return contentId;
	}

	public String convertStringArrayToStringWithCommaDelimetted(String[] stringArray) {
		String excludeuserIdsWithCommaSeperated = "";
		for (int i = 0; i < stringArray.length; ++i) {
			if (i == stringArray.length - 1) {
				excludeuserIdsWithCommaSeperated += stringArray[i];
			} else {
				excludeuserIdsWithCommaSeperated += stringArray[i] + ",";
			}
		}
		return excludeuserIdsWithCommaSeperated;
	}

	public List listTimerContents(UserProfile profile) {
		String query = SQLQueries.LIST_TIMER_CONTENTS;
		return (getJdbcTemplate().queryForList(query, new Object[] { profile.getBusinessId() }));
	}

	public List listBusinessAndUserDetails(long userId) {
		String query = SQLQueries.LIST_BUSINESS_USER_EMAIL_IDS;
		return (getJdbcTemplate().queryForList(query, new Object[] { userId }));
	}
	public String getUserEmail(long userId) {
		String query = SQLQueries.GET_USER_EMAIL_ID;
		return getJdbcTemplate().queryForObject(query, String.class, userId);
	}

	public long insertUSERS(USERS users) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - USERS");

			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(users);
			getNamedParameterJdbcTemplate().update(SQLQueries.INSERTUSER, parametersSource, keyHolder);
			userId = keyHolder.getKey().intValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public long insertUSERSWithApprovalStatus(USERS users) {
		long userId = -1;
		try {
			log.info("Start Doing Transaction - USERS");

			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(users);
			getNamedParameterJdbcTemplate().update(SQLQueries.INSERTUSER_WITH_APPROVAL_STATUS, parametersSource, keyHolder);
			userId = keyHolder.getKey().intValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}

	public List<Map<String, Object>> getAllMyEmployeesList(long businessId, String orderBy, String order) {
		Object[] obj = { new Long(businessId) };
		String query = SQLQueries.LISTALLEMPLOYEES;
		if (orderBy != null) {
			if (orderBy.equalsIgnoreCase("clientName")) {
				query += " order by cl." + orderBy + " " + order;
			} else {
				query += " order by up." + orderBy + " " + order;
			}

		}
		// log.info(query);
		return (getJdbcTemplate().queryForList(query, obj));
	}

	public List getAllMyEmployeesEmails(long businessId) {
		Object[] obj = { new Long(businessId) };
		String query = SQLQueries.LIST_MY_EMPLOYEE_EMAILS;
		log.info("Business Id : {} Query : {}", businessId, query);
		return (getJdbcTemplate().queryForList(query, obj));
	}

	public List getAllMyEnabledEmployeesEmails(long businessId) {
		Object[] obj = { new Long(businessId) };
		String query = SQLQueries.LIST_MY_ENABLED_EMPLOYEE_EMAILS;
		log.info("Business Id : {} Query : {}", businessId, query);
		return (getJdbcTemplate().queryForList(query, obj));
	}

	public List getAllMyEmployeesEmailsByTimeSheetConfiguration(long businessId, String type) {
		Object[] obj = { new Long(businessId), type };
		String query = SQLQueries.LIST_MY_ENABLED_EMPLOYEE_EMAILS_BY_TIME_SHEET_CONFIGURATION;
		log.info("Business Id : {} Query : {}", businessId, query);
		return (getJdbcTemplate().queryForList(query, obj));
	}

	public List listTimerTypes() {
		String query = SQLQueries.LIST_TIMER_TYPES;
		return (getJdbcTemplate().queryForList(query));
	}

	public List<String> listNews() {
		String query = SQLQueries.LIST_NEWS;
		
		int count = countofEmails();
		if(count < 8000)
			count = count+80000;
		String c = count+" emails exchanged...and still counting";
		List<String> list = getJdbcTemplate().queryForList(query,String.class);
		list.add(3,c);
		return list;
	}

	public List<String> listCountries() {
		String query = SQLQueries.LIST_COUNTRIES;
		List<String> list = getJdbcTemplate().queryForList(query,String.class);
		return list;
	}

	public Map<String, Object> loadUserDetailsByLoginName(long id, String login) {
		String query = SQLQueries.LOAD_USER_DETAILS_BY_LOGIN_NAME;
		Map<String, Object> list = getJdbcTemplate().queryForMap(query,new Object[]{id, login});
		
		return list;
	}

	
	public List listEmployeeTimesheetPendingApprovals(UserProfile userProfile) {
		String query = SQLQueries.EMPLOYEE_TIMESHEET_PENDING_APPROVALS_4_ADMIN;
		return (getJdbcTemplate().queryForList(query, new Object[] { userProfile.getBusinessId() }));
	}

	public List listEmployeeTimesheetsForAdmin(UserProfile userProfile, String userId) {
		String query = SQLQueries.LIST_EMPLOYEE_TIMESHEETS_FOR_ADMIN;
		return (getJdbcTemplate().queryForList(query, new Object[] { userProfile.getBusinessId(), userId }));
	}

	public List<Map<String, Object>> listEmployeeTimesheets(long userId) {
		String query = SQLQueries.LIST_EMPLOYEE_TIMESHEETS;
		return (getJdbcTemplate().queryForList(query, new Object[] { userId }));
	}

	public List listEmployeePendingTimesheets(UserProfile userProfile) {
		String query = SQLQueries.LIST_EMPLOYEE_CONDITIONAL_TIMESHEETS;
		return (getJdbcTemplate().queryForList(query, new Object[] { userProfile.getUserId(), "PENDING" }));
	}

	public List listEmployeeRejectTimesheets(UserProfile userProfile) {
		String query = SQLQueries.LIST_EMPLOYEE_CONDITIONAL_TIMESHEETS;
		return (getJdbcTemplate().queryForList(query, new Object[] { userProfile.getUserId(), "REJECTED" }));
	}

	public List listEmployeeApprovedTimesheets(UserProfile userProfile) {
		String query = SQLQueries.LIST_EMPLOYEE_CONDITIONAL_TIMESHEETS;
		return (getJdbcTemplate().queryForList(query, new Object[] { userProfile.getUserId(), "APPROVED" }));
	}

	public List listEmployeeRegistrationPendingApprovals(UserProfile userProfile) {
		String query = SQLQueries.LIST_BUSINESS_USERS_PENDING_APPROVALS;
		return (getJdbcTemplate().queryForList(query, new Object[] { userProfile.getBusinessId() }));
	}

	public List<Map<String, Object>> listEmployeeHistory(long userId, long businessId) {
		String query = SQLQueries.LIST_EMPLOYEE_HISTORY;
		return (getJdbcTemplate().queryForList(query, new Object[] { userId, businessId }));
	}

	public Map<String, Object> getTimerById(long timerId) {
		String query = SQLQueries.GET_TIMER_BY_ID;
		return getJdbcTemplate().queryForMap(query, new Object[] { timerId });
	}

	public Map<String, Object> getTimerContentDetailsById(String contentId) {
		String query = SQLQueries.GET_TIMER_CONTENT_DETAILS_BY_ID;
		return getJdbcTemplate().queryForMap(query, new Object[] { contentId });
	}

	public void updateRequiredDetails(UserProfile userProfile) {
		String query = SQLQueries.GET_CLIENT_NAME;
		long clientId = userProfile.getClientId();
		ArrayList l = new ArrayList();
		l.add(clientId);
		try{
		String clientName = (String) getJdbcTemplate().queryForObject(query, getObjectArray(l.size(), l), String.class);
		userProfile.setCurrentClientName(clientName);
		}catch (EmptyResultDataAccessException e) {
			log.debug("Error updating client name {}", e.getMessage());
		}
	}

	public Map<String, Object> getUserDetails(long personalId) {
		String query = SQLQueries.GET_USER_PERSONAL_DATA;
		return (getJdbcTemplate().queryForMap(query, new Object[] { personalId }));
	}

	public Map<String, Object> getClientDetails(long userId) {
		String query = SQLQueries.GET_CLIENT_DETAILS;
		return (getJdbcTemplate().queryForMap(query, new Object[] { userId }));

	}

	public Map<String, Object> getUserDetailsByUserId(long userId) {
		String query = SQLQueries.GET_USER_PERSONAL_DATA_BY_USER_ID;
		return (getJdbcTemplate().queryForMap(query, new Object[] { userId }));
	}
	
	public int removeResumes(long userId) {
		String query = SQLQueries.REMOVE_RESUMES;
		return (getJdbcTemplate().update(query, new Object[] { userId }));
	}

	public int removeOutage(String type) {
		String query = SQLQueries.REMOVE_SUPER_SETTINGS;
		return getJdbcTemplate().update(query, type);
	}

	public Map<String, Object> updateUserPassword(long userId) {
		String query = SQLQueries.GET_USER_PERSONAL_DATA_BY_USER_ID;
		return (getJdbcTemplate().queryForMap(query, new Object[] { userId }));
	}

	public List<Map<String, Object>> getAllMySearchEmployeesList(long businessId, String orderBy, String order, String sql) {
		Object[] obj = { new Long(businessId) };
		String query = sql;
		String tableName = "userpersonaldataTable.";
		if (orderBy != null) {
			if (orderBy.equalsIgnoreCase("clientName")) {
				tableName = "clientsList.";
			}
			query += " and users.businessId=? and users.role<>'ADMIN' and users.personalDetailsId = userpersonaldataTable.idUserdata and users.clientId=clientsList.clientId order by " + tableName
					+ orderBy + " " + order;
		}
		log.info(query);
		return (getJdbcTemplate().queryForList(query, obj));
	}
	
	public List<Map<String, Object>> getAllBusinessList(){
	
	String query = SQLQueries.LIST_BUSINESSES;
	return (getJdbcTemplate().queryForList(query));
	}
	

	public Map getUserRateDetails(UserProfile userProfile, String userId) {
		Map m = null;
		try {
			UserProfile userProfile2 = new UserProfile();
			BeanUtils.copyProperties(userProfile2, userProfile);
			long userIdInt = Long.parseLong(userId);
			userProfile2.setUserId(userIdInt);
			log.info("Getting the User Rate Details for UserId " + userId);
			SqlParameterSource sqlParameterSource = new BeanPropertySqlParameterSource(userProfile2);
			m = getNamedParameterJdbcTemplate().queryForMap(SQLQueries.LIST_USER_RATE_DETAILS, sqlParameterSource);
		} catch (EmptyResultDataAccessException e) {
			log.warn(e.getMessage());
			m = null;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			m = null;
		}
		return m;
	}

	public List listMyAdmins(UserProfile userProfile) {
		String query = SQLQueries.FETCH_BUSINESS_ADMINS;
		ArrayList l = new ArrayList();
		l.add(userProfile.getBusinessId());
		return (getJdbcTemplate().queryForList(query, getObjectArray(l.size(), l)));
	}

	public int approveUserByAdmin(long userId) {
		int rcdUpdCnt = 0;
		try {
			log.info("Start Doing Transaction - validateBusinessEmail");
			rcdUpdCnt = getJdbcTemplate().update(SQLQueries.APPROVE_BUSINESS_USER_BY_ADMIN, new Object[] { userId });
		} catch (Exception e) {
			rcdUpdCnt = 0;
			e.printStackTrace();
		}
		return rcdUpdCnt;
	}
	public int pendingUserEmployeeChange(long userId, long businessId) {
		int rcdUpdCnt = 0;
		try {
			log.info("Start Doing Transaction - pendingUserEmployeeChange");
			rcdUpdCnt = getJdbcTemplate().update(SQLQueries.CHNAGE_EMPLOYER, new Object[] { businessId, userId });
		} catch (Exception e) {
			rcdUpdCnt = 0;
			e.printStackTrace();
		}
		return rcdUpdCnt;
	}

	public int validateBusinessEmail(long businessId) {
		int rcdUpdCnt = 0;
		try {
			log.info("Start Doing Transaction - validateBusinessEmail {} for {}", businessId, SQLQueries.VALIDATE_BUSINESS);
			rcdUpdCnt = getJdbcTemplate().update(SQLQueries.VALIDATE_BUSINESS, new Object[] { businessId });
		} catch (Exception e) {
			rcdUpdCnt = 0;
			e.printStackTrace();
		}
		return rcdUpdCnt;
	}

	public int validateUserEmail(long userId) {
		int rcdUpdCnt = 0;
		try {
			log.info("Start Doing Transaction - validateUserEmail");
			rcdUpdCnt = getJdbcTemplate().update(SQLQueries.APPROVE_BUSINESS_USER_BY_ADMIN, new Object[] { userId });
		} catch (Exception e) {
			rcdUpdCnt = 0;
			e.printStackTrace();
		}
		return rcdUpdCnt;
	}

	public int validateMemberEmail(long userId) {
		int rcdUpdCnt = 0;
		try {
			log.info("Start Doing Transaction - validateMemberEmail");
			rcdUpdCnt = getJdbcTemplate().update(SQLQueries.VALIDATE_USER_EMAIL, new Object[] { userId });
		} catch (Exception e) {
			rcdUpdCnt = 0;
			e.printStackTrace();
		}
		return rcdUpdCnt;
	}

	public LCH_BUSINESS getBusinessDetails(long businessId, long userId) {
		log.info("Business Id got : " + businessId);
		return (LCH_BUSINESS) getJdbcTemplate().queryForObject(SQLQueries.BUSINESS_DETAILS_BY_BUSINESS_USER_ITSELF, new Object[] { businessId, userId }, new RowMapper() {
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				LCH_BUSINESS businessDetails = new LCH_BUSINESS();
				setBusinessDetails(rs, businessDetails);
				return businessDetails;
			}
		});
	}
	public LCH_BUSINESS getBusinessDetailsByBusiness(final long businessId) {
		log.info("User Id got : {}", businessId);
		return (LCH_BUSINESS) getJdbcTemplate().queryForObject(SQLQueries.BUSINESS_DETAILS_BY_BUSINESS_ID, new Object[] { businessId, businessId }, new RowMapper() {
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				LCH_BUSINESS businessDetails = new LCH_BUSINESS();
				setBusinessDetails(rs, businessDetails);
				return businessDetails;
			}
		});
	}

	private void setBusinessDetails(ResultSet rs, LCH_BUSINESS businessDetails) throws SQLException {
		businessDetails.setBusinessId(rs.getLong(DBConstants.BUSINESS_ID));
		businessDetails.setEmployerEmail((rs.getString(DBConstants.CONTACT_EMAIL)));
		businessDetails.setBusinessAddressId((rs.getString(DBConstants.BUSINESS_ADDRESS_ID)));
		businessDetails.setPhoneNumber((rs.getString(DBConstants.PHONE_NUMBER)));
		businessDetails.setBusinessName((rs.getString(DBConstants.BUSINESS_NAME)));
		businessDetails.setWebsiteURL((rs.getString(DBConstants.WEBSITE_URL)));
	}

	public LCH_BUSINESS getBusinessDetailsByUser(final long userId) {
		log.info("User Id got : {}", userId);
		return (LCH_BUSINESS) getJdbcTemplate().queryForObject(SQLQueries.BUSINESS_DETAILS_BY_USER, new Object[] { userId }, new RowMapper() {
			public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
				LCH_BUSINESS businessDetails = new LCH_BUSINESS();
				setBusinessDetails(rs, businessDetails);
				return businessDetails;
			}
		});
	}

	public int saveBusinessFiles(AdminRegistrationBean adminRegistrationBean) {

		List<FormFile> filesList = new ArrayList<FormFile>();

		if (adminRegistrationBean.getLogo() != null && adminRegistrationBean.getLogo().getFileSize() > 0)
			filesList.add(adminRegistrationBean.getLogo());
		if (adminRegistrationBean.getBusinessProfile() != null && adminRegistrationBean.getBusinessProfile().getFileSize() > 0)
			filesList.add(adminRegistrationBean.getBusinessProfile());

		List<String> colList = new ArrayList<String>();
		colList.add("logo");
		colList.add("businessProfile");

		return uploadFiles2DB(filesList, colList, "lch_business", "businessId", adminRegistrationBean.getBusinessId() + "");
	}

	public void saveExceptionTrace(ExceptionTrace exceptionTrace) {
		log.info("Start Doing Transaction - ExceptionTrace {}", exceptionTrace.getException());
		KeyHolder keyHolder = new GeneratedKeyHolder();
		SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(exceptionTrace);
		getNamedParameterJdbcTemplate().update(SQLQueries.SAVE_EXCEPTION_TRACE, parametersSource, keyHolder);

	}

	public int saveEmployeeProfile(AdminRegistrationBean adminRegistrationBean) {

		List<FormFile> filesList = new ArrayList<FormFile>();

		if (adminRegistrationBean.getBusinessProfile() != null && adminRegistrationBean.getBusinessProfile().getFileSize() > 0)
			filesList.add(adminRegistrationBean.getBusinessProfile());

		List<String> colList = new ArrayList<String>();
		colList.add("profilePath");

		return uploadFiles2DB(filesList, colList, "userpersonaldata", "iduserData", adminRegistrationBean.getPersonalDetailsId() + "");
	}

	public int uploadFiles2DB(List<FormFile> filesList, List<String> colList, String tableName, String whereCndClmName, String whereCndValue) {
		int cnt = 0;
		StringBuilder qry = new StringBuilder("update " + tableName + " set ");
		for (Iterator<String> it = colList.listIterator(); it.hasNext();) {
			cnt++;
			qry.append(it.next() + " = ? ");
			if (cnt < colList.size()) {
				qry.append(", ");
			}
		}
		qry.append(" where " + whereCndClmName + " = " + whereCndValue);
		log.info(qry.toString());
		LobHandler lobHandler = new DefaultLobHandler();
		// reusable object

		/*
		 * Object []params = new Object[filesList.size()]; InputStream is =
		 * null; cnt =-1; for(Iterator<FormFile>
		 * it=filesList.listIterator();it.hasNext();){ cnt++; try{ FormFile file
		 * = it.next(); is = file.getInputStream(); params[cnt]=new
		 * SqlLobValue(is, (file.getFileData()).length, lobHandler); } catch
		 * (Exception e) { e.printStackTrace(); } } cnt=0;
		 * cnt=jdbcTemplate.update(qry.toString(),params);
		 */

		SqlUpdate su = new SqlUpdate(getJdbcTemplate().getDataSource(), qry.toString());
		for (Iterator<String> it = colList.listIterator(); it.hasNext();) {
			String colName = it.next();
			log.info("colName = " + colName);
			su.declareParameter(new SqlParameter(colName, Types.BLOB));
		}
		su.compile();
		log.info("SqlUpdate compiled Successfully.");
		Object[] parameterValues = new Object[colList.size()];
		// parameterValues[0] = new Integer(1);
		cnt = -1;
		InputStream is = null;
		for (Iterator<FormFile> it = filesList.listIterator(); it.hasNext();) {
			cnt++;
			try {
				FormFile file = it.next();
				is = file.getInputStream();
				log.info((file.getFileData()).length + " : " + file.getFileName() + " : " + file.getContentType() + " : " + file.getFileSize());
				parameterValues[cnt] = new SqlLobValue(is, (file.getFileData()).length, lobHandler);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		cnt = 0;
		cnt = su.update(parameterValues);
		log.info("No of records effected in uploadFiles2DB : " + cnt);

		return cnt;
	}

	private boolean saveFile(String fileName, String filePath, byte[] fileData) {

		log.info("Saving file {} at {}", fileName, filePath);

		try {

			File theDir = new File(filePath);

			if (!theDir.exists()) {
				log.info("creating directory: {}", filePath);
				boolean result = theDir.mkdir();
				if (!result) {
					log.error("Unable to create a directory");
				}
			}

			File fileToCreate = new File(filePath, fileName);

			//if (!fileToCreate.exists()) {

				FileOutputStream fileOutStream = new FileOutputStream(fileToCreate);

				fileOutStream.write(fileData);
				fileOutStream.flush();

				fileOutStream.close();

				return true;
			//}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean handleFileAndUpdateCorrespondingTable(long businessId, long userId, DOCTypes docType, final FormFile fileToSave, String aFilePath, String rFilePath) throws Exception {
		int docId = handleFile(businessId, userId, docType.name(), fileToSave, aFilePath, rFilePath);

		if (docId == -1) {
			return Boolean.FALSE;
		}

		switch (docType) {
		case BusinessLogo: {
			update_LCH_BUSINESS_LOGO(businessId, docId);
			break;
		}
		case BusinessProfile: {
			update_LCH_BUSINESS_PROFILE(businessId, docId);
			break;
		}
		case UserProfile: {
			update_USRPERSONALDATA_USR_PROFILE_ATTACHED_DOC_IDS(userId, docId);
			break;
		}
		case TimerAttachement: {
			// business Id used as contentId
			updateTimerContentAttachment(businessId, docId);
			break;
		}
		}
		return Boolean.TRUE;
	}

	public int handleFile(long businessId, long userId, String docType, final FormFile fileToSave, String aFilePath, String rFilePath) {

		int key = -1;

		try {
			if (fileToSave.getFileSize() <= 0)
				return key;

			String savedFileName = businessId + "_" + userId + "_" + docType + "_" + fileToSave.getFileName();
			boolean isFileSaved = saveFile(savedFileName, aFilePath, fileToSave.getFileData());
			if (isFileSaved) {
				ATTACHEDDOCS a = getFileDetails(businessId, userId, aFilePath, rFilePath, fileToSave.getFileName(), docType, savedFileName);
				key = insertFileDetailsIntoDatabase(a);
			}
		} catch (Exception e) {
			log.error("Error Saving File {}", e.getMessage());
			return key;
		}
		return key;
	}

	public int handleSupportingFile(long businessId, long userId, String docType, final byte[] fileToSave, String aFilePath, String rFilePath, String weeklyHrsSummaryId, String fileName)
			throws Exception {

		String savedFileName = Calendar.getInstance().getTimeInMillis() + "_" + businessId + "_" + userId + "_" + weeklyHrsSummaryId + "_" + docType + "_" + fileName;

		boolean isFileSaved = saveFile(savedFileName, aFilePath, fileToSave);
		if (isFileSaved) {
			ATTACHEDDOCS a = getFileDetails(businessId, userId, aFilePath, rFilePath, fileName, docType, savedFileName);
			return insertFileDetailsIntoDatabase(a);
		}
		return -1;
	}

	private ATTACHEDDOCS getFileDetails(long businessId, long userId, String aFilePath, String rFilePath, String fileName, String docType, String savedFileName) {
		ATTACHEDDOCS a = new ATTACHEDDOCS();
		Timestamp t = new Timestamp(Calendar.getInstance().getTimeInMillis());
		a.setAttachedDate(t);
		a.setBusinessId(businessId);
		a.setDocAPath(aFilePath + System.getProperty("file.separator") + savedFileName);
		a.setDocRPath(rFilePath);
		a.setDocName(fileName);
		a.setDocSavedName(savedFileName);
		a.setDocType(docType);
		a.setUserId(userId);

		return a;
	}

	public int insertFileDetailsIntoDatabase(ATTACHEDDOCS attachedDocs) {

		int id = -1;
		try {
			log.info("Start Doing Transaction - Save File Data");

			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(attachedDocs);
			getNamedParameterJdbcTemplate().update(SQLQueries.INSERT_FILE_DETAILS, parametersSource, keyHolder);
			id = keyHolder.getKey().intValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}


	public int resetLogo(long businessId, long userId, DOCTypes docType) throws Exception {
		getJdbcTemplate().update(SQLQueries.DELETE_LOGO, new Object[]{docType.name(),businessId, userId});
		return getJdbcTemplate().update(SQLQueries.RESET_LOGO, new Object[]{"",businessId});
	}
	
	public int deleteSupportingDoc(long idattacheddocs) throws Exception {
		return getJdbcTemplate().update(SQLQueries.DELETE_SUPPORTING_DOC, new Object[]{idattacheddocs});
	}
	
	
	public String uploadSingleFileToDB(final FormFile item, int docType) throws Exception {
		String docIds = "";

		final String name = item.getFileName();
		final Date date = Calendar.getInstance().getTime();

		KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
		getJdbcTemplate().update(new PreparedStatementCreator() {
			public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
				PreparedStatement ps = conn.prepareStatement(SQLQueries.INSERT_DOCS_ATTACHED, Statement.RETURN_GENERATED_KEYS);
				try {
					ps.setString(1, name);
					ps.setObject(2, item.getInputStream());
					ps.setObject(3, date);
				} catch (Exception e) {
					e.printStackTrace();
				}

				return ps;
			}
		}, generatedKeyHolder);

		docIds += String.valueOf(generatedKeyHolder.getKey().intValue()) + ",";

		if (docIds != null && docIds.length() > 0) {
			docIds = docIds.substring(0, docIds.length() - 1);
		}
		log.info("Docs Ids list - uploadFiles2DB : " + docIds);
		return docIds;
	}

	public String uploadFiles2DB(List<DiskFileItem> items, int docType) throws Exception {
		String docIds = "";
		for (int i = 0; i < items.size(); i++) {
			final DiskFileItem item = (DiskFileItem) items.get(i);

			if (!item.isFormField()) {

				final String name = item.getName();
				final Date date = Calendar.getInstance().getTime();
				final ByteArrayInputStream stream = new ByteArrayInputStream(item.get());

				KeyHolder generatedKeyHolder = new GeneratedKeyHolder();
				getJdbcTemplate().update(new PreparedStatementCreator() {
					public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
						PreparedStatement ps = conn.prepareStatement(SQLQueries.INSERT_DOCS_ATTACHED, Statement.RETURN_GENERATED_KEYS);
						ps.setString(1, name);
						ps.setObject(2, stream);
						ps.setObject(3, date);
						return ps;
					}
				}, generatedKeyHolder);

				docIds += String.valueOf(generatedKeyHolder.getKey().intValue()) + ",";
			}
		}

		if (docIds != null && docIds.length() > 0) {
			docIds = docIds.substring(0, docIds.length() - 1);
		}
		log.info("Docs Ids list - uploadFiles2DB : " + docIds);
		return docIds;
	}

	public String getEmployerName(long businessId) {
		String businessName = "";
		businessName = (String) jdbcTemplate.queryForObject(SQLQueries.BUSINESS_NAME, new Object[] { businessId }, String.class);
		return businessName;
	}

	public String getLogoPath(long businessId) throws Exception {

		log.info("Retriving logo path from database {}", businessId);

		String logoName = "";
		logoName = (String) jdbcTemplate.queryForObject(SQLQueries.GET_LOGGEDIN_USER_BUSINESS_LOGO_PATH, new Object[] { businessId }, String.class);
		return logoName;
	}

	public int checkUsrAvailablity(String usrName) {
		int usrCount = 0;
		usrCount = jdbcTemplate.queryForInt(SQLQueries.CHECK_USR_AVAILABLITY, new Object[] { usrName });
		return usrCount;
	}

	public int checkEmailContentNameAvailability(String contentName) {
		int contentNameCount = 0;
		contentNameCount = jdbcTemplate.queryForInt(SQLQueries.CHECK_EMAILCONTENT_NAME_AVAILABILITY, new Object[] { contentName });
		return contentNameCount;
	}

	public int checkUsrEmailAvailablity(String usrEmail) {
		int usrCount = 0;
		usrCount = jdbcTemplate.queryForInt(SQLQueries.CHECK_EMAIL_AVAILABITY, new Object[] { usrEmail });
		return usrCount;
	}

	public NamedParameterJdbcTemplate getNamedParameterJdbcTemplate() {
		return namedParameterJdbcTemplate;
	}

	public void setNamedParameterJdbcTemplate(NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
		this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
	}

	/**
	 * @return Returns the jdbcTemplate.
	 */
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	/**
	 * @param jdbcTemplate
	 *            The jdbcTemplate to set.
	 */
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void updateMonthlySummaryHours(Map sqlParamSource) {
		int count = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_MONTHLY_HRS_SUMMARY, sqlParamSource);
	}

	public void saveMonthlyHours(String regOverHrs[]) {

		int i = regOverHrs.length;
		String[] weekDates = new String[2];
		for (int j = 0; j < i; ++j) {
			String toSave = regOverHrs[j];
			if (toSave != null)
				splitCheckTransact(toSave);
		}
	}

	public void rollback() {
		Connection con = null;
		try {
			log.info("Rollbacking the Transaction");
			con = getJdbcTemplate().getDataSource().getConnection();
			con.rollback();
		} catch (Exception e) {
			log.error("Unable to Rollback");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void commit() {
		Connection con = null;
		try {
			log.info("Commiting the Transaction");
			con = getJdbcTemplate().getDataSource().getConnection();
			con.commit();
		} catch (Exception e) {
			log.error("Unable to Commit");
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void splitCheckTransact(String a) {
		String temp[] = a.split("__");

		Date d1 = new Date();
		Date d2 = new Date();
		try {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			d1 = df.parse(temp[1]);
			d2 = df.parse(temp[2]);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		getJdbcTemplate().update(SQLQueries.INSERTHRS,
				new Object[] { temp[0], d1, d2, temp[3], temp[4], temp[5], temp[6], temp[7], temp[8], temp[9], temp[10], temp[11], temp[12], temp[13], temp[14], temp[15], temp[16], temp[17] });
	}

	/*
	 * public boolean isUser_Alreday_Submit_Hrs_Or_Not(UserProfile userProfile)
	 * { boolean isAlredaySubmit = false; DateUtils du = userProfile.getDu();
	 * 
	 * ArrayList l = new ArrayList(); l.add(userProfile.getUserId());
	 * l.add(userProfile.getBusinessId()); l.add(du.getYear());
	 * l.add(du.getMonth());
	 * 
	 * int count = getJdbcTemplate().queryForInt(
	 * SQLQueries.LIST_USER_ALREDAY_SUBMITTED_HRS, getObjectArray(l.size(), l));
	 * log.info("Count -->" + count);
	 * 
	 * if (count == 1) isAlredaySubmit = true;
	 * 
	 * return isAlredaySubmit; }
	 */

	public List listSubmittedHrs(UserProfile userProfile, TimeSheetTypes timSheetConfigurationType) {
		String weekBeginDate = "";
		String weekEndingDate = "";
		String[] dates;
		DateUtils du = userProfile.getDu();

		ArrayList<String> l = new ArrayList<String>();
		l.add(userProfile.getUserId() + "");
		l.add(userProfile.getBusinessId() + "");
		List r = new ArrayList();
		switch (timSheetConfigurationType) {
		case MONTHLY:
		case DAYS15:
			l.add(du.getYear() + "");
			l.add(du.getMonth() + "");
			l.add(timSheetConfigurationType.name());
			r = (getJdbcTemplate().queryForList(SQLQueries.LIST_USERS_WHO_SUBMITTED_HRS, getObjectArray(l.size(), l)));
			break;
		case WEEKLY:
			dates = WeekToWeekDates.getWeeklyDates(userProfile);
			weekBeginDate = dates[0];
			weekEndingDate = dates[1];

			l.add(weekBeginDate);
			l.add(weekEndingDate);
			l.add(timSheetConfigurationType.name());
			r = (getJdbcTemplate().queryForList(SQLQueries.LIST_USERS_WHO_SUBMITTED_HRS_WEEKLY, getObjectArray(l.size(), l)));
			break;
		case BIWEEKLY:

			dates = WeekToWeekDates.getBiWeeklyDates(userProfile);
			weekBeginDate = dates[0];
			weekEndingDate = dates[1];

			l.add(weekBeginDate);
			l.add(weekEndingDate);
			l.add(timSheetConfigurationType.name());
			r = (getJdbcTemplate().queryForList(SQLQueries.LIST_USERS_WHO_SUBMITTED_HRS_WEEKLY, getObjectArray(l.size(), l)));
			break;
		}

		return r;

	}

	public int getUserCount(String emailId) throws Exception {
		ArrayList params = new ArrayList();
		params.add(emailId);
		return getJdbcTemplate().queryForInt(SQLQueries.USER_COUNT_BY_EMAIL, getObjectArray(params.size(), params));

	}

	public int getEmployerCount(long businessId) throws Exception {
		ArrayList params = new ArrayList();
		params.add(businessId);
		return getJdbcTemplate().queryForInt(SQLQueries.EMPLOYER_COUNT_BY_BUSINESS_ID, getObjectArray(params.size(), params));

	}
	
	public String getValidatedEmployerName(long businessId) throws Exception {
		String employerName = null;
		ArrayList params = new ArrayList();
		params.add(businessId);
		employerName = (String) getJdbcTemplate().queryForObject(SQLQueries.GET_VALIDATED_BUSINESS_NAME_BY_ID, getObjectArray(params.size(), params), String.class);
		return employerName;
	}
	
	
	public String getPassword(String emailId) throws Exception {
		String password = null;
		ArrayList params = new ArrayList();
		params.add(emailId);
		password = (String) getJdbcTemplate().queryForObject(SQLQueries.FETCH_FORGOT_PASSWORD, getObjectArray(params.size(), params), String.class);

		return password;
	}

	public Object[] getObjectArray(int length, List paramsList) {
		Object[] params = new Object[length];
		Iterator it = paramsList.listIterator();
		int index = 0;
		while (it.hasNext()) {
			params[index] = it.next();
			++index;
		}
		return params;
	}

	public int update_USRPERSONALDATA_USR_PROFILE_ATTACHED_DOC_IDS(long userId, int docId) throws Exception {
		ArrayList l = new ArrayList();
		l.add(docId);
		l.add(userId);
		int i = getJdbcTemplate().update(SQLQueries.UPDATE_USRPERSONALDATA_USR_PROFILE_ATTACHED_DOC_IDS, getObjectArray(l.size(), l));
		return i;
	}

	public int update_LCH_BUSINESS_LOGO_AND_PROFILE(long businessId, int supportingLOGODocId, int supportingPROFILEDocId) throws Exception {
		ArrayList l = new ArrayList();
		l.add(supportingLOGODocId);
		l.add(supportingPROFILEDocId);
		l.add(businessId);
		int i = getJdbcTemplate().update(SQLQueries.UPDATE_LCH_BUSINESS_LOGO_AND_PROFILE, getObjectArray(l.size(), l));
		return i;
	}

	public int update_LCH_BUSINESS_LOGO(long businessId, int docId) throws Exception {
		ArrayList l = new ArrayList();
		l.add(docId);
		l.add(businessId);
		int i = getJdbcTemplate().update(SQLQueries.UPDATE_LCH_BUSINESS_LOGO, getObjectArray(l.size(), l));
		return i;
	}

	public int update_LCH_BUSINESS_PROFILE(long businessId, int docId) throws Exception {
		ArrayList l = new ArrayList();
		l.add(docId);
		l.add(businessId);
		int i = getJdbcTemplate().update(SQLQueries.UPDATE_LCH_BUSINESS_PROFILE, getObjectArray(l.size(), l));
		return i;
	}

	public int updateTimerContentAttachment(long contentId, int docId) throws Exception {
		ArrayList l = new ArrayList();
		l.add(docId);
		l.add(contentId);
		int i = getJdbcTemplate().update(SQLQueries.UPDATE_TIMER_ATTACHEMENT, getObjectArray(l.size(), l));
		return i;
	}
	
	
	public int updateTimerEmailContent(final TimerContents bean) throws Exception {
		int i = getJdbcTemplate().update(SQLQueries.UPDATE_TIMER_EMAIL_CONTENTS, new Object[]{bean.getEmailContent(),bean.getContentName(),bean.getDateCreated(),bean.getSignature(), bean.getSubject(), bean.getContentId() });
		return i;
	}
	
	
	public int update_DOCSIDS_WEEKLYHRS_SUMMARY(String weeklyHrsSummaryId, String supportingDocId) {

		ArrayList l = new ArrayList();
		l.add(supportingDocId);
		l.add(weeklyHrsSummaryId);
		int i = getJdbcTemplate().update(SQLQueries.UPDATE_WEEKLY_HRS_SUMMARY, getObjectArray(l.size(), l));
		return i;
	}

	public String getSupporting_DOCSIDS_WEEKLYHRS_SUMMARY(String weeklyHrsSummaryId) {

		String values = getJdbcTemplate().queryForObject(SQLQueries.GET_SUPPORTINGDOCS_WEEKLY_HRS_SUMMARY, String.class, new Object[] { weeklyHrsSummaryId });
		return values;
	}

	/*
	 * public int downloaded(DownloadedEmployeeBean downloadedEmployeeBean,
	 * UserProfile profile) {
	 * 
	 * try { log.info("Start Doing Transaction - createTimer");
	 * 
	 * DownloadedEmployeeBean bean = new DownloadedEmployeeBean();
	 * BeanUtils.copyProperties(profile, bean); String
	 * startingWithText=(String)bean.getStartingWithText();
	 * log.info(startingWithText); String
	 * endingWithText=(String)bean.getEndingWithText();
	 * log.info(endingWithText); String
	 * startingWith=(String)bean.getLastNameListBox(); log.info(startingWith);
	 * String endingWith=(String)bean.getClientWorkingForListBox();
	 * log.info(endingWith);
	 * 
	 * 
	 * 
	 * 
	 * } catch (Exception e) { e.printStackTrace(); rollback(); } int
	 * businessId; String lastNameBox; String order; return
	 * businessId<businessId>
	 * downloadedAllMyEmployeeList(businessId,lastNameBox,order); }
	 */
	// public long insertUSERCONTACTDATA(ContactBean contactBean, UserProfile
	// profile) {
	// long idusercontact = -1;
	// try {
	// log.info("Start Doing Transaction - Contactdetails");
	//
	// USERCONTACTDATA userContactList = new USERCONTACTDATA();
	// BeanUtils.copyProperties(userContactList, contactBean);
	// userContactList.setIdusercontact(profile.getUserId());
	// idusercontact = insertUSERCONTACTDATA(userContactList);
	//
	// } catch (IllegalAccessException e) {
	// e.printStackTrace();
	// } catch (InvocationTargetException e) {
	// e.printStackTrace();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// return idusercontact;
	// }
	//
	 public int insertUSERCONTACTDATA(ContactBean userContactList) {
	 int idusercontact = -1;
	 try {
	 log.info("Start Doing Transaction - USERCONTACT");
	
	 KeyHolder keyHolder = new GeneratedKeyHolder();
	 SqlParameterSource parametersSource = new
	 BeanPropertySqlParameterSource(userContactList);
	 getNamedParameterJdbcTemplate().update(SQLQueries.INSERTUSERCONTACTDATA,
	 parametersSource, keyHolder);
	 idusercontact = keyHolder.getKey().intValue();
	 } catch (Exception e) {
	 e.printStackTrace();
	 }
	 return idusercontact;
	 }

	public List<Map<String, Object>> downloadAllMyEmployeesList1(String listBox1, String listBox2, String listBox1value, String listBox2value, long businessId) {

		String query = "select (SELECT concat('(T)',totalHrsSubmitted,' / ',' (R) ',totalRegularHrs,' / ', ' (O) ',totalOvertimeHrs,' / ','(H) ',totalHolidayHrs) FROM weeklyhrssummary where weeklyHrsSummaryId=(select max(weeklyHrsSummaryId) from weeklyhrssummary where userId=usersTable.idUser)) as recentHrs, * from  userpersonaldata u ,addressinfo a, users usersTable where u."
				+ listBox1
				+ " LIKE '"
				+ listBox1value
				+ "%' and u."
				+ listBox2
				+ " like '"
				+ listBox2value
				+ "%' and u.myAddressId=a.idAddressInfo and usersTable.businessId="
				+ businessId
				+ " and role<>'ADMIN' and usersTable.personalDetailsId=u.iduserData";
		log.debug("querying for to generate Report of Down all employees{}", query);

		return (getJdbcTemplate().queryForList(query));
	}

	public String getTimesheetSupportingDocId(long id) {
		Object[] obj = new Object[] { id };
		String l = jdbcTemplate.queryForObject(SQLQueries.LIST_TIMESHEET_ATTACHED_DOC_IDS, obj, String.class);
		return l;
	}

	public List listFilePaths(String ids) {

		Object[] obj = new Object[] { ids };
		String query = SQLQueries.LIST_TIMESHEET_ATTACHED_DOC_PATH;
		query = query + " (" + ids + ")";
		log.info("query {}", query);
		List l = jdbcTemplate.queryForList(query);

		log.info("result size {}", l.size());
		return l;
	}

	public List listProfiles(long businessId, long userId) {
		Object[] obj = new Object[] { businessId, userId };
		String query = SQLQueries.LIST_EMPLOYEE_RESUMES;
		List l = jdbcTemplate.queryForList(query, obj);
		log.info("query:" + query);
		return l;
	}

	public List listProfileDetails(String idattacheddocs) {
		Object[] obj = new Object[] { idattacheddocs };
		String query = SQLQueries.LIST_EMPLOYEE_PROFILE_DETAILS;
		List l = jdbcTemplate.queryForList(query, obj);
		log.info("query:" + query);
		return l;
	}

	public List<Map<String, Object>> downloadAllEmployees(long businessId, String orderBy_1, String order_1, String orderBy_2, String order_2, String orderBy_3, String order_3) {
		Object[] obj = { new Long(businessId) };
		String query = SQLQueries.DOWNLOADALLEMPLOYEES;
		query += " order by ";
		if (orderBy_1 != null && orderBy_2 != null && orderBy_3 != null) {
			if (!orderBy_1.equalsIgnoreCase("clientWorkingFor")) {
				query += " up." + orderBy_1 + " " + order_1 + ", ";
			} else {
				query += " cl.clientName " + " " + order_1 + ", ";
				;
			}
			if (!orderBy_2.equalsIgnoreCase("clientWorkingFor")) {
				query += " up." + orderBy_2 + " " + order_2 + ", ";
				;
			} else {
				query += " cl.clientName " + " " + order_2 + ", ";
				;
			}
			if (!orderBy_3.equalsIgnoreCase("clientWorkingFor")) {
				query += " up." + orderBy_3 + " " + order_3;
			} else {
				query += " cl.clientName " + " " + order_3;
			}
		}
		log.info("query {}", query);
		return (getJdbcTemplate().queryForList(query, obj));
	}

	public Map getEmployeeDetailsForUpdate(String userId, String businessId) {
		Map m = new HashMap();
		Map FETCH_EMPLOYEE_PERSONAL_ADDRESS = null;
		try {
			Object[] params = new Object[] { userId, businessId };
			log.info("Getting the User Details for UserId " + userId);
			try {
				FETCH_EMPLOYEE_PERSONAL_ADDRESS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_PERSONAL_ADDRESS, params);
				m.put("FETCH_EMPLOYEE_PERSONAL_ADDRESS", FETCH_EMPLOYEE_PERSONAL_ADDRESS);
			} catch (EmptyResultDataAccessException e) {
				e.printStackTrace();
				log.warn("FETCH_EMPLOYEE_PERSONAL_ADDRESS : " + e.getMessage());
			}
			try {
				Map FETCH_EMPLOYEE_CLIENT_ADDRESS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_CLIENT_ADDRESS, params);
				m.put("FETCH_EMPLOYEE_CLIENT_ADDRESS", FETCH_EMPLOYEE_CLIENT_ADDRESS);
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_EMPLOYEE_CLIENT_ADDRESS : " + e.getMessage());
			}

			try {
				Map FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS, params);
				m.put("FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS", FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS);
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS : " + e.getMessage());
			}

			try {

				Map FETCH_EMPLOYEE_PERSONAL_DETAILS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_PERSONAL_DETAILS, params);
				m.put("FETCH_EMPLOYEE_PERSONAL_DETAILS", FETCH_EMPLOYEE_PERSONAL_DETAILS);
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_EMPLOYEE_PERSONAL_DETAILS : " + e.getMessage());
			}
			try {

				Map FETCH_BUSINESS_NAME = getJdbcTemplate().queryForMap(SQLQueries.FETCH_BUSINESS_NAME, params);
				m.put("FETCH_BUSINESS_NAME", FETCH_BUSINESS_NAME);
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_BUSINESS_NAME : " + e.getMessage());
			}
			try {

				Map FETCH_EMPLOYEE_CLIENT_DETAILS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_CLIENT_DETAILS, params);
				m.put("FETCH_EMPLOYEE_CLIENT_DETAILS", FETCH_EMPLOYEE_CLIENT_DETAILS);
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_EMPLOYEE_CLIENT_DETAILS : " + e.getMessage());
			}
		} catch (EmptyResultDataAccessException e) {
			log.warn(e.getMessage());
			// m=null;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			// m = null;
		}
		if (FETCH_EMPLOYEE_PERSONAL_ADDRESS == null) {
			return null;
		}
		return m;
	}

	public void updateAddress(Address add1) {
		SqlParameterSource paramSource = new BeanPropertySqlParameterSource(add1);
		int a = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_ADDRESS, paramSource);
		log.info("Address details updated");
	}

	public void updateAddress(Map add1) {
		Map add = new HashMap(add1);
		if (add.containsKey("myAddressId")) {
			add.put("addId", add.get("myAddressId"));
			int a = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_ADDRESS, add);
		} else if (add.containsKey("homeCountryAddressId")) {
			add.put("addId", add.get("homeCountryAddressId"));
			int a = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_ADDRESS, add);
		} else if (add.containsKey("clientAddressId")) {
			add.put("addId", add.get("clientAddressId"));
			int a = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_ADDRESS, add);
		}
		log.info("Address details updated");
	}

	public void update_employee_personal_data(Map data) {
		int count1 = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_PERSONAL, data);
		int count2 = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_STARTDATE, data);
		log.info("Personal details updated");
	}

	public List getEditMyClientDetails(UserProfile userProfile) {
		List result = null;
		try {
			ArrayList paramsList = new ArrayList();
			paramsList.add(userProfile.getUserId());
			paramsList.add(userProfile.getBusinessId());
			try {
				result = getJdbcTemplate().queryForList(SQLQueries.FETCH_UPDATE_CLIENT, getObjectArray(paramsList.size(), paramsList));
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_EMPLOYEE_CLIENT_ADDRESS : " + e.getMessage());
			}

		} catch (EmptyResultDataAccessException e) {
			log.warn(e.getMessage());
			result = null;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			result = null;
		}

		return result;
	}

	public List getListOfAvailableClients(UserProfile userProfile) {
		ArrayList paramsList = new ArrayList();
		paramsList.add(userProfile.getBusinessId());
		List result = null;

		try {
			result = getJdbcTemplate().queryForList(SQLQueries.FETCH_CLIENTSLIST_OF_A_BUSINESS, getObjectArray(paramsList.size(), paramsList));
		} catch (EmptyResultDataAccessException e) {
			log.warn("FETCH_EMPLOYEE_CLIENT_ADDRESS : " + e.getMessage());
		}
		return result;
	}

	public void updateClientIdInUsersTable(Map m) {
		int count = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_CLIENTID_IN_USRES_TABLE, m);
		log.info("clientId,addressId were updated in users table");
	}

	public int updateUserStatus(int approvalStatus, long userId) {
		ArrayList paramsList = new ArrayList();
		paramsList.add(approvalStatus);
		paramsList.add(userId);
		int recordEffectedCount = 0;
		try {
			recordEffectedCount = getJdbcTemplate().update(SQLQueries.APPROVE_OR_REJECT_EMPLOYEE_REGISTRATION, getObjectArray(paramsList.size(), paramsList));
		} catch (Exception e) {
			log.error("Error in talking the Action. Contact Admin.");
			e.printStackTrace();
		}
		return recordEffectedCount;
	}

	public int updateUserStatus(int approvalStatus, long userId, long businessId) {
		ArrayList paramsList = new ArrayList();
		paramsList.add(approvalStatus);
		paramsList.add(businessId);
		paramsList.add(userId);

		int recordEffectedCount = 0;
		try {
			recordEffectedCount = getJdbcTemplate().update(SQLQueries.DEACTIVATE_EMPLOYEE, getObjectArray(paramsList.size(), paramsList));
		} catch (Exception e) {
			log.error("Error in talking the Action. Contact Admin.");
			e.printStackTrace();
		}
		return recordEffectedCount;
	}

	public int updateBusinessStatus(int approvalStatus,long businessId){
		int recordsAffected = 0;
		ArrayList paramsList = new ArrayList();
		paramsList.add(approvalStatus);
		paramsList.add(businessId);
		if(approvalStatus == 3){
			recordsAffected = getJdbcTemplate().update(SQLQueries.ACTIVATE_DEACTIVATE_BUSINESS, getObjectArray(paramsList.size(), paramsList));
		}
		else if(approvalStatus == 1){
			recordsAffected = getJdbcTemplate().update(SQLQueries.ACTIVATE_DEACTIVATE_BUSINESS, getObjectArray(paramsList.size(), paramsList));
		}
		else{}
		return recordsAffected;
	}
	public String approveOrRejectEmployeeRegistrationPendingApprovals(String ajaxParam, long userId) {
		String msg = "No Action had been taken place.";
		if (ajaxParam != null && userId > 0) {
			ArrayList paramsList = new ArrayList();

			if (ajaxParam.equalsIgnoreCase(TimeSheetStatus.APPROVED.name())) {
				paramsList.add("1");
				msg = TimeSheetStatus.APPROVED.name();

			} else if (ajaxParam.equalsIgnoreCase(TimeSheetStatus.REJECTED.name())) {
				paramsList.add("2");
				msg = TimeSheetStatus.REJECTED.name();
			}
			paramsList.add(userId);
			try {
				getJdbcTemplate().update(SQLQueries.APPROVE_OR_REJECT_EMPLOYEE_REGISTRATION, getObjectArray(paramsList.size(), paramsList));
			} catch (Exception e) {
				msg = "Error in executing the Action. Contact Admin.";
				e.printStackTrace();
			}

		}
		return msg;
	}

	public String approveOrRejectEmployeeTimeSheets(String ajaxParam, String id) {
		String msg = "No Action had been taken place.";
		if (ajaxParam != null) {
			ArrayList paramsList = new ArrayList();

			if (ajaxParam.equalsIgnoreCase(TimeSheetStatus.APPROVED.name())) {
				paramsList.add(TimeSheetStatus.APPROVED.name());
				msg = TimeSheetStatus.APPROVED.name();
			} else if (ajaxParam.equalsIgnoreCase(TimeSheetStatus.REJECTED.name())) {
				paramsList.add(TimeSheetStatus.REJECTED.name());
				msg = TimeSheetStatus.REJECTED.name();
			}
			paramsList.add(Calendar.getInstance().getTime());
			paramsList.add(id);
			try {
				getJdbcTemplate().update(SQLQueries.APPROVE_OR_REJECT_EMPLOYEE_TIMESHEET, getObjectArray(paramsList.size(), paramsList));
			} catch (Exception e) {
				msg = "Error in talking the Action. Contact Admin.";
				e.printStackTrace();
			}
		}
		return msg;
	}

	public void deleteRejectedUser(long businessId) {
		getJdbcTemplate().update(SQLQueries.DELETE_ADDRESS_FOR_APPROVAL_REJECTED_EMPLOYEES, new Object[] { businessId, businessId, businessId });
		getJdbcTemplate().update(SQLQueries.DELETE_USER_PERSONAL_DETAILS_FOR_APPROVAL_REJECTED_EMPLOYEES, new Object[] { businessId });
		getJdbcTemplate().update(SQLQueries.DELETE_USER_FOR_APPROVAL_REJECTED_EMPLOYEES, new Object[] { businessId });
	}

	public List listUserEmails(String userIds) {
		String query = SQLQueries.LIST_USER_EMAILS + "(" + userIds + ")";
		return (getJdbcTemplate().queryForList(query));
	}

	public List listUserEmailsByWeeklyIds(String ids) {
		String query = SQLQueries.LIST_USER_EMAILS_BY_WEEKLYHRSIDS + "(" + ids + ")";
		return (getJdbcTemplate().queryForList(query));
	}

	public List listInvestmentTypes() {
		String query = SQLQueries.LIST_INVESTMENT_TYPES;
		return (getJdbcTemplate().queryForList(query));
	}

	public Map get_investedDate_amount(long investmentType, long userId, long businessId) {
		Object[] param = new Object[] { investmentType, userId, businessId };
		log.info("investedDate & amount fetching");
		return getJdbcTemplate().queryForMap(SQLQueries.FETCH_INVESTMENTDATE_AMOUNT, param);
	}

	public void updateInvestedAmount(Map m) {
		int count = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_INVESTED_AMOUNT_ON_EMPLOYEE, m);
		log.info("updateIvestedAmount query : " + SQLQueries.UPDATE_INVESTED_AMOUNT_ON_EMPLOYEE);
		log.info("updateed Invested Amount on employee details");
	}

	public void updateClientData(Map m) {
		int i = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_CLIENT_DATA, m);
		log.info("client startDate was updated");
	}

	public void enableAnEmployee(Map m) {
		int i = getNamedParameterJdbcTemplate().update(SQLQueries.ENABLE_AN_EMPLOYEE, m);
		log.info("Employee Enabled");
	}

	public void disableAnEmployee(Map m) {
		int i = getNamedParameterJdbcTemplate().update(SQLQueries.DISABLE_AN_EMPLOYEE, m);
		log.info("Employee Disabled");
	}

	public void update_member_personal_data(Map data) {
		int count = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_MEMBER_DETAILS, data);

		log.info("Personal details updated");
	}

	public Map getMemberProfileForUpdate(String userId, String businessId) {
		Map m = new HashMap();
		Map FETCH_EMPLOYEE_PERSONAL_ADDRESS = null;
		try {
			Object[] params = new Object[] { userId, businessId };
			log.info("Getting the User Details for UserId " + userId);
			try {
				FETCH_EMPLOYEE_PERSONAL_ADDRESS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_PERSONAL_ADDRESS, params);
				m.put("FETCH_EMPLOYEE_PERSONAL_ADDRESS", FETCH_EMPLOYEE_PERSONAL_ADDRESS);
			} catch (EmptyResultDataAccessException e) {
				e.printStackTrace();
				log.warn("FETCH_EMPLOYEE_PERSONAL_ADDRESS : " + e.getMessage());
			}

			try {
				Map FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS, params);
				m.put("FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS", FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS);
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_EMPLOYEE_HOME_COUNTRY_ADDRESS : " + e.getMessage());
			}

			try {

				Map FETCH_EMPLOYEE_PROFILE_DETAILS = getJdbcTemplate().queryForMap(SQLQueries.FETCH_EMPLOYEE_PROFILE_DETAILS, params);
				m.put("FETCH_EMPLOYEE_PROFILE_DETAILS", FETCH_EMPLOYEE_PROFILE_DETAILS);
			} catch (EmptyResultDataAccessException e) {
				log.warn("FETCH_EMPLOYEE_PROFILE_DETAILS : " + e.getMessage());
			}

		} catch (EmptyResultDataAccessException e) {
			log.warn(e.getMessage());
			// m=null;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			// m = null;
		}
		if (FETCH_EMPLOYEE_PERSONAL_ADDRESS == null) {
			return null;
		}
		return m;
	}

	// Timer - Start
	public List listTimers(long userId, long businessId) {
		Object[] obj = new Object[] { userId, businessId };
		return (getJdbcTemplate().queryForList(SQLQueries.LIST_TIMERS, obj));
	}
	public List<Map<String, Object>> listDeletableEmailContents(long userId, long businessId) {
		Object[] obj = new Object[] { userId, businessId };
		return (getJdbcTemplate().queryForList(SQLQueries.LIST_DELETABLE_EMAIL_CONTENTS, obj));
	}
	public List<Map<String, Object>> listNonDeletableEmailContents(long userId, long businessId) {
		Object[] obj = new Object[] { userId, businessId };
		return (getJdbcTemplate().queryForList(SQLQueries.LIST_NON_DELETABLE_EMAIL_CONTENTS, obj));
	}

	public Map CheckTimer(String timerId, String userId, String businessId) {
		Object[] obj = new Object[] { timerId, userId, businessId };
		return getJdbcTemplate().queryForMap(SQLQueries.CHECK_TIMER_STATUS, obj);
	}

	public long insertTimerContent(TimerContents emailContent) {
		long contentId = -1;
		try {
			log.info("Start Doing Transaction - insertTimerContent");
			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(emailContent);
			getNamedParameterJdbcTemplate().update(SQLQueries.CREATE_TIMER_CONTENT, parametersSource, keyHolder);
			contentId = keyHolder.getKey().intValue();
			log.info("contentId : {}", contentId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return contentId;
	}

	public long insertTimer(ScheduledTimers timer) {
		long timerId = -1;
		try {
			log.info("Start Doing Transaction - Scheduling a timer");

			KeyHolder keyHolder = new GeneratedKeyHolder();
			SqlParameterSource parametersSource = new BeanPropertySqlParameterSource(timer);
			getNamedParameterJdbcTemplate().update(SQLQueries.CREATE_TIMER, parametersSource, keyHolder);
			timerId = keyHolder.getKey().intValue();
			log.info("timerId : {}", timerId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return timerId;
	}

	public void updateTimerStatus(Map m) {
		int i = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_TIMER_STATUS, m);
		log.info("Timer Update Status count {}", i);
	}

	public void updateTimerStatusByUser(Map m) {
		int i = getNamedParameterJdbcTemplate().update(SQLQueries.UPDATE_TIMER_STATUS_BY_USER, m);
		log.info("Timer Update Status By User count {}", i);
	}
	

	public String selectAdminIdUserByBusinessId(long businessId) {
		Object[] obj = { new Long(businessId) };		
		String query = SQLQueries.SELECT_ADMIN_IDUSER_BY_BUSINESSID;
		log.info("Business Id : {} Query : {}", businessId, query);
		return getJdbcTemplate().queryForObject(query, String.class, businessId);
	}	
	
	public int deleteTimer(long timerId) {
		String query = SQLQueries.DELETE_TIMER_BY_ID;
		return getJdbcTemplate().update(query, new Object[] { timerId });
	}
	public int deleteEmailContent(long id) {
		String query = SQLQueries.DELETE_EMAIL_CONTENT_BY_ID;
		return getJdbcTemplate().update(query, new Object[] { id });
	}

	public void deleteTimer(Map m) {
		int i = getNamedParameterJdbcTemplate().update(SQLQueries.DELETE_TIMER, m);
		log.info("Timer Delete Status count {}" + i);
	}

	public Map getTimerContentForUpdate(Map m) {
		return getNamedParameterJdbcTemplate().queryForMap(SQLQueries.GET_TIMER_CONTENT_FOR_UPDATE, m);
	}

	public Map getAttachmentDetails(String id) {
		Map<String, Object> attachedMap;
		try{
			return jdbcTemplate.queryForMap(SQLQueries.GET_ATTACHED_DOC, new Object[] { id });
		}
		catch(Exception e)	{
			attachedMap = new HashMap<>();
		}
		return attachedMap;
	}

	public Map getTimerContentForNotificationl(long contentId, long businessId) {
		Object[] obj = new Object[] { contentId, businessId };
		Map map = getJdbcTemplate().queryForMap(SQLQueries.GET_TIMER_CONTENT_FOR_NOTIFICATION, obj);
		return map;
	}

	public int checkTimerNameAvailablity(String timerName) {
		int usrCount = 0;
		usrCount = jdbcTemplate.queryForInt(SQLQueries.CHECK_SCHEDULE_TIMERNAME_AVAILABLITY, new Object[] { timerName });
		return usrCount;
	}
	
	// Timer -END

	public Map getPasswordForAnAccount(long userId, long businessId) {
		Object[] obj = new Object[] { userId, businessId };
		Map map = getJdbcTemplate().queryForMap(SQLQueries.GET_PASSWORD_FOR_AN_ACCOUNT, obj);
		return map;
	}
	
	public List<Map<String, Object>> getAdminSettings(long businessId) {
		List<Map<String, Object>> map =null;
		try{
		Object[] obj = new Object[] { businessId };
		map = getJdbcTemplate().queryForList(SQLQueries.GET_ADMIN_SETTINGS, obj);
		}
		catch(EmptyResultDataAccessException e){
			log.debug("No setting found for admin {}, ", businessId);
			map = new ArrayList<Map<String,Object>>();
		}
		return map;
	}
	
	public long saveMonthlySummaryHours(Map sqlParamSource) {

		KeyHolder keyHolder = new GeneratedKeyHolder();
		SqlParameterSource parametersSource = new MapSqlParameterSource(sqlParamSource);

		getNamedParameterJdbcTemplate().update(SQLQueries.INSERT_WEEKLY_HRS_SUMMARY, parametersSource, keyHolder);

		long weeklyHrsSummaryId = keyHolder.getKey().longValue();
		return weeklyHrsSummaryId;

	}

	
	public long updateAdminSettings(long businessId, String name, String value) {
		
		int recordEffectedCount = 0;
		try {
			recordEffectedCount = getJdbcTemplate().update(SQLQueries.UPDATE_TIME_SHEET_CONFIGURATION, new Object[]{value, name, businessId});
		} catch (Exception e) {
			log.error("Error in talking the Action. Contact Admin.");
			e.printStackTrace();
		}
		return recordEffectedCount;		
	}
	
	public long createTimeSheetConfiguration(long businessId, String name, String value) {
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("businessId", String.valueOf(businessId));
		params.put("name", name);
		params.put("value", value);
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		SqlParameterSource parametersSource = new MapSqlParameterSource(params);

		getNamedParameterJdbcTemplate().update(SQLQueries.INSERT_TIME_SHEET_CONFIGURATION, parametersSource, keyHolder);

		long id = keyHolder.getKey().longValue();
		return id;
	}

	public void updateResetedPassword(Map m) {
		int i = getNamedParameterJdbcTemplate().update(SQLQueries.RESET_ACCOUNT_PASSWORD, m);
	}

	public int updateResetForgotPassword(String password, String email) {
		Object[] obj = new Object[] { password, email };
		return getJdbcTemplate().update(SQLQueries.RESET_FORGOT_PASSWORD, obj);
		
	}
	
	public void killBusinessAccount(long userId, long businessId) {
		Object[] obj = new Object[] { userId, businessId };
		int a = getJdbcTemplate().update(SQLQueries.KILL_BUSINESS_ACCOUNT, obj);
		log.info("Account destroyed");
	}

	public List<Map<String, Object>> listEmployeesubmittedHoursMonthly(long businessId) {
		String query = SQLQueries.EMPLOYEESUBMITHOURSMONTHLY;
		return (getJdbcTemplate().queryForList(query, new Object[] { businessId }));
	}

	public List<Map<String, Object>> listEmployeeDownloadMonthlyHrs(long userId, long businessId) {
		String query = SQLQueries.SEARCH_DOWNLOAD_MONTHLY_HRS;
		return (getJdbcTemplate().queryForList(query, new Object[] { userId, businessId }));
	}

	public List<Map<String, Object>> listEmployeesubmittedHoursWeekly(long businessId) {
		String query = SQLQueries.EMPLOYEESUBMITHRSWEEKLY;
		return (getJdbcTemplate().queryForList(query, new Object[] { businessId }));
	}

	public List employeeListBasedOnExpertise(long businessId) {
		String query = SQLQueries.EMPLOYEE_LIST_BASED_EXPERTISE;
		return (getJdbcTemplate().queryForList(query, new Object[] { businessId }));
	}

	public List employeeListBasedOnExperiance(long businessId) {
		String query = SQLQueries.EMPLOYEE_LIST_BASED_EXPERIANCE;
		return (getJdbcTemplate().queryForList(query, new Object[] { businessId }));
	}

	public MonthlyTimeSheetHours getMonthlySubmittedHrs(long idUser, long year, int month) {
		List<Map<String, Object>> databaseResult = jdbcTemplate.queryForList(SQLQueries.GET_MONTHLY_SUBMITTED_HRS, new Object[] { idUser, year, month });
		if (databaseResult.size() <= 0) {
			return null;
		}
		MonthlyTimeSheetHours timeSheetHours = new MonthlyTimeSheetHours(databaseResult);
		return timeSheetHours;
	}

	public Days15TimeSheetHours getHalfOfMonthHrs(long idUser, int year, int month, int startWeekNumber, int noOfWeeks, SubmissionFor submissionFor) {

		int numberOfWeeks = noOfWeeks;
		Set<Integer> weekNumbers = new HashSet<Integer>();
		for (int j = startWeekNumber; j <= noOfWeeks; j++) {
			weekNumbers.add(j);
		}

		NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(jdbcTemplate);
		MapSqlParameterSource parameters = new MapSqlParameterSource();
		parameters.addValue("weekNumber", weekNumbers);
		parameters.addValue("idUser", idUser);
		parameters.addValue("year", year);
		parameters.addValue("month", month);
		parameters.addValue("submissionFor", submissionFor.name());

		List<Map<String, Object>> databaseResult = namedParameterJdbcTemplate.queryForList(SQLQueries.GET_HALF_OF_MONTH_HRS, parameters);

		if (databaseResult.size() <= 0) {
			return null;
		}

		Days15TimeSheetHours timeSheetHours = new Days15TimeSheetHours(databaseResult);
		return timeSheetHours;
	}

	public WeeklyTimeSheetHours getWeeklySubmittedHrs(long idUser, int year, Calendar weekStartDate) {
		 java.sql.Date date = new java.sql.Date(weekStartDate.getTimeInMillis());
		List<Map<String, Object>> databaseResult = jdbcTemplate.queryForList(SQLQueries.GET_WEEKLY_SUBMITTED_HRS, new Object[] { idUser, year, date }, new int[]{Types.INTEGER, Types.INTEGER, Types.DATE});

		if (databaseResult.size() <= 0) {
			return null;
		}

		WeeklyTimeSheetHours timeSheetHours = new WeeklyTimeSheetHours(databaseResult);
		return timeSheetHours;
	}
	
	public BiWeeklyTimeSheetHours getBiWeeklySubmittedHrs(long idUser, int year, Calendar weekStartDate) {
		 java.sql.Date firstWeek = new java.sql.Date(weekStartDate.getTimeInMillis());
		 Calendar cal = (Calendar)weekStartDate.clone();
		 cal.add(Calendar.DAY_OF_MONTH, 7);
		 java.sql.Date secondWeek = new java.sql.Date(cal.getTimeInMillis());
		List<Map<String, Object>> databaseResult = jdbcTemplate.queryForList(SQLQueries.GET_BI_WEEKLY_SUBMITTED_HRS, new Object[] { idUser, year, firstWeek, secondWeek }, new int[]{Types.INTEGER, Types.INTEGER, Types.DATE, Types.DATE});

		if (databaseResult.size() <= 0) {
			return null;
		}

		BiWeeklyTimeSheetHours timeSheetHours = new BiWeeklyTimeSheetHours(databaseResult);
		return timeSheetHours;
	}
	public boolean deleteMonthlySummaryHours(Map listQueryValues) {
		boolean bDeleted = true;

		int count = getNamedParameterJdbcTemplate().update(SQLQueries.DELETE_MONTHLY_HRS_SUMMARY, listQueryValues);

		if (count < 0)
			bDeleted = false;
		return bDeleted;
	}

	public boolean deleteWeeklyHoursByWeekStartDate(Map listQueryValues) {
		boolean bDeleted = true;

		int count = getNamedParameterJdbcTemplate().update(SQLQueries.DELETE_WEEKLY_HRS_BY_WEEK_START_DATE, listQueryValues);

		if (count < 0)
			bDeleted = false;
		return bDeleted;
	}

	public boolean deleteWeeklyHours(Map listQueryValues) {
		boolean bDeleted = true;

		int count = getNamedParameterJdbcTemplate().update(SQLQueries.DELETE_WEEKLY_HRS, listQueryValues);

		if (count < 0)
			bDeleted = false;
		return bDeleted;
	}

	public boolean deleteWeeklyHoursDays15(Map listQueryValues) {
		boolean bDeleted = true;

		int count = getNamedParameterJdbcTemplate().update(SQLQueries.DELETE_WEEKLY_HRS_DAYS15, listQueryValues);

		if (count < 0)
			bDeleted = false;
		return bDeleted;
	}

	public int isTestUserAvailable(String emailId, String loginId) {
		String query = SQLQueries.USER_COUNT_BY_EMAIL_FOR_TEST;
		return getJdbcTemplate().queryForInt(query, new Object[] { loginId, emailId });
	}
	public int getUserCount() {
		String query = SQLQueries.USER_COUNT;
		return getJdbcTemplate().queryForInt(query, new Object[] { });
	}
	public int isSuperAdminAvailable() {
		String query = SQLQueries.USER_COUNT_BY_SUPERADMIN;
		return getJdbcTemplate().queryForInt(query, new Object[] { });
	}
	public int isDemoEmployerAvailable() {
		String query = SQLQueries.USER_COUNT_BY_DEMO_EMPLOYER;
		return getJdbcTemplate().queryForInt(query, new Object[] { });
	}
	
	public int isUserLoginAvailableForRegistration(String login, String emailId) {
		String query = SQLQueries.USER_COUNT_BY_EMAIL_FOR_TEST;
		int count = getJdbcTemplate().queryForInt(query, new Object[] {login, emailId });
		if(count>=1)
			return count;
		else {
			query = SQLQueries.CHECK_USR_AVAILABLITY;
			count = getJdbcTemplate().queryForInt(query, new Object[] {login});
			if(count >= 1)
				return count;
			else
			{
				query = SQLQueries.CHECK_EMAIL_AVAILABITY;
				return getJdbcTemplate().queryForInt(query, new Object[] {emailId});
			}
		}
	}

	public int isDemoEmployeesAvailable() {
		String query = SQLQueries.USER_COUNT_BY_DEMO_EMPLOYEE;
		return getJdbcTemplate().queryForInt(query, new Object[] { });
	}
	public int getAdminCount(long businessId) {
		String query = SQLQueries.USER_COUNT_BY_BUSINESSID;
		return getJdbcTemplate().queryForInt(query, new Object[] { businessId });
	}
	
	public long getActiveAdminUserId(long businessId) {
		String query = SQLQueries.ACTIVE_ADMIN_USER_ID;
		return getJdbcTemplate().queryForLong(query, new Object[] { businessId });
	}
	
	
	public boolean deleteWeeklyHoursByWeek(Map listQueryValues) {
		boolean bDeleted = true;

		int count = getNamedParameterJdbcTemplate().update(SQLQueries.DELETE_WEEKLY_HRS_BY_WEEK_START_DATE, listQueryValues);

		if (count < 0)
			bDeleted = false;
		return bDeleted;
	}

	public List getSummaryHrs(UserProfile profile, TimeSheetTypes type, String weekStartDate) {
		return (jdbcTemplate.queryForList(SQLQueries.GET_SUMMARY_HRS, new Object[] { profile.getUserId(), profile.getBusinessId(), profile.getDu().getYear(), profile.getDu().getMonth(), type.name(),
				weekStartDate }));
	}

	public Map<String, Object> getWeeklySummeryDetails(long weeklyHrsSummaryId) {
		Object[] obj = new Object[] { weeklyHrsSummaryId };
		return getJdbcTemplate().queryForMap(SQLQueries.GET_SUMMARY_HRS_BY_ID, obj);
	}

	public String getAdminEmail(long businessId) {
		try{
			return jdbcTemplate.queryForObject(SQLQueries.GET_CONTACT_EMAIL_FOR_ADMIN_, new Object[] { businessId }, String.class);
		}catch(Exception e){
			log.info("Unable to fetch admin email {} ", e.getMessage());
			return null;
		}
	}
	
	public String getAdminTimeSheetConfigValue(long businessId, String name) {
		try{
		return jdbcTemplate.queryForObject(SQLQueries.GET_ADMIN_TIME_SHEET_CONFIG_VALUE, new Object[] { businessId, name }, String.class);
		}
		catch (Exception e){
			return "8.0";
		}
	}
	public String getSuperAdminEmail(long businessId) {
		return jdbcTemplate.queryForObject(SQLQueries.GET_SUPER_CONTACT_EMAIL_FOR_ADMIN, new Object[] { businessId }, String.class);
	}
	public List<Map<String, Object>> getTodayBdayUsers() {
		String query = SQLQueries.LIST_BDAY_USERS;
		Calendar cal = Calendar.getInstance();
		java.sql.Date date = new java.sql.Date(cal.getTimeInMillis());
		return (getJdbcTemplate().queryForList(query, new Object[] { date }));
	}

	public void resetBdayReminders() {
		String query = SQLQueries.RESET_BDAY_REMINDERS;
		getJdbcTemplate().update(query);
	}

	public void updateBdayRemindersForUser(long businessId) {
		String query = SQLQueries.UPDATE_BDAY_REMINDER_BY_BUSINESS;
		getJdbcTemplate().update(query, new Object[] { businessId });
	}

	public List<Map<String, Object>> listSuperSettings() {
		String query = SQLQueries.LIST_SUPER_SETTINGS;
		return getJdbcTemplate().queryForList(query);
	}
	
	public void insertSuperSettings(String info, String type) {
		getJdbcTemplate().update(SQLQueries.INSERTSUPERSETTINGS, info, type);
	}
	
	public void insertLog(String log, String type) {
		getJdbcTemplate().update(SQLQueries.INSERT_LOG, log, type);
	}
	
	public int countofEmails() {
		int usrCount = 0;
		usrCount = jdbcTemplate.queryForInt(SQLQueries.EMAIL_SENT_COUNT);
		return usrCount;
	}

}
