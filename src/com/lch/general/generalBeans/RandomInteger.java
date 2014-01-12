package com.lch.general.generalBeans;

import java.util.Random;

public class RandomInteger {
	public static final int getRandomNumber() {
		Random randomGenerator = new Random();
		int randomInt=0;
		randomInt = randomGenerator.nextInt(99);
		return randomInt;
	}
}
