package com.lch.general.genericUtils;

import java.util.List;
import java.util.Map;

public class WeeklyTimeSheetHours extends TimeSheetHours{
	
	public WeeklyTimeSheetHours(List<Map<String, Object>> databaseResult) {
		setDatabaseResult(databaseResult);
	}
}
