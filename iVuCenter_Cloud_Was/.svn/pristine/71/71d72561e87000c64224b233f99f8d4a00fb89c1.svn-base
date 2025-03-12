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
import com.ivucenter.cloud.api.openstack.interfaces.AbstractFactory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class GetImages {
	
	private final AbstractFactory abstractFactory = new AbstractFactory();
	

	@Test
	public void getIdentity() throws NotConnectGatewayException, NotSupportGatewayException, InvaildOpenStackException, IOException{
		URL url = new URL("http://100.21.210.142:9292/v2/images");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("X-Auth-Token", "gAAAAABdsShz1U3vLug2MScbo5oAE21o0gADxExH3SECV4SoOW2SMd3mYlFquoU5PFeL7aqYuEfhckPYwCoPz1zu9g5OsGSw96S7kCoQnfrdnn6pdb1AjGP3R8GC_r3cTdD2OIP0wh8RJNDknFXpmEUV8zonhRtwrlS7HpLTOSe7nzePeBx9Mfc");

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
