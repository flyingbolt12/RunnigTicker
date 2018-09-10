package com.lch.struts.actions.admin;

public enum AdminSettings {

	TIMSHEETCONFIGURATION("8.0"),
	HIDE_NOTIFY_EMPLOYER_BUTTON("TRUE");

	private String defaultValue;

	private AdminSettings(String value) {
		defaultValue = value;
	}

	public String getDefautValue() {
		return defaultValue;
	}
}
