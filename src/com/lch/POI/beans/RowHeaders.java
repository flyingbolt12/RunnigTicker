package com.lch.POI.beans;

public enum RowHeaders {
	EMPID("Employee Id"),
	NAME("Full Name"),
	CLIENTNAME("Client Name"),
	STARTDATE("Start Date"),
	ENDDATE("End Date"),
	SUNDAY("SUNDAY"),
	MONDAY("MONDAY"),
	TUESDAY("TUESDAY"),
	WEDNESDAY("WEDNESDAY"),
	THURSDAY("THURSDAY"),
	FRIDAY("FRIDAY"),
	SATURDAY("SATURDAY"),
//	RHOURS("Regular Hours"),
//	OTHOURS("OverTime Hours"),
//	HOLIDAYHOURS("Holiday Hours"),
//	TOTALHOURS("Total Hours"),
	SUBMISSIONTYPE("Submission Type"),
	TIMESHEETSTATUS("TimeSheet Status"),
	SUBMISSIONFOR("Submission For");
	
	//VACATIONHOURS("Vacation Hours");
	
	private String value;
	private RowHeaders(String _vlaue) {
		value = _vlaue;
	}
	
	public String getValue() {
		return value;
	}
}
