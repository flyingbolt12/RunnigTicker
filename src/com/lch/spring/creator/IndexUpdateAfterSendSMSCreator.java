package com.lch.spring.creator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.PreparedStatementCreator;

import com.lch.general.generalBeans.WeeklyHrsBean;

public class IndexUpdateAfterSendSMSCreator implements PreparedStatementCreator {
	WeeklyHrsBean command;
	String id ="";
	private static Logger log = LoggerFactory.getLogger(WeeklyHrsInsertCreator.class);
	
	public IndexUpdateAfterSendSMSCreator(WeeklyHrsBean command) {
		this.command = command;
	}
	public IndexUpdateAfterSendSMSCreator(WeeklyHrsBean command,String id) {
		this.command = command;
		this.id = id;
	}

	PreparedStatement psmt;
	private final String SQL = "update indexcontrol set codeSw=1,codeSentDt=sysdate() where idIndexControl=?";
	public PreparedStatement createPreparedStatement(Connection con)
			throws SQLException {
		log.info("Executing the Query : "+SQL);
		PreparedStatement ps = con.prepareStatement(SQL);
		ps.setObject(1, command.getIdweeklyHrs()+"",Types.INTEGER);
		return ps;
	}

}
