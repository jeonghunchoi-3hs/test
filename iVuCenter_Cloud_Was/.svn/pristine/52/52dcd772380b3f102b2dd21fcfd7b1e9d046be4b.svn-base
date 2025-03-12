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

import com.ivucenter.cloud.portal.productUsageStatus.app.CustomProductUsageStatusAppVO;
import com.ivucenter.cloud.portal.productUsageStatus.disk.CustomProductUsageStatusDiskVO;
import com.ivucenter.cloud.portal.productUsageStatus.fs.CustomProductUsageStatusFsVO;
import com.ivucenter.cloud.portal.productUsageStatus.ip.CustomProductUsageStatusIpVO;
import com.ivucenter.cloud.portal.productUsageStatus.lb.CustomProductUsageStatusLbVO;
import com.ivucenter.cloud.portal.productUsageStatus.pv.CustomProductUsageStatusPvVO;
import com.ivucenter.cloud.portal.productUsageStatus.service.CustomProductUsageStatusServiceVO;
import com.ivucenter.cloud.portal.productUsageStatus.total.CustomProductUsageStatusTotalVO;
import com.ivucenter.cloud.portal.productUsageStatus.vm.CustomProductUsageStatusVmVO;

public class ProductUsageStatusExcelView extends AbstractXlsView{

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

		if(excelGbn.equals("total")){
			excelTotal(workbook, (List<CustomProductUsageStatusTotalVO>) modelMap.get("excel_list"), (CustomProductUsageStatusTotalVO) modelMap.get("excel_list_total"));
		}else if(excelGbn.equals("vm")){
			excelVm(workbook, (List<CustomProductUsageStatusVmVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("disk")){
			excelDisk(workbook, (List<CustomProductUsageStatusDiskVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("pv")){
			excelPv(workbook, (List<CustomProductUsageStatusPvVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("fs")){
			excelFs(workbook, (List<CustomProductUsageStatusFsVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("lb")){
			excelLb(workbook, (List<CustomProductUsageStatusLbVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("ip")){
			excelIp(workbook, (List<CustomProductUsageStatusIpVO>) modelMap.get("excel_list"));
//		}else if(excelGbn.equals("back")){
//			excelBack(workbook, (List<CustomProductUsageStatusBackVO>) modelMap.get("excel_list"));
//		}else if(excelGbn.equals("mca")){
//			excelMca(workbook, (List<CustomProductUsageStatusMcaVO>) modelMap.get("excel_list"));
//		}
//		else if(excelGbn.equals("scm")){
//			excelScm(workbook, (List<CustomProductUsageStatusScmVO>) modelMap.get("excel_list"));
//		}
//		else if(excelGbn.equals("sec")){
//			excelSec(workbook, (List<CustomProductUsageStatusSecVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("service")){
			excelService(workbook, (List<CustomProductUsageStatusServiceVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("app")) {
			excelApp(workbook, (List<CustomProductUsageStatusAppVO>) modelMap.get("excel_list"));
		}
		res.setContentType("Application/Msexcel");

	}

//	private void excelSec(Workbook workbook, List<CustomProductUsageStatusSecVO> list) {
//		Sheet sheet = workbook.createSheet();
//		workbook.setSheetName(0, "상품사용현황_보안관제서비스");
//
//		//header
//		int rowIndex = 1;
//
//		Row rowHead = sheet.createRow(rowIndex++);
//		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
//		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
//		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
//
//		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
//		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
//		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
//		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
//		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
//		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
//
//		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
//
//		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
//		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
//
//		for(int i=1; i <= 5; i++){
//			sheet.setColumnWidth(i, 5000);
//		}
//
//		Cell headCell1 = rowHead.createCell(1);
//		headCell1.setCellValue("구분");
//		headCell1.setCellStyle(styleHeader);
//		Cell headCell2 = rowHead.createCell(2);
//		headCell2.setCellValue("고객사명");
//		headCell2.setCellStyle(styleHeader);
//		Cell headCell3 = rowHead.createCell(3);
//		headCell3.setCellValue("프로젝트명");
//		headCell3.setCellStyle(styleHeader);
//		Cell headCell4 = rowHead.createCell(4);
//		headCell4.setCellValue("과금단위");
//		headCell4.setCellStyle(styleHeader);
//		Cell headCell5 = rowHead.createCell(5);
//		headCell5.setCellValue("상품가입일시");
//		headCell5.setCellStyle(styleHeader);
//
//		for(CustomProductUsageStatusSecVO vo : list){
//			Row rowBody = sheet.createRow(rowIndex++);
//
//			Cell bodyCell1 = rowBody.createCell(1);
//			bodyCell1.setCellValue(vo.getCompanyName());
//			bodyCell1.setCellStyle(styleBody);
//			Cell bodyCell2 = rowBody.createCell(2);
//			bodyCell2.setCellValue(vo.getCustomerName());
//			bodyCell2.setCellStyle(styleBody);
//			Cell bodyCell3 = rowBody.createCell(3);
//			bodyCell3.setCellValue(vo.getProjectAlias());
//			bodyCell3.setCellStyle(styleBody);
//			Cell bodyCell4 = rowBody.createCell(4);
//			bodyCell4.setCellValue(vo.getHourlyFlag().equals("Y")?"시간":"월");
//			bodyCell4.setCellStyle(styleBody);
//			Cell bodyCell5 = rowBody.createCell(5);
//			bodyCell5.setCellValue(vo.getRegDatetime());
//			bodyCell5.setCellStyle(styleBody);
//		}
//
//	}

	private void excelService(Workbook workbook, List<CustomProductUsageStatusServiceVO> list) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_서비스상품");

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

		for(int i=1; i <= 5; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("회원사명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("프로젝트ID");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("상품유형");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("상품명");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("가상서버");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("상품승인일시");
		headCell7.setCellStyle(styleHeader);

		for(CustomProductUsageStatusServiceVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCustomerName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getProjectName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProjectAlias());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getServiceTypeName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getServiceName());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getHostnameAlias());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getRegDatetime().replace("<br> ", ""));
			bodyCell7.setCellStyle(styleBody);
		}

	}

//	private void excelScm(Workbook workbook, List<CustomProductUsageStatusScmVO> list) {
//		Sheet sheet = workbook.createSheet();
//		workbook.setSheetName(0, "상품사용현황_형상관리서비스");
//
//		//header
//		int rowIndex = 1;
//
//		Row rowHead = sheet.createRow(rowIndex++);
//		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
//		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
//		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
//
//		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
//		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
//		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
//		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
//		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
//		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
//
//		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
//
//		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
//		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
//
//		for(int i=1; i <= 5; i++){
//			sheet.setColumnWidth(i, 5000);
//		}
//
//		Cell headCell1 = rowHead.createCell(1);
//		headCell1.setCellValue("구분");
//		headCell1.setCellStyle(styleHeader);
//		Cell headCell2 = rowHead.createCell(2);
//		headCell2.setCellValue("고객사명");
//		headCell2.setCellStyle(styleHeader);
//		Cell headCell3 = rowHead.createCell(3);
//		headCell3.setCellValue("프로젝트명");
//		headCell3.setCellStyle(styleHeader);
//		Cell headCell4 = rowHead.createCell(4);
//		headCell4.setCellValue("과금단위");
//		headCell4.setCellStyle(styleHeader);
//		Cell headCell5 = rowHead.createCell(5);
//		headCell5.setCellValue("상품가입일시");
//		headCell5.setCellStyle(styleHeader);
//
//		for(CustomProductUsageStatusScmVO vo : list){
//			Row rowBody = sheet.createRow(rowIndex++);
//
//			Cell bodyCell1 = rowBody.createCell(1);
//			bodyCell1.setCellValue(vo.getCompanyName());
//			bodyCell1.setCellStyle(styleBody);
//			Cell bodyCell2 = rowBody.createCell(2);
//			bodyCell2.setCellValue(vo.getCustomerName());
//			bodyCell2.setCellStyle(styleBody);
//			Cell bodyCell3 = rowBody.createCell(3);
//			bodyCell3.setCellValue(vo.getProjectAlias());
//			bodyCell3.setCellStyle(styleBody);
//			Cell bodyCell4 = rowBody.createCell(4);
//			bodyCell4.setCellValue(vo.getHourlyFlag().equals("Y")?"시간":"월");
//			bodyCell4.setCellStyle(styleBody);
//			Cell bodyCell5 = rowBody.createCell(5);
//			bodyCell5.setCellValue(vo.getRegDatetime());
//			bodyCell5.setCellStyle(styleBody);
//		}
//	}

//	private void excelMca(Workbook workbook, List<CustomProductUsageStatusMcaVO> list) {
//		Sheet sheet = workbook.createSheet();
//		workbook.setSheetName(0, "상품사용현황_대외계서비스");
//
//		//header
//		int rowIndex = 1;
//
//		Row rowHead = sheet.createRow(rowIndex++);
//		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
//		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
//		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
//
//		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
//		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
//		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
//		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
//		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
//		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
//
//		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
//
//		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
//		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
//
//		for(int i=1; i <= 5; i++){
//			sheet.setColumnWidth(i, 5000);
//		}
//
//		Cell headCell1 = rowHead.createCell(1);
//		headCell1.setCellValue("구분");
//		headCell1.setCellStyle(styleHeader);
//		Cell headCell2 = rowHead.createCell(2);
//		headCell2.setCellValue("고객사명");
//		headCell2.setCellStyle(styleHeader);
//		Cell headCell3 = rowHead.createCell(3);
//		headCell3.setCellValue("프로젝트명");
//		headCell3.setCellStyle(styleHeader);
//		Cell headCell4 = rowHead.createCell(4);
//		headCell4.setCellValue("과금단위");
//		headCell4.setCellStyle(styleHeader);
//		Cell headCell5 = rowHead.createCell(5);
//		headCell5.setCellValue("상품가입일시");
//		headCell5.setCellStyle(styleHeader);
//
//		for(CustomProductUsageStatusMcaVO vo : list){
//			Row rowBody = sheet.createRow(rowIndex++);
//
//			Cell bodyCell1 = rowBody.createCell(1);
//			bodyCell1.setCellValue(vo.getCompanyName());
//			bodyCell1.setCellStyle(styleBody);
//			Cell bodyCell2 = rowBody.createCell(2);
//			bodyCell2.setCellValue(vo.getCustomerName());
//			bodyCell2.setCellStyle(styleBody);
//			Cell bodyCell3 = rowBody.createCell(3);
//			bodyCell3.setCellValue(vo.getProjectAlias());
//			bodyCell3.setCellStyle(styleBody);
//			Cell bodyCell4 = rowBody.createCell(4);
//			bodyCell4.setCellValue(vo.getHourlyFlag().equals("Y")?"시간":"월");
//			bodyCell4.setCellStyle(styleBody);
//			Cell bodyCell5 = rowBody.createCell(5);
//			bodyCell5.setCellValue(vo.getRegDatetime());
//			bodyCell5.setCellStyle(styleBody);
//		}
//	}

//	private void excelBack(Workbook workbook, List<CustomProductUsageStatusBackVO> list) {
//		Sheet sheet = workbook.createSheet();
//		workbook.setSheetName(0, "상품사용현황_백업서비스");
//
//		//header
//		int rowIndex = 1;
//
//		Row rowHead = sheet.createRow(rowIndex++);
//		CellStyle styleHeader = workbook.createCellStyle();		// 헤더스타일 객체 생성
//		CellStyle styleBody = workbook.createCellStyle();		// 본문스타일 객체 생성
//		CellStyle styleBody2 = workbook.createCellStyle();		// 본문스타일 객체 생성
//
//		styleHeader.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleHeader.setFillPattern(CellStyle.SOLID_FOREGROUND);				//셀 색채우기
//		styleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);	//셀 색채우기
//		styleHeader.setBorderLeft(CellStyle.BORDER_THIN);
//		styleHeader.setBorderRight(CellStyle.BORDER_THIN);
//		styleHeader.setBorderTop(CellStyle.BORDER_MEDIUM);
//		styleHeader.setBorderBottom(CellStyle.BORDER_MEDIUM);
//
//		styleBody.setAlignment(CellStyle.ALIGN_CENTER);					//정렬
//		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody.setBorderBottom(CellStyle.BORDER_THIN);
//
//		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
//		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
//		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
//		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
//		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);
//
//		for(int i=1; i <= 6; i++){
//			sheet.setColumnWidth(i, 5000);
//		}
//
//		Cell headCell1 = rowHead.createCell(1);
//		headCell1.setCellValue("구분");
//		headCell1.setCellStyle(styleHeader);
//		Cell headCell2 = rowHead.createCell(2);
//		headCell2.setCellValue("고객사명");
//		headCell2.setCellStyle(styleHeader);
//		Cell headCell3 = rowHead.createCell(3);
//		headCell3.setCellValue("프로젝트명");
//		headCell3.setCellStyle(styleHeader);
//		Cell headCell4 = rowHead.createCell(4);
//		headCell4.setCellValue("백업Size");
//		headCell4.setCellStyle(styleHeader);
//		Cell headCell5 = rowHead.createCell(5);
//		headCell5.setCellValue("과금단위");
//		headCell5.setCellStyle(styleHeader);
//		Cell headCell6 = rowHead.createCell(6);
//		headCell6.setCellValue("상품가입일시");
//		headCell6.setCellStyle(styleHeader);
//
//		for(CustomProductUsageStatusBackVO vo : list){
//			Row rowBody = sheet.createRow(rowIndex++);
//
//			Cell bodyCell1 = rowBody.createCell(1);
//			bodyCell1.setCellValue(vo.getCompanyName());
//			bodyCell1.setCellStyle(styleBody);
//			Cell bodyCell2 = rowBody.createCell(2);
//			bodyCell2.setCellValue(vo.getCustomerName());
//			bodyCell2.setCellStyle(styleBody);
//			Cell bodyCell3 = rowBody.createCell(3);
//			bodyCell3.setCellValue(vo.getProjectAlias());
//			bodyCell3.setCellStyle(styleBody);
//			Cell bodyCell4 = rowBody.createCell(4);
//			bodyCell4.setCellValue(vo.getBackupGb());
//			bodyCell4.setCellStyle(styleBody);
//			Cell bodyCell5 = rowBody.createCell(5);
//			bodyCell5.setCellValue(vo.getHourlyFlag().equals("Y")?"시간":"월");
//			bodyCell5.setCellStyle(styleBody);
//			Cell bodyCell6 = rowBody.createCell(6);
//			bodyCell6.setCellValue(vo.getRegDatetime());
//			bodyCell6.setCellStyle(styleBody);
//		}
//	}

	private void excelIp(Workbook workbook, List<CustomProductUsageStatusIpVO> list) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_공인IP");

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

		for(int i=1; i <= 10; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("구분");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("고객사명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("연결대상");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("과금단위");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("상품 가입일시");
		headCell6.setCellStyle(styleHeader);

		for(CustomProductUsageStatusIpVO vo : list){
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
			bodyCell4.setCellValue(vo.getConnectionTarget());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getHourlyFlag().equals("Y")?"시간":"월");
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getRegDatetime());
			bodyCell6.setCellStyle(styleBody);
		}
	}

	private void excelLb(Workbook workbook, List<CustomProductUsageStatusLbVO> list) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_가상서버");

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
		headCell1.setCellValue("구분");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("고객사명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("서비스 로드분산명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("과금단위");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("상품가입일시");
		headCell6.setCellStyle(styleHeader);

		for(CustomProductUsageStatusLbVO vo : list){
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
			bodyCell4.setCellValue(vo.getLoadbalancerName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getHourlyFlag());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getRegDatetime());
			bodyCell6.setCellStyle(styleBody);
		}
	}

	private void excelPv(Workbook workbook, List<CustomProductUsageStatusPvVO> list) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_PV");

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
		headCell1.setCellValue("클라우드");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("프로젝트ID");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("NAS명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("NAS크기(GB)");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("자원승인일시");
		headCell6.setCellStyle(styleHeader);

		for(CustomProductUsageStatusPvVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCloudName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getProjectName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProjectAlias());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getNasName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getNasGb());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getRegDatetime());
			bodyCell6.setCellStyle(styleBody);
		}
	}

	private void excelFs(Workbook workbook, List<CustomProductUsageStatusFsVO> list) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_Fs");

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
		headCell1.setCellValue("클라우드");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("프로젝트ID");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("NAS명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("NAS크기(GB)");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("자원승인일시");
		headCell6.setCellStyle(styleHeader);

		for(CustomProductUsageStatusFsVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCloudName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getProjectName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProjectAlias());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getNasName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getNasGb());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getRegDatetime());
			bodyCell6.setCellStyle(styleBody);
		}
	}

	private void excelDisk(Workbook workbook, List<CustomProductUsageStatusDiskVO> list) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_블록디스크");

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
		headCell1.setCellValue("회원사명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("클라우드");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트ID");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("프로젝트명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("디스크명");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("크기(GB)");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("가상서버");
		headCell7.setCellStyle(styleHeader);
		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("호스트명");
		headCell8.setCellStyle(styleHeader);
		Cell headCell9 = rowHead.createCell(9);
		headCell9.setCellValue("자원승인일시");
		headCell9.setCellStyle(styleHeader);

		for(CustomProductUsageStatusDiskVO vo : list){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCustomerName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCloudName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProjectName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getProjectAlias());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getDiskAlias());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getSizeGb());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getHostnameAlias());
			bodyCell7.setCellStyle(styleBody);
			Cell bodyCell8 = rowBody.createCell(8);
			bodyCell8.setCellValue(vo.getHostname());
			bodyCell8.setCellStyle(styleBody);
			Cell bodyCell9 = rowBody.createCell(9);
			bodyCell9.setCellValue(vo.getRegDatetime().replace("<br> ", ""));
			bodyCell9.setCellStyle(styleBody);
		}
	}

	private void excelVm(Workbook workbook, List<CustomProductUsageStatusVmVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_가상서버");

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

		for(int i=1; i <= 11; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("클라우드");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("프로젝트명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("서버명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("호스트명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("OS");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("IP");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("vCPU(Core)");
		headCell7.setCellStyle(styleHeader);
		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("MEMORY(GB)");
		headCell8.setCellStyle(styleHeader);
		Cell headCell9 = rowHead.createCell(9);
		headCell9.setCellValue("DISK(GB)");
		headCell9.setCellStyle(styleHeader);
		Cell headCell10 = rowHead.createCell(10);
		headCell10.setCellValue("자원승인일시");
		headCell10.setCellStyle(styleHeader);

		for(CustomProductUsageStatusVmVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCloudName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getProjectAlias());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getHostnameAlias());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getHostname());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			if(vo.getHostname().substring(vo.getHostname().length()-2,vo.getHostname().length()-1).equals("L")) {
				bodyCell5.setCellValue("Linux");
			} else if(vo.getHostname().substring(vo.getHostname().length()-2,vo.getHostname().length()-1).equals("W")) {
				bodyCell5.setCellValue("Windows");
			} else {
				bodyCell5.setCellValue("");
			}
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getFixedIps());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getVcpus());
			bodyCell7.setCellStyle(styleBody);
			Cell bodyCell8 = rowBody.createCell(8);
			bodyCell8.setCellValue(vo.getMemGb());
			bodyCell8.setCellStyle(styleBody);
			Cell bodyCell9 = rowBody.createCell(9);
			bodyCell9.setCellValue(vo.getDiskGb());
			bodyCell9.setCellStyle(styleBody);
			Cell bodyCell10 = rowBody.createCell(10);
			bodyCell10.setCellValue(vo.getRegDatetime().replace("<br> ", ""));
			bodyCell10.setCellStyle(styleBody);
		}
	}

	private void excelApp(Workbook workbook, List<CustomProductUsageStatusAppVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "컨테이너");

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

		for(int i=1; i <= 11; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("클라우드");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("프로젝트ID");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("어플리케이션ID");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("어플리케이션 이름");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("이미지 템플릿");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("Deployment");
		headCell7.setCellStyle(styleHeader);
		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("POD(EA)");
		headCell8.setCellStyle(styleHeader);
		Cell headCell9 = rowHead.createCell(9);
		headCell9.setCellValue("Service");
		headCell9.setCellStyle(styleHeader);
		Cell headCell10 = rowHead.createCell(10);
		headCell10.setCellValue("Route");
		headCell10.setCellStyle(styleHeader);
		Cell headCell11 = rowHead.createCell(11);
		headCell11.setCellValue("Build");
		headCell11.setCellStyle(styleHeader);
		Cell headCell12 = rowHead.createCell(12);
		headCell12.setCellValue("PV(GB)");
		headCell12.setCellStyle(styleHeader);
		Cell headCell13 = rowHead.createCell(13);
		headCell13.setCellValue("승인일시");
		headCell13.setCellStyle(styleHeader);

		for(CustomProductUsageStatusAppVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCloudName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getProjectName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProjectAlias());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getAppName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getAppAlias());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getTemplateName());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getDeploymentConfigCnt());
			bodyCell7.setCellStyle(styleBody);
			Cell bodyCell8 = rowBody.createCell(8);
			bodyCell8.setCellValue(vo.getPod());
			bodyCell8.setCellStyle(styleBody);
			Cell bodyCell9 = rowBody.createCell(9);
			bodyCell9.setCellValue(vo.getServiceCnt());
			bodyCell9.setCellStyle(styleBody);
			Cell bodyCell10 = rowBody.createCell(10);
			bodyCell10.setCellValue(vo.getRoutesCnt());
			bodyCell10.setCellStyle(styleBody);
			Cell bodyCell11 = rowBody.createCell(11);
			bodyCell11.setCellValue(vo.getBuildsCnt());
			bodyCell11.setCellStyle(styleBody);
			Cell bodyCell12 = rowBody.createCell(12);
			bodyCell12.setCellValue(vo.getVolume());
			bodyCell12.setCellStyle(styleBody);
			Cell bodyCell13 = rowBody.createCell(13);
			bodyCell13.setCellValue(vo.getRegDatetime().replace("<br> ", ""));
			bodyCell13.setCellStyle(styleBody);
		}
	}

	public void excelTotal(Workbook workbook, List<CustomProductUsageStatusTotalVO> excelList, CustomProductUsageStatusTotalVO excelList_total){
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "상품사용현황_전체");

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
		styleBody.setAlignment(CellStyle.VERTICAL_CENTER);					//정렬
		styleBody.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody.setBorderRight(CellStyle.BORDER_THIN);
		styleBody.setBorderTop(CellStyle.BORDER_THIN);
		styleBody.setBorderBottom(CellStyle.BORDER_THIN);

		styleBody2.setAlignment(CellStyle.ALIGN_RIGHT);					//정렬
		styleBody2.setAlignment(CellStyle.VERTICAL_CENTER);					//정렬
		styleBody2.setBorderLeft(CellStyle.BORDER_THIN);
		styleBody2.setBorderRight(CellStyle.BORDER_THIN);
		styleBody2.setBorderTop(CellStyle.BORDER_THIN);
		styleBody2.setBorderBottom(CellStyle.BORDER_THIN);

		for(int i=1; i <= 15; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("회원사명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("프로젝트명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("가상서버(EA)");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("CPU(Core)");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("MEM(GB)");
		headCell5.setCellStyle(styleHeader);

		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("OS DISK(GB)");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("블록디스크(GB)");
		headCell7.setCellStyle(styleHeader);

		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("PV DISK(GB)");
		headCell8.setCellStyle(styleHeader);
		Cell headCell9 = rowHead.createCell(9);
		headCell9.setCellValue("NAS 디스크(GB)");
		headCell9.setCellStyle(styleHeader);

		Cell headCell10 = rowHead.createCell(10);
		headCell10.setCellValue("보안관제(EA)");
		headCell10.setCellStyle(styleHeader);
		Cell headCell11 = rowHead.createCell(11);
		headCell11.setCellValue("계정관리(EA)");
		headCell11.setCellStyle(styleHeader);
		Cell headCell12 = rowHead.createCell(12);
		headCell12.setCellValue("백업(EA)");
		headCell12.setCellStyle(styleHeader);
		Cell headCell13 = rowHead.createCell(13);
		headCell13.setCellValue("SW설치(EA)");
		headCell13.setCellStyle(styleHeader);
		Cell headCell14 = rowHead.createCell(14);
		headCell14.setCellValue("디스크관리(EA)");
		headCell14.setCellStyle(styleHeader);

		Cell headCell15 = rowHead.createCell(15);
		headCell15.setCellValue("어플리케이션(EA)");
		headCell15.setCellStyle(styleHeader);
		Cell headCell16 = rowHead.createCell(16);
		headCell16.setCellValue("POD(EA)");
		headCell16.setCellStyle(styleHeader);
		Cell headCell17 = rowHead.createCell(17);
		headCell17.setCellValue("오토스케일링(EA)");
		headCell17.setCellStyle(styleHeader);
		Cell headCell18 = rowHead.createCell(18);
		headCell18.setCellValue("컨테이너터미널(EA)");
		headCell18.setCellStyle(styleHeader);

		for(CustomProductUsageStatusTotalVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCustomerName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getProjectAlias());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getVmCnt());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getVcpusTotal());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getMemTotal());
			bodyCell5.setCellStyle(styleBody);

			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getOsDiskTotal());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getDataDiskTotal());
			bodyCell7.setCellStyle(styleBody);

			Cell bodyCell8 = rowBody.createCell(8);
			bodyCell8.setCellValue(vo.getPvDiskTotal());
			bodyCell8.setCellStyle(styleBody);
			Cell bodyCell9 = rowBody.createCell(9);
			bodyCell9.setCellValue(vo.getNasDiskTotal());
			bodyCell9.setCellStyle(styleBody);

			Cell bodyCell10 = rowBody.createCell(10);
			bodyCell10.setCellValue(vo.getSecCnt());
			bodyCell10.setCellStyle(styleBody);
			Cell bodyCell11 = rowBody.createCell(11);
			bodyCell11.setCellValue(vo.getActCnt());
			bodyCell11.setCellStyle(styleBody);
			Cell bodyCell12 = rowBody.createCell(12);
			bodyCell12.setCellValue(vo.getBackCnt());
			bodyCell12.setCellStyle(styleBody);
			Cell bodyCell13 = rowBody.createCell(13);
			bodyCell13.setCellValue(vo.getSwCnt());
			bodyCell13.setCellStyle(styleBody);
			Cell bodyCell14 = rowBody.createCell(14);
			bodyCell14.setCellValue(vo.getDiskMngCnt());
			bodyCell14.setCellStyle(styleBody);

			Cell bodyCell15 = rowBody.createCell(15);
			bodyCell15.setCellValue(vo.getAppCnt());
			bodyCell15.setCellStyle(styleBody);
			Cell bodyCell16 = rowBody.createCell(16);
			bodyCell16.setCellValue(vo.getPodCnt());
			bodyCell16.setCellStyle(styleBody);
			Cell bodyCell17 = rowBody.createCell(17);
			bodyCell17.setCellValue(vo.getAutoscalingGourpCnt());
			bodyCell17.setCellStyle(styleBody);
			Cell bodyCell18 = rowBody.createCell(18);
			bodyCell18.setCellValue(vo.getContainerTerminalCnt());
			bodyCell18.setCellStyle(styleBody);

		}

		sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 1, 2));

		Row rowBody = sheet.createRow(rowIndex++);

		Cell bodyCell1 = rowBody.createCell(1);
		bodyCell1.setCellValue("합계");
		bodyCell1.setCellStyle(styleBody);
		Cell bodyCell2 = rowBody.createCell(2);
		bodyCell2.setCellStyle(styleBody);
		Cell bodyCell3 = rowBody.createCell(3);
		bodyCell3.setCellValue(excelList_total.getVmCnt());
		bodyCell3.setCellStyle(styleBody);
		Cell bodyCell4 = rowBody.createCell(4);
		bodyCell4.setCellValue(excelList_total.getVcpusTotal());
		bodyCell4.setCellStyle(styleBody);
		Cell bodyCell5 = rowBody.createCell(5);
		bodyCell5.setCellValue(excelList_total.getMemTotal());
		bodyCell5.setCellStyle(styleBody);
		Cell bodyCell6 = rowBody.createCell(6);
		bodyCell6.setCellValue(excelList_total.getOsDiskTotal());
		bodyCell6.setCellStyle(styleBody);
		Cell bodyCell7 = rowBody.createCell(7);
		bodyCell7.setCellValue(excelList_total.getDataDiskTotal());
		bodyCell7.setCellStyle(styleBody);

		Cell bodyCell8 = rowBody.createCell(8);
		bodyCell8.setCellValue(excelList_total.getPvDiskTotal());
		bodyCell8.setCellStyle(styleBody);
		Cell bodyCell9 = rowBody.createCell(9);
		bodyCell9.setCellValue(excelList_total.getNasDiskTotal());
		bodyCell9.setCellStyle(styleBody);

		Cell bodyCell10 = rowBody.createCell(10);
		bodyCell10.setCellValue(excelList_total.getSecCnt());
		bodyCell10.setCellStyle(styleBody);
		Cell bodyCell11 = rowBody.createCell(11);
		bodyCell11.setCellValue(excelList_total.getActCnt());
		bodyCell11.setCellStyle(styleBody);
		Cell bodyCell12 = rowBody.createCell(12);
		bodyCell12.setCellValue(excelList_total.getBackCnt());
		bodyCell12.setCellStyle(styleBody);
		Cell bodyCell13 = rowBody.createCell(13);
		bodyCell13.setCellValue(excelList_total.getSwCnt());
		bodyCell13.setCellStyle(styleBody);
		Cell bodyCell14 = rowBody.createCell(14);
		bodyCell14.setCellValue(excelList_total.getDiskMngCnt());
		bodyCell14.setCellStyle(styleBody);



		Cell bodyCell15 = rowBody.createCell(15);
		bodyCell15.setCellValue(excelList_total.getAppCnt());
		bodyCell15.setCellStyle(styleBody);
		Cell bodyCell16 = rowBody.createCell(16);
		bodyCell16.setCellValue(excelList_total.getPodCnt());
		bodyCell16.setCellStyle(styleBody);
		Cell bodyCell17 = rowBody.createCell(17);
		bodyCell17.setCellValue(excelList_total.getAutoscalingGroupTotal());
		bodyCell17.setCellStyle(styleBody);
		Cell bodyCell18 = rowBody.createCell(18);
		bodyCell18.setCellValue(excelList_total.getContainerTerminalTotal());
		bodyCell18.setCellStyle(styleBody);


	}

}
