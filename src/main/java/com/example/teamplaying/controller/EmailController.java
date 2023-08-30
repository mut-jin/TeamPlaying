package com.example.teamplaying.controller;

import com.example.teamplaying.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.*;

import javax.mail.internet.MimeMessage;
import java.util.Map;
import java.util.Random;

@RestController
public class EmailController {
    private final  JavaMailSenderImpl mailSender;

    @Autowired
    public EmailController(JavaMailSenderImpl mailSender) {
        this.mailSender = mailSender;
    }

    @Autowired
    private MemberService memberService;


    /*@GetMapping("checkEmail/{email}")
    @ResponseBody
    public Map<String, Object> checkEmail(@PathVariable("email") String email) {
        return memberService.checkEmail(email);
    }*/
    // 이메일 인증
    @PostMapping("/EmailAuth")
    @ResponseBody
    public int emailAuth(String email) {

        //난수의 범위 111111 ~ 999999 (6자리 난수)
        Random random = new Random();
        int checkNum = random.nextInt(888888)+111111;

        //이메일 보낼 양식
        String setFrom = "dkssud2422@naver.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
        String toMail = email;
        String title = "Zero-One 회원가입 인증 이메일 입니다.";
        String content = "";
        // msgg += "<img src=../resources/static/image/emailheader.jpg />"; // header image
        content += "<h1>안녕하세요</h1>";
        content += "<h1>커스텀 신발 플랫폼 Zero-One 입니다</h1>";
        content += "<br>";
        content += "<p>아래 인증코드를 입력해주세요</p>";
        content += "<br>";
        content += "<br>";
        content += "<div align='center' style='border:1px solid black'>";
        content += "<h3 style='color:blue'>회원가입 인증코드 입니다</h3>";
        content += "<div style='font-size:130%'>";
        content += "<strong>" + checkNum + "</strong></div><br/>" ; // 메일에 인증번호 checkNum 넣기
        content += "</div>";

        try {
            MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkNum;
    }

    @PostMapping("/EmailAuthPW")
    @ResponseBody
    public int emailAuthPW(String email) {

        //난수의 범위 111111 ~ 999999 (6자리 난수)
        Random random = new Random();
        int checkNum = random.nextInt(888888)+111111;

        //이메일 보낼 양식
        String setFrom = "dkssud2422@naver.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
        String toMail = email;
        String title = "Zero-One 비밀번호 찾기 인증 이메일 입니다.";
        String content = "";
        // msgg += "<img src=../resources/static/image/emailheader.jpg />"; // header image
        content += "<h1>안녕하세요</h1>";
        content += "<h1>커스텀 신발 플랫폼 Zero-One 입니다</h1>";
        content += "<br>";
        content += "<p>아래 인증코드를 입력해주세요</p>";
        content += "<br>";
        content += "<br>";
        content += "<div align='center' style='border:1px solid black'>";
        content += "<h3 style='color:blue'>비밀번호 재설정 인증코드 입니다.</h3>";
        content += "<div style='font-size:130%'>";
        content += "<strong>" + checkNum + "</strong></div><br/>" ; // 메일에 인증번호 checkNum 넣기
        content += "</div>";

        try {
            MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkNum;
    }
}
