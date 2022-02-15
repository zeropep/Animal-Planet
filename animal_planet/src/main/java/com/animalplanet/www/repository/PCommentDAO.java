package com.animalplanet.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;

public interface PCommentDAO {
	int insertPComment(CommentVO cvo);
	List<CommentVO> selectListPComment(@Param("npno") long npno, @Param("pgvo") PagingVO pgvo);
	int selectOnePCommentTotalCount(long npno);
	int updatePComment(CommentVO cvo);
	int deleteOnePComment(long cno);
	int deleteAllPComment(long npno);
	long selectOnePno(long cno);
}
