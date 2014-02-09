/*
 * Created on Jan 17, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.general.generalBeans;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.Roles;
import com.lch.general.enums.TimeSheetTypes;
import com.lch.general.genericUtils.DateUtils;

/**
 * @author Gopi
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class UserProfile {
	private static Logger log = LoggerFactory.getLogger(UserProfile.class);
	private String userRole = "";
	private long userId = 0;
	private long businessId = 0;
	private long clientId = 0;
	private String userName = "";
	private String firstName = "";
	private boolean isBusinessEmailValidated = false;
	private DateUtils du = null;
	private boolean loginStatus;
	
	private String employerEmail = "";
	long personalDetailsId = 0;
	private String currentClientName = "";
	private String employeeEmail = "";
	private String timeSheetConfiguredTo = TimeSheetTypes.MONTHLY.name();
	private String employerName = "";
	private String logoPath = null;
	private boolean isLogoUpdated = false;
	private int approvalStatus = 2;
	private String defaultTimeSheetValue = "8.0";
	private String loginFailReason;

	public boolean isMember() {
		if(userRole!=null && userRole.length() > 0 && userRole.equals(Roles.MEMBER.name()))
			return true;
		else
			return false;
	}

	public boolean isSuperAdmin() {

		if(userRole!=null && userRole.length() > 0 && userRole.equals(Roles.SUPERADMIN.name()))
			return true;
		else
			return false;
	}

	public boolean isChildAdmin() {

		if(userRole!=null && userRole.length() > 0 && userRole.equals(Roles.CHILDADMIN.name()))
			return true;
		else
			return false;
	}

	public boolean isAdmin() {
		if(userRole!=null && userRole.length() > 0 && userRole.equals(Roles.ADMIN.name()))
			return true;
		else
			return false;
	}

	
	public int getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(int approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		try {
			this.approvalStatus = new Integer(approvalStatus).intValue();
		} catch (NumberFormatException e) {
			this.approvalStatus = 2;
		}
	}


	public void setLogoUpdated(boolean isLogoUpdated) {
		this.isLogoUpdated = isLogoUpdated;
	}

	public boolean isLogoUpdated() {
		return isLogoUpdated;
	}

	public String getLogoPath() {

		if (logoPath == null && !isLogoUpdated)
			return "images/ILC.jpg";
		return logoPath;
	}

	public void setLogoPath(String logoPath) {
		this.logoPath = logoPath;
	}

	public String getTimeSheetConfiguredTo() {
		return timeSheetConfiguredTo;
	}

	public void setTimeSheetConfiguredTo(String timeSheetConfiguredTo) {
		this.timeSheetConfiguredTo = timeSheetConfiguredTo;
	}

	public String getCurrentClientName() {
		return currentClientName;
	}

	public void setCurrentClientName(String currentClientName) {
		this.currentClientName = currentClientName;
	}

	public String getEmployerName() {
		return employerName;
	}

	public void setEmployerName(String employerName) {
		this.employerName = employerName;
	}

	public long getPersonalDetailsId() {
		return personalDetailsId;
	}

	public void setPersonalDetailsId(long personalDetailsId) {
		this.personalDetailsId = personalDetailsId;
	}

	public String getEmployerEmail() {
		return employerEmail;
	}

	public void setEmployerEmail(String employerEmail) {
		this.employerEmail = employerEmail;
	}

	public String getEmployeeEmail() {
		return employeeEmail;
	}

	public void setEmployeeEmail(String employeeEmail) {
		this.employeeEmail = employeeEmail;
	}

	public Object clone() {
		try {
			return super.clone();
		} catch (CloneNotSupportedException e) {
			log.error(e.getMessage(), e);
			return null;
		}
	}

	public long getClientId() {
		return clientId;
	}

	public void setClientId(long clientId) {
		this.clientId = clientId;
	}

	/**
	 * @return the isBusinessEmailValidated
	 */
	public boolean isBusinessEmailValidated() {
		return isBusinessEmailValidated;
	}

	/**
	 * @param isBusinessEmailValidated
	 *            the isBusinessEmailValidated to set
	 */
	public void setBusinessEmailValidated(boolean isBusinessEmailValidated) {
		this.isBusinessEmailValidated = isBusinessEmailValidated;
	}

	/**
	 * @return Returns the userRole.
	 */
	public String getUserRole() {
		return userRole;
	}

	/**
	 * @param userRole
	 *            The userRole to set.
	 */
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	/**
	 * @return Returns the du.
	 */
	public DateUtils getDu() {
		return du;
	}

	/**
	 * @param du
	 *            The du to set.
	 */
	public void setDu(DateUtils du) {
		this.du = du;
	}


	/**
	 * 
	 */
	public UserProfile() {
	}

	/**
	 * @return Returns the clientID.
	 */

	/**
	 * @return Returns the firstName.
	 */
	public String getFirstName() {
		return firstName;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getBusinessId() {
		return businessId;
	}

	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}

	/**
	 * @param firstName
	 *            The firstName to set.
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * @return Returns the loginStatus.
	 */
	public boolean isLoginStatus() {
		return loginStatus;
	}

	/**
	 * @param loginStatus
	 *            The loginStatus to set.
	 */
	public void setLoginStatus(boolean loginStatus) {
		this.loginStatus = loginStatus;
	}

	/**
	 * @return Returns the userName.
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName
	 *            The userName to set.
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	 * @return Returns the loginFailReason.
	 */
	public String getLoginFailReason() {
		return loginFailReason;
	}

	/**
	 * @param loginFailReason
	 *            The loginFailReason to set.
	 */
	public void setLoginFailReason(String loginFailReason) {
		this.loginFailReason = loginFailReason;
	}

	public String getDefaultTimeSheetValue() {
		return defaultTimeSheetValue;
	}

	public void setDefaultTimeSheetValue(String defaultTimeSheetValue) {
		this.defaultTimeSheetValue = defaultTimeSheetValue;
	}

	public Double TimeSheetValue() {
		return Double.valueOf(defaultTimeSheetValue);
	}
}
