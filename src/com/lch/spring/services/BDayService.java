package com.lch.spring.services;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;



import org.apache.commons.validator.routines.EmailValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.lch.general.constants.VMConstants;
import com.lch.general.email.EmailDetails;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;

@Service
public class BDayService extends BaseAction {

	private static Logger logger = LoggerFactory.getLogger(BDayService.class);

	@Autowired
	DoTransaction doTransaction;

	@Autowired
	private GenericXmlApplicationContext appContext;

	public void notifyBdays() {

		_ctx = appContext;
		
		Map<Integer, List<Map<String, Object>>> employees = new HashMap<Integer, List<Map<String, Object>>>();
		Map<Integer, Map<String, Object>> employers = new HashMap<Integer, Map<String, Object>>();

		List<Map<String, Object>> users = doTransaction.getTodayBdayUsers();

		// Separate Users by Business Id
 		for (Map<String, Object> map : users) {

			Integer businessId = (Integer) map.get("businessId");
			logger.debug("Business Id {}", businessId);

			List<Map<String, Object>> list = employees.get(businessId);
			if (list == null) {
				logger.debug("creating employee list for {}", businessId);
				list = new ArrayList<Map<String, Object>>();
			}
			logger.info("Role of User {}", map.get("role"));
			// Super ADMIN is eliminated at SQL
			if (!map.get("role").equals("ADMIN")) {
				logger.debug("Adding user for {}", businessId);
				list.add(map);
				employees.put(businessId, list);
			} else {
				employers.put(businessId, map);
			}
		}

		Set<Integer> set = employees.keySet();
		ArrayList<String> to = new ArrayList<String>();
		EmailDetails emailDetails = new EmailDetails();
		
		StringBuffer report = new StringBuffer("<tr><td colspan=\"3\">Following users notified with their Bday Wishes</td></tr>");
		// Process individual user and create Report to send to admin
		for (Integer l : set) {
			try{
			users = employees.get(l);
			String from = (String)((Map<String, Object>)employers.get(l)).get("contactEmail");
			String fromName = (String)((Map<String, Object>)employers.get(l)).get("firstName");
			
			if(from == null)
				continue;
			
			for (Map<String, Object> map : users) {
				to.clear();
				String userEmail = (String) map.get("contactEmail");
				String firstName = (String) map.get("firstName");
				Date dob = (Date) map.get("dob");
				
				report.append("<tr><td height=\"23\" width=\"205\">").append(firstName).append("</td><td height=\"23\" width=\"211\">").append(userEmail).append("</td><td height=\"23\" width=\"231\">").append(dob).append("</td></tr>");
				
				if(EmailValidator.getInstance().isValid(userEmail)) {
					to.add(userEmail);
				}
				
				String emailBody = getEmailTemplate("..."+fromName,
						VMConstants.VM_HAPPY_BDAY);

				emailDetails.setCc(to);
				emailDetails.setReplyTo(from);
				emailDetails.setEmailContent(new StringBuffer(emailBody));
				emailDetails.setSubject("Happy Birthday, "+firstName);
				sendEmail(emailDetails);
			}
			// Send report to Business Admin
			to.clear();
			if(EmailValidator.getInstance().isValid(from)) {
				to.add(from);
			}
			
			String emailBody = getEmailTemplate(report.toString(),
					VMConstants.VM_BDAY_REPORT);
		
			emailDetails.setCc(to);
			emailDetails.setReplyTo(from);
			emailDetails.setEmailContent(new StringBuffer(emailBody));
			emailDetails.setSubject("Report - Happy Birthday");
			sendEmail(emailDetails);
			doTransaction.updateBdayRemindersForUser(l);
			}
			catch (Exception e) {
				logger.error("B'Day Job Not executed {}", e.getMessage());
				e.printStackTrace();
			}
		}
		
	}

	public void resetStudentBDayReminder() {
		 doTransaction.resetBdayReminders();
	}

}
