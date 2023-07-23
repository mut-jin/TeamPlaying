package com.example.teamplaying.service;


import com.example.teamplaying.domain.KakaoPayApproveVO;
import com.example.teamplaying.domain.KakaoPayReadyVO;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
public class KakaoPayService {

    private final String KAKAOPAY_API_KEY = "0badd931172daf138c129bba6c6cf187";

    public KakaoPayReadyVO kakaoPay(Map<String, Object> params) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + KAKAOPAY_API_KEY); // 발급받은 adminkey

//        결제번호는 고유한 결제번호로 생성해줘야 한다.
        MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();

        payParams.add("cid", "TC0ONETIME");
        payParams.add("partner_order_id", "KA02023018001");
        payParams.add("partner_user_id", "kakaopayTest");
        payParams.add("item_name", params.get("item_name"));
        payParams.add("quantity", params.get("quantity"));
        payParams.add("total_amount", params.get("total_amount"));
        payParams.add("tax_free_amount", "0");
        payParams.add("approval_url", "http://localhost:8082/pay/success"); // 결제 승인시 넘어갈 url
        payParams.add("cancel_url", "http://localhost:8082/pay/cancel"); // 결제 취소시 넘어갈 url
        payParams.add("fail_url", "http://localhost:8082/pay/fail"); // 결제 실패시 넘어갈 url

        // 카카오페이 결제준비 api 요청
        HttpEntity<Map> request = new HttpEntity<Map>(payParams, headers);

        RestTemplate template = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/ready";

        // 요청결과
        KakaoPayReadyVO res = template.postForObject(url, request, KakaoPayReadyVO.class);

        /*
        * 요청결과에서 응답받은 tid 값을 데이터베이스에 저장하는 로직 추가
        * 주문번호랑-tid 연결하여 결제이력테이블로 관리?
        */

        return res;
    }

    public KakaoPayApproveVO kakaoPayApprove(String pgToken) {

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + KAKAOPAY_API_KEY); // 발급받은 adminkey
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();

        /*
        결제 번호는 결제 준비 api와 일치 하여야 함.
        tid 불러오는 로직 추가
        */

        String tid = "";
        payParams.add("cid", "TC0ONETIME");
        payParams.add("tid", tid);
        payParams.add("partner_order_id", "KA02023018001");
        payParams.add("partner_user_id", "kakaopayTest");
        payParams.add("pg_token", pgToken);

        // 카카오페이 결제요청 api 요청
        HttpEntity<Map> request = new HttpEntity<Map>(payParams, headers);

        RestTemplate template = new RestTemplate();
        String url = "https://kapi.kakao.com/v1/payment/approve";

        // 요청결과
        KakaoPayApproveVO res = template.postForObject(url, request, KakaoPayApproveVO.class);

        return res;
    }
}
