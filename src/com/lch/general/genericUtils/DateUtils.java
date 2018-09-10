/*
 * Created on Jan 10, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.general.genericUtils;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.struts.actions.members.SaveHours;

/**
 * @author Gopi
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class DateUtils {
	private static Logger logger = LoggerFactory.getLogger(DateUtils.class);
	
	String[] weekdays = new DateFormatSymbols().getWeekdays();
	String[] monthNames = new DateFormatSymbols().getMonths();
	Calendar today = Calendar.getInstance();
	Calendar customDay = Calendar.getInstance();
	Calendar pastSundayCal = null;
	private int year = 0;
	private int month = 0;
	Date weekEndingDate;
	String String1stDayOfMonth;
	Date weekBeginingDate;

	/**
	 * @return Returns the weekBeginingDate.
	 */
	public String getWeekBeginingDate(int weekNum, DateUtils du) {

		int totalDays = du.getCustomDay().getActualMaximum(
				Calendar.DAY_OF_MONTH);
		Calendar week = (Calendar) du.getCustomDay().clone();

		if (weekNum > 1) {
			int j = 9 - week.get(Calendar.DAY_OF_WEEK);
			week.set(Calendar.DAY_OF_MONTH, j + 1);
			int k = 2;
			for (int i = j; i <= totalDays; i += 7) {
				week.set(Calendar.DAY_OF_MONTH, i);
				if (k == weekNum) {
					break;
				}
				++k;
			}
		}
	    
//		SimpleDateFormat format = new SimpleDateFormat("EEE MMM dd yyyy");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		String s = format.format(week.getTime());
		return s;
	}

	/**
	 * @param weekBeginingDate
	 *            The weekBeginingDate to set.
	 */
	public void setWeekBeginingDate(Date weekBeginingDate) {
		this.weekBeginingDate = weekBeginingDate;
	}

	public Calendar getCustomDay() {
		return (Calendar)customDay.clone();
	}

	public void setCustomDay(Calendar _customDay) {
		customDay = _customDay;
		logger.info("Custom Day Set to : {}", customDay.getTime());
	}

	private void determinePastSunday() {

		if(pastSundayCal==null)
			pastSundayCal =  (Calendar)today.clone();
		while (pastSundayCal.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
			pastSundayCal.add(Calendar.DAY_OF_MONTH, -1);
		}
	}

	public Calendar getPastSundayCal() {
		if(pastSundayCal == null)
		{
			determinePastSunday();
		}
		return (Calendar)pastSundayCal.clone();
	}

	public void setPastSundayCal(Calendar pastSundayCal) {
		this.pastSundayCal = pastSundayCal;
		determinePastSunday();
	}
	public static void main(String[] args) {
		DateUtils du = new DateUtils(2012, 10);
		//du.getWeekBeginingDate(6, du);
		//du.getWeekEndingDate(6, du);
		
		du.getPastSundayCal();

	}

	/**
	 * @return Returns the weekEndingDate.
	 */
	public String getWeekEndingDate(int weekNum, DateUtils du) {
		int totalDays = du.getCustomDay().getActualMaximum(
				Calendar.DAY_OF_MONTH);
		Calendar week = (Calendar) du.getCustomDay();
		if (weekNum < 6) {
			int j = 8 - week.get(Calendar.DAY_OF_WEEK);
			week.set(Calendar.DAY_OF_MONTH, j + 1);
			int k = 1;
			for (int i = j; i <= totalDays; i += 7) {
				week.set(Calendar.DAY_OF_MONTH, i);
				if (k == weekNum) {
					break;
				}
				++k;
			}
		} else {
			week.set(Calendar.DAY_OF_MONTH, totalDays);
			logger.info("Last Day of Month {}", week.getTime());
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String s = format.format(week.getTime());
		week = null;

		return s;
	}


	/**
	 * @param weekEndingDate
	 *            The weekEndingDate to set.
	 */
	public void setWeekEndingDate(Date weekEndingDate) {
		this.weekEndingDate = weekEndingDate;
	}

	

	public DateUtils(int year, int month) {
		customDay.set(Calendar.YEAR, year);
		customDay.set(Calendar.MONTH, month);
		customDay.set(Calendar.DATE, 1);
		this.year = year;
		this.month = month;
	}

	/**
	 * @return the weekdays
	 */
	public String[] getWeekdays() {
		return weekdays;
	}

	/**
	 * @return the monthNames
	 */
	public String[] getMonthNames() {
		return monthNames;
	}

	/**
	 * @return the today
	 */
	public Calendar getToday() {
		return today;
	}

	/**
	 * @return the weekBeginingDate
	 */
	public Date getWeekBeginingDate() {
		return weekBeginingDate;
	}

	/**
	 * @return the weekEndingDate
	 */
	public Date getWeekEndingDate() {
		return weekEndingDate;
	}

	/**
	 * @param weekdays the weekdays to set
	 */
	public void setWeekdays(String[] weekdays) {
		this.weekdays = weekdays;
	}

	/**
	 * @param monthNames the monthNames to set
	 */
	public void setMonthNames(String[] monthNames) {
		this.monthNames = monthNames;
	}

	/**
	 * @param today the today to set
	 */
	public void setToday(Calendar today) {
		this.today = today;
	}

	public String getMonthName() {
		// logger.info("Custom Day {}", customDay.getTime());
		String monthName = monthNames[customDay.get(Calendar.MONTH)];
		monthName = monthName.substring(0, 3);
		return monthName;
	}
	public String getMonthName(Calendar cal) {
		String monthName = monthNames[cal.get(Calendar.MONTH)];
		monthName = monthName.substring(0, 3);
		return monthName;
	}
	public int getIntLastDayOfMonth() {
		return customDay.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	public String getStringLastDayOfMonth() {
		return weekdays[customDay.getActualMaximum(Calendar.DAY_OF_MONTH)];
	}

	public int getInt1stDayOfMonth() {
		return customDay.get(Calendar.DAY_OF_WEEK);
	}

	public int getIntMidDayOfMonth() {
		return 15;
	}
	public int getDayOfWeekMidDayOfMonth() {
		Calendar cal = Calendar.getInstance();
		cal.set(customDay.get(Calendar.YEAR), customDay.get(Calendar.MONTH), 16);
		int DAY_OF_WEEK_IN_MONTH=cal.get(Calendar.DAY_OF_WEEK);
		return DAY_OF_WEEK_IN_MONTH;
	}
	
	public String getString1stDayOfMonth() {
		return weekdays[customDay.get(Calendar.DAY_OF_WEEK)];
	}

	/**
	 * @return Returns the month.
	 */
	public int getMonth() {
		return month;
	}

	/**
	 * @param month
	 *            The month to set.
	 */
	public void setMonth(int month) {
		this.month = month;
	}

	/**
	 * @return Returns the year.
	 */
	public int getYear() {
		return year;
	}

	/**
	 * @param year
	 *            The year to set.
	 */
	public void setYear(int year) {
		this.year = year;
	}

	/**
	 * @param string1stDayOfMonth
	 *            The string1stDayOfMonth to set.
	 */
	public void setString1stDayOfMonth(String string1stDayOfMonth) {
		String1stDayOfMonth = string1stDayOfMonth;
	}

}
