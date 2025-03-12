package com.ivucenter.cloud.api;

import java.io.BufferedReader;
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
public class GetProjects {
	
	@Test
	public void getIdentity() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException, IOException{
		URL url = new URL("http://192.168.50.120:5000/v3/projects/");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("X-Auth-Token", "gAAAAABdFWUTiHB-laJ2gEKFq-mjQqZUa6dg-9rdJ_S6nBG4IYDZ-iNHB_wu6_P8bxgiFWx2U9Y4U8M6AnjFpI5uLSYHbSeWTc67bSthpzXK6gS1FHKX4Ha9oPB-OIyPWXkGNiaixWfPQswFsyFeLM_-clnrpd7rPA");

		int status = con.getResponseCode();
		StringBuffer content = new StringBuffer();
		try(BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
			String inputLine;
			while((inputLine = in.readLine()) != null) {
				content.append(inputLine);
			}
		} catch (IOException e) {
			log.error(e.getMessage());
		} finally {
			con.disconnect();
		}
		log.debug("Response status: " + status);
		log.debug(content.toString());

	}
}
