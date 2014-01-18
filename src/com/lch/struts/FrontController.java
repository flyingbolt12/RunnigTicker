package com.lch.struts;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionServlet;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.lch.spring.BusinessComponents.DoTransaction;

public class FrontController extends ActionServlet {

	private static final long serialVersionUID = -7115352712111075814L;

	protected void process(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		GenericXmlApplicationContext ctx;
		try {
			ctx = (GenericXmlApplicationContext)getServletContext().getAttribute("ctx");
			DoTransaction doTransaction = (DoTransaction) ctx.getBean("doTransaction");
			List<Map<String, Object>> superSettings = doTransaction.listSuperSettings();
			getServletContext().setAttribute("superSettings", superSettings);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.process(request, response);
	}
}
