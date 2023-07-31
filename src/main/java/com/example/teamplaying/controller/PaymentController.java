package com.example.teamplaying.controller;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.Payment;
import com.example.teamplaying.domain.PaymentInfo;
import com.example.teamplaying.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@RestController
public class PaymentController {

    private final PaymentService paymentService;



    @Autowired
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/makePayment")
    public ResponseEntity<Map<String, Object>> makePayment(@RequestBody Payment payment) {
        // 결제 로직 작성 (위의 자바스크립트 코드와 함께 활용)
        // 결제 성공 시 필요한 정보를 파라미터로 받아서 paymentService.savePaymentInfo() 호출
        boolean ok = paymentService.savePaymentInfo(payment);

        // 결제가 성공적으로 완료되면 응답에 성공 여부와 리다이렉트할 URL 담아 전달
        Map<String, Object> response = new HashMap<>();

        if (ok) {
            response.put("success", true);
            response.put("redirectUrl", "/shoppingList"); // 원하는 리다이렉트 URL을 여기에 지정

            return ResponseEntity.ok().body(response);

        } else {
            response.put("success", false);
            response.put("error", "결제 처리 중 오류가 발생했습니다.");

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PutMapping("updateProgress/{id}")
    public ResponseEntity<String> updateProgress(@PathVariable Integer id) {
        try {
            paymentService.updateProgress(id);
            return ResponseEntity.ok("CustomRequest 테이블의 progress 컬럼이 업데이트되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트에 실패하였습니다.");
        }
    }
}
