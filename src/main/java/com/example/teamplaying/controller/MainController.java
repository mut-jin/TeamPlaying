package com.example.teamplaying.controller;

import com.example.teamplaying.domain.*;
import com.example.teamplaying.domain.CsBoard;
import com.example.teamplaying.domain.CustomRequest;
import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.domain.*;
import com.example.teamplaying.security.CustomSecurityChecker;
import com.example.teamplaying.service.CsService;
import com.example.teamplaying.service.KakaoPayService;
import com.example.teamplaying.service.MemberService;
import com.example.teamplaying.service.RequestService;
import com.example.teamplaying.service.ShoeBoardService;
import com.example.teamplaying.service.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/")
public class MainController {
    private final MemberService memberService;


    @Autowired
    public MainController(MemberService memberService) {
        this.memberService = memberService;
    }

    @Autowired
    private ShoeBoardService shoeBoardService;

    @Autowired
    private CsService csService;

    @Autowired
    private RequestService requestService;

    @Autowired
    private PaymentService paymentService;


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
    public void main(Model model, Authentication authentication) {

        Map<String, Object> getShoeList = new HashMap<>();

        List<ShoeBoard> nike = shoeBoardService.getAllShoesByBrand("나이키");
        getShoeList.put("nike", nike);

        List<ShoeBoard> adidas = shoeBoardService.getAllShoesByBrand("아디다스");
        getShoeList.put("adidas", adidas);

        List<ShoeBoard> vans = shoeBoardService.getAllShoesByBrand("반스");
        getShoeList.put("vans", vans);

        List<ShoeBoard> converse = shoeBoardService.getAllShoesByBrand("컨버스");
        getShoeList.put("converse", converse);

        List<ShoeBoard> etc = shoeBoardService.getAllShoesByBrand("기타");
        getShoeList.put("etc", etc);

        String myMemberType = "";

        if(authentication == null) {
            getShoeList.put("myUserId", "");
        } else {
            myMemberType = memberService.getMemberType(authentication.getName());
            getShoeList.put("myMemberType", myMemberType);
            getShoeList.put("myUserId", authentication.getName());
        }

        model.addAllAttributes(getShoeList);

//		model.addAttribute("나이키", nike);
//		model.addAttribute("아디다스", adidas);
//		model.addAttribute("반스", vans);
//		model.addAttribute("컨버스", converse);
    }

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
    public String myPage(Authentication authentication, Model model) {
        if(authentication == null) {
            return "redirect:/login";
        }
        Member member = memberService.get(authentication.getName());
        String myMemberType = memberService.getMemberType(authentication.getName());
        System.out.println(member);
        model.addAttribute("member", member);
        model.addAttribute("myMemberType", myMemberType);
        return "totalMyPage";
    }

    @GetMapping("modify")
    public void modifyForm(Authentication authentication, Model model) {
        Member member = memberService.get(authentication.getName());
        model.addAttribute("member", member);
    }

    // 2.
    @PostMapping("modify")
    public String modifyProcess(Member member, RedirectAttributes rttr,
                                @RequestParam MultipartFile file,
                                Authentication authentication) throws IOException {
        System.out.println("file:" + file);
        boolean ok = memberService.modify(member, file, authentication);

        if (ok) {
            rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
            return "redirect:/totalMyPage";
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
                       @RequestParam(value = "order", defaultValue = "id") String order,
                       Authentication authentication) {
        String myUserId;
        String myMemberType = "";
        if(authentication == null) {
            myUserId = "";
        } else {
            myMemberType = memberService.getMemberType(authentication.getName());
            myUserId = authentication.getName();
        }

        Map<String, Object> result = memberService.getArtistBoard(page, search, order, name, myUserId, myMemberType);

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

    @GetMapping("/shoeBoardId/{id}")
    public String ShoeBoardDetail(@PathVariable("id") Integer id, Model model, Authentication authentication) {

        Map<String, Object> list = new HashMap();

        List<ShoeBoard> shoeBoardList = shoeBoardService.getShoeBoard(id, authentication.getName());
        list.put("board", shoeBoardList);
        Member member = shoeBoardService.getNickName(authentication.getName());
        list.put("member", member);

        model.addAllAttributes(list);

        return "teamPlaying/shoeBoardGet";

    }

    @GetMapping("/work")
    public String work(Model model, Authentication authentication,
                       @RequestParam(value = "page", defaultValue = "1") Integer page,
                       @RequestParam(value = "search", defaultValue = "") String search,
                       @RequestParam(value = "type", required = false) String type,
                       @RequestParam(value = "brand", required = false) String brand,
                       @RequestParam(value = "order", defaultValue = "id") String order,
                       @RequestParam(value = "direction", defaultValue = "DESC") String direction,
                       @RequestParam(value = "name", defaultValue = "정렬") String name
    ) {
        String myMemberType = "";
        String myUserId;
        if(authentication == null) {
            myUserId = "";
        } else {
            myUserId = authentication.getName();
            myMemberType = memberService.getMemberType(authentication.getName());
        }
        // 기존의 코드는 그대로 유지합니다
        Map<String, Object> result = shoeBoardService.getshoeBoard(page, search, type, brand, order, direction, name, myUserId, myMemberType);
        model.addAllAttributes(result);

        return "work";
    }


    @GetMapping("artist/{id}")
    public String artistPage(Model model,
                             @PathVariable Integer id,
                             @RequestParam(value = "page", defaultValue = "1") Integer page,
                             Authentication authentication) {
        String myUserId = "";
        if(authentication != null) {
            myUserId = authentication.getName();
        }
        Map<String, Object> result = memberService.getMember(id, page, myUserId);
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


    @GetMapping("canvas1")
    public void canvas1() {

    }

/*
	@GetMapping("canvas1")
	public void canvas1() {

	}
*/

    @PreAuthorize("isAuthenticated()")
    @GetMapping("cs")
    public void cs() {

    }

    @PreAuthorize("isAuthenticated()")
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

    @PreAuthorize("isAuthenticated()")
    @GetMapping("myCs")
    public void myCs(Authentication authentication,
                     Model model,
                     @RequestParam(value = "page", defaultValue = "1") Integer page,
                     @RequestParam(value = "search", defaultValue = "") String search) {
        String writer = memberService.getNickName(authentication.getName());
        Map<String, Object> result = csService.getCsBoardByWriter(writer, search, page);
        model.addAllAttributes(result);
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("myCs/{id}")
    public String myCsPage(Model model,
                           @PathVariable Integer id,
                           Authentication authentication) {
        if(!memberService.check(authentication, id)) {
            return "main";
        }
        Map<String, Object> result = csService.getCsBoardById(id, authentication.getName());
        model.addAllAttributes(result);
        return "myCsPage";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("csRemove")
    public String csRemove(Integer id, RedirectAttributes rttr,
                           Authentication authentication) {
        if(!csService.getWriterById(id).equals(memberService.getNickName(authentication.getName()))) {
            return "main";
        }
        boolean ok = csService.remove(id);
        if (ok) {
            rttr.addFlashAttribute("message", "문의가 삭제되었습니다..");
        } else {
            rttr.addFlashAttribute("message", "문의삭제중 문제가 발생했습니다.");
        }
        return "redirect:/myCs";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("csModify")
    public String csModify(Integer id, Model model,
                         Authentication authentication) {
        if(!csService.getWriterById(id).equals(memberService.getNickName(authentication.getName()))) {
            return "main";
        }
        Map<String, Object> result = csService.getCsBoardById(id);
        model.addAllAttributes(result);
        return "csModify";
    }

    @PreAuthorize("isAuthenticated()")
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
//			rttr.addAttribute("fail", "modifyfail");
            rttr.addFlashAttribute("message", csBoard.getId() + "번 게시물이 수정되지 않았습니다.");
            return "redirect:/csModify/" + csBoard.getId();
        }

    }

	/*@Autowired
	private KakaoPayService payService;

	@GetMapping("/pay/ready")
	public @ResponseBody KakaoPayReadyVO kakaoPay(@RequestParam Map<String, Object> params) {
		KakaoPayReadyVO res = payService.kakaoPay(params);
		*//*log.info(res.toString());*//*
		return res;
	}


	@GetMapping("/pay/success")
	public String Success(@RequestParam("pg_token") String pgToken) {
		KakaoPayApproveVO res = payService.kakaoPayApprove(pgToken);

		*//*
     * 요청 결과에 대해 데이터 베이스에 저장 또는 업데이트 할 로직 추가
     *//*

		return "/pay/success";
	}*/

    @PreAuthorize("isAuthenticated()")
    @GetMapping("shoppingList")
    public void shoppingList(Authentication authentication,
                             Model model,
                             @RequestParam(value = "page", defaultValue = "1") Integer page) {
        Map<String, Object> result = paymentService.getMyRequest(authentication.getName(), page);
        model.addAllAttributes(result);
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("myRequest")
    public void myRequest(Authentication authentication,
                          Model model,
                          @RequestParam(value = "page", defaultValue = "1") Integer page) {
        Map<String, Object> result = requestService.getMyRequest(authentication.getName(), page);
        model.addAllAttributes(result);
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("addRequest")
    public String addRequest(CustomRequest customRequest,
                             Authentication authentication) {
        if (authentication == null || authentication.getName() == null) {
            return "redirect:/login";
        }
        customRequest.setCustomerUserId(authentication.getName());
        System.out.println(customRequest);
        shoeBoardService.addCustomRequest(customRequest);
        return "redirect:/shoppingList";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("removeRequest/{id}")
    @ResponseBody
    public void removeRequest(@PathVariable Integer id) {
        requestService.removeRequest(id);
    }

    @PreAuthorize("isAuthenticated()")
    @PutMapping("acceptRequest")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> acceptRequest(@RequestBody CustomRequest customRequest) {
        System.out.println(customRequest);
        Map<String, Object> res = requestService.acceptRequest(customRequest);
        return ResponseEntity.ok().body(res);
    }

    @PreAuthorize("isAuthenticated()")
    @PutMapping("modifyRequest")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> update(@RequestBody CustomRequest customRequest) {
        Map<String, Object> res = requestService.modify(customRequest);
        return ResponseEntity.ok().body(res);
    }

    @GetMapping("viewCount")
    @ResponseBody
    public Map<String, Object> viewCount(Integer id) {
        return Map.of("view", shoeBoardService.updateAndGetView(id));
    }

    @PostMapping("like")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> like(
            @RequestBody ShoeLike like,
            Authentication authentication) {
        if (authentication == null) {
            return ResponseEntity
                    .status(403)
                    .body(Map.of("message", "로그인 후 좋아요 클릭 해주세요."));
        } else {
            return ResponseEntity
                    .ok()
                    .body(shoeBoardService.like(like, authentication));
        }
    }

    @PostMapping("commentAdd")
    @ResponseBody
    @PreAuthorize("authenticated")
    public ResponseEntity<Map<String, Object>> commentAdd(
            @RequestBody ShoeComment comment,
            Authentication authentication) {

        if (authentication == null) {
            Map<String, Object> res = Map.of("message", "로그인 후 댓글을 작성해주세요.");
            return ResponseEntity.status(401).body(res);
        } else {
            Map<String, Object> res = shoeBoardService.commentAdd(comment, authentication);

            return ResponseEntity.ok().body(res);
        }

    }


    @GetMapping("commentList")
    @ResponseBody
    public List<ShoeComment> commentList(Integer boardId, Authentication authentication) {
        return shoeBoardService.commentList(boardId, authentication);

    }

    @GetMapping("commentId/{id}")
    @ResponseBody
    public ShoeComment commentGet(@PathVariable("id") Integer id) {
        return shoeBoardService.getComment(id);
    }
    @GetMapping("members")
    @PreAuthorize("@customSecurityChecker.checkAdmin(authentication)")
    public String showMemberList(Model model, Authentication authentication) {
        List<Member> members = memberService.getAllMembers();
        ModelAndView modelAndView = new ModelAndView("MemberList"); // 해당 JSP 파일명
        model.addAttribute("members", members);
        return "members";
    }

    @GetMapping("adminCs")
    @PreAuthorize("@customSecurityChecker.checkAdmin(authentication)")
    public String adminCs(Model model, Authentication authentication) {
        List<CsBoard> csBoard = csService.getAllCs();
        ModelAndView modelAndView = new ModelAndView("csList"); // 해당 JSP 파일명
        model.addAttribute("csBoardList", csBoard);
        return "adminCs";
    }

    @PutMapping("commentUpdate")
    @ResponseBody
    @PreAuthorize("authenticated and @customSecurityChecker.checkShoeBoardCommentWriter(authentication, #comment.id)")
    public ResponseEntity<Map<String, Object>> commentUpdate(@RequestBody ShoeComment comment) {
        Map<String, Object> res = shoeBoardService.commentUpdate(comment);
        return ResponseEntity.ok().body(res);
    }

    @DeleteMapping("commentId/{id}")
    @ResponseBody
    @PreAuthorize("authenticated and @customSecurityChecker.checkShoeBoardCommentWriter(authentication, #id)")
    public ResponseEntity<Map<String, Object>> commentRemove(@PathVariable("id") Integer id) {
        Map<String, Object> res = shoeBoardService.commentRemove(id);

        return ResponseEntity.ok().body(res);
    }

    @PreAuthorize("isAuthenticated() && @customSecurityChecker.checkAdmin(authentication)")
    @PostMapping("csAnswer")
    public String csAnswer(String answer, Integer id,
                           Authentication authentication) {
        csService.updateAnswer(answer, id);
        return "redirect:/myCs/" + id;
    }

//	@GetMapping("csModify/{id}")
//	public String modify(@PathVariable("id") Integer id, Model model, Authentication authentication) {
//		model.addAttribute("board", service.getBoard(id, authentication));
//		return "csModify";
//	}


    @DeleteMapping("/members/{id}")
    @PreAuthorize("@customSecurityChecker.checkAdmin(authentication)")
    public ResponseEntity<String> deactivateMember(@PathVariable int id, Authentication authentication) {
        boolean deactivationSuccess = memberService.deactivateMember(id);

        if (deactivationSuccess) {
            return ResponseEntity.ok("Member deactivated successfully.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to deactivate member.");
        }
    }
//
//    @DeleteMapping("/workRemove")
//    @PreAuthorize("@customSecurityChecker.checkAdmin(authentication)")
//    public String workRemove(Integer id, RedirectAttributes rttr) {
//        boolean ok = shoeBoardService.remove(id);
//        if (ok) {
//            // query string에 추가
////			rttr.addAttribute("success", "remove");
//
//            // 모델에 추가
//            rttr.addFlashAttribute("message", id + "번 게시물이 삭제되었습니다.");
//            return "redirect:/work";
//        } else {
//            return "redirect:/work" + id;
//        }
//    }


//    // 아이디 찾기 폼
//    @RequestMapping(value = "findID")
//    public String findID() throws Exception{
//        return "findID";
//    }


    @GetMapping("shoeDelete")
    public String shoeDelete(Integer boardId,
                             RedirectAttributes rttr,
                             Authentication authentication,
                             String url) {
        boolean ok = shoeBoardService.shoeDelete(boardId);
        Integer id = memberService.getIdByUserId(authentication.getName());
        if (ok) {
            rttr.addFlashAttribute("message", "작품이 삭제되었습니다.");
        } else {
            rttr.addFlashAttribute("message", "작품 삭제에 문제가 발생했습니다.");
        }
        return "redirect:/" + url;
    }

    @PreAuthorize("isAuthenticated()")
    @ResponseBody
    @PutMapping("progressChange")
    public void progressChange(@RequestBody CustomRequest customRequest) {
        shoeBoardService.modifyProcess(customRequest);
    }

}


//    @GetMapping("artistInfo")
//    public Map<String, Object> artistInfo(Integer artistId) {
//        Map<String, Object> map = memberService.getArtistBoard(artistId);
//
//        return map;
//    }

//	}
////
////	@GetMapping("canvas1")
////	public void canvas1() {
////
//////	}
//	@GetMapping("cs")
//	public void cs() {
//
//	}
//}
