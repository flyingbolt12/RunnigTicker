package com.lch.general.genericUtils;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.generalBeans.CategoriesAndEmployees;
import com.lch.spring.BusinessComponents.DoTransaction;


enum TimeSheetSubmissionType {
	REGULAR, OVERTIME, HOLIDAY
}

public class MonthlyExcelReportHelpr {
	private static Logger log = LoggerFactory.getLogger(MonthlyExcelReportHelpr.class);
	DoTransaction doTransaction;

	public MonthlyExcelReportHelpr(DoTransaction _doTransaction) {
		doTransaction = _doTransaction;
	}

	public Map<String, EmployeeTimeSheetsBasedOnTypes> startProcessing(List<CategoriesAndEmployees> categoriesAndEmployees, int month, int year, long businessId) {
		log.info("No of total time sheets for all users : {}", categoriesAndEmployees.size());
		Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployeeTimeSheets = processToIndependentEmployeeTimeSheets(categoriesAndEmployees);
		calculateTotalHoursSubmittedByEachEmployeeForAllMonthlySubmittedTimeSheets(independentEmployeeTimeSheets, month, year, businessId);
		return independentEmployeeTimeSheets;
	}

	private Map<String, EmployeeTimeSheetsBasedOnTypes> processToIndependentEmployeeTimeSheets(List<CategoriesAndEmployees> categoriesAndEmployees) {

		log.info("Grouping All Retrived Time Sheets by Employee : Total Count of TimeSheets for all Employees found {}", categoriesAndEmployees.size());
		Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployees = new HashMap<String, EmployeeTimeSheetsBasedOnTypes>();

		int i = 0;
		for (CategoriesAndEmployees timeSheet : categoriesAndEmployees) {
			++i;
			String userId = timeSheet.getUserId();
			
			if (!independentEmployees.containsKey(userId)){
				independentEmployees.put(userId, new EmployeeTimeSheetsBasedOnTypes());
			}
			if (independentEmployees.containsKey(userId)) {
				EmployeeTimeSheetsBasedOnTypes typeofTimeSheet = independentEmployees.get(timeSheet.getUserId());
				if (timeSheet.getSubmissionType().equalsIgnoreCase(TimeSheetSubmissionType.REGULAR.name())) {
					typeofTimeSheet.getRh().add(timeSheet);
				} else if (timeSheet.getSubmissionType().equalsIgnoreCase(TimeSheetSubmissionType.OVERTIME.name())) {
					typeofTimeSheet.getOt().add(timeSheet);
				} else if (timeSheet.getSubmissionType().equalsIgnoreCase(TimeSheetSubmissionType.HOLIDAY.name())) {
					typeofTimeSheet.getHh().add(timeSheet);
				}
				
				if (typeofTimeSheet.categoryId==-1 && typeofTimeSheet.categoryId!=timeSheet.getCategoryId()){
					typeofTimeSheet.categoryId = timeSheet.getCategoryId();
				}
			}
			log.info("{}. New Time Sheet found for UserId : {} - and it is Processed", i, userId+" : "+timeSheet.getEmployeeName());
		}
		log.info("Total number of aggregated users {} and their time sheets processed", independentEmployees.size());

		Set<Entry<String, EmployeeTimeSheetsBasedOnTypes>> set = independentEmployees.entrySet();
		for (Entry<String, EmployeeTimeSheetsBasedOnTypes> entry : set) {
			log.info("User ID {} Having Number of Regular TimeSheets {}", entry.getKey(), entry.getValue().getRh().size());
			log.info("User ID {} Having Number of OvertTime TimeSheets {}", entry.getKey(), entry.getValue().getOt().size());
			log.info("User ID {} Having Number of Holiday TimeSheets {}", entry.getKey(), entry.getValue().getHh().size());
		}
		return independentEmployees;
	}

	private void calculateTotalHoursSubmittedByEachEmployeeForAllMonthlySubmittedTimeSheets(Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployees, int month, int year, long businessId) {

		Set<Entry<String, EmployeeTimeSheetsBasedOnTypes>> set = independentEmployees.entrySet();
		for (Entry<String, EmployeeTimeSheetsBasedOnTypes> entry : set) {

			log.info("User ID {} Having Number of Regular TimeSheets {}", entry.getKey(), entry.getValue().getRh().size());
			calculateTotalHoursSubmittedByEachEmployeeForAllMonthlySubmittedTimeSheetsByType(entry.getValue(), month, year, businessId, TimeSheetSubmissionType.REGULAR, entry.getKey());

			log.info("User ID {} Having Number of OvertTime TimeSheets {}", entry.getKey(), entry.getValue().getOt().size());
			calculateTotalHoursSubmittedByEachEmployeeForAllMonthlySubmittedTimeSheetsByType(entry.getValue(), month, year, businessId, TimeSheetSubmissionType.OVERTIME, entry.getKey());

			log.info("User ID {} Having Number of Holiday TimeSheets {}", entry.getKey(), entry.getValue().getHh().size());
			calculateTotalHoursSubmittedByEachEmployeeForAllMonthlySubmittedTimeSheetsByType(entry.getValue(), month, year, businessId, TimeSheetSubmissionType.HOLIDAY, entry.getKey());
			
			log.info("Total Regular, Overtime, Holiday Hours Calculated {}", new Object[]{entry.getValue().totalRHHours, entry.getValue().totalOTours, entry.getValue().totalHHHours} );
		}

	}

	private void calculateTotalHoursSubmittedByEachEmployeeForAllMonthlySubmittedTimeSheetsByType(EmployeeTimeSheetsBasedOnTypes timesheets, int month, int year, long businessId,
			TimeSheetSubmissionType type, String userId) {

		log.info("Started Calculating Total Monthly Hours for {} User :{}", type, userId);
		
		if (type == TimeSheetSubmissionType.REGULAR) {
			double totalHrs = calculateTotalHours(timesheets.getRh(), month, year, businessId, userId, type);
			timesheets.totalRHHours = totalHrs;
		}
		if (type == TimeSheetSubmissionType.OVERTIME) {
			double totalHrs = calculateTotalHours(timesheets.getOt(), month, year, businessId, userId, type);
			timesheets.totalOTours = totalHrs;
		}
		if (type == TimeSheetSubmissionType.HOLIDAY) {
			double totalHrs = calculateTotalHours(timesheets.getHh(), month, year, businessId, userId, type);
			timesheets.totalHHHours = totalHrs;
		}
	}

	private double calculateCompleteWeekTotalHours(CategoriesAndEmployees timeSheet) {

		return Double.valueOf(timeSheet.getSUNDAY()) + Double.valueOf(timeSheet.getMONDAY()) + Double.valueOf(timeSheet.getTUESDAY()) + Double.valueOf(timeSheet.getWEDNESDAY())
				+ Double.valueOf(timeSheet.getTHURSDAY()) + Double.valueOf(timeSheet.getFRIDAY()) + Double.valueOf(timeSheet.getSATURDAY());
	}

	private Map<String, Object> figureOutBeginAndLastWeekTimeSheets(List<CategoriesAndEmployees> timeSheets) {
		Calendar monthBegin = null;
		Calendar monthEnd = null;
		CategoriesAndEmployees endObj = null;
		CategoriesAndEmployees startObj = null;
		// Get the start week of all time sheets for this month.
		// Get the last week of all time sheets for this month.
		for (CategoriesAndEmployees timeSheet : timeSheets) {

			Calendar startDate = timeSheet.getWeekStartCalendar();
			Calendar endDate = timeSheet.getWeekEndCalendar();
			if (monthBegin == null && monthEnd == null) {
				monthBegin = startDate;
				monthEnd = endDate;
				startObj = timeSheet;
				endObj = timeSheet;
				continue;
			} else {
				if (startDate.before(monthBegin)) {
					monthBegin = startDate;
					startObj = timeSheet;
				}
				if (endDate.after(monthEnd)) {
					monthEnd = endDate;
					endObj = timeSheet;
				}
			}
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("monthBegin", monthBegin);
		map.put("monthEnd", monthEnd);
		map.put("endObj", endObj);
		map.put("startObj", startObj);

		return map;
	}

	Map<String, EmployeeTimeSheetsBasedOnTypes> previousMonthTimeSheets = new HashMap<String, EmployeeTimeSheetsBasedOnTypes>();

	private double previousMonthLastWeekTotalHoursRealtedToRequestMonth(List<CategoriesAndEmployees> timeSheets, int month, int year, long businessId, String userId, TimeSheetSubmissionType submissionType){
		double totalHrs = 0.00d;
		Map<String, Object> tobj = figureOutBeginAndLastWeekTimeSheets(timeSheets);
		Calendar monthBegin = (Calendar) tobj.get("monthBegin");
		Calendar monthEnd = (Calendar) tobj.get("monthEnd");
		log.info("Time Sheet Month Begin {}", monthBegin.getTime());
		log.info("Time Sheet Month End {}", monthEnd.getTime());
		
		if (monthBegin != null && monthEnd != null) {

			log.info("Time Sheet Month Begin Week Day Starts at  {} -- figure out previous month last week dates needed", monthBegin.get(Calendar.DAY_OF_MONTH));
			
			if (monthBegin.get(Calendar.DAY_OF_MONTH) > 1 && monthBegin.get(Calendar.DAY_OF_MONTH) < 7) {
				// Query previous month records
				int yearToUse = year;
				int monthToUse = month;
				if (monthBegin.get(Calendar.MONTH) == 0) {
					yearToUse = year - 1;
					monthToUse = 11;
				} else {
					monthToUse = month - 1;
				}
				log.info("Started Calculating Total Previous month hours for User :{}, Submission Type {}", userId, submissionType);
				if (!previousMonthTimeSheets.containsKey(userId)) {
					log.info("Month {} and Year {} used to query previous month time sheets for user {}", new Object[]{month, year, userId});
					List<CategoriesAndEmployees> pMonthTimeSheets = doTransaction.getCategorySpecificEmployeesSpecificToUser(monthToUse, monthToUse, yearToUse, yearToUse, businessId, userId);
					Map<String, EmployeeTimeSheetsBasedOnTypes> map = processToIndependentEmployeeTimeSheets(pMonthTimeSheets);
					previousMonthTimeSheets.put(userId, map.get(userId));
				} else{
					log.info("Details already available, so stop querying...again");
					monthToUse = month ;
					yearToUse = year;
				}

				Calendar actualMonth = Calendar.getInstance();
				actualMonth.set(Calendar.MONTH, monthToUse);

				List<CategoriesAndEmployees> pTimeSheets = null;

				if (submissionType == TimeSheetSubmissionType.REGULAR) {
					pTimeSheets = previousMonthTimeSheets.get(userId).getRh();
				} else if (submissionType == TimeSheetSubmissionType.OVERTIME) {
					pTimeSheets = previousMonthTimeSheets.get(userId).getOt();
				} else if (submissionType == TimeSheetSubmissionType.HOLIDAY) {
					pTimeSheets = previousMonthTimeSheets.get(userId).getHh();
				}

				if(pTimeSheets.size() ==0) return 0.0;
				
				tobj = figureOutBeginAndLastWeekTimeSheets(pTimeSheets);
				
				monthBegin = (Calendar) tobj.get("monthBegin");
				monthEnd = (Calendar) tobj.get("monthEnd");

				
				
				log.info("Time Sheet's Previous Month Begin {}", monthBegin.getTime());
				log.info("Time Sheet's Previous Month End {}", monthEnd.getTime());
				
				Calendar cal = Calendar.getInstance();
				cal.set(Calendar.MONTH, month - 1);
				int maxdays = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				int startMonthDayForEndOfMonthWeek = startWeekCalendarForEndWeek(pTimeSheets, monthEnd).get(Calendar.DAY_OF_MONTH);
				log.info("Max days in this month {} and End week start day {}", maxdays, startMonthDayForEndOfMonthWeek);
				
				int daysToIgnore = maxdays - startMonthDayForEndOfMonthWeek + 1;
				CategoriesAndEmployees endObj = (CategoriesAndEmployees) tobj.get("endObj");

				int i = 7 - daysToIgnore;
				while (i > 0) {
					log.info("Hours of a Week day at {} -- Adding {}", i, endObj.getHoursOfAWeek(i));
					totalHrs = totalHrs + Double.valueOf(endObj.getHoursOfAWeek(i));
					--i;
				}
			}
		}
		return totalHrs;
	}
	private double calculateTotalHours(List<CategoriesAndEmployees> timeSheets, int month, int year, long businessId, String userId, TimeSheetSubmissionType submissionType) {

		if (timeSheets.size() == 0) return 0.0;
		double totalHrs = 0.00d;
		
		log.info("Started Calculating Total in month hours for User :{}, Submission Type {}", userId, submissionType);
		for (CategoriesAndEmployees timeSheet : timeSheets) {
			
			Calendar startCal = timeSheet.getWeekStartCalendar();
			Calendar endCal = timeSheet.getWeekEndCalendar();

			log.info("Time Sheet - Start Week {} :  End Week {} - Requestd Month {} and Year {}", new Object[]{startCal.getTime(),  endCal.getTime(), month, year});
			//if (startCal.get(Calendar.MONTH) == month && endCal.get(Calendar.MONTH) == month) {
			if (startCal.get(Calendar.MONTH) == month) {
				totalHrs = totalHrs + calculateCompleteWeekTotalHours(timeSheet);
				log.info("Week Total Hours {}", totalHrs);
			}
		}
		log.info("In Month Total Hours {}", totalHrs);

		totalHrs = totalHrs + previousMonthLastWeekTotalHoursRealtedToRequestMonth(timeSheets, month, year, businessId, userId, submissionType);
		
		
		// Current Month Last Week -- remove next month falling hours.
		
		Map<String, Object> tobj = figureOutBeginAndLastWeekTimeSheets(timeSheets);
		Calendar monthBegin = (Calendar) tobj.get("monthBegin");
		Calendar monthEnd = (Calendar) tobj.get("monthEnd");
		log.info("Time Sheet Month Begin {}", monthBegin.getTime());
		log.info("Time Sheet Month End {}", monthEnd.getTime());
		
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.MONTH, month);
		int maxdays = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		int startMonthDayForEndOfMonthWeek = startWeekCalendarForEndWeek(timeSheets, monthEnd).get(Calendar.DAY_OF_MONTH);
		log.info("Max days in this month {} and End week start day {}", maxdays, startMonthDayForEndOfMonthWeek);
		
		int daysToIgnore = maxdays - startMonthDayForEndOfMonthWeek + 1;
		CategoriesAndEmployees endObj = (CategoriesAndEmployees) tobj.get("endObj");

		int i = 7 - daysToIgnore;
		while (i > 0) {
			log.info("Hours of a Week day at {} -- Removing {}", i, endObj.getHoursOfAWeek(i));
			totalHrs = totalHrs - Double.valueOf(endObj.getHoursOfAWeek(i));
			--i;
		}

		return totalHrs;
	}

	public Calendar startWeekCalendarForEndWeek(List<CategoriesAndEmployees> pTimeSheet, Calendar monthEnd) {
		for (CategoriesAndEmployees emp : pTimeSheet) {
			if(emp.getWeekEndCalendar().equals(monthEnd))
				return emp.getWeekStartCalendar();
		}
		return null;
	}
}
