package com.lch.struts.formBeans;

import org.apache.struts.validator.ValidatorForm;


public class SuperAdminBean extends ValidatorForm {

	public String startTime;
	public String endTime;
	public String outageDate;
	
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getOutageDate() {
		return outageDate;
	}
	public void setOutageDate(String outageDate) {
		this.outageDate = outageDate;
	}
}
