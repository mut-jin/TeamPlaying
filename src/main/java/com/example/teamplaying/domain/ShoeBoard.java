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
    private LocalDateTime inserted;

    private List<String> imgUrlList;
    private Integer likeCount;
    private Integer commentCount;
}
