package com.animalplanet.www.repository;

import java.util.List;

import com.animalplanet.www.domain.NProductVO;
import com.animalplanet.www.domain.PagingVO;

public interface NProductDAO {
	int insertNProduct(NProductVO npvo);
	List<NProductVO> selectNProductList();
	NProductVO selectOneNProduct(long npno);
	int updateNProduct(NProductVO npvo);
	int deleteProduct(long npno);
	
	List<NProductVO> selectProductListPaging(PagingVO pgvo);
	int selectOneTotalCount(PagingVO pgvo);
	long selectOnePno();
}
