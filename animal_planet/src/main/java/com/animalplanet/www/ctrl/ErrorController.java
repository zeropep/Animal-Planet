package com.animalplanet.www.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/error/*")
@AllArgsConstructor
@Controller
public class ErrorController {
	
	@GetMapping("/error403")
	public void accessDenied() {}
}
