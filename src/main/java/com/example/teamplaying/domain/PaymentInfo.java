package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PaymentInfo {
    private String pay_method;
    private String merchant_uid;
    private String name;
    private Integer paid_amount;
    private String buyer_name;
    private String imp_uid;
    private LocalDateTime paidAt;

    // 생성자
    public PaymentInfo(String pay_method, String merchant_uid, String name,
                       Integer paid_amount, String buyer_name) {
        this.pay_method = pay_method;
        this.merchant_uid = merchant_uid;
        this.name = name;
        this.paid_amount = paid_amount;
        this.buyer_name = buyer_name;
    }
}
