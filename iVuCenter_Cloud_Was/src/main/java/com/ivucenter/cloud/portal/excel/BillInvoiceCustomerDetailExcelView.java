package com.ivucenter.cloud.portal.excel;

import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;

public class BillInvoiceCustomerDetailExcelView extends AbstractXlsView{

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> modelMap, Workbook workbook, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		String excelGbn = (String) modelMap.get("excel_gbn");
		String excelTitle = (String) modelMap.get("excel_title");
		
		//엑셀 파일명 설정
		String fileName = excelTitle+DateFormatUtils.format(new Date(), "_yyyyMMdd_HHmmss");
		
		String userAgent = req.getHeader("User-Agent");
		// 사용자의 브라우저 정보에 따라 파일명의 인코딩 여부를 결정함 IE11이상은 MSIE에 대한 값이 변경되어 해당 부분 수정 (2019.12.12 장중일)
		if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv") > -1) {
			// IE일 경우 
			fileName = URLEncoder.encode(fileName, "utf-8");
		} else {
			// 크롬, 사파리 등
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1"); 
		}
		
		res.setHeader("Content-disposition", "attachment; filename="+fileName+".xls");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		if(excelGbn.equals("chargeBill")){
			chargeBillExcel(workbook, (List<CustomChargeBillVO>) modelMap.get("excel_list"), excelTitle);
		}
		res.setContentType("Application/Msexcel");
	}
	
	private void chargeBillExcel(Workbook workbook, List<CustomChargeBillVO> list, String excelTitle) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, excelTitle);
		
		//header
		int rowIndex = 1;
	
		Row rowHead = sheet.createRow(rowIndex++);
		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
		
		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
		
		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody.setBorderRight(CellStyle.BORDER_THIN);
		styleBody.setBorderTop(CellStyle.BORDER_THIN);
		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
		
		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
		
		for(int i=1; i <= 9; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("청구년월");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("가상서버");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("블록디스크");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("계정관리");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("보안관제");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("백업");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("SW설치");
		headCell7.setCellStyle(styleHeader);
		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("디스크작업");
		headCell8.setCellStyle(styleHeader);
		Cell headCell9 = rowHead.createCell(9);
		headCell9.setCellValue("매출금액");
		headCell9.setCellStyle(styleHeader);
		
		
		for(CustomChargeBillVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getBillYyyymm().substring(0,4)+"-"+vo.getBillYyyymm().substring(4,6));
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(String.format("%,d", Integer.parseInt(vo.getAA00Amount())));
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(String.format("%,d", Integer.parseInt(vo.getAE00Amount())));
			bodyCell3.setCellStyle(styleBody);
			
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(String.format("%,d", Integer.parseInt(vo.getServiceAccountAmount())));
			bodyCell4.setCellStyle(styleBody2);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(String.format("%,d", Integer.parseInt(vo.getServiceSecurityAmount())));
			bodyCell5.setCellStyle(styleBody2);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(String.format("%,d", Integer.parseInt(vo.getServiceBackupAmount())));
			bodyCell6.setCellStyle(styleBody2);
			
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(String.format("%,d", Integer.parseInt(vo.getServiceSwAmount())));
			bodyCell7.setCellStyle(styleBody);
			Cell bodyCell8 = rowBody.createCell(8);
			bodyCell8.setCellValue(String.format("%,d", Integer.parseInt(vo.getServiceDiskAmount())));
			bodyCell8.setCellStyle(styleBody);
			Cell bodyCell9 = rowBody.createCell(9);
			bodyCell9.setCellValue(String.format("%,d", (Integer.parseInt(vo.getServiceDiskAmount()) + Integer.parseInt(vo.getServiceSwAmount()) + Integer.parseInt(vo.getServiceBackupAmount()) +  Integer.parseInt(vo.getServiceSecurityAmount()) + Integer.parseInt(vo.getAA00Amount()) + Integer.parseInt(vo.getAE00Amount()) + Integer.parseInt(vo.getServiceAccountAmount()))));
			bodyCell9.setCellStyle(styleBody);
			
		}
	}
	
}
