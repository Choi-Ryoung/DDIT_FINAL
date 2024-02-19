package kr.or.ddit.member.login.service.impl;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl {
	
	@Inject
	private JavaMailSender mailSender;
		
	@Async
	public void sendMail(String to, String subject, String body) {
		MimeMessage message = mailSender.createMimeMessage();
			try {
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
					//제목
				messageHelper.setSubject(subject);
				//받는사람
				messageHelper.setTo(to); 
				//보내는사람
				messageHelper.setFrom("qnfspem@naver.com", "TEST");
				//내
				messageHelper.setText(body,true);
				mailSender.send(message);  
			}catch(Exception e) {
				e.printStackTrace();
			}
		}

	}
