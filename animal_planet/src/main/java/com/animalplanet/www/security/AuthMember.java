package com.animalplanet.www.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.animalplanet.www.domain.MemberVO;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
public class AuthMember extends User {
	private static final long serialVersionUID = 1L;
	private MemberVO mvo;
	
	public AuthMember(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		
	}
	
	public AuthMember(MemberVO mvo) {
		// 받은 mvo를 위에있는 AuthMember에 던져야된다.
		super(mvo.getEmail(), mvo.getPwd()
				, mvo.getAuthList().stream().map(
						authVO -> new SimpleGrantedAuthority(authVO.getAuth())).collect(Collectors.toList()));
		// Collection<? extends GrantedAuthority> authorities 는 미리 mvo에 만들어둔 AuthList이긴 하다.
		// 하지만 저 형태로 만들어줘야 하기 때문에 AuthList를 분해해서 GrantedAuthority 형태로 만들어서 
		// 다시 collection형태로 만들어야 한다.
		// 이걸 stream형식으로 하면 조금더 쉽다.
		this.mvo = mvo;
	}
	
	
}
