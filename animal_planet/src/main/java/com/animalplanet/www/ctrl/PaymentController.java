package com.animalplanet.www.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.animalplanet.www.domain.CartVO;
import com.animalplanet.www.domain.OrderVO;
import com.animalplanet.www.service.CartService;
import com.animalplanet.www.service.HistoryService;
import com.animalplanet.www.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/payment/*")
@Controller
public class PaymentController {
	@Inject
	private MemberService msv;
	
	@Inject
	private CartService casv;
	
	@Inject
	private HistoryService hisv;
	
	@GetMapping("/before")
	public void before(@RequestParam("email") String email, Model model,
			@RequestParam("direct") String direct) {
		model.addAttribute("email", email);
		model.addAttribute("mvo", msv.getDetail(email));
		model.addAttribute("direct", direct);
		List<CartVO> list = casv.getList(email);
		int total = 0;
		if (direct.equals("yes")) {
			total = list.get(list.size() - 1).getPrice() * list.get(list.size() - 1).getCartStock();
		} else {
			for (CartVO cavo : list) {
				total += cavo.getPrice() * cavo.getCartStock();
			}
		}
		model.addAttribute("total", total);
	}
	
	@GetMapping("/after")
	public void after() {}
	
	@GetMapping(value = "/{email}", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<CartVO>> getCustomer(@PathVariable("email") String email) {
		return new ResponseEntity<List<CartVO>>(casv.getList(email), HttpStatus.OK);
	}
	
	@PostMapping(value = "/insert", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(@RequestBody List<OrderVO> list) {
		log.debug(list.get(0).toString());
		return hisv.register(list) > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
