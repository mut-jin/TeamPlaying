package com.example.teamplaying.controller;

import com.example.teamplaying.domain.Payment;
import com.example.teamplaying.domain.PaymentInfo;
import com.example.teamplaying.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class PaymentController {

    private final PaymentService paymentService;


    @Autowired
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/makePayment")
    public void makePayment(@RequestBody Payment payment) {
        // 결제 로직 작성 (위의 자바스크립트 코드와 함께 활용)
        // 결제 성공 시 필요한 정보를 파라미터로 받아서 paymentService.savePaymentInfo() 호출
        paymentService.savePaymentInfo(payment);
    }
}
