package com.lch.struts.formBeans.admin;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.upload.FormFile;

import com.lch.general.dbBeans.Address;
import com.lch.struts.formBeans.CommonValidatorForm;

@SuppressWarnings("serial")
public class AdminRegistrationBean extends CommonValidatorForm {

	private String businessName;
	private String websiteURL;
	private FormFile businessProfile;
	private String role = "ADMIN";

	public Address getListAddress(int index) {

		while (index >= listAddress.size()) {
			listAddress.add(new Address());
		}

		return (Address) listAddress.get(index);

	}

	public void setListAddress(int index, Address address) {
		listAddress.add(index, address);
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getWebsiteURL() {
		return websiteURL;
	}

	public void setWebsiteURL(String websiteURL) {
		this.websiteURL = websiteURL;
	}

	public FormFile getBusinessProfile() {
		return businessProfile;
	}

	public void setBusinessProfile(FormFile businessProfile) {
		this.businessProfile = businessProfile;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public void copyBusinessAddressToPersonalAddress() throws Exception
	{
		Address business = (Address)listAddress.get(0);
		Address personal = (Address)listAddress.get(1);
		
		BeanUtils.copyProperties(personal, business);
		
	}
}
