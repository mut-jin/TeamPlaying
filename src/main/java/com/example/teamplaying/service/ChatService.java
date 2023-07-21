package com.example.teamplaying.service;

import com.example.teamplaying.domain.*;
import com.example.teamplaying.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ChatService {

    @Autowired
    private ChatMapper mapper;

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private S3Client s3;

    @Value("${aws.s3.bucketUrl}")
    private String bucketUrl;

    @Value("${aws.s3.bucketName}")
    private String bucketName;

    public List<ChatRoom> invitedSelectByName(String myName) {
        return mapper.chatRoomSelectByMyName(myName);

    }

    public String lastMessageSelectById(Integer id) {
        return mapper.lastMessageSelectById(id);
    }

    public List<Chat> getChat(LocalDateTime inserted, String myUserId) {
        int chatRoomId = mapper.getChatRoomIdByInserted(inserted, myUserId);
        List<Chat> list = mapper.getChatSelectByChatRoomId(chatRoomId);
        List<LocalDateTime> dateTimeList = mapper.getinsertedByChatRoomId(chatRoomId);
        for (int i = 0; i < dateTimeList.size(); i++) {
            LocalTime time = dateTimeList.get(i).toLocalTime();
            list.get(i).setTime(time.getHour() + ":" + time.getMinute());
            list.get(i).setImgUrl(bucketUrl + "/ChatRoom/" + chatRoomId + "/" + list.get(i).getFileName());
        }

        return list;
    }

    public void addChat(Chat data) {
//		for(String s : mapper.getChatRoomUserId(data.getChatRoomId())) {
//			if(!s.equals(data.getSenderId())) {
//				data.setRecipientId(s);
//			}
//		}
        Map<String, String> map = mapper.getChatRoomUserId(data.getChatRoomId());
        if (!map.get("creater").equals(data.getSenderId())) {
            data.setRecipientId(map.get("creater"));
        } else {
            data.setRecipientId(map.get("invited"));
        }
        if (data.getMessage().trim().isEmpty()) {
            return;
        } else {
            int cnt = mapper.addChat(data);
        }
    }

    public List<Chat> checkId(Integer lastChatId, Integer chatRoomId) {
        List<Chat> list = mapper.checkId(lastChatId, chatRoomId);
        for (int i = 0; i < list.size(); i++) {
            LocalDateTime dateTime = list.get(i).getInserted();
            String time = dateTime.getHour() + ":" + dateTime.getMinute();
            list.get(i).setTime(time);
            list.get(i).setImgUrl(bucketUrl + "/ChatRoom/" + chatRoomId + "/" + list.get(i).getFileName());
        }
        return list;
    }

    public void delete(Integer chatRoomId, String myUserId) {
        if (mapper.getChatRoomUserId(chatRoomId).get("creater") == null
                || mapper.getChatRoomUserId(chatRoomId).get("invited") == null) {
            mapper.chatDeleteByChatRoomId(chatRoomId);
            mapper.chatRoomDeleteByChatRoomId(chatRoomId);
        } else {
            if (mapper.getChatRoomUserId(chatRoomId).get("creater").equals(myUserId)) {
                mapper.removeChatRoomCreater(chatRoomId);
            } else {
                mapper.removeChatRoomInvited(chatRoomId);
            }
        }
    }

    public Integer getChatRoomId(String myUserId, LocalDateTime dateInserted) {
        return mapper.getChatRoomIdByInserted(dateInserted, myUserId);
    }

    public void resetCount(Integer chatRoomId, String myUserId) {
        if (myUserId.equals(mapper.getCreaterByChatRoomId(chatRoomId))) {
            mapper.resetInvitedChatCount(chatRoomId);
        } else {
            mapper.resetCreaterChatCount(chatRoomId);
        }
        // TODO Auto-generated method stub

    }

    public boolean checkChatRoom(String yourId, String myId) {
        int cnt = 0;
        for (int i : mapper.checkChatRoom(yourId, myId)) {
            cnt += i;
        }
        return cnt > 0;
    }

    public LocalDateTime getChatLastInserted(Integer id) {
        if (mapper.getChatLastInserted(id) == null) {
            LocalDateTime time = LocalDateTime.now();
            return time;
        } else {
            return mapper.getChatLastInserted(id);
        }
    }

    public List<Chat> getChat(String myId, String yourId) {
        Integer chatRoomId = mapper.getChatRoomIdByYourId(myId, yourId);
        List<Chat> list = mapper.getChatSelectByChatRoomId(chatRoomId);
        List<LocalDateTime> dateTimeList = mapper.getinsertedByChatRoomId(chatRoomId);
        for (int i = 0; i < dateTimeList.size(); i++) {
            LocalTime time = dateTimeList.get(i).toLocalTime();
            list.get(i).setTime(time.getHour() + ":" + time.getMinute());
            list.get(i).setImgUrl(bucketUrl + "/ChatRoom/" + chatRoomId + "/" + list.get(i).getFileName());
        }
        return list;
    }

    public Integer getChatRoomId(String yourId, String myId) {
        return mapper.getChatRoomIdByYourId(myId, yourId);
    }

    public void createChatRoom(String myId, String yourNickName) {
        String yourId = memberMapper.getUserIdSelectByNickName(yourNickName);
        if (yourId == null) {
            return;
        } else {
            mapper.createChatRoom(myId, yourId);
        }

    }

    public void addFiles(Chat chat, MultipartFile[] files) throws Exception {
        Map<String, String> map = mapper.getChatRoomUserId(chat.getChatRoomId());
        if (!map.get("creater").equals(chat.getSenderId())) {
            chat.setRecipientId(map.get("creater"));
        } else {
            chat.setRecipientId(map.get("invited"));
        }
        for (MultipartFile file : files) {
            if (file.getSize() > 0) {

                // 이름이 될 내용
                String objectKey = "TeamPlay/ChatRoom/" + chat.getChatRoomId() + "/" + file.getOriginalFilename();

                // s3 첫번째 파라미터
                PutObjectRequest por = PutObjectRequest.builder().bucket(bucketName).key(objectKey)
                        .acl(ObjectCannedACL.PUBLIC_READ).build();

                // s3 두번째 파라미터
                RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());

                s3.putObject(por, rb);

                chat.setFileName(file.getOriginalFilename());

                mapper.insertFileChat(chat);
            }
        }
    }

    public List<ChatRoom> findRoomSelectBySearch(String search, String myId) {
        List<String> searchId = memberMapper.UserIdSelectBySearch(search);
        List<ChatRoom> list = new ArrayList<>();
        for (String s : searchId) {
            if (mapper.findRoomSelectBySearch(s, myId) != null) {
                list.add(mapper.findRoomSelectBySearch(s, myId));
            }
        }
        return list;
    }

    public List<Integer> searchChatId(String search, Integer chatRoomId) {
        return mapper.searchChatId(search, chatRoomId);
    }

    public Integer getMyCount(String name) {
        List<ChatRoom> list = mapper.chatRoomSelectByMyName(name);
        Integer count = 0;
        for (ChatRoom chatRoom : list) {
            if (chatRoom.getCreater().equals(name)) {
                count += chatRoom.getInvitedChatCount();
            } else {
                count += chatRoom.getCreaterChatCount();
            }
        }
        return count;
    }

    public List<Integer> customRequest(CustomRequest customRequest, MultipartFile[] files) throws IOException {
        int roomCnt = 0;
        Chat chat = new Chat();
        chat.setSenderId(customRequest.getCustomerUserId());
        chat.setRecipientId(customRequest.getArtistUserId());
        for (int i : mapper.checkChatRoom(customRequest.getArtistUserId(), customRequest.getCustomerUserId())) {
            roomCnt += i;
        }
        if (roomCnt <= 0) {
            mapper.createChatRoom(customRequest.getArtistUserId(), customRequest.getCustomerUserId());
        }
        chat.setChatRoomId(mapper.getChatRoomIdByYourId(chat.getSenderId(), chat.getRecipientId()));
        String myDateTime = customRequest.getMakeTime().toString().substring(2);
        String myDate = myDateTime.substring(0, 2);
        String myTime = myDateTime.substring(3);
        chat.setMessage(
                "아래의 내용으로 커스텀 작업이 가능할까요?\n" +
                        "커스텀 요청 신발\n" +
                        customRequest.getBrand() + " " + customRequest.getShoeName() + "\n" +
                        "커스텀 요청 사항\n" +
                        customRequest.getBody() +
                        "커스텀 희망 가격\n" +
                        customRequest.getPrice() +
                        "희망 수령일\n" +
                        myDate + "월 " + myTime + "일" + "까지 작품 수령을 희망합니다.");
        if(files[0].getSize() > 0) {
            chat.setMessage(chat.getMessage() + "\n참고 이미지");
        }
        int cnt = mapper.addChat(chat);
        for (MultipartFile file : files) {
            if (file.getSize() > 0) {

                // 이름이 될 내용
                String objectKey = "TeamPlay/ChatRoom/" + chat.getChatRoomId() + "/" + file.getOriginalFilename();

                // s3 첫번째 파라미터
                PutObjectRequest por = PutObjectRequest.builder().bucket(bucketName).key(objectKey)
                        .acl(ObjectCannedACL.PUBLIC_READ).build();

                // s3 두번째 파라미터
                RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());

                s3.putObject(por, rb);

                chat.setFileName(file.getOriginalFilename());

                mapper.insertFileChat(chat);
            }
        }

        return List.of(cnt, chat.getId());
    }

    public LocalDateTime getChatRoomInserted(String artistUserId, String customerUserId) {
        return mapper.getChatRoomInserted(artistUserId, customerUserId);
    }
}
