package com.lch.struts.actions.members;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.enums.TimeSheetTypes;
import com.lch.general.generalBeans.UserProfile;
import com.lch.general.genericUtils.DateUtils;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;

@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
public abstract class SaveHours extends BaseAction {
	public final static String DELIMETER = "__";
	private static Logger log = LoggerFactory.getLogger(SaveHours.class);

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String regularWeek1[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String regularWeek2[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String regularWeek3[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String regularWeek4[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String regularWeek5[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String regularWeek6[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };

		String overtimeWeek1[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String overtimeWeek2[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String overtimeWeek3[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String overtimeWeek4[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String overtimeWeek5[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String overtimeWeek6[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };

		String holidayWeek1[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String holidayWeek2[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String holidayWeek3[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String holidayWeek4[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String holidayWeek5[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };
		String holidayWeek6[] = { "0.00", "0.00", "0.00", "0.00", "0.00", "0.00", "0.00" };

		boolean bTimeSheetUpdate = false;

		ActionErrors errors = new ActionErrors();
		ActionForward forward = new ActionForward(); // return value

		try {
			// for the sake of file uploading - see file jupload.default.config
			long userId = getLoginUsers_UserId(request);
			long businessId = getBusinessId(request);

			String submissionFor = request.getParameter("submissionFor");

			request.setAttribute("userId", userId);
			request.setAttribute("businessId", businessId);

			HttpSession session = request.getSession();
			UserProfile userProfile = getUserProfile(request);
			if (userProfile != null) {
				DateUtils du = userProfile.getDu();
				log.debug("{}", du.getPastSundayCal().getTime());

				// int noOfWeeks = du.getIntLastDayOfMonth() / 6;
				// int startDay = du.getInt1stDayOfMonth();
				// int endDay = du.getIntLastDayOfMonth();

				Map map = request.getParameterMap();
				HashMap hashMap = new HashMap();
				hashMap.putAll(map);
				Iterator it = hashMap.entrySet().iterator();
				int i = 0;
				while (it.hasNext()) {
					Map.Entry pairs = (Map.Entry) it.next();
					String key = (String) pairs.getKey();
					String x[] = (String[]) pairs.getValue();
					String value = "0.00";
					if (x.length == 1) {
						value = x[0];
					}
					if (key.startsWith("REGULARWEEK_1")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						regularWeek1[i - 1] = value;
					}
					if (key.startsWith("REGULARWEEK_2")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						regularWeek2[i - 1] = value;
					}
					if (key.startsWith("REGULARWEEK_3")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						regularWeek3[i - 1] = value;
					}
					if (key.startsWith("REGULARWEEK_4")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						regularWeek4[i - 1] = value;
					}
					if (key.startsWith("REGULARWEEK_5")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						regularWeek5[i - 1] = value;
					}
					if (key.startsWith("REGULARWEEK_6")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						regularWeek6[i - 1] = value;
					}
					if (key.startsWith("OVERTIMEWEEK_1")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						overtimeWeek1[i - 1] = value;
					}
					if (key.startsWith("OVERTIMEWEEK_2")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						overtimeWeek2[i - 1] = value;
					}
					if (key.startsWith("OVERTIMEWEEK_3")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						overtimeWeek3[i - 1] = value;
					}
					if (key.startsWith("OVERTIMEWEEK_4")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						overtimeWeek4[i - 1] = value;
					}
					if (key.startsWith("OVERTIMEWEEK_5")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						overtimeWeek5[i - 1] = value;
					}
					if (key.startsWith("OVERTIMEWEEK_6")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						overtimeWeek6[i - 1] = value;
					}
					if (key.startsWith("HOLIDAYWEEK_1")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						holidayWeek1[i - 1] = value;
					}
					if (key.startsWith("HOLIDAYWEEK_2")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						holidayWeek2[i - 1] = value;
					}
					if (key.startsWith("HOLIDAYWEEK_3")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						holidayWeek3[i - 1] = value;
					}
					if (key.startsWith("HOLIDAYWEEK_4")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						holidayWeek4[i - 1] = value;
					}
					if (key.startsWith("HOLIDAYWEEK_5")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						holidayWeek5[i - 1] = value;
					}
					if (key.startsWith("HOLIDAYWEEK_6")) {
						i = key.lastIndexOf("_");
						i = Integer.parseInt(key.substring(i + 1, key.length()));
						holidayWeek6[i - 1] = value;
					}

				}

				String regularSubmissionType = "REGULAR";
				String overTimeSubmissionType = "OVERTIME";
				String holidaySubmissionType = "HOLIDAY";

				String regualrWeekString1 = makeString(regularWeek1, 1, du, regularSubmissionType, userProfile, submissionFor);
				String regualrWeekString2 = makeString(regularWeek2, 2, du, regularSubmissionType, userProfile, submissionFor);
				String regualrWeekString3 = makeString(regularWeek3, 3, du, regularSubmissionType, userProfile, submissionFor);
				String regualrWeekString4 = makeString(regularWeek4, 4, du, regularSubmissionType, userProfile, submissionFor);
				String regualrWeekString5 = makeString(regularWeek5, 5, du, regularSubmissionType, userProfile, submissionFor);
				String regualrWeekString6 = makeString(regularWeek6, 6, du, regularSubmissionType, userProfile, submissionFor);

				String overTimeWeekString1 = makeString(overtimeWeek1, 1, du, overTimeSubmissionType, userProfile, submissionFor);
				String overTimeWeekString2 = makeString(overtimeWeek2, 2, du, overTimeSubmissionType, userProfile, submissionFor);
				String overTimeWeekString3 = makeString(overtimeWeek3, 3, du, overTimeSubmissionType, userProfile, submissionFor);
				String overTimeWeekString4 = makeString(overtimeWeek4, 4, du, overTimeSubmissionType, userProfile, submissionFor);
				String overTimeWeekString5 = makeString(overtimeWeek5, 5, du, overTimeSubmissionType, userProfile, submissionFor);
				String overTimeWeekString6 = makeString(overtimeWeek6, 6, du, overTimeSubmissionType, userProfile, submissionFor);

				String holidayTimeWeekString1 = makeString(holidayWeek1, 1, du, holidaySubmissionType, userProfile, submissionFor);
				String holidayTimeWeekString2 = makeString(holidayWeek2, 2, du, holidaySubmissionType, userProfile, submissionFor);
				String holidayTimeWeekString3 = makeString(holidayWeek3, 3, du, holidaySubmissionType, userProfile, submissionFor);
				String holidayTimeWeekString4 = makeString(holidayWeek4, 4, du, holidaySubmissionType, userProfile, submissionFor);
				String holidayTimeWeekString5 = makeString(holidayWeek5, 5, du, holidaySubmissionType, userProfile, submissionFor);
				String holidayTimeWeekString6 = makeString(holidayWeek6, 6, du, holidaySubmissionType, userProfile, submissionFor);

				// send the above strings to stored procedure to store the user
				// hours at two transactions for regular and overtime.

				// DoTransaction doTransaction = (DoTransaction)
				// getSpringCTX().getBean("doTransaction");
				DoTransaction doTransaction = getSpringCtxDoTransactionBean();
				String[] regOverHrs = new String[18];
				regOverHrs[0] = regualrWeekString1;
				regOverHrs[1] = regualrWeekString2;
				regOverHrs[2] = regualrWeekString3;
				regOverHrs[3] = regualrWeekString4;
				regOverHrs[4] = regualrWeekString5;
				regOverHrs[5] = regualrWeekString6;

				regOverHrs[6] = overTimeWeekString1;
				regOverHrs[7] = overTimeWeekString2;
				regOverHrs[8] = overTimeWeekString3;
				regOverHrs[9] = overTimeWeekString4;
				regOverHrs[10] = overTimeWeekString5;
				regOverHrs[11] = overTimeWeekString6;

				regOverHrs[12] = holidayTimeWeekString1;
				regOverHrs[13] = holidayTimeWeekString2;
				regOverHrs[14] = holidayTimeWeekString3;
				regOverHrs[15] = holidayTimeWeekString4;
				regOverHrs[16] = holidayTimeWeekString5;
				regOverHrs[17] = holidayTimeWeekString6;

				String startWeekDate = du.getWeekBeginingDate(1, du);

				bTimeSheetUpdate = (request.getParameter("timeSheetMode") != null && request.getParameter("timeSheetMode").equals("Update")) ? Boolean.TRUE : Boolean.FALSE;

				TimeSheetTypes types = TimeSheetTypes.valueOf(getUserProfile(request).getTimeSheetConfiguredTo());

				String weekEndingDate = "";

				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date date = format.parse(startWeekDate);
				switch (types) {
				case MONTHLY: {
					
					int totalDays = du.getIntLastDayOfMonth();
					Calendar cal = du.getCustomDay();
					cal.set(Calendar.DAY_OF_MONTH, totalDays);
					weekEndingDate = format.format(cal.getTime());
					
					if (bTimeSheetUpdate) {
						deleteTimeSheetData(TimeSheetTypes.MONTHLY, userProfile, submissionFor, startWeekDate, null);
					}

					break;
				}
				case BIWEEKLY: {
					Calendar cal = du.getPastSundayCal();
					startWeekDate = format.format(cal.getTime());
					cal.add(Calendar.DAY_OF_MONTH, 7);
					String weekSecondBeginDate = format.format(cal.getTime());

					cal.add(Calendar.DAY_OF_MONTH, 6);
					weekEndingDate = format.format(cal.getTime());

					if (bTimeSheetUpdate) {
						deleteTimeSheetData(TimeSheetTypes.BIWEEKLY, userProfile, submissionFor, startWeekDate, weekSecondBeginDate);
					}

					break;
				}
				case WEEKLY: {
					Calendar cal = du.getPastSundayCal();
					startWeekDate = format.format(cal.getTime());
					cal.add(Calendar.DAY_OF_MONTH, 6);
					weekEndingDate = format.format(cal.getTime());

					if (bTimeSheetUpdate) {
						deleteTimeSheetData(TimeSheetTypes.WEEKLY, userProfile, submissionFor, startWeekDate, null);
					}

					break;
				}
				case DAYS15: {
					Calendar cal = Calendar.getInstance();
					cal.setTime(date);

					if (submissionFor.equals("FIRST")) {
						cal.add(Calendar.DAY_OF_MONTH, 14);
						weekEndingDate = format.format(cal.getTime());
					} else {
						cal.add(Calendar.DAY_OF_MONTH, 15);
						startWeekDate = format.format(cal.getTime());

						log.info("{} {}", cal.get(Calendar.YEAR), cal.getTime());
						cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
						weekEndingDate = format.format(cal.getTime());
					}

					if (bTimeSheetUpdate) {
						deleteTimeSheetData(TimeSheetTypes.DAYS15, userProfile, submissionFor, startWeekDate, null);
					}

					break;
				}
				}

				doTransaction.saveMonthlyHours(regOverHrs);

				Map summary = new HashMap();
				summary.put("userId", getUserProfile(request).getUserId());
				summary.put("businessId", getUserProfile(request).getBusinessId());
				summary.put("month", getUserProfile(request).getDu().getMonth());
				summary.put("year", getUserProfile(request).getDu().getYear());
				summary.put("totalHrsSubmitted", ((String[]) map.get("MONTHLY_TOTAL"))[0]);
				summary.put("status", "PENDING");
				summary.put("totalRegularHrs", ((String[]) map.get("REGULARWEEK_MONTHLY_TOTAL"))[0]);
				summary.put("totalOvertimeHrs", ((String[]) map.get("OVERTIMEWEEK_MONTHLY_TOTAL"))[0]);
				summary.put("totalHolidayHrs", ((String[]) map.get("HOLIDAYWEEK_MONTHLY_TOTAL"))[0]);
				summary.put("submittedDate", Calendar.getInstance().getTime());
				summary.put("clientId", getUserProfile(request).getClientId());
				summary.put("submissionConfiguredTo", types.name());
				summary.put("submissionFor", submissionFor);
				summary.put("startWeekDate", startWeekDate);
				summary.put("endWeekDate", weekEndingDate);

				long weeklyHrsSummaryId = doTransaction.saveMonthlySummaryHours(summary);
				putObjInRequest("weeklyHrsSummaryId", request, weeklyHrsSummaryId);
				forward = mapping.findForward("addSupportingDocs");
			} else {
				ActionErrors messages = new ActionErrors();

				messages.add("SignoutMessage4IllegalAccess", new ActionMessage("SignoutMessage4IllegalAccess"));
				saveMessages(request, messages);
				log.info("Error Messages Saved");
				forward = mapping.findForward("forwardTo");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// Report the error using the appropriate name and ID.
			errors.add("name", new ActionMessage("id"));
		}
		putObjInRequest("isTimeSheetSubmitted", request, "yes");
		return (forward);

	}

	public abstract String makeString(String array[], int weekNum, DateUtils du, String submissionType, UserProfile userProfile, String submissionFor);

	private void deleteTimeSheetData(TimeSheetTypes type, UserProfile userProfile, String submissionFor, String startWeekDate, String weekSecondBeginDate) {

		Map mapQueryValues = new HashMap();

		mapQueryValues.put("userId", userProfile.getUserId());
		mapQueryValues.put("year", userProfile.getDu().getYear());
		mapQueryValues.put("month", userProfile.getDu().getMonth());
		mapQueryValues.put("businessId", userProfile.getBusinessId());
		mapQueryValues.put("startWeekDate", startWeekDate);
		mapQueryValues.put("submissionConfiguredTo", userProfile.getTimeSheetConfiguredTo());
		mapQueryValues.put("submissionFor", submissionFor);

		DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		boolean bDeleted = false;

		switch (type) {
		case MONTHLY: {

			bDeleted = doTransaction.deleteMonthlySummaryHours(mapQueryValues);
			bDeleted = doTransaction.deleteWeeklyHours(mapQueryValues);

			break;
		}
		case BIWEEKLY: {
			mapQueryValues.put("weekStartDate", startWeekDate);
			bDeleted = doTransaction.deleteMonthlySummaryHours(mapQueryValues);
			bDeleted = doTransaction.deleteWeeklyHoursByWeek(mapQueryValues);
			break;
		}
		case WEEKLY: {

			doTransaction.deleteMonthlySummaryHours(mapQueryValues);

			mapQueryValues.put("weekStartDate", weekSecondBeginDate);
			doTransaction.deleteWeeklyHoursByWeek(mapQueryValues);

			break;

		}
		case DAYS15: {
			doTransaction.deleteMonthlySummaryHours(mapQueryValues);
			doTransaction.deleteWeeklyHoursDays15(mapQueryValues);
			break;
		}
		}
	}

}
