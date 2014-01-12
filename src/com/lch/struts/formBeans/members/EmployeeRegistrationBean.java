package com.lch.struts.formBeans.members;

import java.io.Serializable;

import org.apache.commons.beanutils.BeanUtils;

import com.lch.general.dbBeans.Address;
import com.lch.struts.formBeans.CommonValidatorForm;


public class EmployeeRegistrationBean extends CommonValidatorForm implements Serializable {
	
	private static final long serialVersionUID = -2509087520558269147L;
	
	private String role="MEMBER";

	public Address getClientAddress()
	{
		return listAddress.get(2);
	}
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

	public void copyCurrentAddressToHomeCountryAddress() throws Exception
	{
		Address current = (Address)listAddress.get(0);
		Address homeCountyrAddress = (Address)listAddress.get(1);
		BeanUtils.copyProperties(homeCountyrAddress, current);
	}
	public void copyBusinessAddressToClientAddress() throws Exception
	{
		Address current = (Address)listAddress.get(0);
		Address clientAddress = (Address)listAddress.get(2);
		
		BeanUtils.copyProperties(clientAddress, current);
		
	}
	
}
