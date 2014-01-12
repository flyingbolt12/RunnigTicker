package com.lch.struts.formBeans.members;

import com.lch.general.dbBeans.Address;
import com.lch.struts.formBeans.CommonValidatorForm;

@SuppressWarnings("serial")
public class AddAnEmployeeBean extends CommonValidatorForm {

	String role = "MEMBER";

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
