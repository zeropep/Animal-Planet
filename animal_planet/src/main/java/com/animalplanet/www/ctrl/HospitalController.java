package com.animalplanet.www.ctrl;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.PagingHandler;
import com.animalplanet.www.handler.test;
import com.animalplanet.www.service.HospitalService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/hospital/*")
@Controller
public class HospitalController {
	
	@Inject
	private HospitalService hsv;
	
	@GetMapping("/register")
	public String register(RedirectAttributes reAttr) throws Exception {
		test test = new test();
		test.insertTest(hsv);
		return "redirect:/";
	}
	
	// 합치게될때 지역선택창이 가게될 곳
	@GetMapping("/select")
	public void resion() {}
	
	@GetMapping("/nearme")
	public void getAllList(Model model) {
		model.addAttribute("list", hsv.getAllList());
	}
	
	@GetMapping("/list")
	public void getList(@RequestParam("opn") long opn, Model model, PagingVO pgvo) {
		log.debug(">>> opn {}", opn);
		log.debug(">>> keyword?? {}", pgvo.toString());
		model.addAttribute("list", hsv.getList(opn, pgvo));
		int totalCount = hsv.getTotalCount(opn, pgvo);
		model.addAttribute("opn", opn);
		model.addAttribute("pgn", new PagingHandler(pgvo, totalCount));
	}
	
	@GetMapping("/detail")
	public void getDetail(@RequestParam("hno") long hno, Model model, @ModelAttribute("pgvo") PagingVO pgvo) {
		model.addAttribute("hvo", hsv.getDetail(hno));
	}
}
