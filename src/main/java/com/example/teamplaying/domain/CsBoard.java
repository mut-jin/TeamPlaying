package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CsBoard {
    private Integer id;
    private String category;
    private String body;
    private LocalDateTime inserted;
    private String writer;
}
