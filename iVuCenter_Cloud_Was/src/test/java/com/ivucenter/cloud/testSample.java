package com.ivucenter.cloud;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertSame;

import org.junit.Test;

class testSample {
	
	@Test
	void test() {
		assertEquals(30, 10+20);	
		String abc = null;
		assertNull(abc);
		String abc1 = "abc";
		String abc2 = "abc";
		assertNotNull(abc2);
		assertSame(abc1, abc2);	
	}
}
