package com.lch.struts.formBeans;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

@SuppressWarnings("serial")
public class SearchOptions extends CommonValidatorForm
{
	public SearchOptions() {
		setLastNameRadio("like");
		setFirstNameRadio("like");
		setZipCodeRadio("exact");
		setEmailRadio("like");
	}

	String zipCode = null;

	String email = null;

	String clientLocation = null;

	String country = null;

	String state = null;
	
	String lastNameRadio=null;
	
	String zipCodeRadio=null;
	
	String emailRadio=null;
	
	String firstNameRadio=null;
	
	public String[] stateList = null;

	public String[] countryList = null;

	public String[] cityList = null;

	public String[] clientWorkingForList = null;
	
	public List<String> stateList2Display = null;

	public List<String> countryList2Display  = null;

	public List<String> cityList2Display  = null;

	public List <String>clientWorkingForList2Display  = null;
	
	public String investmentType;
	public Double amount;
	public String investedDate;
	public String submit="";
	
	private String employeeType;
	private String subject;
	private FormFile attachement ;
	private String emailConent;

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		zipCode = null;
		email="";
		clientLocation = null;
		country = null;
		state = null;
		stateList = null;
		countryList = null;
		cityList = null;
		clientWorkingForList = null;
		submit=null;
	}

	
	public List<String> getCityList2Display() {
		return cityList2Display;
	}

	public void setCityList2Display(List<String> cityList2Display) {
		this.cityList2Display = cityList2Display;
	}

	public List <String>getClientWorkingForList2Display() {
		return clientWorkingForList2Display;
	}

	public void setClientWorkingForList2Display(List<String> clientWorkingForList2Display) {
		this.clientWorkingForList2Display = clientWorkingForList2Display;
	}

	public List<String> getCountryList2Display() {
		return countryList2Display;
	}

	public void setCountryList2Display(List<String> countryList2Display) {
		this.countryList2Display = countryList2Display;
	}

	public List<String> getStateList2Display() {
		return stateList2Display;
	}

	public void setStateList2Display(List<String>stateList2Display) {
		this.stateList2Display = stateList2Display;
	}

	public String[] getCityList() {
		return cityList;
	}

	public void setCityList(String[] cityList) {
		this.cityList = cityList;
	}

	public String[] getClientWorkingForList() {
		return clientWorkingForList;
	}

	public void setClientWorkingForList(String[] clientWorkingForList) {
		this.clientWorkingForList = clientWorkingForList;
	}

	public String[] getCountryList() {
		return countryList;
	}

	public void setCountryList(String[] countryList) {
		this.countryList = countryList;
	}

	public String[] getStateList() {
		return stateList;
	}

	public void setStateList(String[] stateList) {
		this.stateList = stateList;
	}

	/**
	 * @return Returns the clientLocation.
	 */
	public String getClientLocation() {
		return clientLocation;
	}

	/**
	 * @param clientLocation
	 *            The clientLocation to set.
	 */
	public void setClientLocation(String clientLocation) {
		this.clientLocation = clientLocation;
	}

	/**
	 * @return Returns the country.
	 */
	public String getCountry() {
		return country;
	}

	/**
	 * @param country
	 *            The country to set.
	 */
	public void setCountry(String country) {
		this.country = country;
	}

	/**
	 * @return Returns the state.
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            The state to set.
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return Returns the zipCode.
	 */
	public String getZipCode() {
		return zipCode;
	}

	/**
	 * @param zipCode
	 *            The zipCode to set.
	 */
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return Returns the lastNameRadio.
	 */
	public String getLastNameRadio() {
		return lastNameRadio;
	}
	/**
	 * @param lastNameRadio The lastNameRadio to set.
	 */
	public void setLastNameRadio(String lastNameRadio) {
		this.lastNameRadio = lastNameRadio;
	}

	/**
	 * @return Returns the firstNameRadio.
	 */
	public String getFirstNameRadio() {
		return firstNameRadio;
	}
	/**
	 * @param firstNameRadio The firstNameRadio to set.
	 */
	public void setFirstNameRadio(String firstNameRadio) {
		this.firstNameRadio = firstNameRadio;
	}
	/**
	 * @return Returns the userNameRadio.
	 */
	public String getEmailRadio() {
		return emailRadio;
	}
	/**
	 * @param userNameRadio The userNameRadio to set.
	 */
	public void setEmailRadio(String emailRadio) {
		this.emailRadio = emailRadio;
	}
	/**
	 * @return Returns the zipCodeRadio.
	 */
	public String getZipCodeRadio() {
		return zipCodeRadio;
	}
	/**
	 * @param zipCodeRadio The zipCodeRadio to set.
	 */
	public void setZipCodeRadio(String zipCodeRadio) {
		this.zipCodeRadio = zipCodeRadio;
	}
	
	public String getEmployeeType() {
		return employeeType;
	}

	public void setEmployeeType(String employeeType) {
		this.employeeType = employeeType;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public FormFile getAttachement() {
		return attachement;
	}

	public void setAttachement(FormFile attachement) {
		this.attachement = attachement;
	}

	public String getEmailConent() {
		return emailConent;
	}

	public void setEmailConent(String emailConent) {
		this.emailConent = emailConent;
	}


	public String getSubmit() {
		return submit;
	}


	public void setSubmit(String submit) {
		this.submit = submit;
	}
}