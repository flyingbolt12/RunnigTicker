package com.lch.struts.actions.members;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.enums.DOCTypes;
import com.lch.spring.BusinessComponents.DoTransaction;
import com.lch.struts.actions.BaseAction;

/**
 * @version 1.0
 * @author
 */

@SuppressWarnings({ "unchecked","unused" })
public class FileUploadAction extends BaseAction

{
    private static String CONTENT_LENGTH = "Content-Length";
	private static Logger log = LoggerFactory.getLogger(FileUploadAction.class);
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String contentLengthHeader = request.getHeader(CONTENT_LENGTH);
	    Long expectedFileSize = StringUtils.isBlank(contentLengthHeader) ? null : Long.parseLong(contentLengthHeader);
	       
	    String aFilePath = getApplicationPathToOneUP()+"supportingDocs";
	    DoTransaction doTransaction = getSpringCtxDoTransactionBean();
		try {
			
			String fileToUpload = getStrAsRequestParameter("fileToUpload", request);
			long weeklyHrsSummaryId = getLongAsRequestParameter("weeklyHrsSummaryId", request);
			long userId = getLongAsRequestParameter("userId", request);
			long businessId = getLongAsRequestParameter("businessId", request);
			
			File repository = new File("c:\\diffs");
			
			FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            
            List<FileItem> formFileItems = upload.parseRequest(request);
            
	        Map<String, String> params = new HashMap<String, String>();
	        List<FileItem> files = new ArrayList<FileItem>();
	        
	        for (FileItem item : formFileItems)
			{
				if (item.isFormField())
				{
					String key = item.getFieldName();
					String value = item.getString();
					if (StringUtils.isNotBlank(key))
					{
						params.put(key.toLowerCase(), StringUtils.defaultString(value));
					}
				}
				else
				{
					files.add(item);
				}
			}
	        
	        FileItem uploadItem;
			String filename;
			
			
	        if (ServletFileUpload.isMultipartContent(request))
            {
				 uploadItem = files.get(0);
				 byte[] bytes = uploadItem.get();
				 filename = files.get(0).getName();
				 
				 String rPath = "/supportingDocs/";
				int fileSavedId =  doTransaction.handleSupportingFile(businessId,userId,DOCTypes.TimeSheetSupportingDoc.name(),bytes,aFilePath,rPath,String.valueOf(weeklyHrsSummaryId),filename);
				
				String existingIds = doTransaction.getSupporting_DOCSIDS_WEEKLYHRS_SUMMARY(String.valueOf(weeklyHrsSummaryId));
				
				int i = getSpringCtxDoTransactionBean().update_DOCSIDS_WEEKLYHRS_SUMMARY(String.valueOf(weeklyHrsSummaryId), existingIds+","+fileSavedId);
				
				
				if(i<=0)
				{
					log.error("Unable to update the details of Attached Documents. Immediate Attention required.");
				}
				
            }
			
			
			
		}  catch (Exception e) {
			e.printStackTrace();
		}
		return mapping.findForward("success");
	}
	
	String insertFileToDB(List<DiskFileItem> items, int docTypeId) throws Exception
	{
		return getSpringCtxDoTransactionBean().uploadFiles2DB(items,docTypeId);
	}

}
