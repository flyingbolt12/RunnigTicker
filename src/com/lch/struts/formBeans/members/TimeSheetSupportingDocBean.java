package com.lch.struts.formBeans.members;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

public class TimeSheetSupportingDocBean extends ActionForm {

	private String weeklyHrsSummaryId;
	private FormFile timeSheetSupportingDoc;

	public String getWeeklyHrsSummaryId() {
		return weeklyHrsSummaryId;
	}

	public void setWeeklyHrsSummaryId(String weeklyHrsSummaryId) {
		this.weeklyHrsSummaryId = weeklyHrsSummaryId;
	}

	public FormFile getTimeSheetSupportingDoc() {
		return timeSheetSupportingDoc;
	}

	public void setTimeSheetSupportingDoc(FormFile timeSheetSupportingDoc) {
		this.timeSheetSupportingDoc = timeSheetSupportingDoc;
	}
}
