package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.CustomRequest;
import com.example.teamplaying.domain.Payment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface PaymentMapper {
    @Insert("INSERT INTO Payment (pay_method, merchant_uid, name, amount, buyer_name) "  +
            "VALUES (#{pay_method}, #{merchant_uid}, #{name}, #{paid_amount}, #{buyer_name})")
    Integer insertPaymentInfo(Payment payment);

    @Select("""
            SELECT * FROM CustomRequest
            WHERE customerUserId = #{customerUserId}
            ORDER BY id DESC
            LIMIT #{startIndex}, #{rowPerPage}
            """)
    List<CustomRequest> getMyRequest(String customerUserId, Integer startIndex, Integer rowPerPage);

    @Select("""
            SELECT fileName FROM CustomRequestFileName
            WHERE boardId = #{boardId}
            """)
    List<String> getFiles(Integer boardId);

    @Select("""
            SELECT COUNT(*) FROM CustomRequest
            WHERE customerUserId = #{customerUserId}
            """)
    Integer getMyRequestCnt(String customerUserId);


    @Select("""
            SELECT * FROM CustomRequest
            WHERE id = #{id}
            """)
    CustomRequest getRequestById(Integer id);

    @Update("""
            UPDATE CustomRequest
            SET
                progress = #{progress}
            WHERE id = #{id}
            """)
    Integer updateProgress(@Param("id") Integer id, @Param("progress") String progress);
}
