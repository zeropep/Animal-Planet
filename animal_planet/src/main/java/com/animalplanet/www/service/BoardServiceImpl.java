package com.animalplanet.www.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.animalplanet.www.domain.BoardDTO;
import com.animalplanet.www.domain.BoardVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.repository.BFileDAO;
import com.animalplanet.www.repository.BoardDAO;
import com.animalplanet.www.domain.FileVO;
import com.animalplanet.www.repository.BCommentDAO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@AllArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private BoardDAO bdao;
	private final BCommentDAO cdao;
	
	@Inject
	private BFileDAO bfdao;
	

	@Transactional
	@Override
	public int register(BoardDTO bdto) {
		int isUp = bdao.insertBoard(bdto.getBvo());
		if (isUp > 0 && bdto.getFList().size() > 0) {
			long bno = bdao.selectOneBno();
			for (FileVO bfvo : bdto.getFList()) {
				bfvo.setBno(bno);
				isUp *= bfdao.insertBFile(bfvo);
			}
		}
		return isUp;
	}

	@Override
	public List<BoardVO> getList() {
		return bdao.selectListBoard();
	}

	@Transactional
	@Override
	public BoardDTO getDetail(long bno) {
		bdao.updateBoardReadCount(bno);
		return new BoardDTO(bdao.selectOneBoard(bno), bfdao.selectListBFile(bno));
	}

	@Override
	public int modify(BoardDTO bdto) {
		int isUp = bdao.updateBoard(bdto.getBvo());
		if (bdto.getFList() != null) {
			if (isUp > 0 && bdto.getFList().size() > 0) {
				long bno = bdto.getBvo().getBno();
				for (FileVO bfvo : bdto.getFList()) {
					bfvo.setBno(bno);
					isUp *= bfdao.insertBFile(bfvo);
				}
			}
		}
		return isUp;
	}
	
	@Transactional
	@Override
	public int remove(long bno) {
		cdao.deleteAllBComment(bno);
		bfdao.deleteAllBFile(bno);
		return bdao.deleteBoard(bno);
	}

	@Override
	public List<BoardVO> getList(PagingVO pagingVO) {
		return bdao.selectListBoardPaging(pagingVO);
	}

	@Override
	public int getTotalCount(PagingVO pagingVO) {
		return bdao.selectOneTotalCount(pagingVO);
	}


	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public int removeFile(String uuid) {
		long bno = bfdao.selectOneBno(uuid);
		int isDel = bfdao.deleteBFile(uuid);
		return isDel;
	}

	@Override
	public List<BoardDTO> getlistWithImage(PagingVO pagingVO) {
		List<BoardDTO> dtoList = new ArrayList<BoardDTO>();
		List<BoardVO> bList = bdao.selectListBoardPaging(pagingVO);
		
		for (BoardVO bvo : bList) {
			BoardDTO bdto = new BoardDTO();
			bdto.setBvo(bvo);
			bdto.setFList(bfdao.selectListBFile(bvo.getBno()));
			dtoList.add(bdto);
		};
		return dtoList;
	}
	
	@Override
	public List<BoardVO> getMyList(String nickName, PagingVO pagingVO) {
		return bdao.selectListMyBoardPaging(nickName, pagingVO);
	}
	
	@Override
	public int getMyTotalCount(String nickName, PagingVO pagingVO) {
		return bdao.selectOneMyTotalCount(nickName, pagingVO);
	}

//	@Override
//	public int register(BoardVO bvo) {
//		return bdao.insertBoard(bvo);
//	}
//
//	@Override
//	public int modify(BoardVO bvo) {
//		return bdao.updateBoard(bvo);
//	}

}
