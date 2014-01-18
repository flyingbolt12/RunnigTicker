package com.lch.general.dbBeans;

import java.io.Serializable;
import java.sql.Timestamp;

public class ExceptionTrace implements Serializable{

	private static final long serialVersionUID = -2777937733482244638L;
	Integer idExceptionTrace;
	String exception;
	String exceptionMessage;
	Timestamp occuredDateTime;
	
	public ExceptionTrace() {
	}
	public Integer getIdExceptionTrace() {
		return idExceptionTrace;
	}
	public void setIdExceptionTrace(Integer idExceptionTrace) {
		this.idExceptionTrace = idExceptionTrace;
	}
	public String getException() {
		return exception;
	}
	public void setException(String exception) {
		this.exception = exception;
	}
	public String getExceptionMessage() {
		return exceptionMessage;
	}
	public void setExceptionMessage(String exceptionMessage) {
		this.exceptionMessage = exceptionMessage;
	}
	public Timestamp getOccuredDateTime() {
		return occuredDateTime;
	}
	public void setOccuredDateTime(Timestamp occuredDateTime) {
		this.occuredDateTime = occuredDateTime;
	}

}
