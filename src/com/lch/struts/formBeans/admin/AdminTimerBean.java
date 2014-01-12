package com.lch.struts.formBeans.admin;

import org.apache.struts.upload.FormFile;

import com.lch.general.enums.TimerStatus;
import com.lch.struts.formBeans.CommonValidatorForm;

@SuppressWarnings("serial")
public class AdminTimerBean extends CommonValidatorForm {

	private long timerId;
	private String contentId;
	private String cronExpression;
	private String timerName;
	private String status = TimerStatus.ACTIVE.name();
	private String emailContent;
	private String contentName;
	private String signature;
	private String attachmentId;
	private FormFile attachment;
	private String subject;
	private String employeeType;
	private String attachmentName;
	private String action;
	
	public String getActualContentId() {
		return contentId;
	}

	public void setActualContentId(String actualContentId) {
		this.contentId = actualContentId;
	}
	
	public String getEmployeeType() {
		return employeeType;
	}

	public void setEmployeeType(String employeeType) {
		this.employeeType = employeeType;
	}

	public String getCronExpression() {
		return cronExpression;
	}

	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public long getTimerId() {
		return timerId;
	}

	public void setTimerId(long timerId) {
		this.timerId = timerId;
	}

	public String getContentId() {
		return contentId;
	}
	public String getContentIdd() {
		return contentId;
	}
	public void setContentId(String contentId) {
		this.contentId = contentId;
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

	public String getEmailContent() {
		return emailContent;
	}

	public void setEmailContent(String emailContent) {
		this.emailContent = emailContent;
	}

	public String getContentName() {
		return contentName;
	}

	public void setContentName(String contentName) {
		this.contentName = contentName;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getAttachmentId() {
		return attachmentId;
	}

	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	public FormFile getAttachment() {
		return attachment;
	}

	public void setAttachment(FormFile attachment) {
		this.attachment = attachment;
	}

	public String getAttachmentName() {
		return attachmentName;
	}

	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

}
