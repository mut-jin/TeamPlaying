package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class CsBoard {
    private Integer id;
    private String title;
    private String category;
    private String body;
    private LocalDateTime inserted;
    private String writer;
    private String answer;

    private LocalDate insert;
}
