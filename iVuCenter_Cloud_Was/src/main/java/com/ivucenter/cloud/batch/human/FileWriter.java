package com.ivucenter.cloud.batch.human;

import java.util.List;

import org.springframework.batch.item.ItemWriter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileWriter implements ItemWriter<HumanVO> {

	@Override
	public void write(List<? extends HumanVO> items) throws Exception {
		for (HumanVO item : items) {
			log.debug(item.toString());
		}
	}

}
