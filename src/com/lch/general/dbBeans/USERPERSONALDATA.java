package com.lch.general.dbBeans;

import java.sql.Timestamp;

public class USERPERSONALDATA {
	
	private long iduserData = 0;
	private String firstName = "";
	private String lastName = "";
	private String middleName = "";
	private long clientId = 0;
	private long clientAddressId = 0;
	private long myAddressId = 0;
	private String contactEmail = "";
	private String fatherName = "";
	private String phoneNumber = "";
	private String countryCitizenship = "";
	private Timestamp dobDate;
	private String employerAddressId = "";
	private String homeCountryAddressId = "";
	private String gendar = "";
	private String profilePath;

	public Timestamp getDobDate() {
		return dobDate;
	}

	public void setDobDate(Timestamp dobDate) {
		this.dobDate = dobDate;
	}

	public long getIduserData() {
		return iduserData;
	}

	public void setIduserData(long iduserData) {
		this.iduserData = iduserData;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public long getClientId() {
		return clientId;
	}

	public void setClientId(long clientId) {
		this.clientId = clientId;
	}

	public long getClientAddressId() {
		return clientAddressId;
	}

	public void setClientAddressId(long clientAddressId) {
		this.clientAddressId = clientAddressId;
	}

	public long getMyAddressId() {
		return myAddressId;
	}

	public void setMyAddressId(long myAddressId) {
		this.myAddressId = myAddressId;
	}

	public String getContactEmail() {
		return contactEmail;
	}

	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}

	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getCountryCitizenship() {
		return countryCitizenship;
	}

	public void setCountryCitizenship(String countryCitizenship) {
		this.countryCitizenship = countryCitizenship;
	}

	public String getEmployerAddressId() {
		return employerAddressId;
	}

	public void setEmployerAddressId(String employerAddressId) {
		this.employerAddressId = employerAddressId;
	}

	public String getHomeCountryAddressId() {
		return homeCountryAddressId;
	}

	public void setHomeCountryAddressId(String homeCountryAddressId) {
		this.homeCountryAddressId = homeCountryAddressId;
	}

	public String getProfilePath() {
		return profilePath;
	}

	public void setProfilePath(String profilePath) {
		this.profilePath = profilePath;
	}

	public String getGendar() {
		return gendar;
	}

	public void setGendar(String gendar) {
		this.gendar = gendar;
	}

}
