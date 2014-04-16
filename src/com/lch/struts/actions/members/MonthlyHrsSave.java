package com.lch.struts.actions.members;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.UserProfile;
import com.lch.general.genericUtils.DateUtils;

/**
 * @version 1.0
 * @author
 */
public class MonthlyHrsSave extends SaveHours {
	private static Logger logger = LoggerFactory.getLogger(MonthlyHrsSave.class);
	public String makeString(String array[],int weekNum,DateUtils du, String submissionType,UserProfile userProfile, String submissionFor)
	{
		String weekBeginDate = du.getWeekBeginingDate(weekNum,du);
		String weekEndingDate = du.getWeekEndingDate(weekNum, du);
		StringBuffer temp=new StringBuffer(weekNum+DELIMETER+weekBeginDate+DELIMETER+weekEndingDate+DELIMETER);
		logger.info("{}", temp);
		String value="";
		Double d;
		Double weekTotal=0.00d;
		for(int i=0; i<7; ++i)
		{
			value=array[i]; 
			try{
				 d = Double.valueOf(value);
				 weekTotal+=d;
			}
			catch (NumberFormatException e) {
				e.printStackTrace();
				value="0.00";
				temp.append(value+DELIMETER);
				continue;
			}
			temp.append(value+DELIMETER);
		}
		if(weekTotal == 0.00d)
			return null;
		temp.append(submissionType);
		
		temp.append("__"+du.getYear()+"__"+userProfile.getUserId()+"__"+userProfile.getBusinessId()+"__"+weekTotal+"__"+du.getMonth()+"__"+userProfile.getTimeSheetConfiguredTo()+"__"+submissionFor);
		logger.info("{}", temp);
		return temp.toString();
	}
	
}