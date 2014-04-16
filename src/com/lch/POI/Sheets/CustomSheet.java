package com.lch.POI.Sheets;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.lch.general.generalBeans.CategoriesAndEmployees;
import com.lch.general.genericUtils.EmployeeTimeSheetsBasedOnTypes;

public class CustomSheet {

	private String sheetName = "";
	private ArrayList<CustomRowHeader> rowHeaders = new ArrayList<CustomRowHeader>();
	private List<CategoriesAndEmployees> categoriesAndEmployees = new ArrayList<CategoriesAndEmployees>();
	private Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployeeMonthlyTimeSheets;

	public List<CategoriesAndEmployees> getCategoriesAndEmployees() {
		return categoriesAndEmployees;
	}

	public void setCategoriesAndEmployees(
			List<CategoriesAndEmployees> categoriesAndEmployees) {
		this.categoriesAndEmployees = categoriesAndEmployees;
	}
	
	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}

	public ArrayList<CustomRowHeader> getRowHeaders() {
		return rowHeaders;
	}

	public void setRowHeaders(ArrayList<CustomRowHeader> rowHeaders) {
		this.rowHeaders = rowHeaders;
	}

	public Map<String, EmployeeTimeSheetsBasedOnTypes> getIndependentEmployeeMonthlyTimeSheets() {
		return independentEmployeeMonthlyTimeSheets;
	}

	public void setIndependentEmployeeMonthlyTimeSheets(Map<String, EmployeeTimeSheetsBasedOnTypes> independentEmployeeMonthlyTimeSheets) {
		this.independentEmployeeMonthlyTimeSheets = independentEmployeeMonthlyTimeSheets;
	}

}
