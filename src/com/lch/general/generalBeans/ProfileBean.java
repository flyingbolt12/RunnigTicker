package com.lch.general.generalBeans;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ProfileBean {

	
	private @Value("#{profileProps['profile.business.approve.email']}")
	String busApprovalEmail = null;

	public String getBusApprovalEmail() {
		return busApprovalEmail;
	}

	public void setBusApprovalEmail(String busApprovalEmail) {
		this.busApprovalEmail = busApprovalEmail;
	}
	
}
