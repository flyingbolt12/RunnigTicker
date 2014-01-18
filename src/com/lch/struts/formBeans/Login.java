package com.lch.struts.formBeans;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * Form bean for a Struts application. Users may access 2 fields on this form:
 * <ul>
 * <li>password - [your comment here]
 * <li>userName - [your comment here]
 * </ul>
 * 
 * @version 1.0
 * @author
 */
@SuppressWarnings("serial")
public class Login extends ActionForm {

	private String password = null;
	private String userName = null;

	/**
	 * Get password
	 * 
	 * @return String
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Set password
	 * 
	 * @param <code>String</code>
	 */
	public void setPassword(String p) {
		this.password = p;
	}

	/**
	 * Get userName
	 * 
	 * @return String
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * Set userName
	 * 
	 * @param <code>String</code>
	 */
	public void setUserName(String u) {
		this.userName = u;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {

		// Reset values are provided as samples only. Change as appropriate.

		password = null;
		userName = null;

	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {

		ActionErrors errors = new ActionErrors();
		// Validate the fields in your form, adding
		// adding each error to this.errors as found, e.g.

		// if ((field == null) || (field.length() == 0)) {
		// errors.add("field", new
		// org.apache.struts.action.ActionError("error.field.required"));
		// }
		return errors;

	}
}
