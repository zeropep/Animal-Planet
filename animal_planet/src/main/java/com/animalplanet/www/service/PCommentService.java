package com.animalplanet.www.service;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.PagingHandler;

public interface PCommentService {
	int register(CommentVO cvo);
	PagingHandler getList(long npno, PagingVO pgvo);
	int modify(CommentVO cvo);
	int remove(long cno);
}
