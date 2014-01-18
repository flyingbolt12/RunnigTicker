/*
 * Created on Feb 22, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.lch.spring.BusinessComponents;

import java.sql.Types;
import java.util.Iterator;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.StoredProcedure;

/**
 * @author Gopi
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
@SuppressWarnings({"rawtypes","unused"})
public class SpringStoredProcedure extends StoredProcedure {

 
	public SpringStoredProcedure(DataSource ds,String SPROC_NAME, Map inParamNamesAndTypes, Map outParamNamesAndTypes) {
    	super(ds, SPROC_NAME);
		int noOfInputParams=inParamNamesAndTypes.size();
    	int noOfOutputParams=outParamNamesAndTypes.size();
    	String paramName = "";
		String paramType = "";
		
    	Iterator it = inParamNamesAndTypes.entrySet().iterator();
    	while(it.hasNext())
    	{
    		Map.Entry entry = (Map.Entry)it.next();
    		paramName = (String)entry.getKey();
    		paramType = (String)entry.getValue();
    		if(paramType.equals("VARCHAR"))
    		{
    		
    			declareParameter(new SqlParameter(paramName, Types.VARCHAR));
    		}
    		if(paramType.equals(""))
    		{
    		
    			declareParameter(new SqlParameter(paramName, Types.VARCHAR));
    		}
    	}
    	it = outParamNamesAndTypes.entrySet().iterator();
    	while(it.hasNext())
    	{
    		
    		
    		Map.Entry entry = (Map.Entry)it.next();
    		paramName = (String)entry.getKey();
    		paramType = (String)entry.getValue();
    		if(paramType.equals("VARCHAR"))
    		{
    			declareParameter(new SqlOutParameter(paramName, Types.VARCHAR));
    		}
    		if(paramType.equals(""))
    		{
    			logger.info("DECLARING");
    			declareParameter(new SqlOutParameter(paramName, Types.JAVA_OBJECT));
    		}
    	}
        
        compile();
    }
    public Map<String, Object> execute(Map<String, ?> inputs) {
        return super.execute(inputs);
    }
   
}
