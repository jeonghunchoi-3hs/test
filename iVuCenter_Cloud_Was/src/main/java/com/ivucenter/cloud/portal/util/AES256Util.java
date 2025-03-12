package com.ivucenter.cloud.portal.util;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

import lombok.extern.slf4j.Slf4j;


/**
 * 양방향 암호화 알고리즘인 AES256 암호화를 지원하는 클래스
 */

@Slf4j
public class AES256Util {
    private String iv;
    private Key keySpec;

    /**
     * 16자리의 키값을 입력하여 객체를 생성한다.
     * @param key 암/복호화를 위한 키값
     * @throws UnsupportedEncodingException 키값의 길이가 16이하일 경우 발생
     */
    public AES256Util(String key) throws UnsupportedEncodingException {
		this.iv = key.substring(0, 16);
        byte[] keyBytes = new byte[16];
        byte[] b = key.getBytes("UTF-8");
        int len = b.length;
        if(len > keyBytes.length){
            len = keyBytes.length;
        }
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");    		
        this.keySpec = keySpec;
    }

    /**
     * AES256 으로 암호화 한다.
     * @param str 암호화할 문자열
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    public String encrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException{
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
        String enStr = new String(Base64.encodeBase64(encrypted));
        return enStr;
    }

    /**
     * AES256으로 암호화된 txt 를 복호화한다.
     * @param str 복호화할 문자열
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    public String decrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException {
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] byteStr = Base64.decodeBase64(str.getBytes());
        return new String(c.doFinal(byteStr), "UTF-8");
    }
    
    public static void main(String[] args) throws UnsupportedEncodingException, NoSuchAlgorithmException, GeneralSecurityException {
    	AES256Util aes = new AES256Util(CodeUtil.KEY_SPEC);
//    	String str = "ufaGRucGe1Qf4zg0+ftwnXffKZxcCt9CXvJQuqU8v6E=";
//    	str = aes.decrypt(str);
//    	log.debug(aes.decrypt("yMGZIS7kuqTXyGIuh1G2Ug=="));
    	log.debug(aes.decrypt("3HJxSxffz34L8UPYiMiGig=="));
//    	log.debug(aes.decrypt("psrR3cE0WN8hAeVHBtvR5w=="));

//    	log.debug(aes.decrypt("hc3sFaNrE5UbdSrDl5zbZA=="));
//    	log.debug(aes.decrypt("iTFmtGNnOugnmy7STOBWjw=="));
    	
    	System.out.println(aes.decrypt("3HJxSxffz34L8UPYiMiGig=="));
    	System.out.println(aes.decrypt("EV6+m2OM4r8ZQyTR41FbKg=="));
    	System.out.println(aes.decrypt("LdDj5tNVbkg0OD+Nhfe/eNP/eqXgzYUVXG/CtqetSCA="));
    	System.out.println(aes.decrypt("Ty4cbD9Z/YWw3kP9EvE1dg=="));
    	System.out.println(aes.encrypt("010-9370-8059"));
    	
//    	str = "sanalim83@gmail.com";
//    	str = aes.encrypt(str);
//    	log.debug("encrypt=>"+str);
	}
}