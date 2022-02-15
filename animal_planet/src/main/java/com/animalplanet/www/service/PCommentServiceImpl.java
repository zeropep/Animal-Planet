package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.PagingHandler;
import com.animalplanet.www.repository.PCommentDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PCommentServiceImpl implements PCommentService {
	@Inject
	private PCommentDAO cdao;

	@Override
	public int register(CommentVO cvo) {
		return cdao.insertPComment(cvo);
	}

	@Override
	public PagingHandler getList(long npno, PagingVO pgvo) {
		int totalCount = cdao.selectOnePCommentTotalCount(npno);
		PagingHandler phd = new PagingHandler(pgvo, totalCount, cdao.selectListPComment(npno, pgvo));
		return phd;
	}

	@Override
	public int modify(CommentVO cvo) {
		return cdao.updatePComment(cvo);
	}

	@Transactional
	@Override
	public int remove(long cno) {
		return cdao.deleteOnePComment(cno);
	}
}
