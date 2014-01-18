package com.lch.general.genericUtils;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Timestamp;
import java.util.Date;

import com.lch.general.dbBeans.ExceptionTrace;

public class BuildExceptionTrace {

	public static com.lch.general.dbBeans.ExceptionTrace buildAndGiveExceptionTrace(Exception e)
	{
		ExceptionTrace trace = new ExceptionTrace();
		trace.setExceptionMessage(e.getMessage());
		trace.setOccuredDateTime(new Timestamp(new Date().getTime()));
		
		 StringWriter stringWritter = new StringWriter();  
	     PrintWriter printWritter = new PrintWriter(stringWritter, true);  
	     e.printStackTrace(printWritter);  
	     printWritter.flush();  
	     stringWritter.flush();  
	     if(stringWritter.toString().length() > 10000)
	     	trace.setException(stringWritter.toString().substring(0,10000));
	     else
	    	 trace.setException(stringWritter.toString());
	    
		return trace;
	}
}
