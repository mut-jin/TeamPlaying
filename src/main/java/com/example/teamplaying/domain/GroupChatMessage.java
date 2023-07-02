package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class GroupChatMessage {
	private Integer id;
	private Integer chatRoomId;
	private String senderId;
	private String message;
	private LocalDateTime inserted;
	private String time;
	private String ImgUrl;
	private String fileName;
}
