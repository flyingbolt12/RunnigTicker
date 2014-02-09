package com.lch.general.email;

import java.io.File;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.AuthenticationFailedException;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;




public class EmailUtil implements Serializable {

	private static String unsub = "<BR><BR><font size=\"1\" face=\"Arial\">You are recieving this email because you registerd with us. The information contained in this e-mail, including any attachment(s), is intended solely for use by the named addressee(s).  If you are not the intended recipient, or a person designated as responsible for delivering such messages to the intended recipient, you are not authorized to disclose, copy, distribute or retain this message, in whole or in part, without written authorization from AlliBilli.  This e-mail may contain proprietary, confidential or privileged information. If you have received this message in error, please notify the sender immediately. This notice is included in all e-mail messages leaving AlliBilli. Also Note that AlliBilli is for general public use. It is not intended for to use any content from any author in a wrong manner. If you feel content is misused please contact us to took that content off from the website or to remove your account <a href=\"http://www.runningticker.com/footerFunct.do?parameter=contactInformation\">at here</a>.Thank you for your cooperation.</font>";
	private static final Logger logger = LoggerFactory.getLogger(EmailUtil.class);

	private static final long serialVersionUID = 1L;
	private JavaMailSender mailSender;
	private String fromEmail;

	private PropertiesBean propBean;

	public PropertiesBean getPropBean() {
		return propBean;
	}

	public void setPropBean(PropertiesBean propBean) {
		this.propBean = propBean;
	}

	public String getFromEmail() {
		return fromEmail;
	}

	public void setFromEmail(String fromEmail) {
		this.fromEmail = fromEmail;
	}

	public Boolean sendEmailWithMultipleRecipants(HashMap<String, Object> myMap) {
		Boolean status = Boolean.FALSE;

		StringBuffer sb = new StringBuffer();
		String subject = "";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			subject = (String) myMap.get(EmailConstants.SUBJECT);
			Object to = myMap.get(EmailConstants.TO);
			Object bcc = myMap.get(EmailConstants.BCC);
			Object cc = myMap.get(EmailConstants.CC);
			String emailBody = (String) myMap.get(EmailConstants.EMAILBODY);
			String from = (String) myMap.get(EmailConstants.FROM);
			File attachment = (File) myMap.get(EmailConstants.ATTACHMENT);
			emailBody += unsub;

			String replyTo = (String) myMap.get(EmailConstants.REPLYTO);
			sb.append("TO : ");
			if (to != null && to instanceof String) {
				String to_str = (String) to;
				if (to_str.length() > 0) {
					helper.setTo(to_str);
					sb.append(to_str);
				}
			} else if (to != null && to.getClass().isArray()) {
				InternetAddress[] addressTo = (InternetAddress[]) to;
				helper.setTo(addressTo);
				for (InternetAddress ia : addressTo)
					sb.append(ia.getAddress() + " , ");
			}
			sb.append("CC : ");
			if (cc != null && cc instanceof String) {
				String cc_str = (String) cc;
				if (cc_str.length() > 0) {
					helper.setCc(cc_str);
					sb.append(cc_str);
				}
			} else if (cc != null && cc.getClass().isArray()) {
				InternetAddress[] addresscc = (InternetAddress[]) cc;
				helper.setCc(addresscc);
				for (InternetAddress ia : addresscc)
					sb.append(ia.getAddress() + " , ");
			}
			sb.append("BCC : ");
			if (bcc != null && bcc instanceof String) {
				String bcc_str = (String) bcc;
				if (bcc_str.length() > 0) {
					helper.setBcc(bcc_str);
					sb.append(bcc_str);
				}
			} else if (bcc != null && bcc.getClass().isArray()) {
				InternetAddress[] addressbcc = (InternetAddress[]) bcc;
				helper.setBcc(addressbcc);
				for (InternetAddress ia : addressbcc)
					sb.append(ia.getAddress() + " , ");
			}

			if (emailBody != null && emailBody.length() > 1)
				helper.setText(emailBody, true);
			if (subject != null && subject.length() > 1)
				helper.setSubject(subject);

			if (replyTo != null && replyTo.length() > 1)
				helper.setReplyTo(replyTo);

			if (attachment != null) {
				helper.addAttachment(attachment.getName(), attachment);
			}

			// helper.setFrom(fromEmail);
			if (propBean.getIsToSendEmail()) {

				if (from != null && from.equals(EmailConstants.FROM_EMAIL)) {
					from = "ILCH " + "<" + from + ">";
					helper.setFrom(from);
					sendEmail(message);
				} else if (from != null && from.length() > 0) {
					from = this.fromEmail + "<" + from + ">";
					helper.setFrom(from);
					sendEmail(message);
				} else
					logger.debug("From Not found Dropping the email");

				logger.debug("Notified Emails {}", sb.toString());
				
			} else {
				logger.debug("Email Sent -> Virtually --> {}", sb.toString());
			}
			
			status = Boolean.TRUE;
		} catch (Exception e) {
			e.printStackTrace();
			status = Boolean.FALSE;
			sendErrorEmail((String) myMap.get(EmailConstants.FROM));
		}

		return status;
	}

	public Map<String, String> confirmSMTP(String host, String port, String username, String password, String auth, String enctype) {
        boolean result = false;
        String exception = null;
        try {
            Properties props = new Properties();
            if (auth.equals(true)) { props.setProperty("mail.smtp.auth", "true"); }
            else { props.setProperty("mail.smtp.auth", "false"); }
            if (enctype.endsWith("TLS")) { props.setProperty("mail.smtp.starttls.enable", "true"); }
            else if (enctype.endsWith("SSL")) { props.setProperty("mail.smtp.startssl.enable", "true"); }
            Session session = Session.getInstance(props, null);
            Transport transport = session.getTransport("smtp");
            int portint = Integer.parseInt(port);
            transport.connect(host, portint, username, password);
            transport.close();
            result = true; } 
        catch(AuthenticationFailedException e) { logger.error(e.toString()); exception = "SMTP: Authentication Failed : "+e.toString(); }
        catch(MessagingException e) { logger.error(e.toString()); exception= "SMTP: Messaging Exception Occurred :"+e.toString(); }
        catch (Exception e) { logger.error(e.toString()); exception= "SMTP: Unknown Exception : "+e.toString(); }
        
        Map<String, String> m = new HashMap<String, String>();
        m.put("result", String.valueOf(result));
        m.put("exception", exception);
        return m; 
        
	}
	
	private void sendErrorEmail(String to) {

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setTo(to);
			helper.setSubject("OPERATION FAILURE DELIVERY");
			helper.setText("The email what you just sent was not successed. Please try again");
			mailSender.send(message);

		} catch (Exception e) {
			logger.error("==========>>>>>>>>>> MAIL SENT FAILED");
		}
	}

	public void sendEmail(MimeMessage message) {
		mailSender.send(message);
	}

	public JavaMailSender getMailSender() {
		return mailSender;
	}

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

}
