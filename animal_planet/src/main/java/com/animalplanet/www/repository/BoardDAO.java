package com.animalplanet.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.animalplanet.www.domain.BoardDTO;
import com.animalplanet.www.domain.BoardVO;
import com.animalplanet.www.domain.PagingVO;

public interface BoardDAO {
	int insertBoard(BoardVO bvo);
	List<BoardVO> selectListBoard();
	BoardVO selectOneBoard(long bno);
	int updateBoard(BoardVO bvo);
	int deleteBoard(long bno);

	List<BoardDTO> selectListBoardImgPaging(PagingVO pagingvo);
	List<BoardVO> selectListBoardPaging(PagingVO pagingVO);
	List<BoardVO> selectListMyBoardPaging(@Param("nickName") String nickName, @Param("pgvo") PagingVO pagingVO);
	int selectOneTotalCount(PagingVO pagingVO);
	int selectOneMyTotalCount(@Param("nickName") String nickName, @Param("pgvo") PagingVO pagingVO);
	long selectOneBno();
	int updateBoardFileCount(@Param("bno") long bno, @Param("cnt") int cnt);
	void updateBoardReadCount(long bno);
	void updateBoardCmtQty(@Param("bno")long bno, @Param("cnt")int cnt);
}
