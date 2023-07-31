package com.example.teamplaying.domain;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Data
public class CustomRequest {
    private Integer id;
    private String shoeName;
    private String body;
    private String price;
    private String brand;
    private LocalDate makeTime;
    private String artistUserId;
    private String customerUserId;
    private String progress;
    private String title;

    private Integer memberId;
    private List<String> fileNameList;
    private boolean contains;

}
