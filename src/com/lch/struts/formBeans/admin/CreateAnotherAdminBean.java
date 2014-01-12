package com.lch.struts.formBeans.admin;

import com.lch.general.dbBeans.Address;
import com.lch.struts.formBeans.CommonValidatorForm;

public class CreateAnotherAdminBean extends CommonValidatorForm{

	private static final long serialVersionUID = -2907448874240009557L;
	private String role = "ADMIN";

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	public Address getListAddress(int index) {

		while (index >= listAddress.size()) {
			listAddress.add(new Address());
		}

		return (Address) listAddress.get(index);

	}

	public void setListAddress(int index, Address address) {
		listAddress.add(index, address);
	}
	
}
