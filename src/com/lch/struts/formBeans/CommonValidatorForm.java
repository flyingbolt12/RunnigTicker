package com.lch.struts.formBeans;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts.upload.FormFile;
import org.apache.struts.validator.ValidatorForm;

import com.lch.general.dbBeans.Address;
import com.lch.general.enums.TimeSheetTypes;

public class CommonValidatorForm extends ValidatorForm {

	protected static final long serialVersionUID = -2940790871349560612L;

	protected String clientWorkingFor;
	protected long businessAddressId;
	protected long personalAddressId;
	protected long clientId;
	protected long personalDetailsId;
	protected String clientName;
	protected String otherClientName;
	protected String startDate;
	protected String dob;
	protected FormFile profilePath;
	protected int employerCode;
	protected String login;
	protected String password;
	protected String confirmPassword;
	protected String termsConditions = "true";
	protected long clientAddressId;
	protected int approvalStatus = 0;
	protected int isEmailValidated = 0;
	protected List<Address> listAddress = new ArrayList<Address>();
	protected String firstName;
	protected String middleName;
	protected String lastName;
	protected String gendar;
	protected String contactEmail;
	protected String phoneNumber;
	protected String fatherName;
	protected String countryCitizenship;

	protected long homeCountryAddressId;
	protected long myAddressId;
	protected long businessId;
	protected long userId;
	protected String timeSheetConfiguredTo = TimeSheetTypes.MONTHLY.name();
	private FormFile logo;
	private String isSameAsBusinessAddress;
	
	public String getIsSameAsBusinessAddress() {
		return isSameAsBusinessAddress;
	}

	public void setIsSameAsBusinessAddress(String isSameAsBusinessAddress) {
		this.isSameAsBusinessAddress = isSameAsBusinessAddress;
	}

	public String getClientWorkingFor() {
		return clientWorkingFor;
	}

	public void setClientWorkingFor(String clientWorkingFor) {
		this.clientWorkingFor = clientWorkingFor;
	}

	public long getBusinessAddressId() {
		return businessAddressId;
	}

	public void setBusinessAddressId(long businessAddressId) {
		this.businessAddressId = businessAddressId;
	}

	public long getPersonalAddressId() {
		return personalAddressId;
	}

	public void setPersonalAddressId(long personalAddressId) {
		this.personalAddressId = personalAddressId;
	}

	public long getClientId() {
		return clientId;
	}

	public void setClientId(long clientId) {
		this.clientId = clientId;
	}

	public long getPersonalDetailsId() {
		return personalDetailsId;
	}

	public void setPersonalDetailsId(long personalDetailsId) {
		this.personalDetailsId = personalDetailsId;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getOtherClientName() {
		return otherClientName;
	}

	public void setOtherClientName(String otherClientName) {
		this.otherClientName = otherClientName;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public FormFile getProfilePath() {
		return profilePath;
	}

	public void setProfilePath(FormFile profilePath) {
		this.profilePath = profilePath;
	}

	public int getEmployerCode() {
		return employerCode;
	}

	public void setEmployerCode(int employerCode) {
		this.employerCode = employerCode;
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

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getTermsConditions() {
		return termsConditions;
	}

	public void setTermsConditions(String termsConditions) {
		this.termsConditions = termsConditions;
	}

	public long getClientAddressId() {
		return clientAddressId;
	}

	public void setClientAddressId(long clientAddressId) {
		this.clientAddressId = clientAddressId;
	}

	public int getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(int approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public int getIsEmailValidated() {
		return isEmailValidated;
	}

	public void setIsEmailValidated(int isEmailValidated) {
		this.isEmailValidated = isEmailValidated;
	}

	public List<Address> getListAddress() {
		return listAddress;
	}

	public void setListAddress(List<Address> listAddress) {
		this.listAddress = listAddress;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getGendar() {
		return gendar;
	}

	public void setGendar(String gendar) {
		this.gendar = gendar;
	}

	public String getContactEmail() {
		return contactEmail;
	}

	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}


	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	public String getCountryCitizenship() {
		return countryCitizenship;
	}

	public void setCountryCitizenship(String countryCitizenship) {
		this.countryCitizenship = countryCitizenship;
	}

	public long getHomeCountryAddressId() {
		return homeCountryAddressId;
	}

	public void setHomeCountryAddressId(long homeCountryAddressId) {
		this.homeCountryAddressId = homeCountryAddressId;
	}

	public long getMyAddressId() {
		return myAddressId;
	}

	public void setMyAddressId(long myAddressId) {
		this.myAddressId = myAddressId;
	}

	public long getBusinessId() {
		return businessId;
	}

	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getTimeSheetConfiguredTo() {
		return timeSheetConfiguredTo;
	}

	public void setTimeSheetConfiguredTo(String timeSheetConfiguredTo) {
		this.timeSheetConfiguredTo = timeSheetConfiguredTo;
	}

	public FormFile getLogo() {
		return logo;
	}

	public void setLogo(FormFile logo) {
		this.logo = logo;
	}
}
