package cn.bluejoe.elfinder.controller.executors;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import cn.bluejoe.elfinder.controller.executor.AbstractCommandExecutor;
import cn.bluejoe.elfinder.controller.executor.CommandExecutor;
import cn.bluejoe.elfinder.controller.executor.FsItemEx;
import cn.bluejoe.elfinder.service.FsService;
import cn.bluejoe.elfinder.util.MimeTypesUtils;

import com.sun.xml.messaging.saaj.packaging.mime.internet.MimeUtility;

public class FileCommandExecutor extends AbstractCommandExecutor implements CommandExecutor
{
	@Override
	public void execute(FsService fsService, HttpServletRequest request, HttpServletResponse response,
			ServletContext servletContext) throws Exception
	{
		String target = request.getParameter("target");
		boolean download = "1".equals(request.getParameter("download"));
		FsItemEx fsi = super.findItem(fsService, target);
		String mime = fsi.getMimeType();

		response.setCharacterEncoding("utf-8");
		response.setContentType(mime);
		//String fileUrl = getFileUrl(fileTarget);
		//String fileUrlRelative = getFileUrl(fileTarget);
		String fileName = fsi.getName();
		//fileName = new String(fileName.getBytes("utf-8"), "ISO8859-1");
		if (download || MimeTypesUtils.isUnknownType(mime))
		{
			response.setHeader("Content-Disposition",
				"attachments; " + getAttachementFileName(fileName, request.getHeader("USER-AGENT")));
			//response.setHeader("Content-Location", fileUrlRelative);
			response.setHeader("Content-Transfer-Encoding", "binary");
		}

		OutputStream out = response.getOutputStream();
		InputStream is = null;
		response.setContentLength((int) fsi.getSize());
		try
		{
			// serve file
			is = fsi.openInputStream();
			IOUtils.copy(is, out);
			out.flush();
			out.close();
		}
		finally
		{
			if (is != null)
			{
				try
				{
					is.close();
				}
				catch (IOException e)
				{
					e.printStackTrace();
				}
			}
		}
	}

	private String getAttachementFileName(String fileName, String userAgent) throws UnsupportedEncodingException
	{
		if (userAgent != null)
		{
			userAgent = userAgent.toLowerCase();

			if (userAgent.indexOf("msie") != -1)
			{
				return "filename=\"" + URLEncoder.encode(fileName, "UTF8") + "\"";
			}

			if (userAgent.indexOf("opera") != -1)
			{
				return "filename*=UTF-8''" + URLEncoder.encode(fileName, "UTF8");
			}
			if (userAgent.indexOf("safari") != -1)
			{
				return "filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO8859-1") + "\"";
			}
			if (userAgent.indexOf("applewebkit") != -1)
			{
				return "filename=\"" + MimeUtility.encodeText(fileName, "UTF8", "B") + "\"";
			}
			if (userAgent.indexOf("mozilla") != -1)
			{
				return "filename*=UTF-8''" + URLEncoder.encode(fileName, "UTF8");
			}
		}

		return "filename=\"" + URLEncoder.encode(fileName, "UTF8") + "\"";
	}
}
