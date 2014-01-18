package com.lch.general.dbBeans;

import java.sql.Timestamp;

/**
 * @author kanchg
 * 
 */
public class ATTACHEDDOCS {

	private long userId;
	private long businessId;
	private String docType;
	private String docAPath;
	private String docRPath;
	private Timestamp attachedDate;
	private String docName;
	private String docSavedName;

	public String getDocSavedName() {
		return docSavedName;
	}

	public void setDocSavedName(String docSavedName) {
		this.docSavedName = docSavedName;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getBusinessId() {
		return businessId;
	}

	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}

	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}

	public String getDocAPath() {
		return docAPath;
	}

	public void setDocAPath(String docAPath) {
		this.docAPath = docAPath;
	}

	public String getDocRPath() {
		return docRPath;
	}

	public void setDocRPath(String docRPath) {
		this.docRPath = docRPath;
	}

	public Timestamp getAttachedDate() {
		return attachedDate;
	}

	public void setAttachedDate(Timestamp attachedDate) {
		this.attachedDate = attachedDate;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}


}
