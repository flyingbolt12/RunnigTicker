package com.lch;

import java.util.HashSet;
import java.util.Set;

import com.github.javafaker.Faker;

public class FakerTest {

	final String lexicon = "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345674890";
	final java.util.Random rand = new java.util.Random();

	final Set<String> identifiers = new HashSet<>();


	public String randomIdentifier() {
	    StringBuilder builder = new StringBuilder();
	    while(builder.toString().length() == 0) {
	        int length = rand.nextInt(5)+5;
	        for(int i = 0; i < length; i++) {
	            builder.append(lexicon.charAt(rand.nextInt(lexicon.length())));
	        }
	        if(identifiers.contains(builder.toString())) {
	            builder = new StringBuilder();
	        }
	    }
	    return builder.toString();
	}
	
	public static void main(String[] args) {
		Faker f = new Faker();
		System.out.println(f.firstName());
		System.out.println(f.lastName());
		System.out.println(f.streetAddress(false));
	}

}
