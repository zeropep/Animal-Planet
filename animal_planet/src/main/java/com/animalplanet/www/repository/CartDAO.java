package com.animalplanet.www.repository;

import java.util.List;

import com.animalplanet.www.domain.CartVO;

public interface CartDAO {
	int insertCart(CartVO cavo);
	List<CartVO> selectCart(String email);
	int updateCartStock(CartVO cavo);
	int deleteCart(long cartno);
}
