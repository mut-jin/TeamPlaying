package com.example.teamplaying.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class Member {

	private Integer id;
	private String userId;
	private String password;
	private String name;
	private String nickName;
	private LocalDateTime inserted;
	private String birth;
	private String address;
	private String addressDetail;
	private String phone;
	private String email;
	private String introduce;
	private String memberType;
	private String profile;

	private Integer likeCount;
	private Integer totalView;
	private Integer subCount;
	private List<String> shoeImgList;
	private Integer workCount;

	
}
