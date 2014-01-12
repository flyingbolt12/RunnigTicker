package com.lch.general.genericUtils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.struts.upload.FormFile;

public class FormFile2File {

	public static File convertToFile(FormFile attachment) {
		File file = null;
		try {
			file = new File(attachment.getFileName());

			OutputStream os = new FileOutputStream(file);
			InputStream is = new BufferedInputStream(attachment.getInputStream());
			int count;
			byte buf[] = new byte[4096];

			while ((count = is.read(buf)) > -1) {
				os.write(buf, 0, count);
			}

			is.close();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return file;
	}

}
