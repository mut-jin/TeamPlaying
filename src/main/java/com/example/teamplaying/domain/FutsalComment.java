package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class FutsalComment {
	private Integer id;
	private Integer boardId;
	private String content;
	private String memberId;
	private LocalDateTime inserted;
	
	private Boolean editable;
}
