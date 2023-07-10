package com.example.teamplaying.service;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.mapper.MemberMapper;
import com.example.teamplaying.mapper.ShoeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberService {
	@Autowired
	private ShoeBoardMapper shoeMapper;

	@Autowired
	private MemberMapper mapper;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Value("${aws.s3.bucketUrl}")
	private String bucketUrl;

	public String getNickName(String userId) {

		return mapper.getNickNameByUserId(userId);
	}

	// 서재권 추가내용 ***********
	public boolean signup(Member member) {
		// 암호를 새롭게 세팅해 준다.
		// plain은 입력해서 받아들여지는 암호
		// setPasswordEncoder를 통해서 다시 password를 set
		String plain = member.getPassword();
		member.setPassword(passwordEncoder.encode(plain));

		int cnt = mapper.insertMember(member);

		return cnt == 1;

	}

	public String getUserId(String yourNickName) {
		return mapper.getUserIdSelectByNickName(yourNickName);
	}

	public List<Member> listMember() {

		return mapper.selectAll();
	}

	public Member get(String userId) {
		return mapper.selectById(userId);
	}

	public boolean modify(Member member, String oldPassword) {
		Member oldMember = mapper.selectById(member.getUserId());

		int cnt = 0;
		if (oldMember.getPassword().equals(oldPassword)) {

			cnt = mapper.update(member);
		}

		return cnt == 1;
	}

	public boolean remove(Member member) {

		System.out.println(member);

		// 채팅 지우기
		mapper.deleteChatByUserId(member.getUserId());
		// 채팅방 지우기
		mapper.deleteChatRoomByUserId(member.getUserId());
		// 그룹 채팅방 지우기
		mapper.deleteGroupChatRoomByUserId(member.getUserId());

		// 러닝메이트 관련 ---
		// 러닝 ==========
		// 신청 목록 지우기
		mapper.deleteRunningPartyById(member.getUserId());
		System.out.println(1);

		// 러닝 today 관련 --
		// 좋아요 지우기
		mapper.deleteRunningTodayLikeById(member.getUserId());
		System.out.println(3);
		// 댓글 지우기
		mapper.deleteRunningTodayCommentById(member.getUserId());
		System.out.println(4);
		// 러닝 게시물 파일 지우기
		List<Integer> idList = mapper.selectIdByWriter(member.getNickName());
		for (Integer id : idList) {
			mapper.deleteRunningFileNameById(id);
		}
		System.out.println(5);

		// 러닝 today 지우기
		mapper.deleteRunningTodayById(member.getNickName());
		System.out.println(6);

		// 등산 =========
		// 등산메이트 관련
		// 신청 목록 지우기
		mapper.deleteClimbingPartyById(member.getUserId());
		System.out.println(7);

		// 등산 today 관련
		// 좋아요 지우기
		mapper.deleteClimbingTodayLikeById(member.getUserId());
		System.out.println(9);
		// 댓글 지우기
		mapper.deleteClimbingTodayCommentById(member.getUserId());
		System.out.println(10);

		// 등산 today 파일 지우기
		List<Integer> climbingTodayIdList = mapper.selectClimbingTodayByWriter(member.getNickName());
		for (Integer id : climbingTodayIdList) {
			mapper.deleteClimbingTodayFileNameById(id);
		}
		System.out.println(11);

		// 등산 today 지우기
		mapper.deleteClimbingTodayById(member.getNickName());
		System.out.println(12);

		// 등산 course 관련
		// 등산 코스 like 지우기
		mapper.deleteClimbingCourseLikeById(member.getUserId());
		System.out.println(13);
		// 등산코스 댓글 지우기
		mapper.deleteClimbingCourseCommentById(member.getUserId());
		System.out.println(14);
		// 등산 코스 파일 지우기
		List<Integer> climbingCourseIdList = mapper.selectClimbCourseIdByWriter(member.getNickName());
		for (Integer id : climbingCourseIdList) {
			mapper.deleteClimbingCourseFileNameById(id);
		}
		System.out.println(15);
		// 등산 코스 지우기
		mapper.deleteClimbingCourseById(member.getNickName());
		System.out.println(16);

		// 러닝 게시물 지우기
		mapper.deleteRunningBoardById(member.getNickName());
		System.out.println(2);

		mapper.deleteClimbingMateById(member.getNickName());

		int cnt = mapper.deleteMember(member.getUserId());

		return cnt == 1;
	}

	public boolean modify(Member member) {
		System.out.println(member);
		member.setId(mapper.getId(member.getUserId()));
		int cnt = mapper.updateMember(member);
		System.out.println("@@@" + cnt);

		return cnt == 1;
	}

	public Map<String, Object> IDCheck(String userId) {
		Member member = mapper.selectById(userId);

		return Map.of("available", member == null);
	}

	public Map<String, Object> checkNickName(String nickName) {
		Member member = mapper.selectByNickName(nickName);
		return Map.of("available", member == null);
	}

	public Map<String, Object> checkEmail(String email) {
		Member member = mapper.selectByEmail(email);

		return Map.of("available", member == null);
	}

    public Map<String, Object> getArtistBoard(Integer page, String search, String type) {
		Integer rowPerPage = 8;
		Integer startIndex = (page - 1) * rowPerPage;

		Integer artistNum = mapper.getArtistNum(search);
		Integer lastPageNum = (artistNum - 1) / rowPerPage + 1;

		Integer rightPageNum = ((page - 1) / 5 + 1) * 5;
		Integer leftPageNum = rightPageNum - 4;
		leftPageNum = Math.max(leftPageNum, 1);
		rightPageNum = Math.min(rightPageNum, lastPageNum);

		Map<String, Object> pageInfo = new HashMap<>();
		pageInfo.put("rightPageNum", rightPageNum);
		pageInfo.put("leftPageNum", leftPageNum);
		pageInfo.put("lastPageNum", lastPageNum);
		pageInfo.put("currentPageNum", page);

		List<Member> list = mapper.selectAllPaging(startIndex ,rowPerPage, search, type);
		for(Member i : list) {
			List<String> shoeList = new ArrayList<>();
			List<Integer> boardIdList = shoeMapper.getBoardIdList(i.getId());
			for(Integer boardID : boardIdList) {
				shoeList.add(bucketUrl + "/shoeBoard/" + boardID + "/" + shoeMapper.getMyShoeFileName(boardID));

			}
			i.setSubCount(shoeMapper.getMySubscribe(i.getId()));
			i.setShoeImgList(shoeList);
			if(i.getTotalView() == null) {
				i.setTotalView(0);
			}
		}

		return Map.of("pageInfo", pageInfo, "boardList", list);
    }


	public Map<String, Object> getMember(Integer id, Integer page) {
		Integer rowPerPage = 9;
		Integer startIndex = (page - 1) * rowPerPage;

		Integer shoeBoardNum = mapper.getmyShoeBoardNum(id);
		Integer lastPageNum = (shoeBoardNum - 1) / rowPerPage + 1;

		Integer rightPageNum = ((page - 1) / 5 + 1) * 5;
		Integer leftPageNum = rightPageNum - 4;
		leftPageNum = Math.max(leftPageNum, 1);
		rightPageNum = Math.min(rightPageNum, lastPageNum);

		Map<String, Object> pageInfo = new HashMap<>();
		pageInfo.put("rightPageNum", rightPageNum);
		pageInfo.put("leftPageNum", leftPageNum);
		pageInfo.put("lastPageNum", lastPageNum);
		pageInfo.put("currentPageNum", page);

		List<Member> list = mapper.getMemberById(startIndex, rowPerPage, id);
		for(Member i : list) {
			i.setProfile(bucketUrl + "/Member/" + i.getId() + "/" + i.getProfile());
		}
		return Map.of("pageInfo", pageInfo, "memberInfo", list);
	}
}