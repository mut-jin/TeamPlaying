package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDate;

@Data
public class ShoeComment {
    private Integer id;
    private Integer boardId;
    private String content;
    private String memberId;
    private LocalDate inserted;
    private Boolean editable;

}
