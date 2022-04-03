package com.animalplanet.www.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class WebAccessDeniedHandler implements AccessDeniedHandler{@Override
	public void handle(HttpServletRequest req, HttpServletResponse res,
			AccessDeniedException ade) throws IOException, ServletException {
	
	if (ade instanceof AccessDeniedException) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null) {
			authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_USER"));
			req.setAttribute("msg", "제한된 접근입니다.");
		}
	}
	req.getRequestDispatcher("/error/error403").forward(req, res);
	}

}
