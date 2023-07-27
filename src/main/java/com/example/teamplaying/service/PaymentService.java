package com.example.teamplaying.service;

import com.example.teamplaying.domain.Payment;
import com.example.teamplaying.domain.PaymentInfo;
import com.example.teamplaying.mapper.PaymentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {
    private final PaymentMapper paymentMapper;

    @Autowired
    public PaymentService(PaymentMapper paymentMapper) {
        this.paymentMapper = paymentMapper;
    }

    public void savePaymentInfo(Payment payment) {
        paymentMapper.insertPaymentInfo(payment);
    }
}
