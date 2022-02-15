package com.animalplanet.www.service;

import java.util.List;

import com.animalplanet.www.domain.NProductVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.domain.ProdDTO;

public interface NProductService {
	int register(ProdDTO dto);
	List<NProductVO> getList();
	ProdDTO getDetail(long npno);
	ProdDTO selectForMod(long npno);
	int modify(ProdDTO dto);
	int remove(long npno);
	
	List<ProdDTO> getList(PagingVO pgvo);
	int getTotalCount(PagingVO pgvo);
	int removeFile(String uuid);
}
