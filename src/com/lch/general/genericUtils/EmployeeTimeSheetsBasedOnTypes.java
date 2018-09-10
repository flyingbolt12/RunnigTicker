package com.lch.general.genericUtils;

import java.util.ArrayList;
import java.util.List;

import com.lch.general.generalBeans.CategoriesAndEmployees;

public class EmployeeTimeSheetsBasedOnTypes {


	private List<CategoriesAndEmployees> rh = new ArrayList<CategoriesAndEmployees>();
	private List<CategoriesAndEmployees> hh = new ArrayList<CategoriesAndEmployees>();
	private List<CategoriesAndEmployees> ot = new ArrayList<CategoriesAndEmployees>();

	double totalRHHours = 0.0d;
	double totalHHHours = 0.0d;
	double totalOTours = 0.0d;
	
	long categoryId = -1;

	public List<CategoriesAndEmployees> getRh() {
		return rh;
	}

	public void setRh(List<CategoriesAndEmployees> rh) {
		this.rh = rh;
	}

	public List<CategoriesAndEmployees> getHh() {
		return hh;
	}

	public void setHh(List<CategoriesAndEmployees> hh) {
		this.hh = hh;
	}

	public List<CategoriesAndEmployees> getOt() {
		return ot;
	}

	public void setOt(List<CategoriesAndEmployees> ot) {
		this.ot = ot;
	}

	public double getTotalRHHours() {
		return totalRHHours;
	}

	public double getTotalHHHours() {
		return totalHHHours;
	}

	public double getTotalOTours() {
		return totalOTours;
	}

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public void setTotalRHHours(double totalRHHours) {
		this.totalRHHours = totalRHHours;
	}

	public void setTotalHHHours(double totalHHHours) {
		this.totalHHHours = totalHHHours;
	}

	public void setTotalOTours(double totalOTours) {
		this.totalOTours = totalOTours;
	}


}
