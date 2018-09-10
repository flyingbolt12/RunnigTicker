package com.lch.POI;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.jfree.util.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.POI.Sheets.CustomRowHeader;
import com.lch.POI.Sheets.CustomSheet;
import com.lch.POI.beans.RowHeaders;
import com.lch.general.generalBeans.CategoriesAndEmployees;
import com.lch.general.genericUtils.EmployeeTimeSheetsBasedOnTypes;

public class ExportToExcel {

	private static Logger logger = LoggerFactory.getLogger(ExportToExcel.class);

	public static SXSSFWorkbook generateReport(List<Map<String, Object>> listAllMyCategories, List<CategoriesAndEmployees> categoriesAndEmployees,
			Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployeeMonthlyTimeSheets) {

		ExportToExcel e = new ExportToExcel();
		SXSSFWorkbook book = e.writeToExcel(categoriesAndEmployees, listAllMyCategories, independentEmployeeMonthlyTimeSheets);
		return book;

	}

	public SXSSFWorkbook writeToExcel(List<CategoriesAndEmployees> categoriesAndEmployees, List<Map<String, Object>> sheetsList,
			Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployeeMonthlyTimeSheets) {

		ArrayList<CustomSheet> sheets = new ArrayList<CustomSheet>();
		ArrayList<CustomRowHeader> rowHeaders = new ArrayList<CustomRowHeader>();

		RowHeaders[] rows = RowHeaders.values();
		for (RowHeaders row : rows) {
			rowHeaders.add(new CustomRowHeader(row.getValue()));
		}

		ArrayList<CustomRowHeader> mRowHeaders = new ArrayList<CustomRowHeader>();
		
		mRowHeaders.add(new CustomRowHeader("INDEX"));
		mRowHeaders.add(new CustomRowHeader("USER ID"));
		mRowHeaders.add(new CustomRowHeader("NAME"));
		mRowHeaders.add(new CustomRowHeader("CLINET NAME"));
		mRowHeaders.add(new CustomRowHeader("Total RH Hours"));
		mRowHeaders.add(new CustomRowHeader("Total OT Hours"));
		mRowHeaders.add(new CustomRowHeader("Total HH Hours"));
		
		Log.info("Processing Users Monthly Report");
		// Users Monthly Report
		CustomSheet cs = new CustomSheet();
		cs.setRowHeaders(mRowHeaders);
		cs.setSheetName("Users - Monthly Report");
		cs.setIndependentEmployeeMonthlyTimeSheets(independentEmployeeMonthlyTimeSheets);
		sheets.add(cs);
		logger.info("Completed Processing Users Monthly Report");
		
		logger.info("Processing Category Monthly Report");
		// Categories Monthly Report
		for (Map<String, Object> category : sheetsList) {

			Map<String, EmployeeTimeSheetsBasedOnTypes> categorySpecificTimSheetsOfAUser = new HashMap<String, EmployeeTimeSheetsBasedOnTypes>();
			cs = new CustomSheet();
			Long idcategories = Long.valueOf(category.get("idcategories").toString());
			logger.info("Now tracing category id {} specific employees", idcategories);
			Set<String> keys = independentEmployeeMonthlyTimeSheets.keySet();
			
			for (String key : keys){
				EmployeeTimeSheetsBasedOnTypes t = independentEmployeeMonthlyTimeSheets.get(key);
				logger.info("Categoring this user {} -- category Id {}", key, t.getCategoryId());
				if (t.getCategoryId() == idcategories){
					logger.info("Match Found for category id {}", key, t.getCategoryId());
					categorySpecificTimSheetsOfAUser.put(key, t);
				}
			}
			cs.setRowHeaders(mRowHeaders);
			cs.setSheetName((String) category.get(("name"))+"-Monthly Report");
			cs.setIndependentEmployeeMonthlyTimeSheets(categorySpecificTimSheetsOfAUser);
			
			if(categorySpecificTimSheetsOfAUser.size() > 0) {
				logger.info((String) category.get(("name"))+"-Monthly Report");
				sheets.add(cs);
			}
			else
			{
				logger.info("No Data available .. Skipping {}", (String) category.get(("name"))+" -- Monthly Report");
			}
		}
		
		// In - Details TimeSheets
		CustomSheet indetails = new CustomSheet();
		indetails.setRowHeaders(rowHeaders);
		indetails.setSheetName("Details");
		indetails.setCategoriesAndEmployees(categoriesAndEmployees);
		sheets.add(indetails);
		
		return new ExportToExcel().getXLSX(sheets);

	}

	public SXSSFWorkbook getXLSX(ArrayList<CustomSheet> sheets) {

		SXSSFWorkbook myBook = new SXSSFWorkbook();

		
		Iterator<CustomSheet> it = sheets.listIterator();

		CellStyle style = createCellStyle(myBook);

		while (it.hasNext()) {
			CustomSheet cs = it.next();
			logger.info("Creating Sheet with name {}", cs.getSheetName());
			Sheet sheet = myBook.createSheet(cs.getSheetName());
			
			if (cs.getIndependentEmployeeMonthlyTimeSheets() == null) {
				ArrayList<CustomRowHeader> rowHeaders = cs.getRowHeaders();
				buildHeaderRow(rowHeaders, sheet, style);
				
				logger.info("{}, {}", cs.getSheetName(), cs.getCategoriesAndEmployees().size());
				fillData(cs.getCategoriesAndEmployees(), sheet);
				
				int i = 0;
				for (CustomRowHeader crh : rowHeaders) {
					sheet.autoSizeColumn(i++);
				}
				
			} else {
				
				ArrayList<CustomRowHeader> rowHeaders = cs.getRowHeaders();
				buildHeaderRow(rowHeaders, sheet, style);
				
				logger.info("{}, {}", cs.getSheetName(), cs.getCategoriesAndEmployees().size());
				fillData(cs.getIndependentEmployeeMonthlyTimeSheets(), sheet);
				
				int i = 0;
				for (CustomRowHeader crh : rowHeaders) {
					sheet.autoSizeColumn(i++);
				}
			}
			
		}
		return myBook;
	}

	private CellStyle createCellStyle(SXSSFWorkbook myBook) {

		CellStyle style = myBook.createCellStyle();
		style.setFillForegroundColor(HSSFColor.GREY_80_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		Font font = myBook.createFont();
		font.setColor(HSSFColor.WHITE.index);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);
		return style;
	}

	private void getDetails(EmployeeTimeSheetsBasedOnTypes details, Map<String, String> map){
		
		boolean isFound = getDetails(details.getRh(),map);
		
		if(!isFound)
			isFound = getDetails(details.getHh(),map);
		
		if(!isFound)
			isFound = getDetails(details.getOt(),map);
	}
	private boolean getDetails(List<CategoriesAndEmployees> timeSheets, Map<String, String> map){
		
		if (timeSheets.size() == 0) return false;
		String name="";
		String cName = "";
		name = timeSheets.get(0).getEmployeeName();
		cName = timeSheets.get(0).getClientName();
		map.put("name", name);
		map.put("cName", cName);
		return true;
	
	}
	
	private void fillData(Map<String, EmployeeTimeSheetsBasedOnTypes> rows, Sheet sheet) {
		
		Set<String> userIds = rows.keySet();
		
		int index = 0;
		
		for(String userId : userIds) {
			String name=null, cName=null;
			++index;
			EmployeeTimeSheetsBasedOnTypes type = rows.get(userId);
			
			if(name == null && cName== null){
				Map<String, String> details = new HashMap<String, String>();
				getDetails(type, details);
				name = details.get("name");
				cName = details.get("cName");
			}
			// logger.info("==> {} {}",  name, cName);
			Row topRow = sheet.createRow(index);
			String[] arr = {index+"", userId, name, cName, type.getTotalRHHours()+"", type.getTotalOTours()+"", type.getTotalHHHours()+""};
			
			fillActualData(arr, topRow);
		}
		
	}
	private void fillData(List<CategoriesAndEmployees> rows, Sheet sheet) {
		Iterator<CategoriesAndEmployees> cit = rows.listIterator();
		int index = 1;
		while (cit.hasNext()) {

			Row topRow = sheet.createRow(index);

			CategoriesAndEmployees bean = cit.next();
			String[] arr = bean.getPropsAsArray();
			// logger.info("===> {}", arr);
			fillActualData(arr, topRow);

			++index;
		}
	}
	private void fillActualData(String[] arr, Row topRow) {
		for (int i = 0; i < arr.length; ++i) {
			Cell cell = topRow.createCell(i);
			// logger.info("{}", arr[i]);
			 if(arr[i]==null) arr[i] = "";
			if (arr[i]!=null && arr[i].equals("FIRST") || arr[i].equals("SECOND")) {
				arr[i] = "15 DAYS";
			}
			cell.setCellValue(arr[i]);
		}
	}

	private void buildHeaderRow(ArrayList<com.lch.POI.Sheets.CustomRowHeader> rowHeaders, Sheet sheet, CellStyle style) {
		Iterator<CustomRowHeader> cit = rowHeaders.listIterator();
		Row topRow = sheet.createRow(0);
		int index = 0;
		while (cit.hasNext()) {
			CustomRowHeader crh = cit.next();
			Cell cell = topRow.createCell(index);

			cell.setCellStyle(style);
			cell.setCellValue(new HSSFRichTextString(crh.getHeaderName()));
			++index;
		}
	}
}
