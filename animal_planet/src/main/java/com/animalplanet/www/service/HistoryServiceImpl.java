package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.animalplanet.www.domain.OrderVO;
import com.animalplanet.www.repository.CartDAO;
import com.animalplanet.www.repository.HistoryDAO;
import com.animalplanet.www.repository.NProductDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HistoryServiceImpl implements HistoryService {
	@Inject
	private HistoryDAO hidao;
	
	@Inject
	private CartDAO cadao;
	
	@Inject
	private NProductDAO npdao;
	
	@Transactional
	@Override
	public int register(List<OrderVO> list) {
		int isUp = 1;
		for (OrderVO ovo : list) {
			ovo.setNpno(Long.valueOf(ovo.getNpno()));
			isUp *= hidao.insertHistory(ovo);
			isUp *= cadao.deleteCart(ovo.getCartno());
			isUp *= npdao.reduceStock(ovo);
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
