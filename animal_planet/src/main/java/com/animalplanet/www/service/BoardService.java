package com.animalplanet.www.service;

import java.util.List;

import com.animalplanet.www.domain.BoardVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.domain.BoardDTO;

public interface BoardService {
	int register(BoardDTO bdto);
//	int register(BoardVO bvo);
	List<BoardVO> getList();
	BoardDTO getDetail(long bno);
	int modify(BoardDTO boardDTO);
//	int modify(BoardVO bvo);
	int remove(long bno);
	
	List<BoardDTO> getlistWithImage(PagingVO pagingVO);
	List<BoardVO> getList(PagingVO pagingVO);
	List<BoardVO> getMyList(String nickName, PagingVO pagingVO);
	int getTotalCount(PagingVO pagingVO);
	int getMyTotalCount(String nickName, PagingVO pagingVO);
	int removeFile(String uuid);
}
