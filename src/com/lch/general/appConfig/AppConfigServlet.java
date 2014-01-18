/*
 * Created on Feb 23, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.general.appConfig;

import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.quartz.CronExpression;
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
import org.springframework.context.support.GenericXmlApplicationContext;

import com.lch.jobs.bday.BDayJob;
import com.lch.jobs.bday.ResetBDayReminderJob;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.admin.ConfirmRegistrationAction;

/**
 * @author Gopi
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class AppConfigServlet extends HttpServlet {

	private static final long serialVersionUID = -8803782732454957359L;
	private final static String CONFIGPATH = "config/spring/applicationContext.xml";
	private static Logger log = LoggerFactory.getLogger(AppConfigServlet.class);

	@Override
	public void init(ServletConfig config) throws ServletException {

		GenericXmlApplicationContext ctx = null;
		try {
			String vcapServices = System.getenv("VCAP_SERVICES");
			if (vcapServices != null)
				log.info(" VCAP SERVICES : {}", System.getenv("VCAP_SERVICES"));
			String profile = System.getProperty("spring.profiles.active");

			// Load Default if NULL
			if (profile == null || (profile != null && profile.length() == 0))
				profile = config.getInitParameter("spring.profiles.active");

			log.info("Spring Profile found : {}", profile);
			ctx = new GenericXmlApplicationContext();
			ctx.getEnvironment().setActiveProfiles(profile);
			ctx.load(CONFIGPATH);
			ctx.refresh();
			config.getServletContext().setAttribute("ctx", ctx);
			log.info("Spring context loaded successfully and now auto configuring jobs one by one...");

			Scheduler scheduler = (Scheduler) ctx.getBean("ilchScheduler");

			JobKey jobKey = new JobKey("Bday" + "_Job", "NotificationGroup");
			JobKey jobKey1 = new JobKey("Bday" + "_Job1", "NotificationGroup");
			JobKey jobKey2 = new JobKey("Bday" + "_Job2", "NotificationGroup");
			log.info("Job Built {}", jobKey.getName());
			TriggerKey tKey_2Hrs = new TriggerKey("Bday_4Hrs" + "_Trigger");
			TriggerKey tKey_12AM = new TriggerKey("Bday_1AM" + "_Trigger");
			TriggerKey tKey_YearlyReset = new TriggerKey("Bday_YearlyReset" + "_Trigger");

			JobDetail jobDetails = null;
			JobDetail jobDetails1 = null;
			JobDetail jobDetails2 = null;
			CronTrigger trigger = null;
			CronTrigger trigger1 = null;
			CronTrigger trigger2 = null;
			try {

				if (!scheduler.checkExists(jobKey) && scheduler.getTrigger(tKey_2Hrs) == null) {
					
					jobDetails = JobBuilder.newJob(BDayJob.class).withIdentity(jobKey.getName(), "NotificationGroup").storeDurably().build();
					jobDetails1 = JobBuilder.newJob(BDayJob.class).withIdentity(jobKey1.getName(), "NotificationGroup").storeDurably().build();
					jobDetails2 = JobBuilder.newJob(ResetBDayReminderJob.class).withIdentity(jobKey2.getName(), "NotificationGroup").storeDurably().build();

					// Every 4 Hrs
					trigger = (CronTrigger) TriggerBuilder.newTrigger().withIdentity(tKey_2Hrs.getName(), "NotificationGroup")
							.withSchedule(CronScheduleBuilder.cronSchedule(new CronExpression("0 0 0/4 1/1 * ? *")).withMisfireHandlingInstructionDoNothing()).build();
					
					// Every Day 1 AM
					trigger1 = (CronTrigger) TriggerBuilder.newTrigger().withIdentity(tKey_12AM.getName(), "NotificationGroup")
							.withSchedule(CronScheduleBuilder.cronSchedule(new CronExpression("0 0 1 1/1 * ? *")).withMisfireHandlingInstructionDoNothing()).build();
					
					// Every Year
					trigger2 = (CronTrigger) TriggerBuilder.newTrigger().withIdentity(tKey_YearlyReset.getName(), "NotificationGroup")
							.withSchedule(CronScheduleBuilder.cronSchedule(new CronExpression("0 0 11 31 12 ? *")).withMisfireHandlingInstructionDoNothing()).build();
					
					log.info("Scheduling job  - {}", "Bday 4 Hrs Execution Job");
					scheduler.scheduleJob(jobDetails, trigger);
					log.info("Scheduling job  - {}", "Bday 1 AM Execution Job");
					scheduler.scheduleJob(jobDetails1, trigger1);
					log.info("Scheduling job - {}", "Bday Reset Every year end on Dec 31 at 11:00 PM");
					scheduler.scheduleJob(jobDetails2, trigger2);
					log.info("Jobs Scheduled");
				} else {
					log.info("Jobs were already scheduled and active. No Action Needed");
				}
				
				log.info("Creating Super Admin...");
				ConfirmRegistrationAction action = new ConfirmRegistrationAction();
				action.createSuperAdmin(ctx);
				//action.createDemoEmployer(ctx);
				
				
				// Set News
				DoTransaction doTransaction = (DoTransaction) ctx.getBean("doTransaction");
				List<String> news = doTransaction.listNews();
				
				config.getServletContext().setAttribute("news", news);
				
				
			} catch (Exception e) {
				log.error("Unable to Start Scheduler {}", e.getMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
