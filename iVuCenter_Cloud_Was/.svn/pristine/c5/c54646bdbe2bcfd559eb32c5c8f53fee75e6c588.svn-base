package com.ivucenter.cloud.portal.bbs.faq;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;


@Service("BbsFaqService")
public class BbsFaqServiceImpl implements BbsFaqService{

    private static final Logger logger = LoggerFactory.getLogger(BbsFaqServiceImpl.class);

	@Autowired
	private BbsFaqDAO dao;

	@Override
	public String list(CustomBbsFaqVO req) {
	    int recordsTotal;
	    int recordsFiltered;

    	List<CustomBbsFaqVO> lists = dao.list(req);
	    recordsTotal = dao.listTot(req);
	    recordsFiltered = recordsTotal;


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

	@Override
	public CustomBbsFaqVO detail(CustomBbsFaqVO req) {
		return dao.findByIdx(req);
	}

	@Override
	public String insert(CustomBbsFaqVO req) {
		return dao.insert(req)+"";
	}

	@Override
	public String update(CustomBbsFaqVO req) {
		return dao.update(req)+"";
	}

	@Override
	public String delete(CustomBbsFaqVO req) {
		return dao.delete(req)+"";
	}

	@Override
	public void updateHitCount(CustomBbsFaqVO req) {
		 dao.updateHitCount(req);
	}

	@Override
	public List<CustomBbsFaqVO> faqList(String delflag) {
		return dao.faqList(delflag);
	}

	@Override
	public List<CustomBbsFaqVO> getNoticeBbscodeList(String codeKeyId){
		return dao.getNoticeBbscodeList(codeKeyId);
	}
}
