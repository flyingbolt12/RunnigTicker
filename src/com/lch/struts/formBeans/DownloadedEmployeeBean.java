package com.lch.struts.formBeans;

import javax.servlet.ServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

@SuppressWarnings("serial")
public class DownloadedEmployeeBean extends ActionForm {
	private String startingWithText;
	private String endingWithText;
	private String lastNameListBox;
	private String clientWorkingForListBox;
	public String getStartingWithText() {
		return startingWithText;
	}
	public void setStartingWithText(String startingWithText) {
		this.startingWithText = startingWithText;
	}
	public String getEndingWithText() {
		return endingWithText;
	}
	public void setEndingWithText(String endingWithText) {
		this.endingWithText = endingWithText;
	}
	public String getLastNameListBox() {
		return lastNameListBox;
	}
	public void setLastNameListBox(String lastNameListBox) {
		this.lastNameListBox = lastNameListBox;
	}
	public String getClientWorkingForListBox() {
		return clientWorkingForListBox;
	}
	public void setClientWorkingForListBox(String clientWorkingForListBox) {
		this.clientWorkingForListBox = clientWorkingForListBox;
	}
	public void reset(ActionMapping mapping, ServletRequest request){
		
		lastNameListBox=null;
		clientWorkingForListBox=null;
		startingWithText=null;
		endingWithText=null;
	}
}
