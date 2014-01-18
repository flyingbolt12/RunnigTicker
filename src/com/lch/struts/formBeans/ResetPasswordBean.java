package com.lch.struts.formBeans;

import org.apache.struts.validator.ValidatorForm;

public class ResetPasswordBean extends ValidatorForm {
	
	private static final long serialVersionUID = -8714082393834896228L;
	private String password ="";
	private String confirmPassword="";
	
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
	
	

}
