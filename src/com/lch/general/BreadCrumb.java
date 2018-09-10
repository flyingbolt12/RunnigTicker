package com.lch.general;

import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;

public class BreadCrumb {

	private Set<Action_Param> st = new LinkedHashSet<Action_Param>();
	
	public void addAction(String action, String params, String uri) {
		// listAllEmployeeAttachments
		if(params==null) return;
		
		if(!params.contains("adminFunctions.jsp")) {
			Action_Param p = new Action_Param(action, params, uri);
			st.add(p);
		}
	}
	
	public Set<Action_Param> listActions() {
		return st;
	}
	
}
