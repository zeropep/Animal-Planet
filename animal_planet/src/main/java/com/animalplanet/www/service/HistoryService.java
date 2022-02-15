package com.animalplanet.www.service;

import java.util.List;

import com.animalplanet.www.domain.OrderVO;

public interface HistoryService {
	int register(List<OrderVO> list);
	List<OrderVO> getList(String email);
	int modify(OrderVO ovo);
	int remove(long ohno);
}
