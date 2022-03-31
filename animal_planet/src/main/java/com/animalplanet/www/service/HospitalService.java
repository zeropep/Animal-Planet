package com.animalplanet.www.service;

import java.util.List;

import com.animalplanet.www.domain.HospitalVO;
import com.animalplanet.www.domain.PagingVO;

public interface HospitalService {
	int register(HospitalVO hvo);
	List<HospitalVO> getAllList();
	List<HospitalVO> getList(long opn, PagingVO pgvo);
	HospitalVO getDetail(long hno);
	int modify(HospitalVO hvo);
	int remove(long hno);
	int getTotalCount(long opn, PagingVO pgvo);
	HospitalVO getDetailByMgtno(String mgtno);
	int update(HospitalVO hvo);
}
