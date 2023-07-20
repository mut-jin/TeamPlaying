package com.example.teamplaying.controller;

import com.example.teamplaying.domain.CsBoard;
import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.service.CsService;
import com.example.teamplaying.service.MemberService;
import com.example.teamplaying.service.ShoeBoardService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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

    @Autowired
    private CsService csService;

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

    @GetMapping({"/", "main"})
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
                       @RequestParam(value = "name", defaultValue = "선택") String name,
                       @RequestParam(value = "order", defaultValue = "id") String order) {
        Map<String, Object> result = memberService.getArtistBoard(page, search, order, name);

        model.addAllAttributes(result);

    }

    @GetMapping("workadd")
    @PreAuthorize("hasAuthority('artist')")
    public void workadd() {
    }


    @PostMapping("workadd")
    public String workResult(ShoeBoard shoeBoard,
                             RedirectAttributes rttr,
                             @RequestParam("files") MultipartFile[] files,
                             Authentication authentication) throws Exception {
        boolean ok = memberService.addShoeBoard(shoeBoard, files, authentication);
        if (ok) {
            return "redirect:/artist/" + memberService.getIdByUserId(authentication.getName());
        } else {
            return "redirect:/workadd";
        }
    }

    @GetMapping("work")
    public void work(Model model, Authentication authentication,
                     @RequestParam(value = "page", defaultValue = "1") Integer page,
                     @RequestParam(value = "search", defaultValue = "") String search,
                     @RequestParam(value = "type", required = false) String type) {

        // work
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

    @GetMapping("canvas1")
    public void canvas1() {

    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("cs")
    public void cs() {

    }

    @PostMapping("cs")
    public String csProcess(CsBoard csBoard,
                            RedirectAttributes rttr,
                            Authentication authentication,
                            @RequestParam("files") MultipartFile[] files) throws Exception {
        csBoard.setWriter(memberService.getNickName(authentication.getName()));
        boolean ok = csService.add(csBoard, files);
        if (ok) {

            rttr.addFlashAttribute("message", "1:1 문의가 등록되었습니다..");
            return "redirect:/myCs";
        } else {
            rttr.addFlashAttribute("message", "1:1 문의중 문제가 발생했습니다.");
            return "redirect:/cs";
        }
    }

    @GetMapping("myCs")
    public void myCs(Authentication authentication,
                     Model model,
                     @RequestParam(value = "page", defaultValue = "1") Integer page,
                     @RequestParam(value = "search", defaultValue = "") String search) {
        String writer = memberService.getNickName(authentication.getName());
        Map<String, Object> result = csService.getCsBoardByWriter(writer, search, page);
        model.addAllAttributes(result);
    }

    @GetMapping("myCs/{id}")
    public String myCsPage(Model model,
                           @PathVariable Integer id) {
        Map<String, Object> result = csService.getCsBoardById(id);
        model.addAllAttributes(result);
        return "myCsPage";
    }

    @PostMapping("csRemove")
    public String csRemove(Integer id, RedirectAttributes rttr) {
        boolean ok = csService.remove(id);
        if (ok) {
            rttr.addFlashAttribute("message", "문의가 삭제되었습니다..");
        } else {
            rttr.addFlashAttribute("message", "문의삭제중 문제가 발생했습니다.");
        }
        return "redirect:/myCs";
    }

    @GetMapping("csModify")
    public void csModify(Integer id, Model model) {
        Map<String, Object> result = csService.getCsBoardById(id);
        model.addAllAttributes(result);
    }

    @PostMapping("csModify")
    public String csModifyProcess(CsBoard csBoard,
                                  @RequestParam(value = "removeFileList", required = false) List<String> removeFileName,
                                  @RequestParam(value = "files", required = false) MultipartFile[] addFiles,
                                  RedirectAttributes rttr) throws Exception {
        boolean ok = csService.modify(csBoard, removeFileName, addFiles);
        if (ok) {
            // 해당 게시물 보기로 리디렉션
            rttr.addFlashAttribute("message", csBoard.getId() + "번 게시물이 수정되었습니다.");
            return "redirect:/myCs/" + csBoard.getId();
        } else {
            rttr.addFlashAttribute("message", csBoard.getId() + "번 게시물이 수정되지 않았습니다.");
            return "redirect:/csModify/" + csBoard.getId();
        }

    }




}