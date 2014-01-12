package com.lch.general.dbBeans;

import java.sql.Timestamp;

import com.lch.struts.formBeans.CommonValidatorForm;

@SuppressWarnings("serial")
public class ScheduledTimers extends CommonValidatorForm{
	
	private String timerId;
	private String contentId;
	private Timestamp dateCreated;
	private String cronExpression;
	private String timerName;
	private String status="ACTIVE";
	public String getTimerId() {
		return timerId;
	}
	public void setTimerId(String timerId) {
		this.timerId = timerId;
	}
	public String getContentId() {
		return contentId;
	}
	public void setContentId(String contentId) {
		this.contentId = contentId;
	}
	public Timestamp getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(Timestamp dateCreated) {
		this.dateCreated = dateCreated;
	}
	public String getCronExpression() {
		return cronExpression;
	}
	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}
	public String getTimerName() {
		return timerName;
	}
	public void setTimerName(String timerName) {
		this.timerName = timerName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
