package com.animalplanet.www.ctrl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.animalplanet.www.domain.FileVO;
import com.animalplanet.www.domain.MemberDTO;
import com.animalplanet.www.domain.MemberVO;
import com.animalplanet.www.service.BoardService;
import com.animalplanet.www.service.MemberService;
import com.animalplanet.www.handler.PagingHandler;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.handler.FileHandler;
import com.animalplanet.www.handler.KakaoAPI;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/member/*")
@AllArgsConstructor
@Controller
@Slf4j

public class MemberController {
	private final FileHandler fhd;
	@Inject
	private JavaMailSender mailSender;
	@Inject
	private MemberService msv;
	@Inject
	private KakaoAPI kakaoApi;
	@Inject
	private BoardService bsv;
	

	// ????????????
	@GetMapping("/register")
	public void register() {
		log.debug(">>> /member/register - GET");
	}

	// ????????? ?????? ??????
		@ResponseBody
		@PostMapping(value = "/dupleCheck", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
		public ResponseEntity<String> dupleCheck(@RequestBody HashMap<String, String> map) {
			log.debug(">>> {}", map.get("email"));
			int isExist = msv.dupleCheck(map.get("email"));
			return isExist > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
					: new ResponseEntity<String>("0", HttpStatus.OK);
		}
	
	// ????????????
	@PostMapping("/register")
	public String register(MemberVO mvo, RedirectAttributes reAttr) {
		log.debug(">>> /member/reigster - POST");
		log.debug(">>> mvo > {}", mvo);
		String phone = mvo.getPhoneNumber();

		if (phone.length() == 10) {
			phone = phone.substring(0, 3) + "-" + phone.substring(3, 6) + "-" + phone.substring(6, 10);
		} else if (phone.length() == 11) {
			phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
		}
		mvo.setPhoneNumber(phone);
		int isUp = msv.register(mvo);
		log.debug(">>> Member Register > {}", isUp > 0 ? "Success" : "Fail");
		reAttr.addFlashAttribute("isUp", isUp);
		return "redirect:/";
	}

	// ????????? GET (????????? ??????)
	@GetMapping("/login")
	public void login() {
		log.debug(">>> /member/login - GET");
	}
	
	// ????????? POST
	@PostMapping("/login")
	public String login(MemberVO mvo, HttpSession ses, RedirectAttributes reAttr) {
		log.debug(">>> mvo > {}", mvo);
		MemberVO loginMvo = msv.login(mvo);
		if (loginMvo != null) {
			ses.setAttribute("ses", loginMvo);
			ses.setMaxInactiveInterval(10 * 60);
		}
		reAttr.addFlashAttribute("isLogin", ses.getAttribute("ses") != null ? 1 : 0);
		return "redirect:/";
	}
	

	// ????????????
	@GetMapping("/logout")
	public String logout(HttpSession ses, RedirectAttributes reAttr) {
		ses.removeAttribute("ses");
		reAttr.addFlashAttribute("isOut", ses.getAttribute("ses") == null ? 1 : 0);
		ses.invalidate();
		return "redirect:/";
	}

	// ???????????? ?????? (????????? ??????)
		@GetMapping("/findPwd")
		public void findPwd() {
			log.debug(">>> /member/findPwd - GET");
		}

		// ???????????? ??????
		@PostMapping("/findPwd")
		public String findPwd(@RequestParam("email") String email, @RequestParam("phoneNumber") String phoneNumber,
				MemberVO mvo, RedirectAttributes reAttr) {
			log.debug(">>> /member/findPwd - POST");
			log.debug(">>> email > {}", email);
			String phone = mvo.getPhoneNumber();

			if (phone.length() == 10) {
				phone = phone.substring(0, 3) + "-" + phone.substring(3, 6) + "-" + phone.substring(6, 10);
			} else if (phone.length() == 11) {
				phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
			}
			mvo.setPhoneNumber(phone);
			MemberVO findPwd = msv.findPwd(mvo);
			log.debug(">>>>>>>> findPwd > {} ", findPwd);
			if (findPwd != null) {

				String pwd = "";
				for (int i = 0; i < 12; i++) {
					pwd += (char) ((Math.random() * 26) + 97);
				}
				mvo.setEmail(email);
				mvo.setPwd(pwd);
				int isUp = msv.modifyPwd(mvo);
				log.debug(">>> Member modifyPwd > {}", isUp > 0 ? "Success" : "Fail");
				reAttr.addFlashAttribute("isUp", isUp);
				try {
					MimeMessage mimeMessage = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

					messageHelper.setFrom("animalplanetprj@gmail.com"); // ??????????????? ????????? ????????? google ???????????? ???????????? ???????????? ???????????????
					messageHelper.setTo(mvo.getEmail()); // ???????????? ?????????
					messageHelper.setSubject(" ?????????????????? ?????? ???????????? ?????? ??????"); // ????????????
					messageHelper.setText("???????????? ????????????????????? " + mvo.getPwd() + "?????????"); // ?????? ??????
					mailSender.send(mimeMessage);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
			return "redirect:/";
		}

	

		// ??????????????? -> ???????????? ?????? POST
		@PostMapping("/modifyPwdChange")
		public String modifyPwdChange(@RequestParam("email") String email, MemberVO mvo, RedirectAttributes reAttr,
				Model model, HttpServletRequest request) {

			model.addAttribute("email", mvo.getEmail());
			log.debug(">>> /member/modifyPwd - POST");
			log.debug(">>> mvo > {}", mvo);

			int isUp = msv.modifyPwd(mvo);
			log.debug(">>> Member modifyPwd > {}", isUp > 0 ? "Success" : "Fail");
			reAttr.addFlashAttribute("isUp", isUp);
			
			// ?????? ??????
			try {
				MimeMessage mimeMessage = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

				messageHelper.setFrom("rlaxogud4637@gmail.com"); // ??????????????? ????????? ????????? google ???????????? ???????????? ???????????? ???????????????
				messageHelper.setTo(mvo.getEmail()); // ???????????? ?????????
				messageHelper.setSubject(" ?????????????????? ???????????? ?????? ??????"); // ????????????
				messageHelper.setText("???????????? ????????? ??????????????? " + mvo.getPwd() + "?????????"); // ?????? ??????
				mailSender.send(mimeMessage);
			} catch (Exception e) {
				e.printStackTrace();
			}

			return "redirect:/member/detail?email=" + mvo.getEmail();
		}


	
	// ??????????????? ????????? / ?????? / ???????????? ?????? GET (????????? ??????)
	@GetMapping({"/detail", "/modify", "/modifyPwd"})
	public void detail(@RequestParam("email") String email, Model model) {
		log.debug(">>> email > {}", email);
		MemberVO mvo = msv.getDetail(email);
		long mno =mvo.getMno();
		
		log.debug(">>> {}", mvo);
		model.addAttribute("mno", mno);
		model.addAttribute("mvo", mvo);
		model.addAttribute("memberDTO", msv.getDetailMember(mno));
	}
	
	// ??????????????? ???????????? ??????
	@PostMapping("/modify")
	public String modify(MemberVO mvo, RedirectAttributes reAttr,@RequestParam(name = "files", required = false)MultipartFile[] files) {
		log.debug(">>> {}", mvo);
		List<FileVO> fList = null;
		
		if(files[0].getSize() > 0) {
			 fList = fhd.uploadFiles(files);
		}
		String phone = mvo.getPhoneNumber();

		if (phone.length() == 10) {
			phone = phone.substring(0, 3) + "-" + phone.substring(3, 6) + "-" + phone.substring(6, 10);
		} else if (phone.length() == 11) {
			phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7, 11);
		}
		mvo.setPhoneNumber(phone);
		reAttr.addFlashAttribute("isMod", msv.modify(new MemberDTO(mvo, fList)) > 0 ? "1":"0");
		
		return "redirect:/member/detail?email=" + mvo.getEmail();
	}
	
	// ????????? ????????? ?????? -> ??????
		@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
		public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){		
			return msv.removeFile(uuid) > 0 ? 
					new ResponseEntity<String>("1", HttpStatus.OK)
					: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	
	// ???????????? - ?????? ??? ?????? (?????? ??? ??? ????????? ??? ?????? ??????????????? ?????? ?????? ??????)
	@GetMapping("/remove")
	public String remove(@RequestParam("email") String email, MemberVO mvo,HttpSession ses, RedirectAttributes reAttr) {
		ses.removeAttribute("ses");
		ses.invalidate();
		int isDel = msv.remove(mvo);
		reAttr.addFlashAttribute("isDel", isDel > 0 ? 1 : 0);
		return "redirect:/";
	}
	
	@GetMapping("/kakaologin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession ses, RedirectAttributes reAttr) {
		log.debug("code : {}", code);
		String accessToken = kakaoApi.getAccessToken(code);
		HashMap<String, Object> userInfo = kakaoApi.getUserInfo(accessToken);

		log.debug("login_info : {}", userInfo.toString());

		if (userInfo.get("email") == null) {
			reAttr.addFlashAttribute("msg_kakao_login", 0);
			return "redirect:/member/login";
		}
		String email = userInfo.get("email").toString();
		
		
		// ????????? ???????????? ??????
		int isUp = msv.dupleCheck(email);
		
		// ??????????????? ????????? ????????????
//		String emptyPwd = "";
//		try {
//			emptyPwd = hash.bytesToHex(hash.sha256(""));
//		} catch (NoSuchAlgorithmException e) {
//			e.printStackTrace();
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
//		log.info("?????????????????????? {}", isUp > 0 ? "yes" : "no");
//		if (isUp < 1) {
//			msv.register(new MemberVO(email, "pwd", "name", "nickName", "phoneNumber", 
//										"isSocial", "address", "addressDetail"));
//		}
		
		// ??????????????????
//		MemberVO kakaoLoginMvo = msv.logInWithKakao(email);
//		if (kakaoLoginMvo != null) {
//			ses.setAttribute("ses", kakaoLoginMvo);
//			ses.setAttribute("access_token", accessToken);
//			ses.setMaxInactiveInterval(60 * 20);
//		}
		
//		if (uvo.getPwd().equals(emptyPwd)) {
//			req.getRequestDispatcher("/userCtrl/changePwd?email=" + email).forward(req, res);
//		} else {
//			req.getRequestDispatcher("/postCtrl/list").forward(req, res);				
//		}
		return "redirect:/";
	}
	
	@GetMapping("/kakaoUnlink")
	public void Unlink(HttpSession ses) {
		String accessToken = (String) ses.getAttribute("accessToken");
		kakaoApi.kakaoUnlink(accessToken);
	}
	

	// ?????? ??? ?????? -> ??? ????????? url ?????? 
	
	//???????????? ????????? - jsp ????????? ?????? ?????? 
	@GetMapping("/myorder")
	public void list(Model model, PagingVO pagingVO, @RequestParam("email") String email) {
		MemberVO mvo = msv.getDetail(email);
		
		model.addAttribute("mno", mvo.getMno());
		model.addAttribute("mvo", mvo);
		model.addAttribute("memberDTO", msv.getDetailMember(mvo.getMno()));
		
		model.addAttribute("list", msv.getOrderList(email, pagingVO));
		int totalCount = msv.getTotalCount(email);
		model.addAttribute("pgn", new PagingHandler(pagingVO, totalCount));
	}

	
	// ?????? ??? ??? ?????????
	@GetMapping("/myboard")
	public void boardList(@RequestParam("email") String email, Model model, PagingVO pagingVO) {
		MemberVO mvo = msv.getDetail(email);
		
		model.addAttribute("mno", mvo.getMno());
		model.addAttribute("mvo", mvo);
		model.addAttribute("memberDTO", msv.getDetailMember(mvo.getMno()));
		
		model.addAttribute("list", bsv.getMyList(mvo.getNickName(), pagingVO));
		int totalCount = bsv.getMyTotalCount(mvo.getNickName(), pagingVO);
		model.addAttribute("pgn", new PagingHandler(pagingVO, totalCount));
	}

	//????????????
	
	
	

}
