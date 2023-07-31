package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class ShoeBoard {
    private Integer id;
    private String title;
    private String shoeName;
    private Integer memberId;
    private String nickName;
    private String body;
    private Integer makeTime;
    private Integer price;
    private Integer view;
    private String brand;
    private LocalDateTime inserted;
    private String fileName;

    private List<String> imgUrlList;
    private Integer likeCount;
    private boolean liked;
    private Integer commentCount;
    private String profile;
    private String address;
    private String userId;

}
