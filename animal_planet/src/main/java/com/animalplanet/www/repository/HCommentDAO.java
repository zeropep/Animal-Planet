package com.animalplanet.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.animalplanet.www.domain.CommentVO;
import com.animalplanet.www.domain.PagingVO;


public interface HCommentDAO {
	int insertHComment(CommentVO cvo);
	List<CommentVO> selectHCommentList(@Param("hno") long hno, @Param("pgvo") PagingVO pgvo);
	int updateHComment(CommentVO cvo);
	int deleteHComment(long cno);
	int deleteAllHComment(long pno);
	long selectOneHComment(long cno); 
	int selectOneHCommentTotalCount(long hno);
}
