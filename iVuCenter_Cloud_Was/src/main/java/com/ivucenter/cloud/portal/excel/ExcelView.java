package com.ivucenter.cloud.portal.excel;

import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;

public class ExcelView extends AbstractXlsView{

	@Override
	protected void buildExcelDocument(Map<String, Object> modelMap, 
									  Workbook workbook, 
									  HttpServletRequest req,
									  HttpServletResponse res) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<CustomChargeBillVO> excelList = (List<CustomChargeBillVO>) modelMap.get("excelList");
		
		//엑셀 파일명 설정
		String fileName = "청구내역_"+DateFormatUtils.format(new Date(), "yyyyMMdd_HHmmss");
		
		String userAgent = req.getHeader("User-AgenXlst");
		if (userAgent.indexOf("MSIE") > -1) {
			fileName = URLEncoder.encode(fileName, "utf-8");
		} else {
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
		}
		
		res.setHeader("Content-disposition", "attachment; filename="+fileName+".xls");
		res.setHeader("Content-Transfer-Encoding", "binary");
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "청구내역");
		
		
		//header
		int rowIndex = 1;
	
		Row rowHead = sheet.createRow(rowIndex++);				// Row 객체 생성
		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
		
		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);//셀 색채우기
		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
		
		styleBody.setAlignment(CellStyle.ALIGN_CENTER);			//정렬
		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody.setBorderRight(CellStyle.BORDER_THIN);
		styleBody.setBorderTop(CellStyle.BORDER_THIN);
		styleBody.setBorderBottom(CellStyle.BORDER_THIN);

		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);			//정렬
		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
		styleBody2.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		
		sheet.setColumnWidth(1, 5000);
		sheet.setColumnWidth(2, 5000);
		
		Cell headCell = rowHead.createCell(1);
		headCell.setCellValue("항목");
		headCell.setCellStyle(styleHeader);
		
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("금액");
		headCell2.setCellStyle(styleHeader);
		
		for(int i=0; i<excelList.size(); i++ ){
			Row rowBody = sheet.createRow(rowIndex++);
			Cell bodyCell = rowBody.createCell(1);
			bodyCell.setCellValue(excelList.get(i).getInvoiceItemName());
			bodyCell.setCellStyle(styleBody);
			
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(excelList.get(i).getAmount());
			bodyCell2.setCellStyle(styleBody2);
			
		}
		
		res.setContentType("Application/Msexcel");
		
	}

}
