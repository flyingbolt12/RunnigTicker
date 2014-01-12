package com.lch.general.genericUtils;

import java.util.List;
import java.util.Map;

public class MonthlyTimeSheetHours extends TimeSheetHours{
	
	public MonthlyTimeSheetHours(List<Map<String, Object>> databaseResult) {
		setDatabaseResult(databaseResult);
	}
}
