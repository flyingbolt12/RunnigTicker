package com.lch.jobs;

import java.io.Serializable;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.lch.spring.services.ImmigrationExpirationService;
import com.lch.struts.actions.ApproveUserByAdminAction;

public class ImmigrationExpirationReminderJob extends QuartzJobBean implements Serializable {
	private static final long serialVersionUID = 4925695908034508728L;
	private static Logger logger = LoggerFactory.getLogger(ApproveUserByAdminAction.class);

	@Override
	protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		logger.info("Job Execution Started--> ResetBDayReminderJob Running for every year");

		SchedulerContext schedulerContext;
		try {
			schedulerContext = ctx.getScheduler().getContext();
			ApplicationContext applicationContext = (ApplicationContext) schedulerContext.get("applicationContext");

			ImmigrationExpirationService service = (ImmigrationExpirationService) applicationContext.getBean("immigrationExpirationService");

			service.notifyExpirations();

		} catch (SchedulerException e) {
			e.printStackTrace();
			logger.error("JOB EXECUTYION FAILED ", e);
		}
	}
}
