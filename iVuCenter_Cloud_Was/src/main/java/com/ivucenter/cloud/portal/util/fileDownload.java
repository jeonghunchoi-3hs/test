package com.ivucenter.cloud.portal.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;

public class fileDownload extends AbstractView{

	private static final Logger logger = LoggerFactory.getLogger(fileDownload.class);

	public void Download(){
        setContentType("application/download; utf-8");
    }

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest req,
			HttpServletResponse res) throws Exception {

		// 다운로드할 파일 경로
		File file = (File)model.get("DownloadFile");

		if(file != null) {
			String fileName = null;
			String userAgent = req.getHeader("User-Agent");

			// 익스플로러
			if(userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1){
                fileName = URLEncoder.encode(file.getName(), "utf-8").replaceAll("\\+", "%20");;
            // 크롬
            }else if(userAgent.indexOf("Chrome") > -1) {
            	StringBuffer sb = new StringBuffer();
            	for(int i=0; i<file.getName().length(); i++) {
            		char c = file.getName().charAt(i);
            		if(c > '~') {
            			sb.append(URLEncoder.encode(""+c, "UTF-8"));
            		}else {
            			sb.append(c);
            		}
            	}
            	fileName = sb.toString();
            // 기타 브라우저
            }else {
            	fileName = new String(file.getName().getBytes("utf-8"));
            }

			res.setContentType(getContentType());
			res.setContentLength((int)file.length());
	        res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";"); //다운로드할 파일명 설정
	        res.setHeader("Content-Transfer-Encoding", "binary");

	        OutputStream out = res.getOutputStream();
	        FileInputStream fis = null;
	        try {
                fis = new FileInputStream(file);
                FileCopyUtils.copy(fis, out);
            } catch(Exception e){
                logger.error("renderMergedOutputModel Exception");
            }finally{
                if(fis != null){
                    try{
                        fis.close();
                    }catch(Exception e){
                    	logger.error("fis.close() Exception");
                    }
                }

                if(out != null) {
                	out.flush(); //버퍼에 남은 데이터 출력
                }
            }
		}
	}

}
