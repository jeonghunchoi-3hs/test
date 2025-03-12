package com.ivucenter.cloud.api.openshift.connector;

import java.net.URL;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.KeyManager;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.fabric8.kubernetes.client.Config;
import io.fabric8.kubernetes.client.ConfigBuilder;
import io.fabric8.kubernetes.client.KubernetesClientException;
import io.fabric8.kubernetes.client.internal.SSLUtils;
import io.fabric8.kubernetes.client.utils.URLUtils;
import okhttp3.Credentials;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class AuthorizationUtils {
	private static final String AUTHORIZATION = "Authorization";
	private static final String LOCATION = "Location";
	private static final String AUTHORIZATION_SERVER_PATH = ".well-known/oauth-authorization-server";
	private static final String AUTHORIZE_QUERY = "?response_type=token&client_id=openshift-challenging-client";

	private static final String BEFORE_TOKEN = "access_token=";
	private static final String AFTER_TOKEN = "&expires_in=";
	private static final String BEFORE_EXPIRES = "&expires_in=";
	private static final String AFTER_EXPIRES = "&scope=";

	 private static OkHttpClient createHttpClient(final Config config) {
	        try {
	            OkHttpClient.Builder httpClientBuilder = new OkHttpClient.Builder();

	            // Follow any redirects
	            httpClientBuilder.followRedirects(true);
	            httpClientBuilder.followSslRedirects(true);

	            if (config.isTrustCerts() || config.isDisableHostnameVerification()) {
	                httpClientBuilder.hostnameVerifier((s, sslSession) -> true);
	            }

	            TrustManager[] trustManagers = SSLUtils.trustManagers(config);
	            KeyManager[] keyManagers = SSLUtils.keyManagers(config);

	            if (keyManagers != null || trustManagers != null || config.isTrustCerts()) {
	                X509TrustManager trustManager = null;
	                if (trustManagers != null && trustManagers.length == 1) {
	                  trustManager = (X509TrustManager) trustManagers[0];
	                }

	                    SSLContext sslContext = SSLUtils.sslContext(keyManagers, trustManagers);
	                    httpClientBuilder.sslSocketFactory(sslContext.getSocketFactory(), trustManager);
	            } else {
	              SSLContext context = SSLContext.getInstance("TLSv1.2");
	              context.init(keyManagers, trustManagers, null);
	              httpClientBuilder.sslSocketFactory(context.getSocketFactory(), (X509TrustManager) trustManagers[0]);
	            }

	            if (config.getConnectionTimeout() > 0) {
	                httpClientBuilder.connectTimeout(config.getConnectionTimeout(), TimeUnit.MILLISECONDS);
	            }

	            if (config.getRequestTimeout() > 0) {
	                httpClientBuilder.readTimeout(config.getRequestTimeout(), TimeUnit.MILLISECONDS);
	            }

	            if (config.getWebsocketPingInterval() > 0) {
	              httpClientBuilder.pingInterval(config.getWebsocketPingInterval(), TimeUnit.MILLISECONDS);
	            }


	          if (config.getCustomHeaders() != null && !config.getCustomHeaders().isEmpty()) {
	            httpClientBuilder.addNetworkInterceptor(chain -> {
	              Request.Builder agent = chain.request().newBuilder();
	              for (Map.Entry<String, String> entry : config.getCustomHeaders().entrySet()) {
	                agent.addHeader(entry.getKey(),entry.getValue());
	              }
	              return chain.proceed(agent.build());
	            });
	          }

	            return httpClientBuilder.build();
	        } catch (Exception e) {
	            throw KubernetesClientException.launderThrowable(e);
	        }
	    }


	public static AccessTokenDetail authorize(String masterUrl, String userName, String password) {
		try {
			AccessTokenDetail accessTokenDetail = new AccessTokenDetail();
			accessTokenDetail.setUserName(userName);

			Config config = new ConfigBuilder().withMasterUrl(masterUrl)
					.withUsername(userName).withPassword(password)
					.withTrustCerts(true).build();

			OkHttpClient clone = createHttpClient(config);

			URL url = new URL(URLUtils.join(masterUrl, AUTHORIZATION_SERVER_PATH));

			Response response = clone.newCall(new Request.Builder().get().url(url).build()).execute();

			String authorizationServer;
			try {
				if (!response.isSuccessful() || response.body() == null) {
					throw new KubernetesClientException(
							"Unexpected response (" + response.code() + " " + response.message() + ")");
				}
				String body = response.body().string();
				ObjectMapper objectMapper = new ObjectMapper();
				JsonNode jsonResponse = objectMapper.readTree(body);
				authorizationServer = jsonResponse.get("authorization_endpoint").asText();
			} finally {
				response.close();
			}
			url = new URL(authorizationServer + AUTHORIZE_QUERY);

			String credential = Credentials.basic(userName, password);
			response = clone.newCall(new Request.Builder().get().url(url).header(AUTHORIZATION, credential).build())
					.execute();

			response.close();

			if (response != null) {
				response = response.priorResponse() != null ? response.priorResponse() : response;
				response = response.networkResponse() != null ? response.networkResponse() : response;
			}
			String location = response != null ? response.header(LOCATION) : null;

			if (location == null || location.isEmpty()) {
				throw new KubernetesClientException("Unexpected response (" + response.code() + " " + response.message()
						+ "), to the authorization request. Missing header:[" + LOCATION + "]!");
			}
			String token = location.substring(location.indexOf(BEFORE_TOKEN) + BEFORE_TOKEN.length());
			token = token.substring(0, token.indexOf(AFTER_TOKEN));
			accessTokenDetail.setToken(token);

			String expires_in = location.substring(location.indexOf(BEFORE_EXPIRES) + BEFORE_EXPIRES.length());
			expires_in = expires_in.substring(0, expires_in.indexOf(AFTER_EXPIRES));
			accessTokenDetail.setExpiresIn(expires_in);
			accessTokenDetail.setIssueDate(new Date());
			return accessTokenDetail;
		} catch (Exception e) {
			throw KubernetesClientException.launderThrowable(e);
		}
	}
}
