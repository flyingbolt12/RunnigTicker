package com.lch.spring.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lch.general.generalBeans.CategoriesAndEmployees;

public class CatergoryEmployeeAssociationRowMapper implements RowMapper<CategoriesAndEmployees>{
	
	@Override
	public CategoriesAndEmployees mapRow(ResultSet rs, int rowNumber)
			throws SQLException {
		
		if (rs != null) {
			CategoriesAndEmployees emp = new CategoriesAndEmployees();
			emp.setEmployeeName(rs.getString("name"));
			emp.setUserId(rs.getString("idUser"));
			emp.setCategoryId(rs.getLong("categoryId"));
			//emp.setPersonalDetailsId(rs.getString("iduserData"));
			emp.setClientName(rs.getString("clientName"));
			emp.setWeekStartDate(rs.getDate("weekStartDate"));
			emp.setWeekEndDate(rs.getDate("weekEndDate"));
			emp.setTotalHrsSubmitted(rs.getString("totalHrsSubmitted"));
			emp.setTotalRegularHrs(rs.getString("totalRegularHrs"));
			emp.setTotalHolidayHrs(rs.getString("totalHolidayHrs"));
			emp.setTotalOvertimeHrs(rs.getString("totalOvertimeHrs"));
			emp.setSUNDAY(rs.getString("SUNDAY"));
			emp.setMONDAY(rs.getString("MONDAY"));
			emp.setTUESDAY(rs.getString("TUESDAY"));
			emp.setWEDNESDAY(rs.getString("WEDNESDAY"));
			emp.setTHURSDAY(rs.getString("THURSDAY"));
			emp.setFRIDAY(rs.getString("FRIDAY"));
			emp.setSATURDAY(rs.getString("SATURDAY"));
			emp.setTimeSheetStatus(rs.getString("status"));
			emp.setSubmissionFor(rs.getString("submissionFor"));
			emp.setSubmissionType(rs.getString("submissionType"));
			//emp.setWeekNumber(rs.getInt("weekNumber"));
			return emp;
		} else {
			return null;
		}
	}

}
