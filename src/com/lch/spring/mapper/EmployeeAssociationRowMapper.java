package com.lch.spring.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.lch.general.generalBeans.EmployeeAssociation;

public class EmployeeAssociationRowMapper implements RowMapper<EmployeeAssociation>{
	
	@Override
	public EmployeeAssociation mapRow(ResultSet rs, int rowNumber)
			throws SQLException {
		
		if (rs != null) {
			EmployeeAssociation emp = new EmployeeAssociation();
			emp.setFirstName(rs.getString("firstName"));
			emp.setLastName(rs.getString("lastName"));
			emp.setCategoryId(rs.getString("categoryId"));
			emp.setPersonalDetailsId(rs.getString("idUserData"));
			emp.setUserId(rs.getString("idUser"));
			emp.setCategoryName(rs.getString("name"));
			return emp;
		} else {
			return null;
		}
	}

}
