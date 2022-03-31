package com.animalplanet.www.domain;

import lombok.extern.slf4j.Slf4j;

import java.util.List;

import com.animalplanet.www.security.AuthVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberVO {
	private long mno;
	private String email;
	private String pwd;	
	private String name;
	private String nickName;
	private String phoneNumber;
	private String isSocial;
	private String address;
	private String addressDetail;
	private int grade;
	private String joinDate;
	private String modDate;
	private String lastLogin;
	private List<AuthVO> authList;

}
