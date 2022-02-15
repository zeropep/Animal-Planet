package com.animalplanet.www.repository;

import java.util.List;

import com.animalplanet.www.domain.OrderVO;

public interface HistoryDAO {
	int insertHistory(OrderVO ovo);
	List<OrderVO> selectHistory(String email);
	int updateHistory(OrderVO ovo);
	int deleteHistory(long ohno);
}
