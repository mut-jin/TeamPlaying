package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class ClimbingCourse {
	private Integer id;
	private String title;
	private String body;
	private String writer;
	private LocalDate inserted;
	private List<String> fileName;
	private String userId;
	
	private Integer likeCount;
	private boolean liked; 
	private Integer commentCount;
}
