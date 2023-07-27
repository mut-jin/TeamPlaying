package com.example.teamplaying.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
public class Payment {

    private String pay_method;
    private String merchant_uid;
    private String name;
    private Integer paid_amount;
    private String buyer_name;
    private String imp_uid;
    private LocalDateTime paidAt;

}
