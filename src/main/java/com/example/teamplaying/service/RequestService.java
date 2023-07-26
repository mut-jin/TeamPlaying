package com.example.teamplaying.service;

import com.example.teamplaying.domain.Chat;
import com.example.teamplaying.domain.CustomRequest;
import com.example.teamplaying.mapper.ChatMapper;
import com.example.teamplaying.mapper.MemberMapper;
import com.example.teamplaying.mapper.RequestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RequestService {

    @Autowired
    private RequestMapper mapper;

    @Autowired
    private ChatMapper chatMapper;

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private S3Client s3;

    @Value("${aws.s3.bucketUrl}")
    private String bucketUrl;

    @Value("${aws.s3.bucketName}")
    private String bucketName;

    public List<Integer> customRequest(CustomRequest customRequest, MultipartFile[] files) throws IOException {
        int cnt = mapper.insertCustomRequest(customRequest);
        if (cnt != 1) {
            return List.of(cnt);
        }

        int roomCnt = 0;
        Chat chat = new Chat();
        chat.setSenderId(customRequest.getCustomerUserId());
        chat.setRecipientId(customRequest.getArtistUserId());
        for (int i : chatMapper.checkChatRoom(customRequest.getArtistUserId(), customRequest.getCustomerUserId())) {
            roomCnt += i;
        }
        if (roomCnt <= 0) {
            chatMapper.createChatRoom(customRequest.getArtistUserId(), customRequest.getCustomerUserId());
        }
        chat.setChatRoomId(chatMapper.getChatRoomIdByYourId(chat.getSenderId(), chat.getRecipientId()));
//        String myDateTime = customRequest.getMakeTime().toString().substring(2);
//        String myDate = myDateTime.substring(0, 2);
//        String myTime = myDateTime.substring(3);
        String customerNickName = memberMapper.getNickNameByUserId(customRequest.getCustomerUserId());
        chat.setMessage(customerNickName + "님이 커스텀 의뢰를 요청하셨습니다.");
//        if(files[0].getSize() > 0) {
//            chat.setMessage(chat.getMessage() + "\n참고 이미지");
//        }
        chatMapper.addChat(chat);
        for (MultipartFile file : files) {
            if (file.getSize() > 0) {

                // 이름이 될 내용
                String objectKey = "TeamPlay/request/" + customRequest.getId() + "/" + file.getOriginalFilename();

                // s3 첫번째 파라미터
                PutObjectRequest por = PutObjectRequest.builder().bucket(bucketName).key(objectKey)
                        .acl(ObjectCannedACL.PUBLIC_READ).build();

                // s3 두번째 파라미터
                RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());

                s3.putObject(por, rb);

                chat.setFileName(file.getOriginalFilename());

                mapper.insertFileCustomRequest(file.getOriginalFilename(), customRequest.getId());
            }
        }

        return List.of(cnt, chat.getId());
    }

    public Map<String, Object> getMyRequest(String artistId, Integer page) {
        Integer rowPerPage = 10;
        Integer startIndex = (page - 1) * rowPerPage;

        Integer myRequestCnt = mapper.getMyRequestCnt(artistId);
        Integer lastPageNum = (myRequestCnt - 1) / rowPerPage + 1;

        Integer rightPageNum = ((page - 1) / 5 + 1) * 5;
        Integer leftPageNum = rightPageNum - 4;
        leftPageNum = Math.max(leftPageNum, 1);
        rightPageNum = Math.min(rightPageNum, lastPageNum);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("rightPageNum", rightPageNum);
        pageInfo.put("leftPageNum", leftPageNum);
        pageInfo.put("lastPageNum", lastPageNum);
        pageInfo.put("currentPageNum", page);

        List<CustomRequest> list = mapper.getMyRequest(artistId, startIndex, rowPerPage);
        for (CustomRequest customRequest : list) {
            customRequest.setFileNameList(mapper.getFiles(customRequest.getId()));
//            System.out.println(customRequest.getProgress());
//            if (customRequest.getProgress().equals("접수 대기중")){
//                customRequest.setProgress("true");
//            }
//            System.out.println(customRequest.getProgress().getClass());
        }

        return Map.of("pageInfo", pageInfo, "myRequestList", list);
    }

    public void removeRequest(Integer id) {
        List<String> removeFileName = mapper.getFiles(id);
        if (removeFileName != null && !removeFileName.isEmpty()) {
            for (String fileName : removeFileName) {
                String objectKey = "TeamPlay/request/" + id + "/" + fileName;

                DeleteObjectRequest dor = DeleteObjectRequest.builder()
                        .key(objectKey)
                        .bucket(bucketName)
                        .build();
                s3.deleteObject(dor);
            }
        }
        mapper.removeRequestFile(id);

        int cnt = mapper.removeRequest(id);

    }

    public Map<String, Object> acceptRequest(CustomRequest customRequest) {
        int cnt = mapper.acceptRequest(customRequest);
        System.out.println(cnt);
        var res = new HashMap<String, Object>();
        if (cnt == 1) {
            res.put("message", "작업을 수락하셨습니다");
        } else {
            res.put("message", "작업이 수락되지 않았습니다");
        }

        return res;
    }

    public Map<String, Object> modify(CustomRequest customRequest) {
        int cnt = mapper.modify(customRequest);
        var res = new HashMap<String, Object>();
        if (cnt == 1) {
            res.put("message", "댓글이 수정되었습니다.");
        } else {
            res.put("message", "댓글이 수정되지 않았습니다.");
        }

        return res;
    }
}
