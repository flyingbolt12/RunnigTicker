package com.lch.jobs;



import java.io.Serializable;

import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.lch.jobs.services.Notification;
import com.lch.struts.actions.ApproveUserByAdminAction;

public class CustomJob extends QuartzJobBean implements Serializable
{
	private static final long serialVersionUID = 4275673822970616161L;
	private static Logger logger = LoggerFactory
			.getLogger(ApproveUserByAdminAction.class);

	@Override
	protected void executeInternal(JobExecutionContext ctx)
			throws JobExecutionException
	{

		logger.info("Job Execution Started--> Custom job");

		SchedulerContext schedulerContext;
		try
		{
			schedulerContext = ctx.getScheduler().getContext();
			GenericXmlApplicationContext applicationContext = (GenericXmlApplicationContext) schedulerContext
					.get("applicationContext");
			
			JobDetail jobDetails = ctx.getJobDetail();
			
			Notification notification = new Notification();
			notification.setContext(applicationContext);
			notification.sendNotification(jobDetails);
			
			notification = null;
			schedulerContext = null;
			applicationContext  = null;
			jobDetails = null;
			
		}
		catch (SchedulerException e)
		{
			e.printStackTrace();
			logger.error("JOB EXECUTYION FAILED ", e);
		}
	}
}
