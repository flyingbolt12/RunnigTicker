package com.lch.general.genericUtils;

import java.util.List;
import java.util.Map;

public class BiWeeklyTimeSheetHours extends TimeSheetHours{
	
	public BiWeeklyTimeSheetHours(List<Map<String, Object>> databaseResult) {
		setDatabaseResult(databaseResult);
	}
}
