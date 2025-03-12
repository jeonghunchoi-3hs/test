package com.ivucenter.cloud.portal.cmm.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ivucenter.cloud.portal.bbs.download.BbsDownloadDAO;
import com.ivucenter.cloud.portal.bbs.download.CustomBbsDownloadVO;
import com.ivucenter.cloud.portal.util.CodeUtil;
import com.ivucenter.cloud.portal.util.RepositoryUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CmmFileService{

	@Autowired
	private CmmFileDAO dao;

	@Autowired
	private BbsDownloadDAO bbsDownloadDAO;

	public List<CustomCmmFileVO> list(CustomCmmFileVO req) {
		return dao.list(req);
	}

	public void copy(CustomCmmFileVO req, String catalogSeq){
		// 기존 file 정보 조회
		req = dao.findById(req);

		if(req != null){
			String sFileName = req.getFileName();
			String newFilename = DateFormatUtils.format(new Date(), "yyyyMMdd-")+UUID.randomUUID();
			String repositorySubdirectory = RepositoryUtils.getRepositorySubDirectory(newFilename);
			String path = CodeUtil.FILE_PATH;
	        String savedDir = path + repositorySubdirectory;

	        // 저장할 디렉토리 생성
	        File srcDirFile = new File(savedDir);
	        if (!srcDirFile.exists()) {
	            srcDirFile.mkdirs();
	        }

			try(
				FileInputStream in = new FileInputStream(new File(req.getFilePath() + req.getFileId()));
				FileOutputStream ou = new FileOutputStream(new File(savedDir+File.separator+newFilename));
				FileChannel fcin = in.getChannel();
				FileChannel fcou = ou.getChannel()
			){

				long size = fcin.size();
				fcin.transferTo(0, size, fcou);

				req.setProgramName(catalogSeq);
		        req.setFileId(newFilename);
		        req.setFileName(sFileName);
		        req.setFilePath(savedDir);
		        req.setFileSize(size);
		        dao.insert(req);

			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}
	}

	public String insert(CustomCmmFileVO req) {
		int iRet = 0;
		String path = CodeUtil.FILE_PATH;

		List<String> allowedExtensions = Arrays.asList(
			    "txt", "jpg", // 기존에 있던 확장자
			    "zip",
			    "doc", "docx", // Microsoft Word 문서
			    "ppt", "pptx", // Microsoft PowerPoint 프레젠테이션
			    "xls", "xlsx", // Microsoft Excel 스프레드시트
			    "pdf", // Portable Document Format 파일
			    "odt", // OpenDocument 텍스트 문서
			    "ods", // OpenDocument 스프레드시트
			    "odp", // OpenDocument 프레젠테이션
			    "png", // 이미지 파일
			    "gif", // 이미지 파일
			    "jpeg", // JPEG 이미지 파일
			    "bmp", // Bitmap 이미지 파일
			    "svg", // Scalable Vector Graphics 파일
			    "tiff", // Tagged Image File Format
			    "hwp", "hwpx", "hwt" // 한글 문서 파일 확장자 추가
		);

		if(req.getFiles() != null){
			for(MultipartFile multipartFile: req.getFiles()){
				if(multipartFile.getSize() > 0){

					String originalFileName = multipartFile.getOriginalFilename();
					if (originalFileName == null) {
						log.error("허용되지 않는 파일명");
						continue;
					}
					String fileName = FilenameUtils.getBaseName(originalFileName.replaceAll("^[a-zA-Z0-9_.-]+$", "_"));
					String extension = FilenameUtils.getExtension(originalFileName).toLowerCase();

		            if(!allowedExtensions.contains(extension)){
	                    log.error("허용되지 않는 파일 확장자: " + extension);
	                    continue; // 허용되지 않는 확장자의 파일은 건너뛰기
	                }


					String sFileName = fileName+DateFormatUtils.format(new Date(), "_yyyyMMdd")+"."+extension;
					String newFilename = DateFormatUtils.format(new Date(), "yyyyMMdd-")+UUID.randomUUID();
					String repositorySubdirectory = RepositoryUtils.getRepositorySubDirectory(newFilename);
			        String savedDir = path + repositorySubdirectory;


			        // 저장할 디렉토리 생성
			        File srcDirFile = new File(savedDir);
			        if (!srcDirFile.exists()) {
			            srcDirFile.mkdirs();
			        }
			        File f = new File(savedDir+File.separator+newFilename);
			        try {
						multipartFile.transferTo(f);
					} catch (IllegalStateException e) {
						log.error(e.getMessage());
					} catch (IOException e) {
						log.error(e.getMessage());
					}

			        req.setFileId(newFilename);
			        req.setFileName(sFileName);
			        req.setFilePath(savedDir);
			        req.setFileSize(multipartFile.getSize());
			        dao.insert(req);
			        iRet++;
				}
			}
		}
		return iRet+"";
	}

	public String delete(CustomCmmFileVO req) {
		CustomCmmFileVO res = dao.detail(req.getFileId());
		if(res != null){
		String path = res.getFilePath() + res.getFileId();

		File f = new File(path);
		if(f.isFile())
		f.delete();

		int iRet = dao.delete(req);

		if(req.getProgramName().equals("bbs_download")){
			CustomBbsDownloadVO vo = new CustomBbsDownloadVO();
			vo.setFilesCnt(dao.list(req).size());
			vo.setDownloadNo(Integer.parseInt(req.getProgramSeq()));
			bbsDownloadDAO.updateFilesCnt(vo);
		}
		return iRet+"";
		}else {
			return "0";
		}
	}

	public CustomCmmFileVO fileDownload(String fileId) {
		CustomCmmFileVO res = dao.detail(fileId);
		if(res != null){
			File file = new File(res.getFilePath() + res.getFileId());
			if (file.exists()) {
				res.setFile(file);
			}
		}
		return res;
	}

}
