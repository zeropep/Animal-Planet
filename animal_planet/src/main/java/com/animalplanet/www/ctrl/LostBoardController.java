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
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.FileHandler;
import com.animalplanet.www.handler.PagingHandler;
import com.animalplanet.www.repository.BoardDAO;
import com.animalplanet.www.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/lostboard/*")
@AllArgsConstructor
@Controller
public class LostBoardController {
	private final BoardService bsv;
	private final FileHandler fhd;
	
	@Inject
	private BoardDAO bdao;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(BoardVO bvo, RedirectAttributes reAttr,
			@RequestParam(name = "image", required = false)String files) throws ParseException{
		log.debug(">>> {}", bvo.toString());
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
		reAttr.addFlashAttribute("isUp", bsv.register(new BoardDTO(bvo, fList)) > 0 ? "1":"0");
		return "redirect:/lostboard/list?bCate=lost";
	}

	@PostMapping("/image")
	public ResponseEntity<FileVO> image(@RequestParam(name = "file", required = false)MultipartFile file) throws IOException {
		FileVO fvo = fhd.summernoteImage(file);
		return new ResponseEntity<FileVO>(fvo, HttpStatus.OK);
	}
	
	@GetMapping("/list")
	public void list(Model model, PagingVO pagingVO) {
		model.addAttribute("list",bsv.getlistWithImage(pagingVO));
		int totalCount = bsv.getTotalCount(pagingVO);
		model.addAttribute("pgn", new PagingHandler(pagingVO, totalCount));
	}
	
	@GetMapping({"/detail"})
	public void detail(Model model, @RequestParam("bno")long bno,
			@ModelAttribute("pgvo")PagingVO pgvo) {
		BoardDTO bdto = bsv.getDetail(bno);
		log.debug(bdto.getBvo().toString());
		model.addAttribute("bdto", bdto);
	}
	
	@GetMapping({"/modify"})
	public void modify(Model model, @RequestParam("bno")long bno,
			@ModelAttribute("pgvo")PagingVO pgvo) {
		model.addAttribute("bdto", bsv.getDetail(bno));
	}
	
	@PostMapping("/modify")
	public String modify(RedirectAttributes reAttr, BoardVO bvo, PagingVO pgvo,
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
		reAttr.addFlashAttribute("isMod", bsv.modify(new BoardDTO(bvo, fList)) > 0 ? "1":"0");
		reAttr.addAttribute("pageNo", pgvo.getPageNo());		
		reAttr.addAttribute("qty", pgvo.getQty());
		reAttr.addAttribute("type", pgvo.getType());		
		reAttr.addAttribute("keyword", pgvo.getKeyword());
		
		return "redirect:/lostboard/detail?bno="+bvo.getBno();
	}

	@PostMapping("/remove")
	public String remove(RedirectAttributes reAttr, @RequestParam("bno")long bno, 
			PagingVO pgvo) {
		reAttr.addFlashAttribute("isDel", bsv.remove(bno) > 0 ? "1":"0");
		reAttr.addAttribute("pageNo", pgvo.getPageNo());		
		reAttr.addAttribute("qty", pgvo.getQty());
		reAttr.addAttribute("type", pgvo.getType());		
		reAttr.addAttribute("keyword", pgvo.getKeyword());
		return "redirect:/parcelboard/list?bCate=parcel";
	}

	@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){		
		return bsv.removeFile(uuid) > 0 ? 
				new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
