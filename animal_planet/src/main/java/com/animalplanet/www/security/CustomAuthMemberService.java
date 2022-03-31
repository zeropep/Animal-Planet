package com.animalplanet.www.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.animalplanet.www.domain.MemberVO;
import com.animalplanet.www.repository.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthMemberService implements UserDetailsService {
	
	@Inject
	private MemberDAO mdao;
	
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		MemberVO mvo = mdao.getDetail(email);
		mvo.setAuthList(mdao.selectAuths(email));
		return new AuthMember(mvo);
	}

}
