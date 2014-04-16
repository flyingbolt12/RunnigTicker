package com.lch.general.generalBeans;

public class EmployeeAssociation {

	private String firstName;
	private String lastName;
	private String categoryId;
	private String personalDetailsId;
	private String userId;
	private String categoryName;
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getPersonalDetailsId() {
		return personalDetailsId;
	}

	public void setPersonalDetailsId(String personalDetailsId) {
		this.personalDetailsId = personalDetailsId;
	}

}
