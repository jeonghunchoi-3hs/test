package com.ivucenter.cloud.main;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component 
public class IvucenterConfig {
	// Attributes	
	private String enableAlarm;
	
	// Constractors
	private IvucenterConfig() { }

	private static class IvucenterConfigSingletonHolder {
		static IvucenterConfig instance = new IvucenterConfig();
	}

	public static IvucenterConfig getInstance() {
		return IvucenterConfigSingletonHolder.instance;
	}	
}
