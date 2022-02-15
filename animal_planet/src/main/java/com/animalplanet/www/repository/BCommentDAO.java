package com.animalplanet.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;

public interface BCommentDAO {
	int insertBComment(CommentVO cvo);
	List<CommentVO> selectListBComment(@Param("bno") long bno, @Param("pgvo") PagingVO pgvo);
	int selectOneBCommentTotalCount(long bno);
	int updateBComment(CommentVO cvo);
	int deleteOneBComment(long cno);
	int deleteAllBComment(long bno);
	long selectOneBno(long cno);
}
