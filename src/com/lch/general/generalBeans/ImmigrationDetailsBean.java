package com.lch.general.generalBeans;

import java.sql.Date;

public class ImmigrationDetailsBean {

	private long idimmigrationdetails;
	private String visaType;
	private Date passportExpiryDate;
	private Date visaIssuedDate;
	private Date visaExpiryDate;
	private Date passportIssueDate;
	private String passportNumber;
	private long userId;

	public long getIdimmigrationdetails() {
		return idimmigrationdetails;
	}

	public void setIdimmigrationdetails(long idimmigrationdetails) {
		this.idimmigrationdetails = idimmigrationdetails;
	}

	public String getVisaType() {
		return visaType;
	}

	public void setVisaType(String visaType) {
		this.visaType = visaType;
	}

	public Date getPassportExpiryDate() {
		return passportExpiryDate;
	}

	public void setPassportExpiryDate(Date passportExpiryDate) {
		this.passportExpiryDate = passportExpiryDate;
	}

	public Date getVisaIssuedDate() {
		return visaIssuedDate;
	}

	public void setVisaIssuedDate(Date visaIssuedDate) {
		this.visaIssuedDate = visaIssuedDate;
	}

	public Date getVisaExpiryDate() {
		return visaExpiryDate;
	}

	public void setVisaExpiryDate(Date visaExpiryDate) {
		this.visaExpiryDate = visaExpiryDate;
	}

	public Date getPassportIssueDate() {
		return passportIssueDate;
	}

	public void setPassportIssueDate(Date passportIssueDate) {
		this.passportIssueDate = passportIssueDate;
	}

	public String getPassportNumber() {
		return passportNumber;
	}

	public void setPassportNumber(String passportNumber) {
		this.passportNumber = passportNumber;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

}
