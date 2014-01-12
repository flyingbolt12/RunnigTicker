package com.lch.general.email;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.InternetAddress;

public class EmailDetails {

	private List<String> to = new ArrayList<String>();
	private List<String> cc = new ArrayList<String>();
	private List<String> bcc = new ArrayList<String>();
	private String from = "contact@allibilli.com";
	private StringBuffer emailContent = new StringBuffer();
	private String subject = "ILCH";
	private File attachment = null;

	public File getAttachment() {
		return attachment;
	}

	public void setAttachment(File attachment) {
		this.attachment = attachment;
	}

	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * @param subject
	 *            the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	public Object[] getTo() throws Exception {
		InternetAddress[] add = new InternetAddress[to.size()];
		int i = 0;
		for (String email : to) {
			add[i] = new InternetAddress(email);
			++i;
		}
		return add;
	}

	public InternetAddress[] getCc() throws Exception {

		InternetAddress[] add = new InternetAddress[cc.size()];
		int i = 0;
		for (String email : cc) {
			add[i] = new InternetAddress(email);
			++i;
		}
		return add;
	}


	public void setTo(List<String> to) {
		this.to = to;
	}

	public void setCc(List<String> cc) {
		this.cc = cc;
	}

	public void setBcc(List<String> bcc) {
		this.bcc = bcc;
	}

	public Object[] getBcc() throws Exception {
		InternetAddress[] add = new InternetAddress[bcc.size()];
		int i = 0;
		for (String email : bcc) {
			add[i] = new InternetAddress(email);
			++i;
		}
		return add;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public StringBuffer getEmailContent() {
		return emailContent;
	}

	public void setEmailContent(StringBuffer emailContent) {
		this.emailContent = emailContent;
	}

	public String toString() {
		return super.toString();
	}

}
