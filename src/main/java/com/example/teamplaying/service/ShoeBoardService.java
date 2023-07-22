package com.example.teamplaying.service;

import com.example.teamplaying.domain.*;
import com.example.teamplaying.mapper.ShoeBoardLikeMapper;
import com.example.teamplaying.mapper.ShoeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
    private ShoeBoardMapper shoeBoardMapper;

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

        List<ShoeBoard> list = mapper.selectAllPaging(direction ,startIndex, rowPerPage, search, type, brand, order);
        for (ShoeBoard i : list) {
            List<String> shoeList = new ArrayList<>();
            for (String j : mapper.getMyShoeFileNameList(i.getId())) {
                shoeList.add(bucketUrl + "/shoeBoard/" + i.getId() + "/" + j);
            }
            i.setImgUrlList(shoeList);
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
        return shoeBoardMapper.getShoesByBrand(brand);
    }

    public List<ShoeBoard> getAllShoesByBrand(String brand) {
        List<ShoeBoard> list = shoeBoardMapper.getAllShoesByBrand(brand);
        for(ShoeBoard shoeBoard : list) {
            shoeBoard.setFileName(bucketUrl + "/shoeBoard/" + shoeBoard.getId() + "/" + shoeBoard.getFileName());
        }
        return list;
    }




//    public List<String> getShoeNameList(String shoeBrand) {
//        return mapper.getShoeNameList(shoeBrand);
//    }
}
