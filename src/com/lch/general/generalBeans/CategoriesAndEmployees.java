package com.lch.general.generalBeans;

import java.sql.Date;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CategoriesAndEmployees {

	private String employeeName;
	private Long categoryId;
	private String personalDetailsId;
	private String userId;
	private String categoryName;
	private String clientName;
	private Date weekStartDate;
	private Date weekEndDate;
	private String totalRegularHrs;
	private String totalHrsSubmitted;
	private String totalOvertimeHrs;
	private String totalHolidayHrs;
	private double totalHrs;
	private String timeSheetStatus;
	private String submissionFor;
	private String submissionType;
	private String SUNDAY;
	private String MONDAY;
	private String TUESDAY;
	private String WEDNESDAY;
	private String THURSDAY;
	private String FRIDAY;
	private String SATURDAY;
	private int weekNumber;
	
	// For the sake of dynamic reporting
	private double totalRHHours;
	private double totalHHours;
	private double totalOTHours;

	public String getHoursOfAWeek(int day) {
		String hours = "";
		switch (day) {

		case Calendar.SUNDAY: {
			hours = getSUNDAY();
			break;
		}
		case Calendar.MONDAY: {
			hours = getMONDAY();
			break;
		}
		case Calendar.TUESDAY: {
			hours = getTUESDAY();
			break;
		}

		case Calendar.WEDNESDAY: {
			hours = getWEDNESDAY();
			break;
		}
		case Calendar.THURSDAY: {
			hours = getTHURSDAY();
			break;
		}
		case Calendar.FRIDAY: {
			hours = getFRIDAY();
			break;
		}
		case Calendar.SATURDAY: {
			hours = getSATURDAY();
			break;
		}
		}
		return hours;
	}
	
	public double getTotalRHHours() {
		return totalRHHours;
	}

	public void setTotalRHHours(double totalRHHours) {
		this.totalRHHours = totalRHHours;
	}

	public double getTotalHHours() {
		return totalHHours;
	}

	public void setTotalHHours(double totalHHours) {
		this.totalHHours = totalHHours;
	}

	public double getTotalOTHours() {
		return totalOTHours;
	}

	public void setTotalOTHours(double totalOTHours) {
		this.totalOTHours = totalOTHours;
	}
	
	public String[] getPropsAsArray(){
		String[] str = {
				userId,
				employeeName,
				clientName,
				getFormattedDate(weekStartDate),
				getFormattedDate(weekEndDate),
				SUNDAY,
				MONDAY,
				TUESDAY,
				WEDNESDAY,
				THURSDAY,
				FRIDAY,
				SATURDAY,
//				totalRegularHrs,
//				totalOvertimeHrs,
//				totalHolidayHrs,
//				totalHrsSubmitted,
				submissionType,
				timeSheetStatus,
				submissionFor
			};
		
		return str;
	}
	
	
	public int getWeekNumber() {
		return weekNumber;
	}

	public void setWeekNumber(int weekNumber) {
		this.weekNumber = weekNumber;
	}

	public String getFormattedDate(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		String s = format.format(date.getTime());
		return s;
	}
	public String getTimeSheetStatus() {
		return timeSheetStatus;
	}

	public void setTimeSheetStatus(String timeSheetStatus) {
		this.timeSheetStatus = timeSheetStatus;
	}
	
	
	public String getSubmissionFor() {
		return submissionFor;
	}

	public void setSubmissionFor(String submissionFor) {
		this.submissionFor = submissionFor;
	}

	
	public String getSUNDAY() {
		return SUNDAY;
	}

	public void setSUNDAY(String sUNDAY) {
		SUNDAY = sUNDAY;
	}

	public String getMONDAY() {
		return MONDAY;
	}

	public void setMONDAY(String mONDAY) {
		MONDAY = mONDAY;
	}

	public String getTUESDAY() {
		return TUESDAY;
	}

	public void setTUESDAY(String tUESDAY) {
		TUESDAY = tUESDAY;
	}

	public String getWEDNESDAY() {
		return WEDNESDAY;
	}

	public void setWEDNESDAY(String wEDNESDAY) {
		WEDNESDAY = wEDNESDAY;
	}

	public String getTHURSDAY() {
		return THURSDAY;
	}

	public void setTHURSDAY(String tHURSDAY) {
		THURSDAY = tHURSDAY;
	}

	public String getFRIDAY() {
		return FRIDAY;
	}

	public void setFRIDAY(String fRIDAY) {
		FRIDAY = fRIDAY;
	}

	public String getSATURDAY() {
		return SATURDAY;
	}

	public void setSATURDAY(String sATURDAY) {
		SATURDAY = sATURDAY;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public String getPersonalDetailsId() {
		return personalDetailsId;
	}

	public void setPersonalDetailsId(String personalDetailsId) {
		this.personalDetailsId = personalDetailsId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public Date getWeekStartDate() {
		return weekStartDate;
	}

	public Calendar getWeekStartCalendar() {
		Calendar startCal = Calendar.getInstance();
		startCal.setTimeInMillis(weekStartDate.getTime());
		return startCal;
	}
	
	
	public void setWeekStartDate(Date weekStartDate) {
		this.weekStartDate = weekStartDate;
	}

	public Date getWeekEndDate() {
		return weekEndDate;
	}

	public Calendar getWeekEndCalendar() {
		Calendar weekEnd = Calendar.getInstance();
		weekEnd.setTimeInMillis(weekEndDate.getTime());
		return weekEnd;
	}
	
	public void setWeekEndDate(Date weekEndDate) {
		this.weekEndDate = weekEndDate;
	}

	public String getTotalRegularHrs() {
		return totalRegularHrs;
	}

	public void setTotalRegularHrs(String totalRegularHrs) {
		this.totalRegularHrs = totalRegularHrs;
	}

	public String getTotalHrsSubmitted() {
		return totalHrsSubmitted;
	}

	public void setTotalHrsSubmitted(String totalHrsSubmitted) {
		this.totalHrsSubmitted = totalHrsSubmitted;
	}

	public String getTotalOvertimeHrs() {
		return totalOvertimeHrs;
	}

	public void setTotalOvertimeHrs(String totalOvertimeHrs) {
		this.totalOvertimeHrs = totalOvertimeHrs;
	}

	public String getTotalHolidayHrs() {
		return totalHolidayHrs;
	}

	public void setTotalHolidayHrs(String totalHolidayHrs) {
		this.totalHolidayHrs = totalHolidayHrs;
	}

	public String getSubmissionType() {
		return submissionType;
	}

	public void setSubmissionType(String submissionType) {
		this.submissionType = submissionType;
	}

	public double getTotalHrs() {
		return totalHrs;
	}

	public void setTotalHrs(double totalHrs) {
		this.totalHrs = totalHrs;
	}

}
