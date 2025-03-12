package com.ivucenter.cloud.api.openstack.connector;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.SocketException;
import java.nio.charset.StandardCharsets;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLHandshakeException;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.NoHttpResponseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpRequestRetryHandler;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpHead;
import org.apache.http.client.methods.HttpOptions;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpTrace;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.conn.HttpHostConnectException;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.protocol.HttpContext;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ivucenter.cloud.api.common.utils.JsonUtils;
import com.ivucenter.cloud.api.common.utils.SystemCalculatorInfo;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class OpenStackRestConnector {

    private static final Logger logger = LoggerFactory.getLogger(OpenStackRestConnector.class);

	private static CloseableHttpClient getHttpConnection(String https) {
		SystemCalculatorInfo systemCalculatorInfo = new SystemCalculatorInfo();
		if(https.equals("https") || systemCalculatorInfo.getIsSSL()) {
			HttpRequestRetryHandler retryHandler = new HttpRequestRetryHandler() {
				@Override
				public boolean retryRequest(IOException arg0, int arg1, HttpContext arg2) {
					return false;
				}
			};


			SSLContext sslContext = null;
			try {
				sslContext = new SSLContextBuilder().loadTrustMaterial(null, (certificate, authType) -> true).build();
			} catch (KeyManagementException e) {
				logger.error("KeyManagementException");
			} catch (NoSuchAlgorithmException e) {
				logger.error("NoSuchAlgorithmException");
			} catch (KeyStoreException e) {
				logger.error("KeyStoreException");
			}
			return HttpClients.custom().setSSLContext(sslContext).setSSLHostnameVerifier(new NoopHostnameVerifier())
					.setRetryHandler(retryHandler).build();
		}

		return HttpClients.createDefault();
	}

	public static RestResponse doRequest(HttpMethod method, String url, Map<String, String> headers)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		return doRequest(method, url, headers, null, null, false, null);
	}

	public static RestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, boolean isNoHttpResponse)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		return doRequest(method, url, headers, null, null, isNoHttpResponse, null);
	}

	public static RestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, String contentType, String payLoad)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		return doRequest(method, url, headers, contentType, payLoad, false, null);
	}

	public static RestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, String contentType,String payLoad, String authString)
		throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
			return doRequest(method, url, headers, contentType, payLoad, false, authString);
		}


	public static RestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, String contentType, String payLoad, boolean isNoHttpResponse, String authString)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		RestResponse output = null;
		CloseableHttpClient httpClient = null;
		HttpResponse response = null;
		try {
			HttpUriRequest httpRequest = getRequest(method, url);
			if (headers != null) {
				headers.forEach((k, v) -> {
					httpRequest.addHeader(k, v);
				});
			}
			if (method.equals(HttpMethod.POST) || method.equals(HttpMethod.PUT) || method.equals(HttpMethod.PATCH)) {
				if (payLoad != null) {
					StringEntity input = new StringEntity(payLoad);
					if (input != null) { input.setContentType(contentType); }
					((HttpEntityEnclosingRequest) httpRequest).setEntity(input);

				}
			}

			String auth = authString;
			if(auth != null) {
				byte[] encodedAuth = Base64.encodeBase64(
						auth.getBytes(StandardCharsets.UTF_8));
				String authHeader = "Basic " + new String(encodedAuth);
				httpRequest.setHeader(HttpHeaders.AUTHORIZATION, authHeader);
			}

			log.debug(">>>> Method : {} , URL : {}", method, url);
			String https = url.substring(0, 5);

			if (headers != null) log.debug(">>>> Header  : {}", headers.toString());
			if (payLoad != null) log.debug(">>>> Body : \r\n"+ JsonUtils.getJsonFormatString(payLoad));
			httpClient = getHttpConnection(https);


			response = httpClient.execute(httpRequest);
			output = responseHandler(response);
			log.debug("<<<< status : {}", output.getStatusCode());
			log.debug("<<<< Header : {} ", output.getSubjectToken());

			if(output.getMessage()!=null) {log.debug("<<<< Body : \r\n {}", JsonUtils.getJsonFormatString(output.getMessage()));
				if (output.getMessage().trim().startsWith("<am:fault")) {
					throw new NotSupportGatewayException(output.getStatusCode(), output.getMessage());
				}
			}

			if (output.getStatusCode() >= 300) {
				ObjectMapper mapper = new ObjectMapper();
				JsonNode rootNode = mapper.readTree(output.getMessage());
				String message = null;



				for (JsonNode jsonNode : rootNode) {
					for(Iterator<Entry<String,JsonNode>> iterator = jsonNode.fields();iterator.hasNext();) {
						Entry<String,JsonNode> field = iterator.next();
						if (field.getKey().equals("message")) {
							message = field.getValue().asText();
							break;
						}
					}
				}
				if (message != null) {
					log.error(message);
					throw new InvaildOpenStackException(output.getStatusCode(), message);
				} else {
					log.error("Unknown Exception !");
					throw new InvaildOpenStackException(output.getStatusCode(), "Unknown Exception !");
				}
			}
		} catch (HttpHostConnectException hhce) {
			log.error(hhce.getMessage());
			throw new NotConnectGatewayException(500, hhce.getMessage());
		} catch (NoHttpResponseException nhre) {
			if (isNoHttpResponse) {
				output = new RestResponse();
				output.setStatusCode(204);
				output.setMessage("Success");
			} else {
				log.error(nhre.getMessage());
			}
		} catch (SSLHandshakeException | SocketException e) {
			log.error(e.getMessage());
			throw new NotConnectGatewayException(500, e.getMessage());
		} catch (UnsupportedEncodingException e) {
			log.error(e.getMessage());
		} catch (ClientProtocolException e) {
			log.error(e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
		} finally {
			/*try {
				response.getEntity().getContent().close();
			} catch (UnsupportedOperationException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}
			HttpClientUtils.closeQuietly(response);
			HttpClientUtils.closeQuietly(httpClient);*/
		}
		if (output != null)
			if(output.getMessage()!=null) {	log.debug("\r\n"+ JsonUtils.getJsonFormatString(output.getMessage()));}
		return output;
	}

	private static HttpUriRequest getRequest(HttpMethod method, String url) {
		HttpUriRequest httpRequest = null;
		if (method.equals(HttpMethod.POST)) {
			httpRequest = new HttpPost(url);
		} else if (method.equals(HttpMethod.GET)) {
			httpRequest = new HttpGet(url);
		} else if (method.equals(HttpMethod.PUT)) {
			httpRequest = new HttpPut(url);
		} else if (method.equals(HttpMethod.DELETE)) {
			httpRequest = new HttpDelete(url);
		} else if (method.equals(HttpMethod.HEAD)) {
			httpRequest = new HttpHead(url);
		} else if (method.equals(HttpMethod.OPTIONS)) {
			httpRequest = new HttpOptions(url);
		} else if (method.equals(HttpMethod.PATCH)) {
			httpRequest = new HttpPatch(url);
		} else if (method.equals(HttpMethod.TRACE)) {
			httpRequest = new HttpTrace(url);
		}
		return httpRequest;

	}

	private static RestResponse responseHandler(HttpResponse response) throws IOException {
		RestResponse output = new RestResponse();
		if(null != response) {
			// body
			HttpEntity entity = response.getEntity();
			if(null != entity) {
				output.setMessage(EntityUtils.toString(entity));
			}
			// result code
			output.setStatusCode(response.getStatusLine().getStatusCode());

			// header
			Header[] headers = response.getAllHeaders();
			for(Header header : headers) {
				if( "X-Subject-Token".equals(header.getName()) )  {
					output.setSubjectToken(header.getValue());



				}
			}
		}

		return output;
	}

}