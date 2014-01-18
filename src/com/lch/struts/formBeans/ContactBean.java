package com.lch.struts.formBeans;

import java.io.Serializable;

import javax.servlet.ServletRequest;

import org.apache.struts.action.ActionMapping;
import org.apache.struts.validator.ValidatorForm;

@SuppressWarnings("serial")
public class ContactBean extends ValidatorForm implements Serializable{
	
	private String firstName="";
	private String lastName="";
	private String company="";
	private String address="";
	private String city="";
	private String state="";
	private String zip="";
	private String phone="";
	private String email="";
	private String subject="";
	private String comment="";
	private long userId;
	
	private String employerEmail="";
	
	public String getEmployerEmail() {
		return employerEmail;
	}
	public void setEmployerEmail(String employerEmail) {
		this.employerEmail = employerEmail;
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
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public void reset(ActionMapping mapping, ServletRequest request)
	{
		/*
		  firstName=null;
		lastName=null;
		company=null;
		address=null;
		city=null;
		state=null;
		zip=null;
		phone=null;
		email=null;
		subject=null;
		comment=null;
		
		*/
		
	}
	
	
	
	
	
	
	
	
	
	
}
	
