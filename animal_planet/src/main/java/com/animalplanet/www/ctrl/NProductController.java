package com.animalplanet.www.ctrl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.animalplanet.www.domain.BoardDTO;
import com.animalplanet.www.domain.BoardVO;
import com.animalplanet.www.domain.FileVO;
import com.animalplanet.www.domain.NProductVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.domain.ProdDTO;
import com.animalplanet.www.handler.FileHandler;
import com.animalplanet.www.handler.PagingHandler;
import com.animalplanet.www.service.NProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/nproduct/*")
@Controller
public class NProductController {
	@Inject
	private NProductService npsv;
	
	@Inject
	private FileHandler fhd;
	
	@GetMapping("/register")
	public void register() {}
	
//	@PostMapping("/register")
//	public String register(NProductVO npvo, RedirectAttributes reAttr) {
//		reAttr.addFlashAttribute("isUp", npsv.register(npvo));
//		return "redirect:/nproduct/list";
//	}
	
	@PostMapping("/register")
	public String register(NProductVO npvo, RedirectAttributes reAttr, 
			@RequestParam(name = "image", required = false) String files) throws ParseException {
		log.debug(">>> {}", npvo.toString());
		JSONArray arr = new JSONArray();
		JSONParser parser = new JSONParser();
		arr = (JSONArray) parser.parse(files);
		
		List<FileVO> fList = new ArrayList<FileVO>();
		for (Object obj : arr) {
			JSONObject json = (JSONObject) obj;
			FileVO fvo = new FileVO();
			fvo.setUuid(json.get("uuid").toString());
			fvo.setSaveDir(json.get("saveDir").toString());
			fvo.setFileName(json.get("fileName").toString());
			fvo.setFileType(Integer.parseInt(json.get("fileType").toString()));
			fvo.setFileSize(Long.parseLong(json.get("fileSize").toString()));
			fList.add(fvo);
		}
		reAttr.addFlashAttribute("isUp", npsv.register(new ProdDTO(npvo, fList)) > 0 ? "1" : "0");
		return "redirect:/nproduct/list";
	}
	
	@PostMapping("/image")
	public ResponseEntity<FileVO> image(@RequestParam(name = "file", required = false)MultipartFile file) throws IOException {
		FileVO fvo = fhd.summernoteImage(file);
		return new ResponseEntity<FileVO>(fvo, HttpStatus.OK);
	}
	
	@GetMapping("/list")
	public void getList(Model model, PagingVO pgvo) {
		log.debug(pgvo.toString());
		model.addAttribute("list", npsv.getList(pgvo));
		int totalCount = npsv.getTotalCount(pgvo);
		model.addAttribute("pgn", new PagingHandler(pgvo, totalCount));
	}
	
	@GetMapping("/detail")
	public void detail(@RequestParam("npno") long npno, Model model, @ModelAttribute("pgvo") PagingVO pgvo) {
		model.addAttribute("pdto", npsv.getDetail(npno));
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("npno") long npno, Model model, @ModelAttribute("pgvo") PagingVO pgvo) {
		model.addAttribute("pdto", npsv.selectForMod(npno));
	}
	
	@PostMapping("/modify")
	public String modify(NProductVO npvo, RedirectAttributes reAttr, PagingVO pgvo, 
			@RequestParam(name = "image", required = false)String files) throws ParseException {
		JSONArray arr = new JSONArray();
		JSONParser parser = new JSONParser();
		arr = (JSONArray) parser.parse(files);
		
		List<FileVO> fList = new ArrayList<FileVO>();
		for (Object obj : arr) {
			JSONObject json = (JSONObject) obj;
			FileVO fvo = new FileVO();
			fvo.setUuid(json.get("uuid").toString());
			fvo.setSaveDir(json.get("saveDir").toString());
			fvo.setFileName(json.get("fileName").toString());
			fvo.setFileType(Integer.parseInt(json.get("fileType").toString()));
			fvo.setFileSize(Long.parseLong(json.get("fileSize").toString()));
			fList.add(fvo);
		}
		reAttr.addFlashAttribute("isMod", npsv.modify(new ProdDTO(npvo, fList)) > 0 ? "1" : "0");
		reAttr.addAttribute("pageNo", pgvo.getPageNo());		
		reAttr.addAttribute("qty", pgvo.getQty());
		reAttr.addAttribute("type", pgvo.getType());		
		reAttr.addAttribute("keyword", pgvo.getKeyword());
		
		return "redirect:/nproduct/detail?npno="+npvo.getNpno();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("npno") long npno, RedirectAttributes reAttr, PagingVO pgvo) {
		reAttr.addFlashAttribute("isDel", npsv.remove(npno));
		reAttr.addAttribute("pageNo", pgvo.getPageNo());
		reAttr.addAttribute("qty", pgvo.getQty());
		reAttr.addAttribute("type", pgvo.getType());
		reAttr.addAttribute("keyword", pgvo.getKeyword());
		return "redirect:/nproduct/list?category1 = Dog";
	}
	
	@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable("uuid") String uuid) {
		return npsv.removeFile(uuid) > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
