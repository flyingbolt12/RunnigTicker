package com.lch.general.dbBeans;

public class DOCSFORSUPPORTING {
	int supportingDocId;
	long userId=0;
	String docIds="";
	long docTypeId=0;
	long businessId=0;
	public int getSupportingDocId() {
		return supportingDocId;
	}
	public void setSupportingDocId(int supportingDocId) {
		this.supportingDocId = supportingDocId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getDocIds() {
		return docIds;
	}
	public void setDocIds(String docIds) {
		this.docIds = docIds;
	}
	public long getDocTypeId() {
		return docTypeId;
	}
	public void setDocTypeId(long docTypeId) {
		this.docTypeId = docTypeId;
	}
	public long getBusinessId() {
		return businessId;
	}
	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}

}
