package com.ivucenter.cloud.api.openshift.object;

import java.util.Iterator;
import java.util.Map;

public class OpsNodeOptionList {
	public static String SPEC = "spec";
	public static String SPEC_HARD = "hard";
	public static String SPEC_HARD_LIMIT_CPU = "limits.cpu";
	public static String SPEC_HARD_REQUESTS_CPU = "requests.cpu";
	public static String SPEC_HARD_REQUESTS_MEMORY = "requests.memory";
	public static String SPEC_HARD_LIMIT_MEMORY = "limits.memory";
	public static String SPEC_HARD_PERSISTENTVOLUMECLAIMS = "persistentvolumeclaims";
	public static String SPEC_HARD_PODS = "pods";
	
	public static String NOT_CODE = "4";
	public static String NOT_CODE_NAMESPACE = NOT_CODE + "04";
	
	
	public static String STATUS = "status";
	public static String STATUS_HARD = "hard";
	public static String STATUS_HARD_LIMIT_CPU = "limits.cpu";
	public static String STATUS_HARD_LIMIT_MEMORY = "limits.memory";
	public static String STATUS_HARD_REQUESTS_CPU = "requests.cpu";
	public static String STATUS_HARD_REQUESTS_MEMORY = "requests.memory";
	public static String STATUS_HARD_PERSISTENTVOLUMECLAIMS = "persistentvolumeclaims";
	public static String STATUS_HARD_PODS = "pods";
	
	public static String STATUS_USED = "used";
	public static String STATUS_USED_LIMIT_CPU = "limits.cpu";
	public static String STATUS_USED_LIMIT_MEMORY = "limits.memory";
	
	public static String STATUS_USED_REQUESTS_CPU = "requests.cpu";
	public static String STATUS_USED_REQUESTS_MEMORY = "requests.memory";
	
	public static String STATUS_USED_PERSISTENTVOLUMECLAIMS = "persistentvolumeclaims";
	public static String STATUS_USED_PODS = "pods";
	
	public static String QUOTANAME = "-quota";
	
	public static String  LIMITRANGEBULDER    = "-limitrangebulder";
	public static String PROJECT_DISPLAY_NAME_ANNOTATION = "openshift.io/display-name"; 
	public static String PROJECT_DESCRIPTION_ANNOTATION = "openshift.io/description"; 
	public static String changeValue(String text,Map<String, String> param) {
		Iterator<String> keys = param.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			text = text.replaceAll("\\$\\{"+key+"\\}", param.get(key));
		}
		return text;
	}
	
	public static String quotaNickNameOption = "-quota";
	public static String quotaNickNameReturn( String namespace) {
		String tot_Str = null;
		
		tot_Str = namespace + quotaNickNameOption;
		return tot_Str;
	}
	
	
	
}
