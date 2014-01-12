package com.lch.general.genericUtils;

import org.apache.commons.lang3.RandomStringUtils;

public class GeneratePassword {
	public static String getGeneratedPassword()
	{
		String password = RandomStringUtils.random(8, true, true);
		return password;
	}
	
}
