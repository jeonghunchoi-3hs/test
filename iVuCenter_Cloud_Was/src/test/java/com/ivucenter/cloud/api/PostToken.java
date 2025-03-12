package com.ivucenter.cloud.api;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.junit.Test;

import com.ivucenter.cloud.api.openstack.exception.InvaildOpenStackException;
import com.ivucenter.cloud.api.openstack.exception.NotConnectGatewayException;
import com.ivucenter.cloud.api.openstack.exception.NotSupportGatewayException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PostToken {
	
	@Test
	public void getIdentity() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException, IOException{
		URL url = new URL("http://192.168.50.120:5000/v3/auth/tokens/");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("POST");
		con.setRequestProperty("Content-Type", "application/json");
		con.setRequestProperty("content-length", "281");

		/* Payload support */
		con.setDoOutput(true);
		DataOutputStream out = new DataOutputStream(con.getOutputStream());
		out.writeBytes("{\n");
		out.writeBytes("  \"auth\" : {\n");
		out.writeBytes("    \"identity\" : {\n");
		out.writeBytes("      \"methods\" : [ \"password\" ],\n");
		out.writeBytes("      \"password\" : {\n");
		out.writeBytes("        \"user\" : {\n");
		out.writeBytes("          \"domain\" : {\n");
		out.writeBytes("            \"name\" : \"Default\"\n");
		out.writeBytes("          },\n");
		out.writeBytes("          \"name\" : \"admin\",\n");
		out.writeBytes("          \"password\" : \"passw0rd\"\n");
		out.writeBytes("        }\n");
		out.writeBytes("      }\n");
		out.writeBytes("    }\n");
		out.writeBytes("  }\n");
		out.writeBytes("}\n");
		out.flush();
		out.close();

		int status = con.getResponseCode();
		StringBuffer content = new StringBuffer();
		try(BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
			String inputLine;
			while((inputLine = in.readLine()) != null) {
				content.append(inputLine);
			}
		} catch(IOException e) {
			log.error(e.getMessage());
		} finally {
			con.disconnect();
		}
		log.debug("Response status: " + status);
		log.debug(content.toString());

	}
}
