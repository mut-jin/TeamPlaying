package com.example.teamplaying.service;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.mapper.MemberMapper;
import com.example.teamplaying.mapper.ShoeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import com.example.teamplaying.domain.Member;
import com.example.teamplaying.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional(rollbackFor = Exception.class)
public class MemberService {

    private final MemberDao memberDao;

    @Autowired
    public MemberService(MemberDao memberDao) {
        this.memberDao = memberDao;
    }

//    public List<Member> getAllMembers() {
//        return memberDao.getMemberList();
//    }


    @Autowired
    private S3Client s3;

    @Autowired
    private ShoeBoardMapper shoeMapper;

    @Autowired
    private MemberMapper mapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Value("${aws.s3.bucketUrl}")
    private String bucketUrl;

    @Value("${aws.s3.bucketName}")
    private String bucketName;

    public String getNickName(String userId) {

        return mapper.getNickNameByUserId(userId);
    }

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

    public List<Member> getAllMembers() {
        return mapper.selectAllMember();
    }


    public Member get(String userId) {
        return mapper.selectById(userId);
    }

//    public boolean modify(Member member, String oldPassword) {
//        Member oldMember = mapper.selectById(member.getUserId());
//
//        int cnt = 0;
//        if (oldMember.getPassword().equals(oldPassword)) {
//
//            cnt = mapper.update(member);
//        }
//
//        return cnt == 1;
//    }

    public boolean remove(Member member) {
        Member oldMember = mapper.selectById(member.getUserId());
        int cnt = 0;

        if (passwordEncoder.matches(member.getPassword(), oldMember.getPassword())) {
            // 암호가 같으면?

            cnt = mapper.deleteById(member.getUserId());
        }

        return cnt == 1;
    }

    public boolean modify(Member member, String oldPassword) {

        // 패스워드를 바꾸기 위해 노력했다면...
        if (!member.getPassword().isBlank()) {

            // 입력된 패스워드를 암호화
            String plain = member.getPassword();
            member.setPassword(passwordEncoder.encode(plain));
        }

        Member oldMember = mapper.selectById(member.getUserId());

        int cnt = 0;

        if(passwordEncoder.matches(oldPassword, oldMember.getPassword())) {
            // 기존 암호와 같으면
            cnt = mapper.update(member);
        }

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

    public Map<String, Object> getArtistBoard(Integer page, String search, String order, String name) {
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

        List<Member> list = mapper.selectAllPaging(startIndex, rowPerPage, search, order);
        for (Member i : list) {
            List<String> shoeList = new ArrayList<>();
            List<Integer> boardIdList = shoeMapper.getBoardIdList(i.getId());
            for (Integer boardID : boardIdList) {
                shoeList.add(bucketUrl + "/shoeBoard/" + boardID + "/" + shoeMapper.getMyShoeFileName(boardID));

            }
            i.setProfile(bucketUrl + "/Member/" + i.getId() + "/" + i.getProfile());
            i.setSubCount(shoeMapper.getMySubscribe(i.getId()));
            i.setShoeImgList(shoeList);
            if (i.getTotalView() == null) {
                i.setTotalView(0);
            }
        }

        return Map.of("pageInfo", pageInfo, "boardList", list, "name", name);
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

        Member member = mapper.getMemberById(startIndex, rowPerPage, id);
        member.setProfile(bucketUrl + "/Member/" + id + "/" + member.getProfile());
        List<Integer> boardIdList = shoeMapper.getBoardIdList(id);
        List<String> shoeList = new ArrayList<>();
        for (Integer boardID : boardIdList) {
            shoeList.add(bucketUrl + "/shoeBoard/" + boardID + "/" + shoeMapper.getMyShoeFileName(boardID));
        }
        member.setShoeImgList(shoeList);

        return Map.of("pageInfo", pageInfo, "memberInfo", member);
    }

    public boolean addShoeBoard(ShoeBoard shoeBoard, MultipartFile[] files, Authentication authentication) throws Exception {
        Member member = shoeMapper.selectMemberById(authentication.getName());
        shoeBoard.setNickName(member.getNickName());
        shoeBoard.setMemberId(member.getId());

        int cnt = shoeMapper.insert(shoeBoard);
        for (MultipartFile file : files) {
            if (file.getSize() > 0) {
                String objectKey = "TeamPlay/shoeBoard/" + shoeBoard.getId() + "/" + file.getOriginalFilename();
                PutObjectRequest por = PutObjectRequest.builder()
                        .acl(ObjectCannedACL.PUBLIC_READ)
                        .bucket(bucketName)
                        .key(objectKey)
                        .build();
                RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());

                s3.putObject(por, rb);
                shoeMapper.insertFileName(shoeBoard.getId(), file.getOriginalFilename());

            }
        }
        return cnt == 1;

    }

    public Integer getIdByUserId(String userId) {
        return mapper.getId(userId);
    }

    public Map<String, Object> getArtistBoard(Integer artistId) {
        Member member = mapper.getArtistInfo(artistId);
        List<ShoeBoard> shoeList = mapper.getShoeBoardList(member.getId());

        return Map.of("member", member, "shoeList", shoeList);
    }


//        public boolean deleteMember(int memberId) {
//            // 회원 삭제 작업 수행
//            int rowsAffected = mapper.deleteMemberById(memberId);
//            return rowsAffected > 0;
//        }

//    public boolean deactivateMember(int memberId) {
//        // 회원 상태를 비활성화(0)로 변경하는 작업 수행
//        int rowsAffected = mapper.deactivateMemberById(memberId);
//        return rowsAffected > 0;
//    }

    public boolean deactivateMember(int id) {
        int rowsAffected = mapper.updateMemberStatus(id, 0);
        return rowsAffected > 0;
    }

    public String findIdByNameAndEmail(String name, String email) {
        Member member = mapper.selectByNameAndEmail(name, email);
        return (member != null) ? member.getUserId() : null;
    }
}
