package com.animalplanet.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.animalplanet.www.domain.HospitalVO;
import com.animalplanet.www.domain.PagingVO;

public interface HospitalDAO {
	int insertHospital(HospitalVO hvo);
	List<HospitalVO> selectAllHospitalList();
	List<HospitalVO> selectHospitalList(@Param("opn") long opn, @Param("pgvo") PagingVO pgvo);
	HospitalVO selectOneHospital(long hno);
	int updateHospital(HospitalVO hvo);
	int deleteHospital(long hno);
	int selectTotalCount(@Param("opn") long opn, @Param("pgvo") PagingVO pgvo);
}
