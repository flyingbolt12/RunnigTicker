package com.lch.struts.actions.admin;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.dbBeans.TimerContents;
import com.lch.general.enums.TimerStatus;
import com.lch.general.generalBeans.UserProfile;
import com.lch.jobs.CustomJob;
import com.lch.struts.actions.BaseAction;
import com.lch.struts.formBeans.admin.AdminTaskBean;
import com.lch.struts.formBeans.admin.AdminTimerBean;

/**
 * @version 1.0
 * @author
 */
public class AdminFunctTaskImplAction extends BaseAction {
	private static Logger log = LoggerFactory.getLogger(AdminFunctTaskImplAction.class);

	

	public ActionForward showCreateTask(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showCreateTask");

		String isForTimerContentCreation = getStrAsRequestParameter("isForTimerContentCreation", request);
		log.info("isForTimerContentCreation: " + isForTimerContentCreation);
		putObjInSession("isForTimerContentCreation", request, isForTimerContentCreation);

		return forward;
	}

	public ActionForward createTask(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
		AdminTaskBean taskBean = (AdminTaskBean) form;
		log.info("Creating admin task: {}", taskBean.getTaskName());
		long id = getSpringCtxDoTransactionBean().insertAdminTask(taskBean);
		ActionForward forward = new ActionForward();
		// TODO: more to do here
		if (id != -1) {
			log.info("Admin task created with id: {}", id);
			forward = mapping.findForward("listTasks");
		} else {
			log.info("Admin task creation failed");
			forward = mapping.findForward("showCreateTask");
		}
		return forward;
	}

	public ActionForward listTasks(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("listTasks");

		List<AdminTaskBean> tasks = null;
		try {
			tasks = getSpringCtxDoTransactionBean().getAllNonDeletedAdminTasks();
			putObjInRequest("taskCount", request, tasks.size());
			putObjInRequest("taskList", request, tasks);
		} catch (Exception ex) {
			log.error("Error while getting admin task list", ex);
			putObjInRequest("errorMsg", request, "An error occured while getting the tasks. Please try again later.");
		}

		return forward;
	}

	public ActionForward createTimerContent(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String isForTimerContentCreation = (String) getObjFrmSession("isForTimerContentCreation", request);
		if (isForTimerContentCreation != null && isForTimerContentCreation.length() > 0) {
			String cancel = request.getParameter("cancel");
			if (cancel != null)
				return mapping.findForward("showTimerCreationPage");
		}
		
		String action = (String)getStrAsRequestParameter("action", request);
		
		if(action!=null && action.equals("Update")){
			
			log.info("Save the edit content page by {} for id {}", getUserProfile(request).getFirstName(), getStrAsRequestParameter("id", request));
			
			AdminTimerBean adminTimerBean = (AdminTimerBean)form;
			TimerContents emailContent = new TimerContents();
			BeanUtils.copyProperties(emailContent, adminTimerBean);

			Timestamp date = new Timestamp(Calendar.getInstance().getTimeInMillis());
			emailContent.setDateCreated(date);
			emailContent.setContentId(getStrAsRequestParameter("id", request));
			int i = getSpringCtxDoTransactionBean().updateTimerEmailContent(emailContent);
			if(i>0)
			{
				putObjInRequest("status", request, "Updated successfully");
			}
			else
			{
				putObjInRequest("status", request, "Failed to update.");
			}
			return handleEmailContentDeleteEdit(mapping, form, request, response);
		}
		else
		{
		
		log.info("New Timer Content Creating by User : " + getUserProfile(request).getFirstName());
		AdminTimerBean adminTimerBean = (AdminTimerBean) form;
		ActionForward forward = new ActionForward();

		String aFilePath = getApplicationPathToOneUP() + "timerDocs";
		String rFilePath = "/timerDocs/";

		getSpringCtxDoTransactionBean().createTimerContent(adminTimerBean, getUserProfile(request), aFilePath, rFilePath);
		putObjInRequest("selectedBusinessReminderEmailContentId", request, adminTimerBean.getContentName());

		forward = mapping.findForward("showTimerCreationPage");
		return forward;
		}
	}

	@SuppressWarnings("unchecked")
	public ActionForward selectExistingEmailContent(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		log.info("Moving to selectExistingEmailContent");
		List<Map<String, Object>> listBusinessEmailContent = getSpringCtxDoTransactionBean().listTimerContents(getUserProfile(request));
		
		if( listBusinessEmailContent.size() > 0 )
		{
			forward = mapping.findForward("selectExistingEmailContent");
			putObjInRequest("listBusinessEmailContent", request, listBusinessEmailContent);
		}
		else
		{
			putObj4generalAJAXMsg(request, "None Created. Create one now!");
			forward = mapping.findForward("generalJSP4AJAXMsg");			
		}
		
		return forward;
	}

	public ActionForward updateTimerStatus(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		AdminTimerBean adminTimerBean = (AdminTimerBean) form;
		Scheduler scheduler = getSpringCtxQuartzScheduler();

		// Map<String, Object> timer =
		// getSpringCtxDoTransactionBean().getTimerById(adminTimerBean.getTimerId());

		if (adminTimerBean.getTimerId() <= 0) {
			putStatusObjInRequest(request, "Unable to process");
			return mapping.findForward("status");
		}

		String status = adminTimerBean.getStatus();
		Map<String, String> map = new HashMap<String, String>();
		map.put("timerId", String.valueOf(adminTimerBean.getTimerId()));
		if (status.equals(TimerStatus.ACTIVE.name())) {
			scheduler.resumeJob(buildJobKey(adminTimerBean));
			map.put("status", TimerStatus.ACTIVE.name());
			getSpringCtxDoTransactionBean().updateTimerStatus(map);
		} else if (status.equals(TimerStatus.DISABLE.name())) {
			scheduler.pauseJob(buildJobKey(adminTimerBean));
			map.put("status", TimerStatus.DISABLE.name());
			getSpringCtxDoTransactionBean().updateTimerStatus(map);
		} else if (status.equals(TimerStatus.DELETE.name())) {
			scheduler.pauseJob(buildJobKey(adminTimerBean));
			scheduler.deleteJob(buildJobKey(adminTimerBean));
			getSpringCtxDoTransactionBean().deleteTimer(adminTimerBean.getTimerId());
		}

		return mapping.findForward("showTimers");
	}

	private JobKey buildJobKey(AdminTimerBean adminTimerBean) {
		JobKey jobKey = new JobKey(adminTimerBean.getTimerName() + "_Job", "NotificationGroup");
		log.info("Job Key Built {}", jobKey.getName());
		return jobKey;
	}
	public ActionForward showManageEmailContentsPage(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("--manageEmailContents--");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showManageEmailContents");
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = userProfile.getUserId();
		log.info("userId : {} businessId : {}", userId , businessId);
		List<Map<String, Object>> list = getSpringCtxDoTransactionBean().listDeletableEmailContents(userId, businessId);
		log.info("list {}", list);
		putObjInRequest("list", request, list);
		List<Map<String, Object>> list1 = getSpringCtxDoTransactionBean().listNonDeletableEmailContents(userId, businessId);
		log.info("list1 {}", list1);
		putObjInRequest("list1", request, list1);
		return (forward);
	}
	public ActionForward handleEmailContentDeleteEdit(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.info("--handleEmailContent--");
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("showManageEmailContents");
		UserProfile userProfile = getUserProfile(request);
		long businessId = userProfile.getBusinessId();
		long userId = userProfile.getUserId();
		
		if(request.getParameter("action").equals("DELETE"))
		{
			log.info("Delete the email content {}", request.getParameter("id"));
			int i = getSpringCtxDoTransactionBean().deleteEmailContent(getLongAsRequestParameter("id", request));
			if(i>0)
			{
				putObjInRequest("status", request, "Deleted successfully");
			}
			else
			{
				putObjInRequest("status", request, "Failed to delete.");
			}
		}
		else if (request.getParameter("action").equals("EDIT")){
			log.info("Edit the email content {}", request.getParameter("id"));
			putObjInRequest("isTimerContentToUpdate", request, "yes");
			putObjInRequest("id", request, request.getParameter("id"));
			Map<String, Object> map = getSpringCtxDoTransactionBean().getTimerContentDetailsById(request.getParameter("id"));
			AdminTimerBean bean = new AdminTimerBean();
			BeanUtils.copyProperties(bean, map);
			putObjInRequest("adminTimerBean", request, bean);
			return mapping.findForward("showCreateTimeContent");
		}
		
		return showManageEmailContentsPage(mapping, form, request, response);
	}

	public ActionForward createTimer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("statusDef");
		log.info("Creating the Timer");
		AdminTimerBean adminTimerBean = (AdminTimerBean) form;

		Scheduler scheduler = getSpringCtxQuartzScheduler();

		JobKey jobKey = buildJobKey(adminTimerBean);
		TriggerKey tKey = new TriggerKey(adminTimerBean.getTimerName() + "_Trigger");

		JobDetail jobDetails = null;
		CronTrigger trigger = null;
		Date date = null;
		try {
			jobDetails = JobBuilder.newJob(CustomJob.class).withIdentity(jobKey.getName(), "NotificationGroup").storeDurably().build();
			trigger = (CronTrigger) TriggerBuilder.newTrigger().withIdentity(tKey.getName(), "NotificationGroup").withSchedule(CronScheduleBuilder.cronSchedule(adminTimerBean.getCronExpression()).withMisfireHandlingInstructionDoNothing())
					.build();

			jobDetails.getJobDataMap().put("contentId", adminTimerBean.getContentId());
			jobDetails.getJobDataMap().put("notificationGroupType", adminTimerBean.getEmployeeType());

			if (!scheduler.checkExists(jobKey) && scheduler.getTrigger(tKey) == null) {
				date = scheduler.scheduleJob(jobDetails, trigger);
				log.info("Job Scheduled");

				if (date != null)
					getSpringCtxDoTransactionBean().createTimer(adminTimerBean, getUserProfile(request));

				putStatusObjInRequest(request, "<p align=\"center\"><b>Timer Created Successfully and it is now ACTIVE.<b></p>");

			} else {
				putStatusObjInRequest(request, "<p align=\"center\"> <b> Failed to create timer, as name already exists</b></p>");
			}

		} catch (Exception e) {
			putStatusObjInRequest(request, "<p align=\"center\"><b>Unable to create timer...Check whether you entered correct details or not<b></p>");
			return forward;
		}

		return forward;

	}

	public ActionForward cancelTimer(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward = mapping.findForward("cancelTimer");
		log.info("Cancelling the Timer Creation");
		return forward;
	}

	public ActionForward checkTaskNameAvailability(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String timerName = request.getParameter("ajaxParam");
		String ajaxMsg = "";
		int timerNamesCount =0;
		try {
			timerNamesCount = getSpringCtxDoTransactionBean().checkTimerNameAvailablity(timerName);
			log.info("No Of Timer Names available for with this Timer Name - " + timerNamesCount);
			if(timerNamesCount ==0)
			{    
				log.info("message");
				//ajaxMsg = "Congratulations, This Timer Name is availbale.";
				ajaxMsg = "";
				putObjInRequest("generalAJAXMsg", request, ajaxMsg);
				log.info("message");
			}
			else
			{    log.info("message");
				ajaxMsg = "Sorry, This Timer Name is not availbale.";
				putObjInRequest("generalAJAXMsg", request, ajaxMsg);
				putObjInRequest("disableSubmitRequired", request, "disableSubmitRequired");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			putObjInRequest("generalAJAXMsg", request,
					"Unable to Identify. Please proceed next");
		}

		return mapping.findForward("generalJSP4AJAXMsg");
	}	
}
