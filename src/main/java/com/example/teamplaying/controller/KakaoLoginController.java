package com.example.teamplaying.controller;

import com.example.teamplaying.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class KakaoLoginController {

    @GetMapping("/kakao-login")
    public String handleKakaoLogin(@RequestParam("accessToken") String accessToken) {
        // 액세스 토큰을 이용하여 사용자 정보를 가져오거나 처리합니다.
        // 필요한 작업을 수행한 후, 로그인 성공 후 리다이렉트할 페이지로 이동합니다.
        return "redirect:/main";
    }




}
