/*
 * Created on Jan 17, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.spring.BusinessComponents;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.MappingSqlQuery;

import com.lch.general.generalBeans.UserProfile;
import com.lch.spring.SQLQueries;
import com.lch.struts.actions.admin.AdminSettings;
import com.lch.struts.formBeans.Login;

/**
 * @author Gopi
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class LoginCheck {
	DoTransaction doTransaction;
	private static Logger log = LoggerFactory.getLogger(LoginCheck.class);

	public DoTransaction getDoTransaction() {
		return doTransaction;
	}

	public void setDoTransaction(DoTransaction doTransaction) {
		this.doTransaction = doTransaction;
	}

	public UserProfile isLogin(Login login) throws Exception {
		UserProfile loginStatus = new UserProfile();
		isLogin(loginStatus, login);
		return loginStatus;
	}
	private void loadAdminSettings(UserProfile loginStatus){
		List<Map<String, Object>> settings = getDoTransaction().getAdminSettings(loginStatus.getBusinessId());
		
		for(Map<String, Object> map : settings)
		{
			String key = "name";
			String value="value";
			if(map.get(key).equals(AdminSettings.TIMSHEETCONFIGURATION.name())) {
				log.info("Default Time Sheet Value set to {}", (String)map.get(value));
				loginStatus.setDefaultTimeSheetValue((String)map.get(value));
			}
			
			if(map.get(key).equals(AdminSettings.HIDE_NOTIFY_EMPLOYER_BUTTON.name())) {
				log.info("Default Hide Skip Notify Employer Button {}", (String)map.get(value));
				loginStatus.setHideSkipNotifyEmployerButton((Boolean.parseBoolean((String)map.get(value))));
			}
		}
	}

	private void isLogin(UserProfile loginStatus, Login login) {
		LoginMappingQuery custQry = new LoginMappingQuery(getDoTransaction().getJdbcTemplate().getDataSource());
		Object[] parms = new Object[2];
		parms[0] = login.getUserName();
		parms[1] = login.getPassword();
		List<?> UserProfiles = custQry.execute(parms);
		log.info("UserProfiles found " + UserProfiles.size());
		if (UserProfiles != null && UserProfiles.size() > 1) {
			loginStatus.setLoginStatus(false);
			loginStatus.setLoginFailReason("invalidLogin");
			log.info("Login Failed");
		} else if (UserProfiles != null && UserProfiles.size() == 1) {

			UserProfile userProfile = (UserProfile) UserProfiles.get(0);
			log.info("Approval Status {}", userProfile.getApprovalStatus());

			// If deleted case of admin
			if ((userProfile.isAdmin() || userProfile.isChildAdmin()) && ( userProfile.getApprovalStatus() == 3 || userProfile.getApprovalStatus() == 2)) {
				loginStatus.setLoginStatus(false);
				loginStatus.setLoginFailReason("invalidLoginDeletedEmployer");
			} 
			else if (userProfile.getApprovalStatus() == 1 || userProfile.getApprovalStatus() == 2 || userProfile.getApprovalStatus() == 3) // If approved and disabled 3 Memeber
			{
			
				if (userProfile.isEmailValidated()) {
					try {
						BeanUtils.copyProperties(loginStatus, userProfile);
						loadAdminSettings(loginStatus);
						if (loginStatus.isAdmin() || loginStatus.isChildAdmin()) {
							loginStatus.setEmployerEmail(loginStatus.getEmployeeEmail());
						} else {

							String employerEmail;
							if (loginStatus.getUserRole().equals("SUPERADMIN")) {
								employerEmail = getDoTransaction().getSuperAdminEmail(loginStatus.getBusinessId());
							} else {
								getDoTransaction().updateRequiredDetails(loginStatus);
								employerEmail = getDoTransaction().getAdminEmail(loginStatus.getBusinessId());
								//String defaultTimeSheetValue = getDoTransaction().getAdminTimeSheetConfigValue(loginStatus.getBusinessId(), AdminSettings.TIMSHEETCONFIGURATION.name());
							}

							loginStatus.setEmployerEmail(employerEmail);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					log.info("Login Successed");
				} else {
					
					// Who ever it is - if email not validated fail the login
						loginStatus.setLoginStatus(false);
						loginStatus.setLoginFailReason("emailNotValidated");
						log.warn("Login Failed : " + loginStatus.getLoginFailReason());
					
				}
			} else if (userProfile.getApprovalStatus() == 0) {
				loginStatus.setLoginStatus(false);
				if (userProfile.isAdmin() || userProfile.isChildAdmin())
					loginStatus.setLoginFailReason("invalidLoginPendingEmployerApproval");
				else
					loginStatus.setLoginFailReason("invalidLoginPendingEmployeeApproval");
			} else {
				loginStatus.setLoginStatus(false);
				loginStatus.setLoginFailReason("invalidLogin");
				log.warn("Login Failed : " + loginStatus.getLoginFailReason());
			}
		} else {

			loginStatus.setLoginStatus(false);
			loginStatus.setLoginFailReason("invalidLogin");
			log.warn("Login Failed : " + loginStatus.getLoginFailReason());
		}
	}
}

class LoginMappingQuery extends MappingSqlQuery<UserProfile> implements SQLQueries {
	private static Logger log = LoggerFactory.getLogger(LoginMappingQuery.class);

	public LoginMappingQuery(DataSource ds) {
		super(ds, LOGINCHECKSQL);
		super.declareParameter(new SqlParameter("login", Types.VARCHAR));
		super.declareParameter(new SqlParameter("password", Types.VARCHAR));
		compile();
	}

	public UserProfile mapRow(ResultSet rs, int rowNumber) throws SQLException {
		if (rs != null) {
			return UpdateUserSession.getUserProfile(rs, null);
		} else {
			log.info("Unable to find users with the query {}", LOGINCHECKSQL);
			return null;
		}
	}
}