package com.example.teamplaying.service;

import com.example.teamplaying.domain.CustomRequest;
import com.example.teamplaying.domain.Payment;
import com.example.teamplaying.domain.PaymentInfo;
import com.example.teamplaying.mapper.MemberMapper;
import com.example.teamplaying.mapper.PaymentMapper;
import com.example.teamplaying.mapper.RequestMapper;
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
    private MemberMapper memberMapper;

    @Autowired
    public PaymentService(PaymentMapper paymentMapper) {
        this.paymentMapper = paymentMapper;
    }

    public boolean savePaymentInfo(Payment payment) {
        Integer cnt = paymentMapper.insertPaymentInfo(payment);

        return cnt == 1;
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
                customRequest.setProgress("의뢰 확인중");
            }
            System.out.println(customRequest.getProgress().getClass());
        }

        String myMemberType = memberMapper.getMemberTypeByUserId(customerUserId);

        return Map.of("pageInfo", pageInfo, "myRequestList", list, "myMemberType", myMemberType);
    }

    public void updateProgress(Integer id) {
        CustomRequest customRequest = paymentMapper.getRequestById(id);
        customRequest.setProgress("작업중"); // 원하는 값으로 progress 컬럼을 업데이트

        int rowsAffected = paymentMapper.updateProgress(id, customRequest.getProgress());
        if (rowsAffected != 1) {
            throw new RuntimeException("CustomRequest 테이블의 progress 컬럼 업데이트에 실패했습니다.");
        }
    }
}
