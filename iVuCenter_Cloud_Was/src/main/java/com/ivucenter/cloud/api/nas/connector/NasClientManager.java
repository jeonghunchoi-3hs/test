package com.ivucenter.cloud.api.nas.connector;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.nutanix.BasicAuthInterceptor;

import okhttp3.OkHttpClient;

public class NasClientManager {

	public static OkHttpClient getNasClient(SystemCalculatorInfo systemCalculatorInfo) throws Exception {
		TrustManager TRUST_ALL_CERTS = new X509TrustManager() {
			@Override
			public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) {
			}

			@Override
			public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) {
			}

			@Override
			public java.security.cert.X509Certificate[] getAcceptedIssuers() {
				return new java.security.cert.X509Certificate[] {};
			}
		};

		SSLContext sslContext = SSLContext.getInstance("TLSv1.2");
		sslContext.init(null, new TrustManager[] { TRUST_ALL_CERTS }, new java.security.SecureRandom());

		OkHttpClient client = new OkHttpClient.Builder()
				.addInterceptor(
						new BasicAuthInterceptor(systemCalculatorInfo.getNasusername(), systemCalculatorInfo.getNaspassword()))
				.sslSocketFactory(sslContext.getSocketFactory(), (X509TrustManager) TRUST_ALL_CERTS)
				.hostnameVerifier(new HostnameVerifier() {
					@Override
					public boolean verify(String hostname, SSLSession session) {
						return true;
					}
				}).build();
		return client;
	}

}
