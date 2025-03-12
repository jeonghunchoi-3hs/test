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
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;

public class SalesExcelView extends AbstractXlsView{

	@Override
	protected void buildExcelDocument(Map<String, Object> modelMap, Workbook workbook, HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<CustomChargeBillVO> excelList = (List<CustomChargeBillVO>) modelMap.get("excelList");
		
		//엑셀 파일명 설정
		String fileName = "매출현황_"+DateFormatUtils.format(new Date(), "yyyyMMdd_HHmmss");
		
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
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "매출현황");
		
		
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
		
		sheet.setColumnWidth(1, 5000);
		sheet.setColumnWidth(2, 5000);
		sheet.setColumnWidth(3, 5000);
		sheet.setColumnWidth(4, 5000);
		sheet.setColumnWidth(5, 5000);
		sheet.setColumnWidth(6, 5000);
		sheet.setColumnWidth(7, 5000);

		
		Cell headCell = rowHead.createCell(1);
		headCell.setCellValue("회원사명");
		headCell.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("담당조직(부서)");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트ID");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("프로젝트명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("담당자");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("매출년월");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("사용요금");
		headCell7.setCellStyle(styleHeader);
		
		for(int i=0; i<excelList.size(); i++ ){
			Row rowBody = sheet.createRow(rowIndex++);
			
			Cell bodyCell = rowBody.createCell(1);
			bodyCell.setCellValue(excelList.get(i).getCustomerName());
			bodyCell.setCellStyle(styleBody);
			
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(excelList.get(i).getDeptName().replaceAll(" ", ""));
			bodyCell2.setCellStyle(styleBody);
			
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(excelList.get(i).getProjectName());
			bodyCell3.setCellStyle(styleBody);
			
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(excelList.get(i).getProjectAlias());
			bodyCell4.setCellStyle(styleBody);
			
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(excelList.get(i).getManagerName());
			bodyCell5.setCellStyle(styleBody);
			
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(excelList.get(i).getBillYyyymm().substring(0,4)+"-"+excelList.get(i).getBillYyyymm().substring(4,6));
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(String.format("%,d", Integer.parseInt(excelList.get(i).getAmount())));
			bodyCell7.setCellStyle(styleBody2);
		}
		
		int numBottom = rowIndex+1;
		Row rowBottom = sheet.createRow(numBottom);
		Cell bottomCell1 = rowBottom.createCell(1);
		bottomCell1.setCellValue("매출합계");
		bottomCell1.setCellStyle(styleHeader);

		Cell bottomCell2 = rowBottom.createCell(2);
		bottomCell2.setCellStyle(styleHeader);
		
		Cell bottomCell3 = rowBottom.createCell(3);
		bottomCell3.setCellStyle(styleHeader);
		
		Cell bottomCell4 = rowBottom.createCell(4);
		bottomCell4.setCellStyle(styleHeader);
		
		Cell bottomCell5 = rowBottom.createCell(5);
		bottomCell5.setCellStyle(styleHeader);
		
		Cell bottomCell6 = rowBottom.createCell(6);
		bottomCell6.setCellStyle(styleHeader);
		
		Cell bottomCell7 = rowBottom.createCell(7);
		bottomCell7.setCellValue(String.format("%,d", Integer.parseInt((String) modelMap.get("totalAmount"))));
		bottomCell7.setCellStyle(styleHeader);
		
		//셀병합
		sheet.addMergedRegion(new CellRangeAddress(numBottom, numBottom, 2, 5));
		
		res.setContentType("Application/Msexcel");
		
	}

}
