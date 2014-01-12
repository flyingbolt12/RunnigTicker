package com.lch.general.genericUtils;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.lch.general.generalBeans.UserProfile;

public class WeekToWeekDates {

	public static String[] getWeeklyDates(UserProfile userProfile) {
		String[] array = new String[2];
		DateUtils du = userProfile.getDu();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = du.getPastSundayCal();
		String weekBeginDate = "";
		String weekEndingDate = "";
		weekBeginDate = format.format(cal.getTime());
		cal.add(Calendar.DAY_OF_MONTH, 6);
		weekEndingDate = format.format(cal.getTime());
		array[0] = weekBeginDate;
		array[1] = weekEndingDate;

		return array;

	}

	public static String[] getBiWeeklyDates(UserProfile userProfile) {
		String[] array = new String[2];
		DateUtils du = userProfile.getDu();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = du.getPastSundayCal();
		String weekBeginDate = "";
		String weekEndingDate = "";

		weekBeginDate = format.format(cal.getTime());

		cal.add(Calendar.DAY_OF_MONTH, 13);
		weekEndingDate = format.format(cal.getTime());

		array[0] = weekBeginDate;
		array[1] = weekEndingDate;

		return array;

	}
}
