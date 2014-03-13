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

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.MappingSqlQuery;

import com.lch.general.dbBeans.DBConstants;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.genericUtils.DateUtils;
import com.lch.spring.SQLQueries;

/**
 * @author Gopi
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class UpdateUserSession {
	private static Logger log = LoggerFactory.getLogger(LoginCheck.class);
	DoTransaction doTransaction;

	public DoTransaction getDoTransaction() {
		return doTransaction;
	}

	public void setDoTransaction(DoTransaction doTransaction) {
		this.doTransaction = doTransaction;
	}

	@SuppressWarnings("rawtypes")
	public void updateSession(UserProfile userProfile) throws Exception {
		SessionMappingQuery custQry = new SessionMappingQuery(getDoTransaction());
		Object[] parms = new Object[1];
		parms[0] = userProfile.getUserId();
		List UserProfiles = custQry.execute(parms);
		if (UserProfiles != null && UserProfiles.size() > 1) {
			log.error("More than one User profile found " + UserProfiles.size());
		} else if (UserProfiles != null && UserProfiles.size() == 1) {

			UserProfile up = (UserProfile) UserProfiles.get(0);
			DateUtils du = userProfile.getDu();
			BeanUtils.copyProperties(userProfile, up);
			userProfile.setDu(du);
		}
	}

	public static UserProfile getUserProfile(ResultSet rs, DoTransaction doTransaction) throws SQLException {

		UserProfile userProfile = new UserProfile();
		userProfile.setUserName(rs.getString("userName"));
		userProfile.setEmployeeEmail(rs.getString("employeeEmail"));
		userProfile.setBusinessId(rs.getLong(DBConstants.BUSINESS_ID));
		userProfile.setFirstName(rs.getString("firstName"));
		userProfile.setClientId(rs.getLong("clientId"));
		userProfile.setLoginStatus(true);
		userProfile.setUserId(rs.getInt("userId"));
		//userProfile.setBusinessEmailValidated(rs.getBoolean("isValidated"));
		userProfile.setEmailValidated(rs.getBoolean("isEmailValidated"));
		userProfile.setPersonalDetailsId(rs.getLong("personalDetailsId"));
		userProfile.setEmployerName(rs.getString("employerName"));
		userProfile.setTimeSheetConfiguredTo(rs.getString("timeSheetConfiguredTo"));
		String userRole = rs.getString("role");
		userProfile.setApprovalStatus(rs.getString("approvalstatus"));
		userProfile.setUserRole(userRole);
		if (doTransaction != null) {
			String employerEmail = doTransaction.getAdminEmail(userProfile.getBusinessId());
			userProfile.setEmployerEmail(employerEmail);
		}
		return userProfile;

	}
}

@SuppressWarnings("rawtypes")
class SessionMappingQuery extends MappingSqlQuery implements SQLQueries {
	private static Logger log = LoggerFactory.getLogger(SessionMappingQuery.class);
	DoTransaction doTransaction;

	public SessionMappingQuery(DoTransaction doTransaction) {
		super(doTransaction.getJdbcTemplate().getDataSource(), SESSION_UPDATE_SQL);
		super.declareParameter(new SqlParameter("userId", Types.VARCHAR));
		this.doTransaction = doTransaction;
		compile();
	}

	public Object mapRow(ResultSet rs, int rowNumber) throws SQLException {
		if (rs != null) {

			return UpdateUserSession.getUserProfile(rs, doTransaction);

		} else {
			log.info("Unable to find users with the query {}", SESSION_UPDATE_SQL);
			return null;
		}
	}
}