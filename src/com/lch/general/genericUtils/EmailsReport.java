package com.lch.general.genericUtils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.validator.routines.EmailValidator;

public class EmailsReport {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static ArrayList createReport(String emails) {
		ArrayList list = new ArrayList();

		ArrayList<String> validList = new ArrayList<String>();
		ArrayList<String> inValidList = new ArrayList<String>();
		StringBuffer sb = new StringBuffer("List of Emails notified Successfully : <BR><BR>");

		if (emails != null && emails.length() > 0) {
			String[] invidualEmail = emails.split(",");
			EmailValidator validator = EmailValidator.getInstance();
			for (String email : invidualEmail) {
				if (validator.isValid(email)) {
					validList.add(email);
				} else {
					inValidList.add(email);
				}
			}
			int index = 0;
			for (String email : validList) {
				++index;
				sb.append(index).append(" . ").append(email).append("<BR>");
			}
			sb.append("<BR>List of invalid Emails found and not notified : <BR>");
			index = 0;
			for (String email : inValidList) {
				++index;
				sb.append(index).append(" . ").append(email).append("<BR>");
			}

			list.add(validList);
			list.add(sb);
		}
		return list;
	}
	
	public static StringBuffer getReportReport(String fromEmail, List<String> validList)
	{
		int index = 0;
		StringBuffer sb = new StringBuffer("List of Emails notified Successfully : <BR><BR>");

		for (String email : validList) {
			++index;
			sb.append(index).append(" . ").append(email).append("<BR>");
		}
		return sb;
	}
}
