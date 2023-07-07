package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class ShoeBoard {
    private Integer id;
    private String category;
    private String shoeName;
    private Integer memberId;
    private String nickName;
    private String body;
    private Integer makeTime;
    private Integer price;
    private Integer view;
    private LocalDateTime inserted;
    private String address;

    private List<String> imgUrlList;
}
