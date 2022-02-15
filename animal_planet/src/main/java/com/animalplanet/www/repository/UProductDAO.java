package com.animalplanet.www.repository;

import java.util.List;

import com.animalplanet.www.domain.UProductVO;

public interface UProductDAO {
	int insertUProduct(UProductVO upvo);
	List<UProductVO> selectNProductList();
	UProductVO selectOneNProduct(long upno);
	int updateNProduct(UProductVO upvo);
	int deleteProduct(long upno);
}
