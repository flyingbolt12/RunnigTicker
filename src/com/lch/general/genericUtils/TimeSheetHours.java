package com.lch.general.genericUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public abstract class TimeSheetHours {

	List<Map<String, Object>> regular = new ArrayList<Map<String, Object>>();
	List<Map<String, Object>> over = new ArrayList<Map<String, Object>>();
	List<Map<String, Object>> holiday = new ArrayList<Map<String, Object>>();
	List<Map<String, Object>> databaseResult;
	
	public void setDatabaseResult(List<Map<String, Object>> databaseResult) {
		this.databaseResult = databaseResult;
		catagorizeHrs();
	}

	public List<Map<String, Object>> getRegular() {
		return regular;
	}

	public List<Map<String, Object>> getOver() {
		return over;
	}

	public List<Map<String, Object>> getHoliday() {
		return holiday;
	}

	public void catagorizeHrs() {
		for (Map<String, Object> loopingMap : databaseResult) {
			SubMissionType type = SubMissionType.valueOf((String) loopingMap.get("submissionType"));

			switch (type) {
			case REGULAR:
				regular.add(loopingMap);
				break;

			case OVERTIME:
				over.add(loopingMap);
				break;

			case HOLIDAY:
				holiday.add(loopingMap);
				break;
			}
		}
	}
	private Map<String, Object> getHrsMap(int weekNo, List<Map<String, Object>> list) {
		for (Map<String, Object> map : list) {
			long weekNumber = (Long) map.get("weekNumber");
			if (weekNumber == weekNo) {
				return map;
			}
		}
		return null;
	}

	private double[] buildArray(Map<String, Object> map) {
		double hrs[] = {  0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00  };

		if (map == null)
			return hrs;
		hrs[0] = (Double) map.get(WeekDays.SUNDAY.name());
		hrs[1] = (Double) map.get(WeekDays.MONDAY.name());
		hrs[2] = (Double) map.get(WeekDays.TUESDAY.name());
		hrs[3] = (Double) map.get(WeekDays.WEDNESDAY.name());
		hrs[4] = (Double) map.get(WeekDays.THURSDAY.name());
		hrs[5] = (Double) map.get(WeekDays.FRIDAY.name());
		hrs[6] = (Double) map.get(WeekDays.SATURDAY.name());

		return hrs;
	}

	public double[] getHours(int weekNo, SubMissionType type) {

		double hrs[] = null;
		switch (type) {
		case REGULAR: {
			Map<String, Object> map = getHrsMap(weekNo, regular);
			hrs = buildArray(map);
			break;
		}
		case OVERTIME: {
			Map<String, Object> map = getHrsMap(weekNo, over);
			hrs = buildArray(map);
			break;
		}
		case HOLIDAY: {
			Map<String, Object> map = getHrsMap(weekNo, holiday);
			hrs = buildArray(map);
			break;
		}
		}
		return hrs;
	}
}
