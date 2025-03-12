package com.ivucenter.cloud.portal.excel;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelService extends AbstractXlsView{
	
	//workbook 생성 Excel 2007 이전 버전
	Workbook xlsWb = new HSSFWorkbook();
	
	//workbook 생성 Excel 2007 이후 버전
	Workbook xlsxWb = new HSSFWorkbook();
	
	//Sheet 생성
	Sheet sheet1 = xlsWb.createSheet("firstSheet");
	//컬럼 너비 설정

	@Override
	protected void buildExcelDocument(Map<String, Object> arg0, 
									  Workbook arg1, 
									  HttpServletRequest arg2,
									  HttpServletResponse arg3) throws Exception {

		
	}
	
	
}
