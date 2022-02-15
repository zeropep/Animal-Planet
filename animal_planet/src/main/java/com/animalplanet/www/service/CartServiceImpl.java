package com.animalplanet.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.animalplanet.www.domain.CartVO;
import com.animalplanet.www.repository.CartDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CartServiceImpl implements CartService {
	@Inject
	private CartDAO cadao;
	
	@Override
	public int register(CartVO cavo) {
		return cadao.insertCart(cavo);
	}

	@Override
	public List<CartVO> getList(String email) {
		return cadao.selectCart(email);
	}

	@Override
	public int modify(CartVO cavo) {
		return cadao.updateCartStock(cavo);
	}

	@Override
	public int remove(long cartno) {
		return cadao.deleteCart(cartno);
	}

}
