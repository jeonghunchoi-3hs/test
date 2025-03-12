package com.ivucenter.cloud.batch.sendStatus;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ivucenter.cloud.portal.home.CustomMbrHomeVO;
import com.ivucenter.cloud.portal.home.PotalHomeService;
import com.ivucenter.cloud.portal.oss.disk.CustomStorageVO;

@Service
public class SendStatusService {

	@Autowired
    private PotalHomeService potalHomeService;
	
	public Map<String,String> getContent(){
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일 hh시");
		String date = "";
		date = format.format(cal.getTime());
		
		Map<String, Map<String,CustomMbrHomeVO>> availMap = new HashMap<String,Map<String,CustomMbrHomeVO>>(); 
		
		List<CustomMbrHomeVO> lastWeek = potalHomeService.availHistoryAvr();
		
		for(CustomMbrHomeVO last : lastWeek) {
			Map<String,CustomMbrHomeVO> weekMap = new HashMap<String,CustomMbrHomeVO>();
			
			if(availMap.get(last.getCloudId()) == null) {
				weekMap.put(last.getViewPoint(), last);
				availMap.put(last.getCloudId(),weekMap);
			} else {
				weekMap = availMap.get(last.getCloudId());
				weekMap.put(last.getViewPoint(), last);
			}
		}
		Map<String,String> keywordMap = new HashMap<>();
		String content1 = "";
		content1 += "<table cellpadding='0' cellspacing='0' class='t_blue'>";
		content1 += "<table cellpadding='0' cellspacing='0' class='t_blue'>\r\n"; 
		content1 +=		"	<colgroup>\r\n";
		content1 +=		"		<col width='*' />\r\n"; 
		content1 +=		"		<col width='11%' />\r\n"; 
		content1 +=		"		<col width='11%' />\r\n"; 
		content1 +=		"		<col width='11%' />\r\n"; 
		content1 +=		"		<col width='11%' />\r\n"; 
		content1 +=		"		<col width='11%' />\r\n"; 
		content1 +=		"		<col width='11%' />\r\n"; 
		content1 +=		"	</colgroup>\r\n";
		content1 +=		"	<thead>\r\n";
		content1 +=		"		<tr>\r\n"; 
		content1 +=		"<th class='grey02' rowspan='2'>클라우드</th>";
		content1 +=		"<th class='grey02' rowspan='2'>자원</th>";
		content1 +=		"<th colspan='2'>vCPU (Core)</th>";
		content1 +=		"<th colspan='2'>Memory (GB)</th>";
		content1 +=		"<th colspan='2'>Disk (GB)</th>";
		content1 +=		"		</tr>\r\n"; 
		content1 +=		"		<tr>\r\n"; 
		content1 +=		"			<th class='grey01'>금주</th>\r\n"; 
		content1 +=		"			<th class='grey02'>전주</th>\r\n"; 
		content1 +=		"			<th class='grey01'>금주</th>\r\n"; 
		content1 +=		"			<th class='grey02'>전주</th>\r\n"; 
		content1 +=		"			<th class='grey01'>금주</th>\r\n"; 
		content1 +=		"			<th class='grey02'>전주</th>\r\n"; 
		content1 +=		"		</tr>\r\n"; 
		content1 +=		"	</thead>\r\n"; 
		content1 +=		"	<tbody>\r\n"; 
		Iterator<String> keys = availMap.keySet().iterator();
		while( keys.hasNext()) {
			String key = keys.next();
			Map<String, CustomMbrHomeVO> value = availMap.get(key);
			Iterator<String> keys2 = value.keySet().iterator();
			String cloudName = "";
			int vcpuTotal = 0;
			int memTotal = 0;
			int diskTotal = 0;
			int vcpuUsed = 0;
			int memUsed = 0;
			int diskUsed = 0;
			Double vcpuAvr = 0.0;
			Double memAvr = 0.0;
			Double diskAvr = 0.0;
			int lvcpuTotal = 0;
			int lmemTotal = 0;
			int ldiskTotal = 0;
			int lvcpuUsed = 0;
			int lmemUsed = 0;
			int ldiskUsed = 0;
			Double lvcpuAvr = 0.0;
			Double lmemAvr = 0.0;
			Double ldiskAvr = 0.0;
			while(keys2.hasNext()) {
				String key2 = keys2.next();
				CustomMbrHomeVO avail = value.get(key2);
				if(key2.equals("last")) {
					cloudName = avail.getCloudName();
					vcpuTotal = avail.getVcpuTotal();
					memTotal = avail.getMemTotal();
					diskTotal = avail.getDiskTotal();
					vcpuUsed = avail.getVcpuUsed();
					memUsed = avail.getMemUsed();
					diskUsed = avail.getDiskUsed();
					vcpuAvr = avail.getVcpuAvr();
					memAvr = avail.getMemAvr();
					diskAvr = avail.getDiskAvr();
				}
				if(key2.equals("current")) {
					cloudName = avail.getCloudName();
					lvcpuTotal = avail.getVcpuTotal();
					lmemTotal = avail.getMemTotal();
					ldiskTotal = avail.getDiskTotal();
					lvcpuUsed = avail.getVcpuUsed();
					lmemUsed = avail.getMemUsed();
					ldiskUsed = avail.getDiskUsed();
					lvcpuAvr = avail.getVcpuAvr();
					lmemAvr = avail.getMemAvr();
					ldiskAvr = avail.getDiskAvr();
				}
			}
			content1 +=		"		<tr>\r\n"; 
			content1 +=		"			<td rowspan='3'>"+cloudName+"</td>";
			content1 +=		"			<td>전체 용량</td>\r\n"; 
			content1 +=		"			<td class='red'>"+String.format("%,d",lvcpuTotal)+"</td>\r\n";
			content1 +=		"			<td>"+String.format("%,d",vcpuTotal)+"</td>\r\n"; 
			content1 +=		"			<td class='red'>"+String.format("%,d",lmemTotal)+"</td>\r\n"; 
			content1 +=		"			<td>"+String.format("%,d",memTotal)+"</td>\r\n"; 
			content1 +=		"			<td class='red'>"+String.format("%,d",ldiskTotal)+"</td>\r\n"; 
			content1 +=		"			<td>"+String.format("%,d",diskTotal)+"</td>\r\n"; 
			content1 +=		"		</tr>\r\n";
			content1 +=		"		<tr>\r\n"; 
			content1 +=		"			<td>사용 용량</td>\r\n"; 
			content1 +=		"			<td class='red'>"+String.format("%,d",lvcpuUsed)+"</td>\r\n";
			content1 +=		"			<td>"+String.format("%,d",vcpuUsed)+"</td>\r\n"; 
			content1 +=		"			<td class='red'>"+String.format("%,d",lmemUsed)+"</td>\r\n";
			content1 +=		"			<td>"+String.format("%,d",memUsed)+"</td>\r\n"; 
			content1 +=		"			<td class='red'>"+String.format("%,d",ldiskUsed)+"</td>\r\n";
			content1 +=		"			<td>"+String.format("%,d",diskUsed)+"</td>\r\n"; 
			content1 +=		"		</tr>\r\n";
			content1 +=		"		<tr>\r\n"; 
			content1 +=		"			<td>사용률</td>\r\n"; 
			content1 +=		"			<td class='red'>"+Math.floor(lvcpuAvr)+"%</td>\r\n"; 
			content1 +=		"			<td>"+Math.floor(vcpuAvr)+"%</td>\r\n"; 
			content1 +=		"			<td class='red'>"+Math.floor(lmemAvr)+"%</td>\r\n";
			content1 +=		"			<td>"+Math.floor(memAvr)+"%</td>\r\n"; 
			content1 +=		"			<td class='red'>"+Math.floor(ldiskAvr)+"%</td>\r\n";
			content1 +=		"			<td>"+Math.floor(+diskAvr)+"%</td>\r\n"; 
			content1 +=		"		</tr>\r\n";
		}

		content1 +=		"	</tbody>\r\n"; 
		content1 +=		"</table>";
		
		List<CustomMbrHomeVO> vmUsedHistory = potalHomeService.vmUsedHistory();
		
		String content2 = "";
		content2 += "<table cellpadding='0' cellspacing='0' class='t_green'>\r\n";
		content2 += "	<colgroup>\r\n";
		content2 += "		<col width='15%' />\r\n"; 
		content2 += "		<col width='15%' />\r\n"; 
		content2 += "		<col width='15%' />\r\n"; 
		content2 += "		<col width='11%' />\r\n";
		content2 += "		<col width='11%' />\r\n";
		content2 += "	</colgroup>\r\n";
		content2 += "	<thead>\r\n";
		content2 += "		<tr>\r\n";
		content2 += "			<th class='grey02' rowspan='3'>운영망</th>\r\n";
		content2 += "			<th class='grey02' rowspan='3'>클라우드</th>\r\n";
		content2 += "			<th class='grey02' rowspan='3'>영역</th>\r\n";
		content2 += "			<th class='grey01' rowspan='3'>전주</th>\r\n"; 
		content2 += "			<th class='grey02' rowspan='3'>금주</th>\r\n";
		content2 += "		</tr>\r\n";
		content2 += "	</thead>\r\n"; 
		content2 += "	<tbody>\r\n"; 
		for(CustomMbrHomeVO vmUsed : vmUsedHistory) {
			if(vmUsed.getViewPoint().equals("OA")) {
				content2 += "		<tr>\r\n"; 
				content2 += "			<td rowspan='2'>OA</td>\r\n";
				content2 += "			<td rowspan='2'>오픈클라우드</td>\r\n";
				content2 += "			<td>가상서버</td>\r\n"; 
				content2 += "			<td>"+String.format("%,d",vmUsed.getVmUsed())+"</td>\r\n";
				content2 += "			<td class='red'>"+String.format("%,d",vmUsed.getLVmUsed())+"</td>\r\n"; 
				content2 += "		</tr>\r\n";
				content2 += "		<tr>\r\n"; 
				content2 += "			<td>프로젝트 수</td>\r\n"; 
				content2 += "			<td>"+String.format("%,d",vmUsed.getLProject())+"</td>\r\n";
				content2 += "			<td class='red'>"+String.format("%,d",vmUsed.getProject())+"</td>\r\n"; 
				content2 += "		</tr>\r\n";
			}
			if(vmUsed.getViewPoint().equals("FA")) {
				content2 += "		<tr>\r\n";
				content2 += "			<td>FA</td>\r\n"; 
				content2 += "			<td>오픈클라우드</td>\r\n"; 
				content2 += "			<td>가상서버</td>\r\n"; 
				content2 += "			<td>"+String.format("%,d",vmUsed.getVmUsed())+"</td>\r\n";
				content2 += "			<td class='red'>"+String.format("%,d",vmUsed.getLVmUsed())+"</td>\r\n"; 
				content2 += "		</tr>\r\n";
			}
			if(vmUsed.getViewPoint().equals("DMZ")) {
				content2 += "		<tr>\r\n";
				content2 += "			<td>DMZ</td>\r\n"; 
				content2 += "			<td>오픈클라우드</td>\r\n"; 
				content2 += "			<td>가상서버</td>\r\n"; 
				content2 += "			<td>"+String.format("%,d",vmUsed.getVmUsed())+"</td>\r\n";
				content2 += "			<td class='red'>"+String.format("%,d",vmUsed.getLVmUsed())+"</td>\r\n"; 
				content2 += "		</tr>\r\n";
			}
		}
		content2 += "	</tbody>\r\n"; 
		content2 += "</table>";
		
		List<CustomMbrHomeVO> monthVm = potalHomeService.monthVm();
		
		String content3 = "";
		content3 += "<script>";
		content3 += "Highcharts.chart('container', {";
		content3 += "	title: { text : null},";
		content3 += "	subtitle: {},";
		content3 += "	xAxis: {crosshair: true,categories: [";
		int i = 0;
		for(CustomMbrHomeVO month : monthVm) {
			content3 += "'"+month.getRegMonth()+"'";
			i++;
			if(i < 6) {
				content3 += ",";
			}
		}
		i = 0;
		content3 += "]},";
		content3 += " 	yAxis: {title: { text: '' } },";
		content3 += " 	credits: {enabled: false },";
		content3 += " 	legend: {enabled: false },";
		content3 += " 	colors: ['#185380'],";
		content3 += " 	plotOptions: {line: {dataLabels: {enabled:true},enableMouseTracking:false},column: {pointPadding: 0.2, borderWidth: 0}},";
		content3 += " 	series: [{data:[";
		for(CustomMbrHomeVO month : monthVm) {
			content3 += month.getTotAmount();
			i++;
			if(i < 6) {
				content3 += ",";
			}
		}
		content3 += "]}],";
		content3 += "})";
		content3 += "</script>";
		
		String content4 = "";
		List<CustomMbrHomeVO> mngProductAvr = potalHomeService.mngProductAvr();
		for(CustomMbrHomeVO productAvr : mngProductAvr) {
			List<CustomStorageVO> storageList = potalHomeService.getStorageList(productAvr.getCloudId());
			productAvr.setStorageList(storageList);
		}
		
		content4 += "<table class='tableI'>";
		content4 += "<colgroup>";
		content4 += "<col width='*'/>";
		content4 += "<col width='18%'/>";
		content4 += "<col width='18%'/>";
		content4 += "<col width='18%'/>";
		content4 += "<col width='18%'/>";
		content4 += "<col width='18%'/>";
		content4 += "</colgroup>";
		content4 += "<thead>";
		content4 += "<tr>";
		content4 += "<th></th>";
		content4 += "<th>가상서버</th>";
		content4 += "<th>vCPU</th>";
		content4 += "<th>Memory</th>";
		content4 += "<th>SAN디스크</th>";
		content4 += "<th>Ceph디스크</th>";
		content4 += "</tr>";
		content4 += "</thead>";
		content4 += "<tbody>";
		for(CustomMbrHomeVO productAvr : mngProductAvr) {
			DecimalFormat df = new DecimalFormat("#");
			df.setRoundingMode(RoundingMode.UP);
			DecimalFormat df2 = new DecimalFormat("#,##0");
			content4 += "<tr>";
			content4 += "<td>";
			if(productAvr.getCloudType().equals("openstack")) {
				content4 += "<img src='http://K-Cloud.kepco.co.kr/resources/assets/img/icon_openstack.png' height='24px' class='vm' />";
			} else if(productAvr.getCloudType().equals("vmware")) {
				content4 += "<img src='http://K-Cloud.kepco.co.kr/resources/assets/img/icon_vm.png' height='24px' class='vm' />";
			}
			content4 += "<p class='mt10'>"+productAvr.getCloudName()+"</p>";
			content4 += "</td>";
			content4 += "<td>";
			content4 += "<div class='progress mb5'>";
			content4 += "<div class='progress-bar progress-bar-"+prColor(productAvr.getVmAvr())+"' style='width:"+df.format(productAvr.getVmAvr())+"%' pattern='#'/></div>";
			content4 += "</div>";
			content4 += "<span class='text-"+prColor(productAvr.getVmAvr())+" f16\'>"+df.format(productAvr.getVmAvr()+(1-(productAvr.getVmAvr()%1))%1)+"%</span> <span class='text-66'>("+df2.format(productAvr.getVmUsed())+"/"+df2.format(productAvr.getVmTotal())+" EA)</span>"; 
			content4 += "</td>";
			content4 += "<td>";
			content4 += "<div class='progress mb5'>";
			content4 += "<div class='progress-bar progress-bar-"+prColor(productAvr.getVcpuAvr())+"' style='width:"+df.format(productAvr.getVcpuAvr())+"%' pattern='#'/></div>";
			content4 += "</div>";
			content4 += "<span class='text-"+prColor(productAvr.getVcpuAvr())+" f16'>"+df.format(productAvr.getVcpuAvr()+(1-(productAvr.getVcpuAvr()%1))%1)+"%</span> <span class='text-66'>("+df2.format(productAvr.getVcpuUsed())+"/"+df2.format(productAvr.getVcpuTotal())+" EA)</span>";
			content4 += "</td>";
			content4 += "<td>";
			content4 += "<div class='progress mb5'>";
			content4 += "<div class='progress-bar progress-bar-"+prColor(productAvr.getMemAvr())+"' style='width:"+df.format(productAvr.getMemAvr())+"%' pattern='#'/></div>";
			content4 += "</div>";
			content4 += "<span class='text-"+prColor(productAvr.getMemAvr())+" f16'>"+df.format(productAvr.getMemAvr()+(1-(productAvr.getMemAvr()%1))%1)+"%</span> <span class='text-66'>("+df2.format(productAvr.getMemUsed())+"/"+df2.format(productAvr.getMemTotal())+" GB)</span>";
			content4 += "</td>";
			content4 += "<td>";
			for(CustomStorageVO storage : productAvr.getStorageList()) {
				if(storage.getStorageType().equals("hitachi-g900")) {
					double storageAvr =100.0 *  storage.getUsedSpace() / storage.getTotalSpace();
					if(productAvr.getCloudType().equals("vmware")) {
						content4 += "<h6 class='mb5 tal'>"+storage.getStorageId()+"</h6>";
					}
					content4 += "<div class=progress mb5'>";
					content4 += "<div class='progress-bar progress-bar-"+prColor(Double.valueOf(storageAvr))+"' style='width:"+df.format(storageAvr)+"%' pattern='#'/></div>";
					content4 += "</div>";
					content4 += "<span class='text-"+prColor(Double.valueOf(storageAvr))+" f16'>"+df.format(storageAvr)+"%</span> <span class='text-66'>("+df2.format(storage.getUsedSpace())+"/"+df2.format(storage.getTotalSpace())+"GB)</span>";
					
				}
			}
			content4 += "</td>";
			content4 += "<td>";
			if(productAvr.getCloudType().equals("openstack") && productAvr.getCloudId().equals("e8bea700-878f-489e-bd11-488398a33ed8")) {
				for(CustomStorageVO storage : productAvr.getStorageList()) {
					if(storage.getStorageType().equals("tripleo_ceph") || storage.getStorageType().equals("tripleo_ceph2")) {
						double storageAvr = 100.0 * storage.getUsedSpace() / storage.getTotalSpace();
						String diskName = "";
						if(storage.getStorageType().equals("tripleo_ceph")) {
							diskName = "SATA";
						} else if(storage.getStorageType().equals("tripleo_ceph2")) {
							diskName = "SAS";
						}
						content4 += "<h6 class='mb5 tal'>"+diskName+"</h6>";
						content4 += "<div class='progress mb5'>";
						content4 += "<div class='progress-bar progress-bar-"+prColor(Double.valueOf(storageAvr))+"' style='width:"+df.format(storageAvr)+"%' pattern='#'/></div>";
						content4 += "</div>";
						content4 += "<span class='text-"+prColor(Double.valueOf(storageAvr))+" f16'>"+df.format(storageAvr)+"%</span> <span class='text-66'>("+df2.format(storage.getUsedSpace())+"/"+df2.format(storage.getTotalSpace())+"GB)</span>";
					}
				}
			}
			content4 += "</td>";
			content4 += "</tr>";
		}
		content4 += "</tbody>";
		content4 += "</table>";
		
		keywordMap.put("[[date]]", date);
		keywordMap.put("[[content1]]", content1);
		keywordMap.put("[[content2]]", content2);
		keywordMap.put("[[content3]]", content3);
		keywordMap.put("[[content4]]", content4);
		return keywordMap;
	}
	
	public String prColor(Double value) {
		String Fill = "";
		if(value <= 60) {
			Fill = "green";
		} else if(value > 60 && value <=80) {
			Fill = "yellow";
		} else if(value > 80 ) {
			Fill = "red";
		}
		return Fill;
	}
}
