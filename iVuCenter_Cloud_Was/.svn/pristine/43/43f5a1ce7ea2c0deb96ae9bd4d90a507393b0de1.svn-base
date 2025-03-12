package com.ivucenter.cloud.portal.bbs.download;

import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.portal.cmm.file.CmmFileDAO;
import com.ivucenter.cloud.portal.cmm.file.CustomCmmFileVO;

@Service
public class BbsDownloadService{

    private static final Logger logger = LoggerFactory.getLogger(BbsDownloadService.class);

	@Autowired
	private BbsDownloadDAO dao;

	@Autowired
	CmmFileDAO cmmFileDAO;

	public String list(CustomBbsDownloadVO req) {
    	List<CustomBbsDownloadVO> lists = dao.list(req);
	    int recordsTotal = dao.listTot(req).size();
	    int recordsFiltered = recordsTotal;

	    List<CustomBbsDownloadVO> list = new LinkedList<CustomBbsDownloadVO>();

	    for(CustomBbsDownloadVO vo :lists){
	    	CustomCmmFileVO fileVO = new CustomCmmFileVO();
	    	fileVO.setProgramName("bbs_download");
	    	fileVO.setProgramSeq(vo.getDownloadNo()+"");
	    	List<CustomCmmFileVO> file = cmmFileDAO.list(fileVO);
	    	vo.setFileList(file);
	    	list.add(vo);
	    }

	    try {
	        JsonObject jsonResponse = new JsonObject();
	        Gson gson = new Gson();

	        jsonResponse.addProperty("draw", req.getDraw());
	        jsonResponse.addProperty("recordsTotal", recordsTotal);
	        jsonResponse.addProperty("recordsFiltered", recordsFiltered);
	        jsonResponse.add("data", gson.toJsonTree(lists));

	        return jsonResponse.toString();
	    } catch (JsonIOException e) {

            logger.error("JSON 처리 중 오류 발생");

	    }
		return "";
	}

	public CustomBbsDownloadVO detail(CustomBbsDownloadVO req) {
		return dao.detail(req);
	}

	public String insert(CustomBbsDownloadVO req) {

		if( req.getDownloadNo()> 0 ){
			return dao.update(req)+"";
		}else{
			dao.insert(req);
			return dao.findLastIndex();
		}
	}

	public String delete(CustomBbsDownloadVO req) {
		return dao.delete(req)+"";
	}

	public String updateFilesCnt(CustomCmmFileVO req) {

		CustomBbsDownloadVO vo = new CustomBbsDownloadVO();
		vo.setFilesCnt(cmmFileDAO.list(req).size());
		vo.setDownloadNo(Integer.parseInt(req.getProgramSeq()));

		return dao.updateFilesCnt(vo)+"";
	}

	public List<CustomBbsDownloadVO> excel(CustomBbsDownloadVO req) {
		return dao.listTot(req);
	}

}
