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

import com.ivucenter.cloud.portal.bss.discount.CustomBssDiscountVO;
import com.ivucenter.cloud.portal.cmm.customer.CustomCmmCustomerVO;
import com.ivucenter.cloud.portal.req.user.CustomReqUserVO;

public class CmmCustomerExcelView extends AbstractXlsView{

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
		
		if(excelGbn.equals("vatRate")){
			excelVatRate(workbook, (List<CustomCmmCustomerVO>) modelMap.get("excel_list"), excelTitle);
		}else if(excelGbn.equals("user")){
			excelUser(workbook, (List<CustomReqUserVO>) modelMap.get("excel_list"), excelTitle);
		}else if(excelGbn.equals("bssDiscount")){
			bssDiscountExcel(workbook, (List<CustomBssDiscountVO>) modelMap.get("excel_list"), excelTitle);			
		}
		res.setContentType("Application/Msexcel");
	}
	
	private void bssDiscountExcel(Workbook workbook, List<CustomBssDiscountVO> list, String excelTitle) {
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
		
		for(int i=1; i <= 4; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("구분");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("고객사");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("할인율(%)");
		headCell4.setCellStyle(styleHeader);
		
		for(CustomBssDiscountVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCompanyName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCustomerName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProjectAlias());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getDiscountRate());
			bodyCell4.setCellStyle(styleBody);
		}
	}
	
	private void excelUser(Workbook workbook, List<CustomReqUserVO> list, String excelTitle) {
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
		
		for(int i=1; i <= 8; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("회원사");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("소속조직(부서)");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("ID");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("사용자명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("전화번호(사선)");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("수신여부(문자)");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("수신여부(이메일)");
		headCell7.setCellStyle(styleHeader);
		for(CustomReqUserVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCustomerName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getDeptName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getUserId());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getUserName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getUserTelEx());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			if(vo.getSmsRecvFlag().equals("Y")) {
				bodyCell6.setCellValue("✔");
			} else {
				bodyCell6.setCellValue("-");
			}
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			if(vo.getMailRecvFlag().equals("Y")) {
				bodyCell7.setCellValue("✔");
			} else {
				bodyCell7.setCellValue("-");
			}
			bodyCell7.setCellStyle(styleBody);

		}
	}
	
	private void excelVatRate(Workbook workbook, List<CustomCmmCustomerVO> list, String excelTitle) {
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
		
		for(int i=1; i <= 6; i++){
			sheet.setColumnWidth(i, 5000);
		}
		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("고객사ID");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("구분");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("고객사");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("대표자명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("담당자");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("부가가치세율(%)");
		headCell6.setCellStyle(styleHeader);
		
		for(CustomCmmCustomerVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCustomerId());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCustomerName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getCompanyName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getCompanyRepDec());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getManagerName());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getVatRate()+"%");
			bodyCell6.setCellStyle(styleBody);
		}
	}
}
