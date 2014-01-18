package com.lch.general.dbBeans;

/**
 * @author ADMIN
 *
 */
public class USERCLIENTSLIST {
private String iduserClientsList;
private String clientName;
private String isCurrent;
private String startDate;
private String expectedEndDate;
private String actualEndDate;
public String getIduserClientsList() {
	return iduserClientsList;
}
public void setIduserClientsList(String iduserClientsList) {
	this.iduserClientsList = iduserClientsList;
}
public String getClientName() {
	return clientName;
}
public void setClientName(String clientName) {
	this.clientName = clientName;
}
public String getIsCurrent() {
	return isCurrent;
}
public void setIsCurrent(String isCurrent) {
	this.isCurrent = isCurrent;
}
public String getStartDate() {
	return startDate;
}
public void setStartDate(String startDate) {
	this.startDate = startDate;
}
public String getExpectedEndDate() {
	return expectedEndDate;
}
public void setExpectedEndDate(String expectedEndDate) {
	this.expectedEndDate = expectedEndDate;
}
public String getActualEndDate() {
	return actualEndDate;
}
public void setActualEndDate(String actualEndDate) {
	this.actualEndDate = actualEndDate;
}
}