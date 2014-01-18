package com.lch.struts.formBeans;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

@SuppressWarnings("serial")
public class NotifyEmployeesBean extends CommonValidatorForm
{
	
	public String submit="";
	
	private String employeeType;
	private String subject;
	private FormFile attachement ;
	private String emailContent;

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		submit=null;
		emailContent=null;
	}

	public String getSubmit() {
		return submit;
	}

	public void setSubmit(String submit) {
		this.submit = submit;
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

	public String getEmailContent() {
		return emailContent;
	}

	public void setEmailContent(String emailContent) {
		this.emailContent = emailContent;
	}



}