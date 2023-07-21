package com.example.teamplaying.domain;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;

@Data
public class CustomRequest {
    private Integer id;
    private String shoeName;
    private String Body;
    private String price;
    private String brand;
    private LocalDate makeTime;
    private String artistUserId;
    private String customerUserId;

}
