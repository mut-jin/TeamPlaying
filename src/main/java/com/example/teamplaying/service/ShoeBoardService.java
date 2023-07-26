package com.example.teamplaying.service;

import com.example.teamplaying.domain.*;
import com.example.teamplaying.mapper.MemberMapper;
import com.example.teamplaying.mapper.ShoeBoardLikeMapper;
import com.example.teamplaying.mapper.ShoeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Comparator;


@Service
public class ShoeBoardService {

    @Value("${aws.s3.bucketUrl}")
    private String bucketUrl;

    @Autowired
    private ShoeBoardMapper mapper;

    @Autowired
    private ShoeBoardLikeMapper likeMapper;

    @Autowired
    private MemberMapper memberMapper;

    public Map<String, Object> getshoeBoard(Integer page, String search, String type, String brand, String order, String direction) {
        Integer rowPerPage = 18;
        Integer startIndex = (page - 1) * rowPerPage;

        Integer shoeBoardNum = mapper.getshoeBoardNum(search);
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
        pageInfo.put("brand", brand);
        pageInfo.put("order", order);

        List<ShoeBoard> list = mapper.selectAllPaging(direction, startIndex, rowPerPage, search, type, brand, order);
        for (ShoeBoard i : list) {
//            List<String> shoeList = new ArrayList<>();
//            for (String j : mapper.getMyShoeFileNameList(i.getId())) {
//                shoeList.add(bucketUrl + "/shoeBoard/" + i.getId() + "/" + j);
//            }
            i.setImgUrlList(mapper.getMyShoeFileNameList(i.getId()));
        }
        return Map.of("pageInfo", pageInfo, "shoeBoardList", list);
    }

    public List<String> getShoeModelsByBrand(String brand) {
        List<String> shoeNameList = mapper.getShoeModelsByBrand(brand);
        return shoeNameList;
    }

    public List<ShoeBoard> workListBoard() {
        return mapper.selectShoeBoardList();
    }

    public List<ShoeBoard> getShoeBoard(Integer id, String myUserId) {

        List<ShoeBoard> list = mapper.selectById(id);
        for (ShoeBoard shoeBoard : list) {
            if (myUserId != null) {
                ShoeLike like = likeMapper.select(id, myUserId);
                if (like != null) {
                    shoeBoard.setLiked(true);
                }
            }
        }
        return list;
    }

    public Member getNickName(String name) {

        return mapper.getNickName(name);
    }

    public List<ShoeBoard> getShoesByBrand(String brand) {
        return mapper.getShoesByBrand(brand);
    }

    public List<ShoeBoard> getAllShoesByBrand(String brand) {
        List<ShoeBoard> list = mapper.getAllShoesByBrand(brand);
        for (ShoeBoard shoeBoard : list) {
            shoeBoard.setFileName(bucketUrl + "/shoeBoard/" + shoeBoard.getId() + "/" + shoeBoard.getFileName());
            shoeBoard.setImgUrlList(mapper.getMyShoeFileNameList(shoeBoard.getId()));
            shoeBoard.setProfile(bucketUrl + "/member/" + shoeBoard.getMemberId() + "/" + shoeBoard.getProfile());
        }
        return list;
    }

    public Integer updateAndGetView(Integer id) {
        mapper.updateView(id);
        System.out.println("a");
        return mapper.getView(id);
    }

    public Map<String, Object> like(ShoeLike like, Authentication authentication) {
        Map<String, Object> result = new HashMap<>();

        result.put("like", false);

        like.setMemberId(authentication.getName());
        Integer deleteCnt = likeMapper.delete(like);

        if (deleteCnt != 1) {
            Integer insertCnt = likeMapper.insert(like);
            result.put("like", true);
        }

        Integer count = likeMapper.countByBoardId(like.getBoardId());
        result.put("count", count);

        return result;
    }

    public Map<String, Object> commentAdd(ShoeComment comment, Authentication authentication) {
        comment.setMemberId(authentication.getName());

        var res = new HashMap<String, Object>();

        int cnt = mapper.insertComment(comment);
        if (cnt == 1) {
            res.put("message", "댓글이 등록되었습니다.");
        } else {
            res.put("message", "댓글이 등록되지 않았습니다.");
        }

        return res;
    }

    public List<ShoeComment> commentList(Integer boardId, Authentication authentication) {
        List<ShoeComment> comments = mapper.selectAllByBoardId(boardId);
        if (authentication != null) {
            for (ShoeComment comment : comments) {
                comment.setEditable(comment.getMemberId().equals(authentication.getName()));
            }
        }
        return comments;
    }

    public ShoeComment getComment(Integer id) {
        return mapper.commentSelectById(id);
    }

    public Map<String, Object> commentUpdate(ShoeComment comment) {
        int cnt = mapper.commentUpdate(comment);
        var res = new HashMap<String, Object>();
        if (cnt == 1) {
            res.put("message", "댓글이 수정되었습니다.");
        } else {
            res.put("message", "댓글이 수정되지 않았습니다.");
        }

        return res;
    }

    public Map<String, Object> commentRemove(Integer id) {
        int cnt = mapper.commentDeleteById(id);

        var res = new HashMap<String, Object>();

        if (cnt == 1) {
            res.put("message", "댓글이 삭제되었습니다.");
        } else {
            res.put("message", "댓글이 삭제 되지 않았습니다.");
        }
        return res;
    }

    public void addCustomRequest(CustomRequest customRequest) {
        customRequest.setArtistUserId(memberMapper.getUserIdSelectById(customRequest.getMemberId()));
        mapper.addCustomRequest(customRequest);
    }


//    public List<String> getShoeNameList(String shoeBrand) {
//        return mapper.getShoeNameList(shoeBrand);
//    }
}
