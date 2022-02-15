package com.animalplanet.www.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.animalplanet.www.domain.CartVO;
import com.animalplanet.www.service.CartService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/cart/*")
@Controller
public class CartController {
	@Inject
	private CartService casv;
	
	@PostMapping(value = "/post", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<String> cartInsert(@RequestBody CartVO cavo) {
		return casv.register(cavo) > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/list")
	public void cartList(@RequestParam("email") String email, Model model) {
		model.addAttribute("email", email);
	}
	
	@GetMapping(value = "/{email}", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<CartVO>> cartList(@PathVariable("email") String email) {
		return new ResponseEntity<List<CartVO>>(casv.getList(email), HttpStatus.OK);
	}
	
	@PutMapping(value = "/{cartno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> editStock(@PathVariable("cartno") long cartno, @RequestBody CartVO cavo) {
		return casv.modify(cavo) > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value = "/{cartno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> deleteCart(@PathVariable("cartno") long cartno) {
		return casv.remove(cartno) > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
