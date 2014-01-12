package com.lch.general.dbBeans;

import org.apache.struts.upload.FormFile;

public class LCH_BUSINESS {
	
	private String businessName;
	private String businessAddressId;
	private String phoneNumber;
	private String websiteURL;
	private long  registeredByUserId;
	private String employerEmail;
	private String isValidated;
	private long businessId;
	/**
	 * @return the businessId
	 */
	public long getBusinessId() {
		return businessId;
	}
	/**
	 * @param businessId the businessId to set
	 */
	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}
	private FormFile logo;
	private FormFile businessProfile;
	
	public String getBusinessName() {
		return businessName;
	}
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}
	public String getBusinessAddressId() {
		return businessAddressId;
	}
	public void setBusinessAddressId(String businessAddressId) {
		this.businessAddressId = businessAddressId;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getWebsiteURL() {
		return websiteURL;
	}
	public void setWebsiteURL(String websiteURL) {
		this.websiteURL = websiteURL;
	}

	public long getRegisteredByUserId() {
		return registeredByUserId;
	}
	public void setRegisteredByUserId(long registeredByUserId) {
		this.registeredByUserId = registeredByUserId;
	}
	public String getEmployerEmail() {
		return employerEmail;
	}
	public void setEmployerEmail(String employerEmail) {
		this.employerEmail = employerEmail;
	}
	public String getIsValidated() {
		return isValidated;
	}
	public void setIsValidated(String isValidated) {
		this.isValidated = isValidated;
	}
	/**
	 * @return the logo
	 */
	public FormFile getLogo() {
		return logo;
	}
	/**
	 * @param logo the logo to set
	 */
	public void setLogo(FormFile logo) {
		this.logo = logo;
	}
	/**
	 * @return the businessProfile
	 */
	public FormFile getBusinessProfile() {
		return businessProfile;
	}
	/**
	 * @param businessProfile the businessProfile to set
	 */
	public void setBusinessProfile(FormFile businessProfile) {
		this.businessProfile = businessProfile;
	}
	
	
}
