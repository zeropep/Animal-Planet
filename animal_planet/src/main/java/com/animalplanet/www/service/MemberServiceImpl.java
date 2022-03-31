package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.animalplanet.www.domain.FileVO;
import com.animalplanet.www.domain.MemberDTO;
import com.animalplanet.www.domain.MemberVO;
import com.animalplanet.www.domain.OrderVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.repository.MemberDAO;
import com.animalplanet.www.repository.MemberFileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	private MemberFileDAO mfdao;
	
	@Inject
	private MemberDAO mdao;
	
	@Transactional
	@Override
	public int register(MemberVO mvo) {
		mdao.insertMember(mvo);
		return mdao.insertAuthInit(mvo.getEmail());
	}

	@Override
	public MemberVO login(MemberVO mvo) {
		MemberVO loginMvo = mdao.selectOneLogin(mvo);

		return loginMvo;
	}

	@Override
	public List<MemberVO> getList() {
		return mdao.selectList();
	}
		
	@Override
	public MemberVO getDetail(String email) {
		
		return mdao.getDetail(email);
	}


	// 내정보 수저
	@Override
	public int modify(MemberDTO memberDTO) {
		int isUp = mdao.update(memberDTO.getMvo());
		if (memberDTO.getFList() != null) {
			if (isUp > 0 && memberDTO.getFList().size() > 0) {
				long mno = memberDTO.getMvo().getMno();
				for (FileVO fvo : memberDTO.getFList()) {
					fvo.setMno(mno);
					mfdao.deleteAllMemberFile(mno);
					isUp *= mfdao.insertMemberFile(fvo);
				}
			}
		}
		return isUp;
	}

	//회원탈퇴
	@Override
	public int remove(MemberVO mvo) {
	
		
		return mdao.delete(mvo);
	}

	//이메일 중복체크
	@Override
	public int dupleCheck(String email) {
		return mdao.selectExist(email);
	}
	
	// 비밀번호 변경
	@Override 
	public int modifyPwd(MemberVO mvo) {
		return mdao.modifyPwd(mvo);
	}

	//비밀번호 찾기
	@Override
	public MemberVO findPwd(MemberVO mvo) {
		return mdao.findPwd(mvo);
	}

	//페이징
	@Override
	public int getTotalCount(String email) {
		return mdao.selectOneOrderTotalCount(email);
	}

	// 구매내역 리스트
	@Override
	public List<OrderVO> getOrderList(String email, PagingVO pagingVO) {
		return mdao.selectListOrderPaging(email, pagingVO);
	}

	// 내정보
	@Override
	public MemberDTO getDetailMember(long mno) {
		List<FileVO> list = mfdao.selectListMemberFile(mno);
		for (FileVO fvo : list) {
			log.debug(fvo.toString());
		}
		return new MemberDTO(mdao.getDetailMember(mno), list);
	}

	//파일삭제(프로필이미지)
	@Override
	public int removeFile(String uuid) {
		long mno = mfdao.selectOneMno(uuid);
		int isDel = mfdao.deleteMemberFile(uuid);
		
		return isDel;
	}

	@Transactional
	@Override
	public void admin() {
		mdao.admin();
		mdao.adminAuthInit();
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}
	

}
