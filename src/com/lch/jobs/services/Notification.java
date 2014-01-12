package com.lch.jobs.services;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.quartz.JobDetail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.lch.general.constants.VMConstants;
import com.lch.general.dbBeans.LCH_BUSINESS;
import com.lch.general.email.EmailDetails;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.general.genericUtils.EmailsReport;
import com.lch.struts.actions.BaseAction;

public class Notification extends BaseAction {

	private static Logger logger = LoggerFactory.getLogger(Notification.class);

	public void sendNotification(JobDetail jobDetail) {
		if (_ctx == null) {
			logger.error("No Context Set into it..Please set by using setContext Method");
		}

		
		String contentId = (String) jobDetail.getJobDataMap().get("contentId");
		String notificationGroupType = (String) jobDetail.getJobDataMap().get("notificationGroupType");

		logger.info("--> {}{}", contentId, notificationGroupType);
		Map<String, Object> contentDetails = getSpringCtxDoTransactionBean().getTimerContentDetailsById(contentId);
		logger.info("contentDetails {}", contentDetails);
		
		long businessId = Long.valueOf((Integer)contentDetails.get("businessId"));
		long userId = (Long)contentDetails.get("userId");
		String emailContent = (String) contentDetails.get("emailContent");
		String contentName = (String) contentDetails.get("contentName");
		String subject = (String) contentDetails.get("subject");
		String attachmentId = (String) contentDetails.get("attachmentId");
	
		
		Map<String, Object> attachedMap = getSpringCtxDoTransactionBean().getAttachmentDetails(attachmentId);
		
		LCH_BUSINESS business = getSpringCtxDoTransactionBean().getBusinessDetails(businessId,userId);
		List<String> bcc = new ArrayList<String>();

		EmailDetails emailDetails = new EmailDetails();
		List<Map<String, String>> listAllMyEmployees;
		if (notificationGroupType.equals("all")) {
			listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesEmails(businessId);
		} else {
			listAllMyEmployees = getSpringCtxDoTransactionBean().getAllMyEmployeesEmailsByTimeSheetConfiguration(businessId, notificationGroupType);
		}

		for (Map<String, String> email : listAllMyEmployees) {
			bcc.add(email.get("contactEmail"));
		}
		
		VMInputBean vmbean = new VMInputBean();
		vmbean.setText(emailContent);
		emailDetails.setSubject(subject);
		String sb = getEmailTemplate(vmbean,VMConstants.VM_TIMER_NOTIFICATION);
		emailDetails.setEmailContent(new StringBuffer(sb));
		emailDetails.setBcc(bcc);
		
		if(attachedMap!=null && attachedMap.size() > 0)
		{
			String docPath = (String)attachedMap.get("docAPath");
			logger.info("Doc Path for attachement found {}", docPath);
			File f = new File(docPath);
			emailDetails.setAttachment( f);
		}
		
		emailDetails.setFrom(business.getEmployerEmail());
		sendEmail(emailDetails);

		StringBuffer reportContent = EmailsReport.getReportReport(business.getEmployerEmail(), bcc);
		
		emailDetails = new EmailDetails();
		emailDetails.setSubject("Status Report of Job " +contentName);
		emailDetails.setEmailContent(new StringBuffer(reportContent));
		List<String> to = new ArrayList<String>();
		to.add(business.getEmployerEmail());
		emailDetails.setTo(to);
		sendEmail(emailDetails);
		
	}
	
	public void setContext(GenericXmlApplicationContext ctx) {
		_ctx = ctx;
	}
}
