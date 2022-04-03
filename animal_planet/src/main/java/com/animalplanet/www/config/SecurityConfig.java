package com.animalplanet.www.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.animalplanet.www.security.CustomAuthMemberService;
import com.animalplanet.www.security.LoginFailureHandler;
import com.animalplanet.www.security.LoginSuccessHandler;
import com.animalplanet.www.security.WebAccessDeniedHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@ComponentScan(basePackages = { "com.animalplanet.www.security" })
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Bean
	public PasswordEncoder bcPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AuthenticationSuccessHandler authSuccessHandler() {
		return new LoginSuccessHandler();
	}

	@Bean
	public AuthenticationFailureHandler authFailureHandler() {
		return new LoginFailureHandler();
	}
	
	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
		return new WebAccessDeniedHandler();
	}

	// 주소매핑을 통한 인증
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests().antMatchers("/nproduct/register", "/nproduct/modify", "/nproduct/remove", "/nproduct/image", "/nproduct/file/*", 
						"/hospital/register")
				.hasRole("ADMIN")
				.antMatchers("/member/modifyPwdChange", "/member/detail", "/member/modify", "/member/modifyPwd",
						"/member/myorder", "/member/myboard", "/member/resign", "/member/pwdCheck",
						"/cart/*", 
						"/hcomment/post", "/hcomment/{\\d+}",
						"/pcomment/post", "/pcomment/{\\d+}",
						"/bcomment/post", "/bcomment/{\\d+}",
						"/freeboard/register", "/freeboard/image", "/freeboard/detail", "/freeboard/modify", "/freeboard/remove", "/freeboard/file/*", 
						"/lostboard/register", "/lostboard/image", "/lostboard/detail", "/lostboard/modify", "/lostboard/remove", "/lostboard/file/*",
						"/parcelboard/register", "/parcelboard/image", "/parcelboard/detail", "/parcelboard/modify", "/parcelboard/remove", "/parcelboard/file/*",
						"/payment/*"
						)
				.hasAnyRole("ADMIN", "USER")
				.antMatchers("/member/login", "/member/register", "/member/findPwd")
				.anonymous()
				.antMatchers("/", "/resources/**", "/upload/**", "/common/commingSoon",
						"/hospital/select", "/hospital/nearme", "/hospital/list", "/hospital/detail", 
						"/nproduct/list", "/nproduct/detail",
						"/pcomment/{\\d+}/{\\d+}", "/hcomment/{\\d+}/{\\d+}", "/bcomment/{\\d+}/{\\d+}",
						"/freeboard/list", "/lostboard/list", "/parcelboard/list")
				.permitAll().anyRequest().authenticated();
		
		http.exceptionHandling().accessDeniedHandler(accessDeniedHandler());

		// 커스텀 로그인 페이지를 구성해서 security 적용을 하기 위한 설정
		// controller에 주소요청 매핑도 같이 해주어야 한다.
		http.formLogin().usernameParameter("email").passwordParameter("pwd").loginPage("/member/login")
				.successHandler(authSuccessHandler()).failureHandler(authFailureHandler());

		// 시큐리티를 적용한 후 logout은 반드시 post방식으로 진행해야 함.
		http.logout().logoutUrl("/member/logout").invalidateHttpSession(true).deleteCookies("JSESSIONID")
				.logoutSuccessUrl("/");
	}

	@Bean
	public UserDetailsService customUserService() {
		return new CustomAuthMemberService();
	}

	// 사용자 인증
	// provider : 인증체계 제공하는 객체
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserService()).passwordEncoder(bcPasswordEncoder());
	}

}
