package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class FutsalToday {
	
	private Integer id;
	private String title;
	private String body;
	private LocalDateTime inserted;
	private String writer;
	private String userId;
	
	private List<String> fileName;
	private Integer likeCount;
	private boolean liked;
	private Integer commentCount;
}
