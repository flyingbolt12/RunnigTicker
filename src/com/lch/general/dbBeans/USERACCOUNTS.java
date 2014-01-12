package com.lch.general.dbBeans;

import java.util.Calendar;
import java.util.Date;

public class USERACCOUNTS {
	private long userId;
	private String userActualRate;
	private String userGivenRate;
	private long userRateTypeId;
	private long userClientId;
	private long businessId;
	private Date recordUpdatedDate = Calendar.getInstance().getTime();



	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getUserActualRate() {
		return userActualRate;
	}

	public void setUserActualRate(String userActualRate) {
		this.userActualRate = userActualRate;
	}

	public String getUserGivenRate() {
		return userGivenRate;
	}

	public void setUserGivenRate(String userGivenRate) {
		this.userGivenRate = userGivenRate;
	}

	public long getUserRateTypeId() {
		return userRateTypeId;
	}

	public void setUserRateTypeId(long userRateTypeId) {
		this.userRateTypeId = userRateTypeId;
	}

	public long getUserClientId() {
		return userClientId;
	}

	public void setUserClientId(long userClientId) {
		this.userClientId = userClientId;
	}

	public long getBusinessId() {
		return businessId;
	}

	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}

	public Date getRecordUpdatedDate() {
		return recordUpdatedDate;
	}

	public void setRecordUpdatedDate(Date recordUpdatedDate) {
		this.recordUpdatedDate = recordUpdatedDate;
	}

}
