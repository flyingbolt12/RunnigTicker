package com.lch.struts.formBeans;

import org.apache.struts.validator.ValidatorForm;

@SuppressWarnings("serial")
public class InviteotherBusinessBean extends ValidatorForm{

	private String emailsList;

	public String getEmailsList() {
		return emailsList;
	}

	public void setEmailsList(String emailsList) {
		this.emailsList = emailsList;
	}
	
}
