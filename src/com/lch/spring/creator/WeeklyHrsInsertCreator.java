package com.lch.spring.creator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.PreparedStatementCreator;

import com.lch.general.generalBeans.WeeklyHrsBean;

public class WeeklyHrsInsertCreator implements PreparedStatementCreator {

	PreparedStatement psmt;

	private final String SQL = "INSERT INTO `weeklyhrs` (`weekNumber`,`weekStartDate`,`weekEndDate`,`SUNDAY`,`MONDAY`,`TUESDAY`,`WEDNESDAY`,`THURSDAY`,`FRIDAY`,`SATURDAY`,`isOverTime`,`idYearMonth`,`idUser`,`idBusiness`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

	WeeklyHrsBean weeklyHrsBean;

	private static Logger log = LoggerFactory.getLogger(WeeklyHrsInsertCreator.class);

	public WeeklyHrsInsertCreator(WeeklyHrsBean bean) {
		this.weeklyHrsBean = bean;
	}

	public PreparedStatement createPreparedStatement(Connection con)
			throws SQLException {
		log.info("Executing the Query : " + SQL);
		PreparedStatement ps = con.prepareStatement(SQL);

		ps.setObject(1, String.valueOf(weeklyHrsBean.getWeekNumber()));
		ps.setObject(2, weeklyHrsBean.getWeekStartDate());
		ps.setObject(3, weeklyHrsBean.getWeekEndDate());
		ps.setObject(4, String.valueOf(weeklyHrsBean.getSUNDAY()));
		ps.setObject(5, String.valueOf(weeklyHrsBean.getMONDAY()));
		ps.setObject(6, String.valueOf(weeklyHrsBean.getTUESDAY()));
		ps.setObject(7, String.valueOf(weeklyHrsBean.getWEDNESDAY()));
		ps.setObject(8, String.valueOf(weeklyHrsBean.getTHURSDAY()));
		ps.setObject(9, String.valueOf(weeklyHrsBean.getFRIDAY()));
		ps.setObject(10, String.valueOf(weeklyHrsBean.getSATURDAY()));
		ps.setObject(11, String.valueOf(weeklyHrsBean.isOverTime()));
		ps.setObject(12, String.valueOf(weeklyHrsBean.getIdYearMonth()));
		ps.setObject(13, String.valueOf(weeklyHrsBean.getIdUser()));
		ps.setObject(14, String.valueOf(weeklyHrsBean.getIdBusiness()));
		
		return ps;
	}

}
