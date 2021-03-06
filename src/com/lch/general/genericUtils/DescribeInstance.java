/*
 * Created on Jan 17, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.general.genericUtils;

import java.lang.reflect.Field;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Gopi
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class DescribeInstance {
	private static Logger log = LoggerFactory.getLogger(DescribeInstance.class);

	public static void describeInstance(Object object) {
		if (GenericProperties.isDescribeInstanceFieldValuesLOGPrint) {
			Class<?> cls = object.getClass();
			Field fieldlist[] = cls.getDeclaredFields();
			if (fieldlist.length > 0) {
				for (int i = 0; i < fieldlist.length; i++) {
					try {
						Field fld = fieldlist[i];
						fld.setAccessible(true);
						log.info(fld.getName() + "-->" + fld.get(object));

					} catch (IllegalAccessException e) {
						log.error("(Exception Thrown: " + e + ")");
					}
				}
			}
		}
	}

}