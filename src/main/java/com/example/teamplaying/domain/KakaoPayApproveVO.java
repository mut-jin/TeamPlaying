package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class KakaoPayApproveVO {
    private String aid; //  요청 고유번호
    private String tid; // 결제 고유번호
    private String cid; // 가맹점 코드
    private String partner_order_id; // 가맹점 주문번호
    private String partner_user_id; // 가맹점 회원 id
    private String payment_method_type; // 결제 수단, CARD 또는 MONEY
    private Integer amount; // 결제 금액 정보
    private String item_name; // 상품 이름
    private String item_code; // 상품 코드
    private Integer quantity; // 상품 수량
    private LocalDateTime created_at; // 결제 준비 요청 시간
    private LocalDateTime approved_at; // 결제 승인 시간
    private String payload; // 결제 승인 요청에 대해 저장한 값, 요청 시 전달된 내용
}
