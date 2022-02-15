package com.animalplanet.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.animalplanet.www.domain.MemberDTO;
import com.animalplanet.www.domain.MemberVO;
import com.animalplanet.www.domain.OrderVO;
import com.animalplanet.www.domain.PagingVO;

public interface MemberDAO {
	int insertMember(MemberVO mvo); // register
	MemberVO selectOneLogin(MemberVO mvo); // login
	List<MemberVO> selectList(); // list
	int update(MemberVO mvo); // modify
	int delete(MemberVO mvo); // remove
	int update(String email); // last_login
	int selectExist(String email); // email duple Check
	int updateGrade(MemberVO mvo);
	int modifyPwd(MemberVO mvo); //modifyPwd
	MemberVO findPwd(MemberVO mvo); //findPwd
	int selectOneOrderTotalCount(String email);
	List<OrderVO> selectListOrderPaging(@Param("email") String email, @Param("pgvo") PagingVO pagingVO);
	
	MemberVO getDetail(String email);
	MemberVO getDetailMember(long mno);

	
}