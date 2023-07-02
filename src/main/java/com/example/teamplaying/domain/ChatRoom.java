package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ChatRoom {

	private Integer id;
	private String creater;
	private String invited;
	private LocalDateTime inserted;
	private Integer createrChatCount;
	private Integer invitedChatCount;
}
