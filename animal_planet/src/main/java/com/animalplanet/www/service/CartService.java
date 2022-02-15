package com.animalplanet.www.service;

import java.util.List;

import com.animalplanet.www.domain.CartVO;

public interface CartService {
	int register(CartVO cavo);
	List<CartVO> getList(String email);
	int modify(CartVO cavo);
	int remove(long cartno);
}
