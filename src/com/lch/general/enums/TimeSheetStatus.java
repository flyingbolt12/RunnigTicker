package com.lch.general.enums;

public enum TimeSheetStatus {
	NOTSUBMITTED("NOT SUBMITTED"), APPROVED("APPROVED"), PENDING("PENDING"), REJECTED("REJECTED"), SAVEDASDRAFT("SAVED AS DRAFT");

	String rep;

	private TimeSheetStatus(String _rep) {
		rep = _rep;
	}

	public String getRep() {
		return rep;
	}

	public void setRep(String rep) {
		this.rep = rep;
	}

}
