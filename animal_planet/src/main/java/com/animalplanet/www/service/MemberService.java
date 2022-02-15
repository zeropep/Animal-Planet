package com.animalplanet.www.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.animalplanet.www.domain.MemberDTO;
import com.animalplanet.www.domain.MemberVO;
import com.animalplanet.www.domain.OrderVO;
import com.animalplanet.www.domain.PagingVO;

public interface MemberService {
	int register(MemberVO mvo);
	MemberVO login(MemberVO mvo);
	List<MemberVO> getList();
	MemberVO getDetail(String email);
	int modify(MemberDTO memberDTO);
	int remove(MemberVO mvo);
	int dupleCheck(String email);
	int modifyPwd(MemberVO mvo);	//비밀번호 변경
	MemberVO findPwd(MemberVO mvo);
	int getTotalCount(String email);
	List<OrderVO> getOrderList(String email, PagingVO pagingVO);

	MemberDTO getDetailMember(long mno);
	int removeFile(String uuid);
	
	
	
	
	
}
