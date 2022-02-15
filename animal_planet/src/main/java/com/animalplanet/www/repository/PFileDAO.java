package com.animalplanet.www.repository;

import java.util.List;

import com.animalplanet.www.domain.FileVO;

public interface PFileDAO {
	int insertPFile(FileVO pfvo);
	List<FileVO> selectListPFile(long npno);
	int deletePFile(String uuid);
	int deleteAllPFile(long npno);
	long selectOnePno(String uuid);
	int selectOneFileCount(long npno);
	List<FileVO> selectListAllFiles();
}
