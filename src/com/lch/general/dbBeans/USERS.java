package com.lch.general.dbBeans;

import java.util.Date;

import com.lch.general.enums.TimeSheetTypes;

public class USERS {
	private int iduser = 0;
	private String firstName = "";
	private String login = "";
	private String password = "";
	private int isPwdChangeRequired = 0;
	private String expairyDate = new Date().toString();
	private String registeredDate = new Date().toString();
	private long businessId = 0;
	private String role = "";
	private int personalDetailsId = 0;
	private String timeSheetConfiguredTo=TimeSheetTypes.MONTHLY.name();

	int clientId = 0;
	int approvalStatus = 0;

	public String getTimeSheetConfiguredTo() {
		return timeSheetConfiguredTo;
	}

	public void setTimeSheetConfiguredTo(String timeSheetConfiguredTo) {
		this.timeSheetConfiguredTo = timeSheetConfiguredTo;
	}

	public int getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(int approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getIduser() {
		return iduser;
	}

	public void setIduser(int iduser) {
		this.iduser = iduser;
	}

	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * @param firstName
	 *            the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return the isPwdChangeRequired
	 */
	public int getIsPwdChangeRequired() {
		return isPwdChangeRequired;
	}

	/**
	 * @param isPwdChangeRequired
	 *            the isPwdChangeRequired to set
	 */
	public void setIsPwdChangeRequired(int isPwdChangeRequired) {
		this.isPwdChangeRequired = isPwdChangeRequired;
	}

	public String getExpairyDate() {
		return expairyDate;
	}

	public void setExpairyDate(String expairyDate) {
		this.expairyDate = expairyDate;
	}

	public String getRegisteredDate() {
		return registeredDate;
	}

	public void setRegisteredDate(String registeredDate) {
		this.registeredDate = registeredDate;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}


	public long getBusinessId() {
		return businessId;
	}

	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}

	/**
	 * @return the personalDetailsId
	 */
	public int getPersonalDetailsId() {
		return personalDetailsId;
	}

	/**
	 * @param personalDetailsId
	 *            the personalDetailsId to set
	 */
	public void setPersonalDetailsId(int personalDetailsId) {
		this.personalDetailsId = personalDetailsId;
	}

}
