package com.animalplanet.www.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.animalplanet.www.service.MemberService;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	@Getter @Setter
	private String authEmail;
	
	@Getter @Setter
	private String authUrl;
	
	private RedirectStrategy rdStg = new DefaultRedirectStrategy();
	
	private RequestCache reqCache = new HttpSessionRequestCache();
	// 현재까지의 req res 를 캐싱하여 가지고 있는 객체
	
	@Inject
	private MemberService msv;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		setAuthEmail(authentication.getName());
		setAuthUrl("/board/list");
		
		boolean isUp = msv.updateLastLogin(getAuthEmail());
		// 로그인 성공한 계정의 정보들이 authentication에 담겨있다.
		
		HttpSession ses = request.getSession(false);
		// 새로 생성된 세션이 아닌 기존에 존재하는 세션
		
		if (!isUp || ses == null) {
			return;
		} else {
			ses.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
			// 시큐리티에서 시도한 인증 실패 기록 삭제
			// 시큐리티 실패하면 이를 캐싱하여 WebAttributes에 기록하는데, 로그인하면 이전까지의 실패 기록을 날린다는 의미
		}
		SavedRequest savedReq = reqCache.getRequest(request, response);
		rdStg.sendRedirect(request, response,
				(savedReq != null ? savedReq.getRedirectUrl() : getAuthUrl()));
		// 로그인 전 원래 가려고 하던 곳이 있다면 그 페이지로 보내주고 아니면 원래 가기로 되어있던 페이지로 간다. 
	}

}
