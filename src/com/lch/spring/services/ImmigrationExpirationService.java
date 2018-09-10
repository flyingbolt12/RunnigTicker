package com.lch.spring.services;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class ImmigrationExpirationService extends BaseAction {

	private static Logger logger = LoggerFactory.getLogger(ImmigrationExpirationService.class);

	@Autowired
	DoTransaction doTransaction;

	@Autowired
	private GenericXmlApplicationContext appContext;

	public void notifyExpirations() {

		_ctx = appContext;
		logger.info("Start Notifying about to expire immigration details");
		List<Map<String, Object>> employers = doTransaction.getAllBusinessList();
		List<Map<String, Object>> visaExpiresList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> passportExpiresList = new ArrayList<Map<String, Object>>();
		logger.info("No of employer found {}", employers.size());
		for (Map<String, Object> employer : employers){
			try{
				long businessId = new Long(employer.get("businessId").toString()).longValue();
				logger.info("Employer Business Id found to process {}", businessId);
				List<Map<String, Object>> listAllMyEmployees = doTransaction.getAllMyEmployeesWithImmigrationDetails(businessId);
				logger.info("No of employees found for this business {}", listAllMyEmployees.size());
				for(Map<String, Object> employee : listAllMyEmployees)
				{
					logger.info("Processing the list");
					try {
						Date passportExpiryDate = (Date) employee.get("passportExpiryDate");
						Date visaExpiryDate = (Date) employee.get("visaExpiryDate");

						// Today
						Calendar today = Calendar.getInstance();
						logger.info("Today {}", today.getTime());
						
						// Date after 2 months
						Calendar futureDate = Calendar.getInstance();
						futureDate.add(Calendar.MONTH, 2);
						logger.info("After 2 months {}", futureDate.getTime());

						if (visaExpiryDate.before(futureDate.getTime())) {
							logger.info("About to Expire Visa Employee found");
							visaExpiresList.add(employee);
						}

						if (passportExpiryDate.before(futureDate.getTime())) {
							logger.info("About to Expire Passport Employee found");
							passportExpiresList.add(employee);
						}
					} catch (Exception e) {
						logger.info("Error {}", e.getMessage());
						continue;
					}
				}
				logger.info("No of Visa and Passport Employees found {} {}", visaExpiresList.size(), passportExpiresList.size());
				if(visaExpiresList.size() > 0 || passportExpiresList.size() > 0)
				{
				logger.info("Preparing Report");
				// Prepare Report
				StringBuffer visaData= new StringBuffer();
				StringBuffer passportData= new StringBuffer();
				for (Map<String, Object> employee : visaExpiresList) {
					
					Date visaExpiryDate = (Date)employee.get("visaExpiryDate");
					Date visaIssuedDate = (Date)employee.get("visaIssuedDate");
					String visaType = (String)employee.get("visaType");
					String firstName = (String)employee.get("firstName");
					String lastName = (String)employee.get("lastName");
					String employeeEmail = (String)employee.get("contactEmail");
					visaData.append("<tr><td align=\"center\">"+ firstName + lastName+"</td><td align=\"center\" nowrap>"+visaIssuedDate+"</td><td align=\"center\">"+visaExpiryDate+ " -- "+visaType+"</td></tr>");
				}
				
				for (Map<String, Object> employee : passportExpiresList) {
					
					Date passportExpiryDate = (Date)employee.get("passportExpiryDate");
					String passportNumber = (String)employee.get("passportNumber");
					Date passportIssueDate = (Date)employee.get("passportIssueDate");
					
					String firstName = (String)employee.get("firstName");
					String lastName = (String)employee.get("lastName");
					String employeeEmail = (String)employee.get("contactEmail");
					passportData.append("<tr><td align=\"center\">"+ firstName + lastName+"</td><td align=\"center\" nowrap>"+passportIssueDate+"</td><td align=\"center\">"+passportExpiryDate+ " -- No : "+passportNumber+"</td></tr>");
				}
				
				String employerEmail = (String)employer.get("contactEmail");
				logger.info("Shooting Email To : {}", employerEmail);
				ArrayList<String> to = new ArrayList<String>();
				to.add(employerEmail);
				EmailDetails emailDetails = new EmailDetails();
				
				Map<String, String> notification = new HashMap<String, String>();
				notification.put("visas", visaData.toString());
				notification.put("passports", passportData.toString());
				// Shoot Email
				String emailBody = getEmailTemplate(notification,
						VMConstants.VM_IMMIGRATION_REPORT);
			
				emailDetails.setTo(to);
				emailDetails.setEmailContent(new StringBuffer(emailBody));
				logger.debug("Email {}", emailBody);
				emailDetails.setSubject("Report - Immigration Details");
				sendEmail(emailDetails);
				}
				else
				{
					logger.info("No Employees found to process. Moving to next");
				}
				
			}
			catch (Exception e)
			{
				logger.info("Error {}", e.getMessage());
				continue;
			}
		}

		
	
		
	/*	Map<Integer, List<Map<String, Object>>> employees = new HashMap<Integer, List<Map<String, Object>>>();
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
				emailDetails.setFrom(from);
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
			emailDetails.setFrom(from);
			emailDetails.setEmailContent(new StringBuffer(emailBody));
			emailDetails.setSubject("Report - Happy Birthday");
			sendEmail(emailDetails);
			doTransaction.updateBdayRemindersForUser(l);
		}*/

	}

}
