package com.ivucenter.cloud.api.nutanix.connector;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import com.ivucenter.cloud.api.nutanix.BasicAuthInterceptor;
import com.ivucenter.cloud.portal.cmm.cloud.CustomOssCloudVO;

import okhttp3.OkHttpClient;

public class NutanixClientManager {

	public static OkHttpClient getPrismClient(CustomOssCloudVO cloudVo) throws Exception {
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
						new BasicAuthInterceptor(cloudVo.getAdminUsername(), cloudVo.getAdminPassword()))
				.sslSocketFactory(sslContext.getSocketFactory(), (X509TrustManager) TRUST_ALL_CERTS)
				.hostnameVerifier(new HostnameVerifier() {
					@Override
					public boolean verify(String hostname, SSLSession session) {
						return true;
					}
				}).build();
		return client;
	}

	public static OkHttpClient getCalmClient(CustomOssCloudVO cloudVo) throws Exception {
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
						new BasicAuthInterceptor(cloudVo.getCalmAdminUser(), cloudVo.getCalmAdminPassword()))
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
