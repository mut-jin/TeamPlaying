package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.Payment;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
    @Insert("INSERT INTO Payment (pay_method, merchant_uid, name, amount, buyer_name) "  +
            "VALUES (#{pay_method}, #{merchant_uid}, #{name}, #{paid_amount}, #{buyer_name})")
    void insertPaymentInfo(Payment payment);
}
