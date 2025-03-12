package com.ivucenter.cloud.portal.util;

public class CamelUtil {

	public static String UnderScoreCase(String camel){
		
		String regex = "([^_A-Z])([A-Z])";
		String replacement = "$1_$2";
		
		return camel.replaceAll(regex, replacement).toLowerCase();
	}
	
	public static String CamelCase(String underScore){
		
		if(underScore.indexOf('_')< 0 && Character.isLowerCase(underScore.charAt(0))){
			return underScore;
		}
		
		StringBuffer sb = new StringBuffer();
		boolean nextUpper = false;
		int len = underScore.length();
		
		for(int i=0; i<len; i++){
			char currentChar = underScore.charAt(i);
			if(currentChar == '_'){
				nextUpper = true;
			}else{
				if(nextUpper){
					sb.append(Character.toUpperCase(currentChar));
					nextUpper = false;
				}else{
					sb.append(Character.toLowerCase(currentChar));	
				}
			}
		}
		return sb.toString();
	}
	/*
	public static void main(String[] args) {
		String str = "regDateTime";
		str = CamelUtil.UnderScoreCase(str);
		log.debug(str);
		str = CamelUtil.CamelCase(str);
		log.debug(str);
	}
	*/
}
