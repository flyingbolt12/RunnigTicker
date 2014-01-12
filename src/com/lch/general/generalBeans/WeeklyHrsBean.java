package com.lch.general.generalBeans;

import java.sql.Timestamp;

public class WeeklyHrsBean {
	private int idweeklyHrs;
	private int weekNumber;
	private Timestamp weekStartDate;
	private Timestamp weekEndDate;
	private int SUNDAY;
	private int MONDAY;
	private int TUESDAY;
	private int WEDNESDAY;
	private int THURSDAY;
	private int FRIDAY;
	private int SATURDAY;
	private boolean isOverTime;
	private int idYearMonth;
	private int idUser;
	private int idBusiness;
	
	public int getFRIDAY() {
		return FRIDAY;
	}
	public void setFRIDAY(int friday) {
		FRIDAY = friday;
	}
	public int getIdBusiness() {
		return idBusiness;
	}
	public void setIdBusiness(int idBusiness) {
		this.idBusiness = idBusiness;
	}
	public int getIdUser() {
		return idUser;
	}
	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}
	public int getIdweeklyHrs() {
		return idweeklyHrs;
	}
	public void setIdweeklyHrs(int idweeklyHrs) {
		this.idweeklyHrs = idweeklyHrs;
	}
	public int getIdYearMonth() {
		return idYearMonth;
	}
	public void setIdYearMonth(int idYearMonth) {
		this.idYearMonth = idYearMonth;
	}
	public boolean isOverTime() {
		return isOverTime;
	}
	public void setOverTime(boolean isOverTime) {
		this.isOverTime = isOverTime;
	}
	public int getMONDAY() {
		return MONDAY;
	}
	public void setMONDAY(int monday) {
		MONDAY = monday;
	}
	public int getSATURDAY() {
		return SATURDAY;
	}
	public void setSATURDAY(int saturday) {
		SATURDAY = saturday;
	}
	public int getSUNDAY() {
		return SUNDAY;
	}
	public void setSUNDAY(int sunday) {
		SUNDAY = sunday;
	}
	public int getTHURSDAY() {
		return THURSDAY;
	}
	public void setTHURSDAY(int thrusday) {
		THURSDAY = thrusday;
	}
	public int getTUESDAY() {
		return TUESDAY;
	}
	public void setTUESDAY(int tuesday) {
		TUESDAY = tuesday;
	}
	public int getWEDNESDAY() {
		return WEDNESDAY;
	}
	public void setWEDNESDAY(int wednesday) {
		WEDNESDAY = wednesday;
	}
	public Timestamp getWeekEndDate() {
		return weekEndDate;
	}
	public void setWeekEndDate(Timestamp weekEndDate) {
		this.weekEndDate = weekEndDate;
	}
	public int getWeekNumber() {
		return weekNumber;
	}
	public void setWeekNumber(int weekNumber) {
		this.weekNumber = weekNumber;
	}
	public Timestamp getWeekStartDate() {
		return weekStartDate;
	}
	public void setWeekStartDate(Timestamp weekStartDate) {
		this.weekStartDate = weekStartDate;
	}
	
	
}
