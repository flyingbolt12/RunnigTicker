package com.lch.struts.actions;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lch.general.enums.DOCTypes;
import com.lch.general.generalBeans.UserProfile;

public class DownloadAFile extends BaseAction {
	private static Logger log = LoggerFactory.getLogger(DownloadAFile.class);

	private String buildHTML(String filePath, String fileName, HttpServletRequest request) {
		return "<img src=\"" + filePath + fileName + "\"/><BR>";
	}

	@SuppressWarnings("unchecked")
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String action = request.getParameter("action");
		List<FileDetails> files = new ArrayList<DownloadAFile.FileDetails>();

		if (action == null)
		{
			log.info("No action defined");
			putStatusObjInRequest(request, "Error occured while downloading files");
			return mapping.findForward("status");
		}
		
		if (action.equals("timeSheets") || action.equalsIgnoreCase("view")) {
			long id = getLongAsRequestParameter("id", request);
			String sIds ="0";
			
			if(action.equalsIgnoreCase("view"))
			{
				sIds = request.getParameter("id");
			}
			else
			{
				sIds = getSpringCtxDoTransactionBean().getTimesheetSupportingDocId(id);	
			}
			boolean isNonImg = false;
			List<Map<String, String>> filePaths = null;

			
			StringBuilder builder = new StringBuilder();

			if (sIds.equals("0")) {
				putObjInRequest("staus", request, "No files available");
				return mapping.findForward("status");
			} else {

				filePaths = getSpringCtxDoTransactionBean().listFilePaths(sIds);

				for (Map<String, String> path : filePaths) {
					if (path.get("docSavedName").endsWith("jpg") || path.get("docSavedName").endsWith("JPG") || path.get("docSavedName").endsWith("png") || path.get("docSavedName").endsWith("PNG")
							|| path.get("docSavedName").endsWith("gif") || path.get("docSavedName").endsWith("GIF")) {
						String html = buildHTML(path.get("docRPath"), path.get("docSavedName"), request);
						log.info("HTML Produced {}", html);
						builder.append(html);
					} else if (path.get("docSavedName").endsWith("pdf") || path.get("docSavedName").endsWith("PDF")) {
						
						ServletOutputStream os = response.getOutputStream();
					    try {
					        response.setContentType("application/pdf");
					        //response.addHeader("content-disposition", "attachment; filename=" + (String) path.get("docSavedName"));
					        FileInputStream fileInputStream = new FileInputStream((String) path.get("docAPath"));
					        BufferedInputStream buf = new BufferedInputStream(fileInputStream);
					        int i;
					        while ((i = buf.read()) != -1) {
					            os.write(i);
					        }
					        fileInputStream.close();
					    } finally {
					        os.close();
					    }
					    return null;
					} else {
						isNonImg = true;
						break;
					}
				}
			}

			if (!isNonImg) {
				putObjInRequest("status", request, builder.toString());
				return mapping.findForward("status");
			} else {

				for (Map<String, String> path : filePaths) {
					String filePath = (String) path.get("docAPath");
					String fileName = (String) path.get("docSavedName");

					FileDetails fileDetails = new FileDetails();
					fileDetails.fileName = fileName;
					fileDetails.filePath = filePath;

					files.add(fileDetails);
				}
			}
			ServletOutputStream sos = response.getOutputStream();
			try {
				response.setContentType("application/zip");
				response.setHeader("Content-Disposition", "attachment; filename=\"TimeSheetSupportingDocuments.zip\"");
				sos.write(zipFiles(files));
			} catch (Exception e) {
				e.printStackTrace();
				putStatusObjInRequest(request, "Error occured while downloading files");
				return mapping.findForward("status");
			} finally {
				sos.flush();
			}
			
		}
		else if (action.equals(DOCTypes.UserProfile.name()))
		{
			UserProfile userProfile = getUserProfile(request);
			long businessId = userProfile.getBusinessId();
			long userId = getIntAsRequestParameter("userId", request);
			StringBuilder builder = new StringBuilder();
			
			if(userId == 0)
			{
				userId = userProfile.getUserId();
			}

			if(userProfile.isAdmin()){
			String link = String.format("<a href=\"adminFunctImpl.do?parameter=notifyToUploadProfile&userId=%s&businessId=%s\">click here.</a>", userId, businessId);
			builder = new StringBuilder("No Profile(s) uploaded by your Employee. <br>If you want to notify your Employee to upload a profile please : ");
			builder.append(link);
			}
			else
			{
				builder = new StringBuilder("No Profile(s) uploaded by you.");
			}
			
			try {
				List<Map<String, Object>> profilesList = getSpringCtxDoTransactionBean().listProfiles(
						businessId, userId);
				
				if(profilesList.size() == 0){
					putStatusObjInRequest(request, builder.toString());
					return mapping.findForward("status");
				}
				
				for (Map<String, Object> path : profilesList) {
					String filePath = (String) path.get("docAPath");
					String fileName = (String) path.get("docSavedName");

					FileDetails fileDetails = new FileDetails();
					fileDetails.fileName = fileName;
					fileDetails.filePath = filePath;

					files.add(fileDetails);
				}
				
				ServletOutputStream sos = response.getOutputStream();
				try {
					response.setContentType("application/zip");
					response.setHeader("Content-Disposition", "attachment; filename=\"MyProfiles.zip\"");
					sos.write(zipFiles(files));
				} catch (Exception e) {
					e.printStackTrace();
					putStatusObjInRequest(request, "Error occured while downloading files");
					return mapping.findForward("status");
				} finally {
					sos.flush();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return null;
	}

	class FileDetails {
		String filePath;
		String fileName;
	}

	private byte[] zipFiles(List<FileDetails> filePaths) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ZipOutputStream zos = new ZipOutputStream(baos);
		byte bytes[] = new byte[2048];

		for (FileDetails fileDetails : filePaths) {
			log.info("Zipping {}", fileDetails.filePath);
			FileInputStream fis = new FileInputStream(fileDetails.filePath);
			BufferedInputStream bis = new BufferedInputStream(fis);

			zos.putNextEntry(new ZipEntry(fileDetails.fileName));

			int bytesRead;
			while ((bytesRead = bis.read(bytes)) != -1) {
				zos.write(bytes, 0, bytesRead);
			}
			zos.closeEntry();
			bis.close();
			fis.close();
		}
		zos.flush();
		baos.flush();
		zos.close();
		baos.close();

		return baos.toByteArray();
	}
}
