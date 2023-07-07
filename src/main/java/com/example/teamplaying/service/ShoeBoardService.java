package com.example.teamplaying.service;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.mapper.ShoeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ShoeBoardService {

    @Value("${aws.s3.bucketUrl}")
    private String bucketUrl;

    @Autowired
    private ShoeBoardMapper mapper;

    public Map<String, Object> getshoeBoard(Integer page, String search, String type) {
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

        List<ShoeBoard> list = mapper.selectAllPaging(startIndex, rowPerPage, search, type);
        for (ShoeBoard i : list) {
            List<String> shoeList = new ArrayList<>();
            for (String j : mapper.getMyShoeFileNameList(i.getId())) {
                shoeList.add(bucketUrl + "/shoeBoard/" + i.getId() + "/" + j);
            }
            i.setImgUrlList(shoeList);
        }
        return Map.of("pageInfo", pageInfo, "boardList", list);
    }
}
