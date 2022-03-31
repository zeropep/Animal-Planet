package com.animalplanet.www.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Getter @Setter
public class LoginFailureHandler implements AuthenticationFailureHandler {
	private String authEmail;
	private String errorMessage;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		setAuthEmail(request.getParameter("email"));
		// 로그인을 실패했으므로 db에서 가져오는게 아니라 파라미터에 남아있는 값으로 한다.
		
		if (exception instanceof BadCredentialsException || exception instanceof InternalAuthenticationServiceException) {
			// BadCredentialsException : 이메일이나 패스워드를 틀리면 발생
			// InternalAuthenticationServiceException : 내부적으로 인증이 불가할 시 발생
			
			setErrorMessage(exception.getMessage().toString());
		}
		log.debug(">>> errorMessage {}", errorMessage);
		request.setAttribute("email", getAuthEmail());
		request.setAttribute("errMsg", getErrorMessage());
		request.getRequestDispatcher("/member/login?error").forward(request, response);
	}

}
