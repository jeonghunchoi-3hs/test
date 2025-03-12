package com.ivucenter.cloud.portal.cmm.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mng/cmm/file")
public class MngCmmFileController{

	@Autowired
	private CmmFileService service;

	@RequestMapping(value = "/list")
	public ResponseEntity<List<CustomCmmFileVO>> mngCmmFileList(CustomCmmFileVO req) {
		List<CustomCmmFileVO> res = service.list(req);

		return new ResponseEntity<List<CustomCmmFileVO>>(res, HttpStatus.OK);
	}


	@RequestMapping(value = "/insert")
	public ResponseEntity<String> mngCmmFileInsert(CustomCmmFileVO req) {
		String res = service.insert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/delete")
	public ResponseEntity<String> mngCmmFileDelete(CustomCmmFileVO req) {
			String res = service.delete(req);


		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

//	@RequestMapping(value = "/download/{fileId}", method = RequestMethod.GET)
//	public ResponseEntity<InputStreamResource> downloadFile(@PathVariable("fileId") String fileId) throws ServletException, FileNotFoundException, UnsupportedEncodingException {
//		CustomCmmFileVO res = service.fileDownload(fileId);
//
//		if(res.getFile() == null){
//			return new ResponseEntity<InputStreamResource>(HttpStatus.NO_CONTENT);
//		}
//		HttpHeaders respHeaders = new HttpHeaders();
//		String mimeType = URLConnection.guessContentTypeFromName(res.getFileName());
//		if (mimeType == null) {
//			mimeType = "application/octet-stream";
//		}
//		if (res.getFileName().endsWith(".pdf")) {
//			mimeType = "application/pdf";
//		}
//
//		respHeaders.setContentType(MediaType.valueOf(mimeType));
//		respHeaders.setContentDispositionFormData("attachment", URLEncoder.encode(res.getFileName(), "utf-8").replace("+", "%20"));
//		respHeaders.setContentLength((int) res.getFile().length());
//		InputStreamResource inputStreamResource = new InputStreamResource(new FileInputStream(res.getFile()));
//		return new ResponseEntity<InputStreamResource>(inputStreamResource, respHeaders, HttpStatus.OK);
//	}

	private static final String BASE_PATH = "/appfile/";

	@RequestMapping(value = "/download/{fileId}", method = RequestMethod.GET)
	public void downloadFile(@PathVariable("fileId") String fileId, HttpServletResponse response) throws ServletException, IOException {

		if (!isValidFileId(fileId)) {
			response.sendError(HttpStatus.BAD_REQUEST.value(), "invaild file id");
			return;
		}

		CustomCmmFileVO res = service.fileDownload(fileId);

		if (res.getFile() == null){
			response.sendError(HttpStatus.NO_CONTENT.value(), "file not found");
			return;
		}

		File file = res.getFile();

		if (!isValidFile(file)) {
			response.sendError(HttpStatus.BAD_REQUEST.value(), "invalid file");
			return;
		}

		String replaceFileName = res.getFileName();
		if (replaceFileName != null) {
			replaceFileName = replaceFileName.replaceAll("[/\\\\]", "").replaceAll("\\.{2,}", "").replaceAll("&", "");
		}

		String mimeType = URLConnection.guessContentTypeFromName(res.getFileName());
		if (mimeType == null) {
			mimeType = "application/octet-stream";
		}

		if (res.getFileName().endsWith(".pdf")) {
			mimeType = "application/pdf";
		}

		response.setContentType(mimeType);
		response.setHeader("Content-Disposition", "attachment;filename=\"" + URLEncoder.encode(replaceFileName, "UTF-8").replace("+", "%20"));
		response.setContentLength((int) file.length());

		try (InputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
			byte[] buffer = new byte[4096];
			int read;
			while ((read = in.read(buffer)) != -1) {
				out.write(buffer, 0, read);
			}
		}
	}

	private boolean isValidFileId(String fileId) {
		return fileId != null && fileId.matches("^[a-zA-Z0-9_.-]+$");
	}

	private boolean isValidFile(File file) {
		try {
			String canoicalPath = file.getCanonicalPath();
			String basePath = new File(BASE_PATH).getCanonicalPath();
			return canoicalPath.startsWith(basePath);
		} catch(IOException e) {
			return false;
		}
	}

	@RequestMapping(value = "/update")
	public ResponseEntity<String> cmmUpdateFile(CustomCmmFileVO req) {
		log.debug("++++++++++"+req.getFileId());
		String res = service.delete(req);
		   res = service.insert(req);

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}

	@RequestMapping(value = "/deleteInsert")
	public ResponseEntity<String> mngCmmFileDeleteInsert(CustomCmmFileVO req) {
		String res="";
		List<CustomCmmFileVO> resultList = service.list(req);

		if(resultList.size()==0){
			res = service.insert(req);
		}else{
			for(int i=0; i < resultList.size(); i++){
				req.setFileId(resultList.get(i).getFileId());
				res = service.delete(req);
			}
			res = service.insert(req);
		}

		return new ResponseEntity<String>(res, HttpStatus.OK);
	}
}
