package com.animalplanet.www.ctrl;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	private BCryptPasswordEncoder bcpEncoder;
	@Inject
	private JavaMailSender mailSender;
	@Inject
	private MemberService msv;
	@Inject
	private KakaoAPI kakaoApi;
	@Inject
	private BoardService bsv;
	

	// 회원가입
	@GetMapping("/register")
	public void register() {
		log.debug(">>> /member/register - GET");
	}

	// 이메일 중복 검사
		@ResponseBody
		@PostMapping(value = "/dupleCheck", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
		public ResponseEntity<String> dupleCheck(@RequestBody HashMap<String, String> map) {
			log.debug(">>> {}", map.get("email"));
			int isExist = msv.dupleCheck(map.get("email"));
			return isExist > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
					: new ResponseEntity<String>("0", HttpStatus.OK);
		}
	
	// 회원가입
	@PostMapping("/register")
	public String register(MemberVO mvo, RedirectAttributes reAttr) {
		log.debug(">>> /member/reigster - POST");
		log.debug(">>> mvo > {}", mvo);
		mvo.setPwd(bcpEncoder.encode(mvo.getPwd()));
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

	// 로그인 GET (페이지 이동)
	@GetMapping("/login")
	public void login() {
		log.debug(">>> /member/login - GET");
	}
	
	// 로그인 POST
	@PostMapping("/login")
	public String login(HttpServletRequest req, RedirectAttributes reAttr) {
		reAttr.addFlashAttribute("email", req.getAttribute("email"));
		reAttr.addFlashAttribute("errMsg", req.getAttribute("errMsg"));
		return "redirect:/member/login";
//		log.debug(">>> mvo > {}", mvo);
//		MemberVO loginMvo = msv.login(mvo);
//		if (loginMvo != null) {
//			ses.setAttribute("ses", loginMvo);
//			ses.setMaxInactiveInterval(10 * 60);
//			return "redirect:/";
//		} else {
//			reAttr.addFlashAttribute("isLogin", 1);
//			return "redirect:/member/login";
//		}
	}
	

	// 로그아웃
//	@GetMapping("/logout")
//	public String logout(HttpSession ses, RedirectAttributes reAttr) {
//		ses.removeAttribute("ses");
//		reAttr.addFlashAttribute("isOut", ses.getAttribute("ses") == null ? 1 : 0);
//		ses.invalidate();
//		return "redirect:/";
//	}

	// 비밀번호 찾기 (페이지 이동)
		@GetMapping("/findPwd")
		public void findPwd() {
			log.debug(">>> /member/findPwd - GET");
		}

	// 비밀번호 찾기
	@PostMapping("/findPwd")
	public String findPwd(MemberVO mvo, RedirectAttributes reAttr) {
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
			mvo.setPwd(bcpEncoder.encode(pwd));
			int isUp = msv.modifyPwd(mvo);
			log.debug(">>> Member modifyPwd > {}", isUp > 0 ? "Success" : "Fail");
			reAttr.addFlashAttribute("isUp", isUp);
			try {
				MimeMessage mimeMessage = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

				messageHelper.setFrom("animalplanetprj@gmail.com"); // 보내는사람 이메일 여기선 google 메일서버 사용하는 아이디를 작성하면됨
				messageHelper.setTo(mvo.getEmail()); // 받는사람 이메일
				messageHelper.setSubject(" 애니멀플래닛 임시 비밀번호 발급 안내"); // 메일제목
				messageHelper.setText("회원님의 임시비밀번호는 " + pwd + "입니다"); // 메일 내용
				mailSender.send(mimeMessage);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			return "redirect:/member/findPwd";
		}
		return "redirect:/";
	}

	// 비밀번호 확인
	@PostMapping(value = "/pwdCheck", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> pwdCheck(@RequestBody MemberVO mvo, HttpServletRequest request) {
		HttpSession ses = request.getSession();
		MemberVO loggedInUser = (MemberVO) ses.getAttribute("ses");
		if (bcpEncoder.matches(mvo.getPwd(), loggedInUser.getPwd())) {
			return new ResponseEntity<String>("1", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 마이페이지 -> 비밀번호 변경 POST
	@PostMapping("/modifyPwdChange")
	public String modifyPwdChange(MemberVO mvo, RedirectAttributes reAttr,
									Model model, HttpServletRequest request) {
		String userPwd = mvo.getPwd();
		model.addAttribute("email", mvo.getEmail());

		mvo.setPwd(bcpEncoder.encode(mvo.getPwd()));
		int isUp = msv.modifyPwd(mvo);
		log.debug(">>> Member modifyPwd > {}", isUp > 0 ? "Success" : "Fail");
		reAttr.addFlashAttribute("isUp", isUp);
		
		// 메일 발송
		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

			messageHelper.setFrom("animalplanet1224@gmail.com"); // 보내는사람 이메일 여기선 google 메일서버 사용하는 아이디를 작성하면됨
			messageHelper.setTo(mvo.getEmail()); // 받는사람 이메일
			messageHelper.setSubject(" 애니멀플래닛 비밀번호 변경 안내"); // 메일제목
			messageHelper.setText("회원님의 변경된 비밀번호는 " + userPwd + "입니다"); // 메일 내용
			mailSender.send(mimeMessage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/member/detail?email=" + mvo.getEmail();
	}


	
	// 마이페이지 내정보 / 수정 / 비밀번호 변경 GET (페이지 이동)
	@GetMapping({"/detail", "/modify", "/modifyPwd"})
	public void detail(@RequestParam("email") String email, HttpServletRequest request, Model model) {
		HttpSession ses = request.getSession();
		MemberVO loggedInUser = (MemberVO) ses.getAttribute("ses");
		if (!email.equals(loggedInUser.getEmail())) {
			email = loggedInUser.getEmail();
		}
		MemberVO mvo = msv.getDetail(email);
		long mno =mvo.getMno();
		
		log.debug(">>> {}", mvo);
		model.addAttribute("mno", mno);
		model.addAttribute("mvo", mvo);
		model.addAttribute("memberDTO", msv.getDetailMember(mno));
	}
	
	// 마이페이지 회원정보 수정
	@PostMapping("/modify")
	public String modify(MemberVO mvo, RedirectAttributes reAttr, HttpSession ses, @RequestParam(name = "files", required = false)MultipartFile[] files) {
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
		int modify = msv.modify(new MemberDTO(mvo, fList));
		if (modify > 0) {
			ses.setAttribute("ses", mvo);
		}
		reAttr.addFlashAttribute("isMod", modify > 0 ? "1":"0");
		
		return "redirect:/member/detail?email=" + mvo.getEmail();
	}
	
	// 프로필 이미지 수정 -> 삭제
		@DeleteMapping(value = "/file/{uuid}", produces = MediaType.TEXT_PLAIN_VALUE)
		public ResponseEntity<String> removeFile(@PathVariable("uuid")String uuid){		
			return msv.removeFile(uuid) > 0 ? 
					new ResponseEntity<String>("1", HttpStatus.OK)
					: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
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
		
		
		// 기존의 회원인지 체크
		int isUp = msv.dupleCheck(email);
		
		// 기존회원이 아니면 레지스터
//		String emptyPwd = "";
//		try {
//			emptyPwd = hash.bytesToHex(hash.sha256(""));
//		} catch (NoSuchAlgorithmException e) {
//			e.printStackTrace();
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
//		log.info("기존회원인가요? {}", isUp > 0 ? "yes" : "no");
//		if (isUp < 1) {
//			msv.register(new MemberVO(email, "pwd", "name", "nickName", "phoneNumber", 
//										"isSocial", "address", "addressDetail"));
//		}
		
		// 로그인시키기
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
	

	// 합친 후 구현 -> 각 페이지 url 필요 
	
	//구매내역 리스트 - jsp 페이지 작업 필요 
	@GetMapping("/myorder")
	public void list(Model model, PagingVO pagingVO, HttpServletRequest request, @RequestParam("email") String email) {
		HttpSession ses = request.getSession();
		MemberVO loggedInUser = (MemberVO) ses.getAttribute("ses");
		if (!email.equals(loggedInUser.getEmail())) {
			email = loggedInUser.getEmail();
		}
		MemberVO mvo = msv.getDetail(email);
		
		model.addAttribute("mno", mvo.getMno());
		model.addAttribute("mvo", mvo);
		model.addAttribute("memberDTO", msv.getDetailMember(mvo.getMno()));
		
		model.addAttribute("list", msv.getOrderList(email, pagingVO));
		int totalCount = msv.getTotalCount(email);
		model.addAttribute("pgn", new PagingHandler(pagingVO, totalCount));
	}

	
	// 내가 쓴 글 리스트
	@GetMapping("/myboard")
	public void boardList(@RequestParam("email") String email, HttpServletRequest request, Model model, PagingVO pagingVO) {
		HttpSession ses = request.getSession();
		MemberVO loggedInUser = (MemberVO) ses.getAttribute("ses");
		if (!email.equals(loggedInUser.getEmail())) {
			email = loggedInUser.getEmail();
		}
		MemberVO mvo = msv.getDetail(email);
		
		model.addAttribute("mno", mvo.getMno());
		model.addAttribute("mvo", mvo);
		model.addAttribute("memberDTO", msv.getDetailMember(mvo.getMno()));
		
		model.addAttribute("list", bsv.getMyList(mvo.getNickName(), pagingVO));
		int totalCount = bsv.getMyTotalCount(mvo.getNickName(), pagingVO);
		model.addAttribute("pgn", new PagingHandler(pagingVO, totalCount));
	}

	// 
	@GetMapping("/resign")
	public void remove(@RequestParam("email") String email, HttpServletRequest request, Model model) {
		HttpSession ses = request.getSession();
		MemberVO loggedInUser = (MemberVO) ses.getAttribute("ses");
		if (!email.equals(loggedInUser.getEmail())) {
			email = loggedInUser.getEmail();
		}
		MemberVO mvo = msv.getDetail(email);
		long mno =mvo.getMno();
		
		log.debug(">>> {}", mvo);
		model.addAttribute("mno", mno);
		model.addAttribute("mvo", mvo);
		model.addAttribute("memberDTO", msv.getDetailMember(mno));
	}
	
	// 계정탈퇴 - 회의 후 수정 (탈퇴 시 각 게시판 글 내용 삭제여부에 따라 변경 필요)
	@PostMapping("/resign")
	public String remove(MemberVO mvo, HttpServletRequest request, RedirectAttributes reAttr) {
		HttpSession ses = request.getSession();
		ses.removeAttribute("ses");
		ses.invalidate();
		int isDel = msv.remove(mvo);
		reAttr.addFlashAttribute("isDel", isDel > 0 ? 1 : 0);
		return "redirect:/";
	}
	
	@GetMapping("/admin")
	public String admin(@RequestParam("code") String code, RedirectAttributes reAttr) {
		if (code.equals("ANIMALADMINGENERATOR3306")) {
			msv.admin();
		}
		return "redirect:/";
	}

}
