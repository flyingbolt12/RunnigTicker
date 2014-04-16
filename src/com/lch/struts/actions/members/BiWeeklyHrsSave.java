package com.lch.struts.actions.members;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.lch.general.generalBeans.UserProfile;
import com.lch.general.genericUtils.DateUtils;

/**
 * @version 1.0
 * @author
 */
public class BiWeeklyHrsSave extends SaveHours {
	
	public String makeString(String array[], int weekNum, DateUtils du,
			String submissionType, UserProfile userProfile, String submissionFor) {
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = du.getPastSundayCal();
		String weekBeginDate="";
		String weekEndingDate="";
		
		if(weekNum == 1)
		{
			weekBeginDate = format.format(cal.getTime());
			cal.add(Calendar.DAY_OF_MONTH,6);
			weekEndingDate = format.format(cal.getTime());
		}
		else
		{
			cal.add(Calendar.DAY_OF_MONTH,7);
			weekBeginDate = format.format(cal.getTime());
			cal.add(Calendar.DAY_OF_MONTH,6);
			weekEndingDate = format.format(cal.getTime());
		}
		StringBuffer temp = new StringBuffer(weekNum + DELIMETER
				+ weekBeginDate + DELIMETER + weekEndingDate + DELIMETER);
		String value = "";
		Double d;
		Double weekTotal = 0.00d;
		for (int i = 0; i < 7; ++i) {
			value = array[i];
			try {
				d = Double.valueOf(value);
				weekTotal += d;
			} catch (NumberFormatException e) {
				e.printStackTrace();
				value = "0.00";
				temp.append(value + DELIMETER);
				continue;
			}
			temp.append(value + DELIMETER);
		}
		if (weekTotal == 0.00d)
			return null;
		temp.append(submissionType);

		temp.append("__" + du.getYear() + "__" + userProfile.getUserId() + "__"
				+ userProfile.getBusinessId() + "__" + weekTotal + "__"
				+ du.getMonth() + "__" + userProfile.getTimeSheetConfiguredTo()
				+ "__" + submissionFor);
		return temp.toString();

	}
}