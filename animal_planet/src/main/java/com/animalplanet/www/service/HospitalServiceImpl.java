package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.animalplanet.www.domain.HospitalVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.repository.HospitalDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HospitalServiceImpl implements HospitalService {
	@Inject
	private HospitalDAO hdao;
	
	@Override
	public int register(HospitalVO hvo) {
		return hdao.insertHospital(hvo);
	}

	@Override
	public List<HospitalVO> getAllList() {
		return hdao.selectAllHospitalList();
	}

	@Override
	public List<HospitalVO> getList(long opn, PagingVO pgvo) {
		return hdao.selectHospitalList(opn, pgvo);
	}

	@Override
	public HospitalVO getDetail(long hno) {
		return hdao.selectOneHospital(hno);
	}

	@Override
	public int modify(HospitalVO hvo) {
		return hdao.updateHospital(hvo);
	}

	@Override
	public int remove(long hno) {
		return hdao.deleteHospital(hno);
	}

	@Override
	public int getTotalCount(long opn, PagingVO pgvo) {
		return hdao.selectTotalCount(opn, pgvo);
	}

}
