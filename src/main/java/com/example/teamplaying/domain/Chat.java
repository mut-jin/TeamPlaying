package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Chat {
	private Integer id;
	private Integer chatRoomId;
	private String senderId;
	private String recipientId;
	private String message;
	private LocalDateTime inserted;
	private String time;
	private String fileName;
	private String imgUrl;
}
