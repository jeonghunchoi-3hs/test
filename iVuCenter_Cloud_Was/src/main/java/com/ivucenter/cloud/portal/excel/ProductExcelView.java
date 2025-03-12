package com.ivucenter.cloud.portal.excel;

import java.net.URLEncoder;
import java.text.DecimalFormat;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.ivucenter.cloud.portal.bill.policy.CustomBillPolicyVO;
import com.ivucenter.cloud.portal.bss.catalog.CustomBssCatalogVO;
import com.ivucenter.cloud.portal.bss.product.CustomBssProductVO;
import com.ivucenter.cloud.portal.charge.bill.CustomChargeBillVO;
import com.ivucenter.cloud.portal.mng.req.work.CustomMngReqWorkVO;
import com.ivucenter.cloud.portal.oss.application.CustomOssAppVO;
import com.ivucenter.cloud.portal.oss.application.OssAppService;
import com.ivucenter.cloud.portal.oss.disk.CustomOssDiskVO;
import com.ivucenter.cloud.portal.oss.persistentvolume.CustomOssPvVO;
import com.ivucenter.cloud.portal.oss.service.CustomOssServiceVO;
import com.ivucenter.cloud.portal.oss.vm.CustomOssVmVO;
import com.ivucenter.cloud.portal.req.product.CustomReqProductVO;

public class ProductExcelView extends AbstractXlsView{

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

		if(excelGbn.equals("vm")){
			excelVm(workbook, (List<CustomOssVmVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("disk")){
			excelDisk(workbook, (List<CustomOssDiskVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("productApprv")){
			excelProductApprv(workbook, (List<CustomReqProductVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("work")){
			excelWork(workbook, (List<CustomMngReqWorkVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("catalog")){
			excelCatalog(workbook, (List<CustomBssCatalogVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("product")){
			excelProduct(workbook, (List<CustomBssProductVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("billPolicy")){
			excelBillPolicy(workbook, (List<CustomBillPolicyVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("calculateExcel")){
			calculateExcel(workbook, (List<CustomChargeBillVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("serviceView")){
			serviceViewExcel(workbook, (List<CustomOssServiceVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("projectVm")) {
			excelProjectVm(workbook, (List<CustomOssVmVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("billDetailPolicy")) {
			excelBillDetailPolicy(workbook, (List<CustomBillPolicyVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("application")) {
			excelApplication(workbook, (List<CustomOssAppVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("pv")) {
			excelPv(workbook, (List<CustomOssPvVO>) modelMap.get("excel_list"));
		}else if(excelGbn.equals("envView")){
			envViewExcel(workbook, (List<CustomReqProductVO>) modelMap.get("excel_list"));
		}

		res.setContentType("Application/Msexcel");
	}


	private void serviceViewExcel(Workbook workbook, List<CustomOssServiceVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "삼품관리_카탈로그 관리");

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
		headCell1.setCellValue("서비스 ID");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("클라우드");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("서비스 유형");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("서비스명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("가상서버");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("생성일시");
		headCell6.setCellStyle(styleHeader);

		for(CustomOssServiceVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getServiceId());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCloudName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getServiceTypeName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getServiceName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getHostnameAlias());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getCreateDatetime2());
			bodyCell6.setCellStyle(styleBody);
  		}
	}

	private void envViewExcel(Workbook workbook, List<CustomReqProductVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "개발환경 관리");

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
		headCell1.setCellValue("cicd그룹명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("cicd개발환경명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("개발환경 Url");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("관리자");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("생성일시");
		headCell5.setCellStyle(styleHeader);

		for(CustomReqProductVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);
			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCicdGroupName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCicdProjectName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getUrl());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getDevUserName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getRegDatetime2());
			bodyCell5.setCellStyle(styleBody);
  		}
	}

	private void excelBillPolicy(Workbook workbook, List<CustomBillPolicyVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "삼품관리_카탈로그 관리");

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
		headCell1.setCellValue("정책명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("적용일자");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("수정자");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("수정일시");
		headCell4.setCellStyle(styleHeader);


		for(CustomBillPolicyVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getPolicyName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			if(vo.getApplyDate().equals("9999-12-31")) {
				bodyCell2.setCellValue("");
			} else {
				bodyCell2.setCellValue(vo.getApplyDate());
			}
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getModUserName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getModDatetime2());
			bodyCell4.setCellStyle(styleBody);
  		}
	}

	private void excelBillDetailPolicy(Workbook workbook, List<CustomBillPolicyVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "삼품관리_카탈로그 관리");

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
		headCell1.setCellValue("과금항목명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("수량");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("월 금액");
		headCell3.setCellStyle(styleHeader);

		for(CustomBillPolicyVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getItemName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getQuantity() + " " + vo.getUnit());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getMonthlyPrice());
			bodyCell3.setCellStyle(styleBody);
  		}
	}

	private void excelProduct(Workbook workbook, List<CustomBssProductVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "삼품관리_카탈로그 관리");

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
		headCell1.setCellValue("상품카테고리");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("상품명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("사용여부");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("등록자");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("등록일시");
		headCell5.setCellStyle(styleHeader);

		for(CustomBssProductVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getProductCategoryName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getProductName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getDelFlag().equals("N")?"사용":"미사용");
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getUserName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getRegDatetime2());
			bodyCell5.setCellStyle(styleBody);
  		}
	}

	private void excelCatalog(Workbook workbook, List<CustomBssCatalogVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "삼품관리_카탈로그 관리");

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
		headCell1.setCellValue("카탈로그명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("적용일자");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("등록자");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("등록일시");
		headCell4.setCellStyle(styleHeader);

		for(CustomBssCatalogVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCatalogName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getApplyDate());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getUserName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getModDatetime());
			bodyCell4.setCellStyle(styleBody);

  		}
	}

	private void calculateExcel(Workbook workbook, List<CustomChargeBillVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "작업승인처리_정산승인");

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
		headCell1.setCellValue("정산년월");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("승인상태");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("정산자");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("정산일시");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("확정자");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("확정일시");
		headCell6.setCellStyle(styleHeader);


		for(CustomChargeBillVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getBillYyyymm());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getConfirnFlag());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProcUserName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getProcDatetime());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getComfirmUserName());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getConfirmDatetime());
			bodyCell6.setCellStyle(styleBody);
  		}
	}

	private void excelWork(Workbook workbook, List<CustomMngReqWorkVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "작업승인처리_작업신청관리");

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

		for(int i=1; i <= 7; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("작업유형");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("서비스유형");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("프로젝트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("서비스명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("작업상태");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("작업자");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("등록일시");
		headCell7.setCellStyle(styleHeader);
		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("완료일시");
		headCell8.setCellStyle(styleHeader);

		for(CustomMngReqWorkVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getRequestTypeName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			if(vo.getProductCategoryName().equals("01")) {
				bodyCell2.setCellValue("계정관리");
			}else if(vo.getProductCategoryName().equals("01")) {
				bodyCell2.setCellValue("보안관제");
			}else if(vo.getProductCategoryName().equals("03")) {
				bodyCell2.setCellValue("백업관리");
			}else if(vo.getProductCategoryName().equals("04")) {
				bodyCell2.setCellValue("SW설치");
			}else if(vo.getProductCategoryName().equals("05")) {
				bodyCell2.setCellValue("디스크관리");
			}
			bodyCell2.setCellValue(vo.getProductCategoryName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getProjectName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getServiceName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getWorkState());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getWorkUserName());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getRegDatetime2());
			bodyCell7.setCellStyle(styleBody);
			Cell bodyCell8 = rowBody.createCell(8);
			bodyCell8.setCellValue(vo.getCompleteDatetime2());
			bodyCell8.setCellStyle(styleBody);
  		}
	}

	private void excelProductApprv(Workbook workbook, List<CustomReqProductVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "작업승인처리_상품 신청 관리");

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

		for(int i=1; i <= 12; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("주문번호");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("클라우드");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("회원사");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("프로젝트명");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("처(실)");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("담당조직(부서)");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("승인단계");
		headCell7.setCellStyle(styleHeader);
		Cell headCell8 = rowHead.createCell(8);
		headCell8.setCellValue("신규(EA)");
		headCell8.setCellStyle(styleHeader);
		Cell headCell9 = rowHead.createCell(9);
		headCell9.setCellValue("변경(EA)");
		headCell9.setCellStyle(styleHeader);
		Cell headCell10 = rowHead.createCell(10);
		headCell10.setCellValue("삭제(EA)");
		headCell10.setCellStyle(styleHeader);
		Cell headCell11 = rowHead.createCell(11);
		headCell11.setCellValue("신청자");
		headCell11.setCellStyle(styleHeader);
		Cell headCell12 = rowHead.createCell(12);
		headCell12.setCellValue("승인부서승인일시");
		headCell12.setCellStyle(styleHeader);

		for(CustomReqProductVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getOrderNo());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCloudName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getCustomerName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getProjectName());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getDeptName2().split("/")[2]);
			bodyCell5.setCellStyle(styleBody);

			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getDeptName());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			if(vo.getApprvState().equals("APPRV_PROCESSING")) {
				bodyCell7.setCellValue("처리중");
			} else if(vo.getApprvState().equals("APPRV_COMPLETED")) {
				if(vo.getProvisioningStatus() == "PROVISIONING_FAIL") {
					bodyCell7.setCellValue("작업실패");
				} else {
					bodyCell7.setCellValue("완료");
				}
			} else if(vo.getApprvState().equals("APPRV_REJECTED")) {
				bodyCell7.setCellValue("반려");
			}
			bodyCell7.setCellValue(vo.getApprvState());
			bodyCell7.setCellStyle(styleBody);
			Cell bodyCell8 = rowBody.createCell(8);
			bodyCell8.setCellValue(vo.getNewCnt());
			bodyCell8.setCellStyle(styleBody);
			Cell bodyCell9 = rowBody.createCell(9);
			bodyCell9.setCellValue(vo.getChangeCnt());
			bodyCell9.setCellStyle(styleBody);
			Cell bodyCell10 = rowBody.createCell(10);
			bodyCell10.setCellValue(vo.getExprCnt());
			bodyCell10.setCellStyle(styleBody);
			Cell bodyCell11 = rowBody.createCell(11);
			bodyCell11.setCellValue(vo.getOrderUserName());
			bodyCell11.setCellStyle(styleBody);
			Cell bodyCell12 = rowBody.createCell(12);
			bodyCell12.setCellValue(vo.getHApprvDatetime());
			bodyCell12.setCellStyle(styleBody);
  		}
	}

	private void excelDisk(Workbook workbook, List<CustomOssDiskVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "블록디스크 관리");

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

		for(int i=1; i <= 7; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("디스크명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("클라우드");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("크기(GB)");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("가상서버");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("호스트명");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("마운트포인트");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("생성일시");
		headCell7.setCellStyle(styleHeader);
		DecimalFormat dc = new DecimalFormat("###,###,###,###");
		for(CustomOssDiskVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getDiskAlias());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCloudName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(dc.format(vo.getSizeGb())+" GB");
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getHostnameAlias());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getHostname());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getAttachments());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getRegDatetime2());
			bodyCell7.setCellStyle(styleBody);
  		}
	}

	private void excelVm(Workbook workbook, List<CustomOssVmVO> excelList) {
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

		for(int i=1; i <= 5; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("가상서버명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("가상서버명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("호스트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("IP 주소");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("BACKUP IP 주소");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("운전상태");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("전원상태");
		headCell7.setCellStyle(styleHeader);

		for(CustomOssVmVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getHostnameAlias());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCloudName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getHostname());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getIpAddr());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getBakupFixedIps());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getStatus());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getPower());
			bodyCell7.setCellStyle(styleBody);
  		}
	}
	private void excelProjectVm(Workbook workbook, List<CustomOssVmVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "가상서버_목록");

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

		for(int i=1; i <= 7; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("서버명");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("클라우드");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("호스트명");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("IP주소");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("BACKUP IP 주소");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("운전상태");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("전원상태");
		headCell7.setCellStyle(styleHeader);

		for(CustomOssVmVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getHostnameAlias());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getCloudName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getHostname());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getIpAddr());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			bodyCell5.setCellValue(vo.getBakupFixedIps());
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getStatus());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getPower());
			bodyCell7.setCellStyle(styleBody);
		}
	}

	private void excelApplication(Workbook workbook, List<CustomOssAppVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "자원 현황_어플리케이션");

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

		for(int i=1; i <= 7; i++){
			sheet.setColumnWidth(i, 5000);
		}

		Cell headCell1 = rowHead.createCell(1);
		headCell1.setCellValue("클라우드");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("어플리케이션명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("이미지 템플릿");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("POD수");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("상태");
		headCell5.setCellStyle(styleHeader);
		Cell headCell6 = rowHead.createCell(6);
		headCell6.setCellValue("ScaleOut");
		headCell6.setCellStyle(styleHeader);
		Cell headCell7 = rowHead.createCell(7);
		headCell7.setCellValue("생성일시");
		headCell7.setCellStyle(styleHeader);

		for(CustomOssAppVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getCloudName());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getAppName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getTemplateName());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getPod());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			if (vo.getDelFlag().equals("N")) {
				bodyCell5.setCellValue("정상(빌드 중)");
			} else {
				bodyCell5.setCellValue("삭제");
			}
			bodyCell5.setCellStyle(styleBody);
			Cell bodyCell6 = rowBody.createCell(6);
			bodyCell6.setCellValue(vo.getScaleOutName());
			bodyCell6.setCellStyle(styleBody);
			Cell bodyCell7 = rowBody.createCell(7);
			bodyCell7.setCellValue(vo.getRegDatetime());
			bodyCell7.setCellStyle(styleBody);


  		}
	}

	private void excelPv(Workbook workbook, List<CustomOssPvVO> excelList) {
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "자원 현황_PV");

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
		headCell1.setCellValue("스토리지ID");
		headCell1.setCellStyle(styleHeader);
		Cell headCell2 = rowHead.createCell(2);
		headCell2.setCellValue("스토리지명");
		headCell2.setCellStyle(styleHeader);
		Cell headCell3 = rowHead.createCell(3);
		headCell3.setCellValue("크기(GB)");
		headCell3.setCellStyle(styleHeader);
		Cell headCell4 = rowHead.createCell(4);
		headCell4.setCellValue("파일 경로");
		headCell4.setCellStyle(styleHeader);
		Cell headCell5 = rowHead.createCell(5);
		headCell5.setCellValue("연결관리");
		headCell5.setCellStyle(styleHeader);

		for(CustomOssPvVO vo : excelList){
			Row rowBody = sheet.createRow(rowIndex++);

			Cell bodyCell1 = rowBody.createCell(1);
			bodyCell1.setCellValue(vo.getNasId());
			bodyCell1.setCellStyle(styleBody);
			Cell bodyCell2 = rowBody.createCell(2);
			bodyCell2.setCellValue(vo.getNasName());
			bodyCell2.setCellStyle(styleBody);
			Cell bodyCell3 = rowBody.createCell(3);
			bodyCell3.setCellValue(vo.getNasGb());
			bodyCell3.setCellStyle(styleBody);
			Cell bodyCell4 = rowBody.createCell(4);
			bodyCell4.setCellValue(vo.getNasFileSystemPath());
			bodyCell4.setCellStyle(styleBody);
			Cell bodyCell5 = rowBody.createCell(5);
			if ("PVC_MOUNT".equals(vo.getConnectStatus())) {
				bodyCell5.setCellValue("연결");
			} else {
				bodyCell5.setCellValue("미연결");
			}
			bodyCell5.setCellStyle(styleBody);

  		}
	}

}
