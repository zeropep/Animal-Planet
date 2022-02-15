package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.animalplanet.www.domain.OrderVO;
import com.animalplanet.www.repository.CartDAO;
import com.animalplanet.www.repository.HistoryDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HistoryServiceImpl implements HistoryService {
	@Inject
	private HistoryDAO hidao;
	
	@Inject
	private CartDAO cadao;
	
	@Override
	public int register(List<OrderVO> list) {
		int isUp = 0;
		for (OrderVO ovo : list) {
			ovo.setNpno(Long.valueOf(ovo.getNpno()));
			isUp *= hidao.insertHistory(ovo);
			isUp *= cadao.deleteCart(ovo.getCartno());
		}
		
		return isUp;
	}

	@Override
	public List<OrderVO> getList(String email) {
		return hidao.selectHistory(email);
	}

	@Override
	public int modify(OrderVO ovo) {
		return hidao.updateHistory(ovo);
	}

	@Override
	public int remove(long ohno) {
		return hidao.deleteHistory(ohno);
	}

}
