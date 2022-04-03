package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.PagingHandler;
import com.animalplanet.www.repository.BCommentDAO;
import com.animalplanet.www.repository.BoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BCommentServiceImpl implements BCommentService {
	
	@Inject
	private BCommentDAO cdao;
	
	@Transactional
	@Override
	public int register(CommentVO cvo) {
		return cdao.insertBComment(cvo);
	}

	@Override
	public PagingHandler getList(long bno, PagingVO pgvo) {
		int totalCount = cdao.selectOneBCommentTotalCount(bno);
		List<CommentVO> list = cdao.selectListBComment(bno, pgvo);
		PagingHandler phd = new PagingHandler(pgvo, totalCount, list);
		return phd;
	}

	@Override
	public int modify(CommentVO cvo) {
		return cdao.updateBComment(cvo);
	}

	@Override
	public int remove(long cno) {
		return cdao.deleteOneBComment(cno);
	}

}
