package com.animalplanet.www.repository;

import java.util.List;

import com.animalplanet.www.domain.FileVO;

public interface BFileDAO {
	int insertBFile(FileVO bfvo);
	List<FileVO> selectListBFile(long bno);
	int deleteBFile(String uuid);
	int deleteAllBFile(long bno);
	long selectOneBno(String uuid);
	int selectOneFileCount(long bno);
	List<FileVO> selectListAllFiles();
}
