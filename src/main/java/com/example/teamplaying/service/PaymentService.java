package com.example.teamplaying.service;

import com.example.teamplaying.domain.CustomRequest;
import com.example.teamplaying.domain.Payment;
import com.example.teamplaying.domain.PaymentInfo;
import com.example.teamplaying.mapper.PaymentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PaymentService {
    private final PaymentMapper paymentMapper;

    @Autowired
    PaymentMapper mapper;

    @Autowired
    public PaymentService(PaymentMapper paymentMapper) {
        this.paymentMapper = paymentMapper;
    }

    public void savePaymentInfo(Payment payment) {
        paymentMapper.insertPaymentInfo(payment);
    }

    public Map<String, Object> getMyRequest(String customerUserId, Integer page) {
        Integer rowPerPage = 10;
        Integer startIndex = (page - 1) * rowPerPage;

        Integer myRequestCnt = mapper.getMyRequestCnt(customerUserId);
        Integer lastPageNum = (myRequestCnt - 1) / rowPerPage + 1;

        Integer rightPageNum = ((page - 1) / 5 + 1) * 5;
        Integer leftPageNum = rightPageNum - 4;
        leftPageNum = Math.max(leftPageNum, 1);
        rightPageNum = Math.min(rightPageNum, lastPageNum);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("rightPageNum", rightPageNum);
        pageInfo.put("leftPageNum", leftPageNum);
        pageInfo.put("lastPageNum", lastPageNum);
        pageInfo.put("currentPageNum", page);

        List<CustomRequest> list = mapper.getMyRequest(customerUserId, startIndex, rowPerPage);
        for (CustomRequest customRequest : list) {
            customRequest.setFileNameList(mapper.getFiles(customRequest.getId()));
            System.out.println(customRequest.getProgress());
            if (customRequest.getProgress().equals("접수 대기중")){
                customRequest.setProgress("true");
            }
            System.out.println(customRequest.getProgress().getClass());
        }

        return Map.of("pageInfo", pageInfo, "myRequestList", list);
    }
}
