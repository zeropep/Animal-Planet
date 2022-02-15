package com.animalplanet.www.service;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.PagingHandler;

public interface HCommentService {
	int register(CommentVO cvo);
	PagingHandler getList(long hno, PagingVO pgvo);
	int modify(CommentVO cvo);
	int remove(long cno);
}
