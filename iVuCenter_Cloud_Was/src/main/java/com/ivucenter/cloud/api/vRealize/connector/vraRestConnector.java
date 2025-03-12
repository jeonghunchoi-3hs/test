package com.ivucenter.cloud.api.vRealize.connector;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.SocketException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLHandshakeException;

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
import com.ivucenter.cloud.api.openstack.connector.OpenStackRestConnector;
import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class vraRestConnector {

    private static final Logger logger = LoggerFactory.getLogger(vraRestConnector.class);

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
	public static vraRestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, String contentType)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
				return doRequest(method, url, headers, contentType, null, false,"");
			}
	public static vraRestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, String contentType,String payLoad)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
				return doRequest(method, url, headers, contentType, payLoad, false,"");
			}
	public static vraRestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, String contentType,String payLoad, String authString)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
				return doRequest(method, url, headers, contentType, payLoad, false, authString);
			}
	public static vraRestResponse doRequest(HttpMethod method, String url, Map<String, String> headers, String contentType, String payLoad, boolean isNoHttpResponse, String authString)
			throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException {
		vraRestResponse output = null;
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

				String authHeader = "Bearer " + auth;
				httpRequest.setHeader(HttpHeaders.AUTHORIZATION, authHeader);
			}

			log.debug(">>>> Method : {} , URL : {}", method, url);
			String https = url.substring(0, 5);

			if (headers != null) log.info(">>>> Header  : {}", headers.toString());
			if (payLoad != null) log.info(">>>> Body : \r\n"+ JsonUtils.getJsonFormatString(payLoad));
			httpClient = getHttpConnection(https);


			response = httpClient.execute(httpRequest);
			output = responseHandler(response);
			log.info("<<<< status : {}", output.getStatusCode());

			if(output.getMessage()!=null) {log.info("<<<< Body : \r\n {}", JsonUtils.getJsonFormatString(output.getMessage()));
				if (output.getMessage().trim().startsWith("<am:fault")) {
					throw new NotSupportGatewayException(output.getStatusCode(), output.getMessage());
				}
			}

			if (output.getStatusCode() >= 300) {
				ObjectMapper mapper = new ObjectMapper();
				JsonNode rootNode = mapper.readTree(output.getMessage());
				String message = null;
				message = rootNode.get("message").toString();
				//message = rootNode.get("value").get("messages").get(0).get("default_message").toString();
				//System.out.print(rootNode.at("/value/messages"));

				/*for (JsonNode jsonNode : rootNode) {
					for(Iterator<Entry<String,JsonNode>> iterator = jsonNode.fields();iterator.hasNext();) {
						Entry<String,JsonNode> field = iterator.next();
						if (field.getKey().equals("messages")) {
							JsonNode rootNode2 = mapper.readTree(field.getValue().asText());
							for(JsonNode jsonNode2 : rootNode2) {
								for(Iterator<Entry<String,JsonNode>> iterator2 = jsonNode.fields();iterator.hasNext();) {
									Entry<String,JsonNode> field2 = iterator.next();
									System.out.print(field2);
								}
							}
							message = field.getValue().asText();
							break;
						}
					}
				}*/
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
				//output = new RestResponse();
				//output.setStatusCode(204);
				//output.setMessage("Success");
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

	private static vraRestResponse responseHandler(HttpResponse response) throws IOException {
		vraRestResponse output = new vraRestResponse();
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
					//output.setSubjectToken(header.getValue());



				}
			}
		}

		return output;
	}
}
