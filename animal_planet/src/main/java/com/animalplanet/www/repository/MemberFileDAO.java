package com.animalplanet.www.repository;

import java.util.List;

import com.animalplanet.www.domain.FileVO;

public interface MemberFileDAO {
	int insertMemberFile(FileVO fvo);	
	int deleteMemberFile(String uuid);
	int deleteAllMemberFile(long mno);
	long selectOneMno(String uuid);
	int selectOneFileCount(long mno);
	List<FileVO> selectListAllFiles();
	List<FileVO> selectListMemberFile(long mno);
}
