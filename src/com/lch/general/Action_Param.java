package com.lch.general;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

public class Action_Param {

	String action;
	String uri;
	String params;
	String url;
	public Action_Param(String action, String params, String uri) {
		this.action = action;
		this.params = params;
		this.uri = uri;
		url = action+"?"+params;
	}
	
	public String getURL()
	{
		return url;
	}
	public String getName()
	{
		System.out.println("==============="+params +"-->" +uri);
		String name ="";
		if (params!=null) {
			if(params.contains("forwardTo") || params.contains("parameter")) {
				params = params.replaceAll("parameter=", "");
				params = params.replaceAll("forwardTo=", "");
			}
			name = params;
		}
		else name=uri;
		System.out.println("==============="+name);
		return name;
	}
	
	@Override
    public int hashCode() {
        return new HashCodeBuilder(17, 31). // two randomly chosen prime numbers
            // if deriving: appendSuper(super.hashCode()).
            append(url).
            toHashCode();
    }
	
	@Override
	public boolean equals(Object obj) {
		 if (!(obj instanceof Action_Param))
	            return false;
	        if (obj == this)
	            return true;

	        Action_Param rhs = (Action_Param) obj;
	        return new EqualsBuilder().
	            append(action+"?"+params, rhs.url).
	            isEquals();
	    }
	

}
