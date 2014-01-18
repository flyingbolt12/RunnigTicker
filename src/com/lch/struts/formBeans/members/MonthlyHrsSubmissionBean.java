package com.lch.struts.formBeans.members;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

@SuppressWarnings("serial")
public class MonthlyHrsSubmissionBean extends ActionForm {

	String months ="";
	String years ="";
	/**
	 * @return the months
	 */
	public String getMonths() {
		return months;
	}
	/* (non-Javadoc)
	 * @see org.apache.struts.action.ActionForm#reset(org.apache.struts.action.ActionMapping, javax.servlet.http.HttpServletRequest)
	 */
	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		months ="";
		years ="";
	}
	/**
	 * @param months the months to set
	 */
	public void setMonths(String months) {
		this.months = months;
	}
	/**
	 * @return the yeras
	 */
	/**
	 * @return the years
	 */
	public String getYears() {
		return years;
	}
	/**
	 * @param years the years to set
	 */
	public void setYears(String years) {
		this.years = years;
	}

}
