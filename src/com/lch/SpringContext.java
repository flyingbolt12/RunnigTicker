package com.lch;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.lch.general.appConfig.AppConfigServlet;

public class SpringContext implements ApplicationContextAware {
	  private static ApplicationContext CONTEXT;
	  private static Logger log = LoggerFactory.getLogger(AppConfigServlet.class);
	  
	@Override
	public void setApplicationContext(ApplicationContext ctx) throws BeansException {
		log.info("SPRING CONTEXT FROM SERVLET INITIALIZED");
		 CONTEXT = ctx;
	}
	
	public static Object getBean(String beanName) {
	    return CONTEXT.getBean(beanName);
	 }
}
