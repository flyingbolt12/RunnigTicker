package com.lch.POI.Sheets;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;

public class CustomRowHeader {

	public CustomRowHeader(String headerName) {
		this.headerName = headerName;
	}

	private String headerName = "";
	private HSSFCellStyle cellStyle;

	public String getHeaderName() {
		return headerName;
	}

	public void setHeaderName(String headerName) {
		this.headerName = headerName;
	}

	public HSSFCellStyle getCellStyle() {
		return cellStyle;
	}

	public void setCellStyle(HSSFCellStyle cellStyle) {
		this.cellStyle = cellStyle;
	}

}
