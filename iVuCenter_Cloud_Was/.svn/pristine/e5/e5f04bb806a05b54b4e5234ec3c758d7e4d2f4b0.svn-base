package com.ivucenter.cloud.portal.util;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class TokenGenerator {

	/**
	 * Token 
	 * 
	 * @param params
	 * @return
	 */
	public static String generate(String... params) {
		
		String[] input = params;
		if (params.length == 0) return null;
		
		String data = "";
		for (int i = 0; i < input.length; i++) data += input[i];
		
		byte[] sha1 = DigestUtils.sha1(data);
		String token = Base64.encodeBase64String(sha1);
		
		return StringUtils.replaceChars(token, ",+/\"\\<>=;", null);
	}
	
	public static void main(String[] args) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException {
		String sPw = "passw0rd";   
		 
		
		System.out.print(TokenGenerator.generate("admin", sPw));
		
		
		
		//qXrNtZHQ7PxqvTE8DteaDief2os
		//qXrNtZHQ7PxqvTE8DteaDief2os
	}
}
