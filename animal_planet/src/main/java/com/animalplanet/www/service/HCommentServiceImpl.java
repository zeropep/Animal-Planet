package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.PagingHandler;
import com.animalplanet.www.repository.HCommentDAO;
import com.animalplanet.www.repository.HospitalDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HCommentServiceImpl implements HCommentService {
	@Inject
	private HCommentDAO cdao;

	@Override
	public int register(CommentVO cvo) {
		return cdao.insertHComment(cvo);
	}

	@Override
	public PagingHandler getList(long hno, PagingVO pgvo) {
		int totalCount = cdao.selectOneHCommentTotalCount(hno);
		PagingHandler phd = new PagingHandler(pgvo, totalCount, cdao.selectHCommentList(hno, pgvo));
		return phd;
	}

	@Override
	public int modify(CommentVO cvo) {
		return cdao.updateHComment(cvo);
	}

	@Transactional
	@Override
	public int remove(long cno) {
		return cdao.deleteHComment(cno);
	}
}
