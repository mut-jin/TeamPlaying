package com.example.teamplaying.controller;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.service.MemberService;
import com.example.teamplaying.service.ShoeBoardService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
public class MainController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private ShoeBoardService shoeBoardService;

	@GetMapping("checkEmail/{email}")
	@ResponseBody
	public Map<String, Object> checkEmail(@PathVariable("email") String email) {
		return memberService.checkEmail(email);
	}

	@GetMapping("checkNickName/{nickName}")
	@ResponseBody
	public Map<String, Object> checkNickName(@PathVariable("nickName") String nickName) {
		return memberService.checkNickName(nickName);
	}

	@GetMapping("IDCheck/{userId}")
	@ResponseBody
	public Map<String, Object> checkId(@PathVariable("userId") String id) {

		return memberService.IDCheck(id);
	}

	@GetMapping({ "/", "main" })
	public void main() {

	}

	// 서재권 작업 내용***********************
	@GetMapping("login")
	public void loginForm() {

	}

	@GetMapping("signup")
	public void signupForm() {

	}

	@PostMapping("signup")
	public String signupProcess(Member member, RedirectAttributes rttr) {

		try {
			memberService.signup(member);
			// 정보 제공을 위한 것
			rttr.addFlashAttribute("member", member);
			// alert를 위한 것
			rttr.addFlashAttribute("message", "회원 가입되었습니다 ⭕⭕");
			return "redirect:/login";

		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("member", member);
			rttr.addFlashAttribute("message", "회원 가입 실패 ❌❌");
			return "redirect:/main";
		}
	}

	@GetMapping("list")
	public void list(Model model) {
		List<Member> list = memberService.listMember();
		model.addAttribute("memberList", list);
	}

	// 경로 : /member/info?userid=asdf
	@GetMapping("info")
	public void info(String userId, Model model) {
		Member member = memberService.get(userId);
		System.out.println(member);
		model.addAttribute("member", member);
	}

	@GetMapping("totalMyPage")
	public void myapge(Authentication authentication, Model model) {
		Member member = memberService.get(authentication.getName());
		System.out.println(member);
		model.addAttribute("member", member);
	}

	@GetMapping("modify")
	public void modifyForm(Authentication authentication, Model model) {
		Member member = memberService.get(authentication.getName());
		model.addAttribute("member", member);
	}

	// 2.
	@PostMapping("modify")
	public String modifyProcess(Member member, RedirectAttributes rttr) {
		boolean ok = memberService.modify(member);

		if (ok) {
			rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
			return "redirect:/info?userId=" + member.getUserId();
		} else {
			rttr.addFlashAttribute("message", "회원 정보시 문제가 발생했습니다.");
			return "redirect:/modify?userId=" + member.getUserId();
		}
	}

	@GetMapping("welcomeMain")
	public void welcomMain() {

	}

	@PostMapping("remove")
	public String remove(Member member, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		boolean ok = memberService.remove(member);
		if (ok) {
			request.logout();
			rttr.addFlashAttribute("message", "회원 탈퇴하였습니다.");
		} else {
			rttr.addFlashAttribute("message", "회원 탈퇴시 문제가 발생하였습니다.");
		}
		return "redirect:/main";
	}

	@GetMapping("artist")
	public void artist(Model model,
					   @RequestParam(value = "page", defaultValue = "1") Integer page,
					   @RequestParam(value = "search", defaultValue = "") String search,
					   @RequestParam(value = "type", required = false) String type,
					   @RequestParam(value = "name", defaultValue = "선택") String name,
					   @RequestParam(value = "order", defaultValue = "id") String order) {
		Map<String, Object> result = memberService.getArtistBoard(page, search, type, order, name);

		model.addAllAttributes(result);

	}@GetMapping("work")
	public void work(Model model,
					 @RequestParam(value = "page", defaultValue = "1") Integer page,
					 @RequestParam(value = "search", defaultValue = "") String search,
					 @RequestParam(value = "type", required = false) String type) {
		Map<String, Object> result = shoeBoardService.getshoeBoard(page, search, type);

		model.addAllAttributes(result);
	}

	@GetMapping("artist/{id}")
	public String artistPage(Model model,
							 @PathVariable Integer id,
							 @RequestParam(value = "page", defaultValue = "1") Integer page) {
		Map<String, Object> result = memberService.getMember(id, page);
		model.addAllAttributes(result);
		return "artistPage";
	}


	@GetMapping("workadd")
	public void workadd() {

	}

	@GetMapping("/getShoeModels")
	public ResponseEntity<List<String>> getShoeModels(@RequestParam String brand) {
		List<String> shoeModels = shoeBoardService.getShoeModelsByBrand(brand);
		return ResponseEntity.ok(shoeModels);
	}


//	@GetMapping("workadd/shoeBrand")
//	public Map<String, Object> shoeBrand(String shoeBrand) {
//		Map<String, Object> map = new HashMap<>();
//		map.put("shoeNameList", shoeBoardService.getShoeNameList(shoeBrand));
//		return map;
//	}


	@GetMapping("canvas")
	public void canvas() {

	}

	@GetMapping("cs")
	public void cs() {

	}

}