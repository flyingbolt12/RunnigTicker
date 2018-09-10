package com.lch.spring.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class DownloadBusinessdataRowMapper implements RowMapper<ResultSet>{
	
	@Override
	public ResultSet mapRow(ResultSet rs, int rowNumber)
			throws SQLException {
		
		if (rs != null) {
			return rs;
		} else {
			return null;
		}
	}

}
