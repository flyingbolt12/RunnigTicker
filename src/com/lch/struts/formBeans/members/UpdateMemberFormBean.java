package com.lch.struts.formBeans.members;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;

import com.lch.general.dbBeans.Address;
import com.lch.struts.formBeans.CommonValidatorForm;

@SuppressWarnings("serial")
public class UpdateMemberFormBean extends CommonValidatorForm
{
	
	private String role="MEMBER";

	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		  clientWorkingFor="";
		  clientName="";
		  otherClientName="";
		  startDate="";
		  dob="";
		  listAddress = new ArrayList<Address>();
		  firstName="";
		  middleName="";
		  lastName="";
		  gendar="";
		  contactEmail="";
		  phoneNumber="";
		  fatherName="";
		  countryCitizenship="";
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

         return (Address)listAddress.get(index);

     }
	
	public void setListAddress(int index, Address address) {
		listAddress.add(index, address);
	}
}
