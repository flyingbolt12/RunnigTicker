package com.lch.struts.actions.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.constants.VMConstants;
import com.lch.general.email.EmailDetails;
import com.lch.general.enums.TimeSheetStatus;
import com.lch.general.generalBeans.VMInputBean;
import com.lch.struts.actions.BaseAction;
@SuppressWarnings("rawtypes")
public class AdminEmailApproval extends BaseAction{
	private static Logger log = LoggerFactory
			.getLogger(AdminEmailApproval.class);
	
	public ActionForward execute(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ActionForward forward ;
		String bid = request.getParameter("p");
		
		String onlyId = bid.substring(0, 2);
		int i = new Integer(onlyId).intValue();
		i = i-2;
		int length = new Integer(bid.substring(bid.lastIndexOf("_")+1,
				bid.length())).intValue();

		String id = bid.substring(i, i+length);
		log.info(id);
		List emails;
		String status ="";
		long userId = 0;
		try {
			userId = new Integer(id).intValue();
		} catch (Exception e) {
			userId = 0;
		}
		emails = getSpringCtxDoTransactionBean().listUserEmails(userId + "");
		status = getSpringCtxDoTransactionBean().approveOrRejectEmployeeRegistrationPendingApprovals(TimeSheetStatus.APPROVED.name(),
				userId);
		
		putObjInRequest("approvalMsg", request, status);
		sendApprovalStatusEmail(emails, status);
		forward= mapping.findForward("approvalMsg");
		return forward;
		
	}
	@SuppressWarnings("unchecked")
	private void sendApprovalStatusEmail(List emails, String status) {
		if(emails == null)
		{
			log.error("Invalid emails list");
			return;
		}
		log.info("sending approval status email");
		emails = processEmails(emails);
		VMInputBean bean = new VMInputBean();
		if(status.equals(TimeSheetStatus.APPROVED.name())){
			status = "Your registration request is approved by your employer. Now you can login into the system.";
		}
		else if(status.equals(TimeSheetStatus.REJECTED.name())){
			status = "Your registration request is denied by your employer. Contact your employer to know what causes this desicion";
		}
		else{
			
		}
		bean.setText(status);

		EmailDetails emailDetails = new EmailDetails();
		emailDetails.setBcc(emails);
		emailDetails.setSubject("Your RunningTicker  Approval Status");
		String sb = getEmailTemplate(bean, VMConstants.VM_APPROVAL_STATUS);
		emailDetails.setEmailContent(new StringBuffer(sb));
		sendEmail(emailDetails);
	}
	private List<String> processEmails(List<Map<String, String>> emailsMap)
	{
		List<String> emails = new ArrayList<String>();
		
		for (Map<String, String> m : emailsMap)
			emails.add(m.get("contactEmail"));
		
		return emails;
	}

}
