package com.example.teamplaying.service;

import com.example.teamplaying.domain.CsBoard;
import com.example.teamplaying.mapper.CsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CsService {

    @Autowired
    private S3Client s3;

    @Value("${aws.s3.bucketUrl}")
    private String bucketUrl;

    @Value("${aws.s3.bucketName}")
    private String bucketName;

    @Autowired
    private CsMapper csMapper;

    public Map<String, Object> getCsBoardByWriter(String writer, String search, Integer page) {
        Integer rowPerPage = 10;
        Integer startIndex = (page - 1) * rowPerPage;

        Integer csCount = csMapper.getCsCount(search, writer);
        Integer lastPageNum = (csCount - 1) / rowPerPage + 1;

        Integer rightPageNum = ((page - 1) / 5 + 1) * 5;
        Integer leftPageNum = rightPageNum - 4;
        leftPageNum = Math.max(leftPageNum, 1);
        rightPageNum = Math.min(rightPageNum, lastPageNum);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("rightPageNum", rightPageNum);
        pageInfo.put("leftPageNum", leftPageNum);
        pageInfo.put("lastPageNum", lastPageNum);
        pageInfo.put("currentPageNum", page);

        List<CsBoard> list = csMapper.getCsBoardByWriter(writer, startIndex, rowPerPage, search);
        for(CsBoard csBoard : list) {
            csBoard.setInsert(csBoard.getInserted().toLocalDate());
        }
        return Map.of("pageInfo", pageInfo, "csBoardList", list);
    }

    public boolean add(CsBoard csBoard, MultipartFile[] files) throws Exception {
        int cnt = csMapper.insert(csBoard);
        for (MultipartFile file : files) {
            if (file.getSize() > 0) {
                String objectKey = "TeamPlay/csBoard/" + csBoard.getId() + "/" + file.getOriginalFilename();
                PutObjectRequest por = PutObjectRequest.builder()
                        .acl(ObjectCannedACL.PUBLIC_READ)
                        .bucket(bucketName)
                        .key(objectKey)
                        .build();
                RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());

                s3.putObject(por, rb);
                csMapper.insertFileName(csBoard.getId(), file.getOriginalFilename());

            }
        }
        return cnt == 1;
    }

    public Map<String, Object> getCsBoardById(Integer id) {
        CsBoard csBoard = csMapper.getCsBoardById(id);
        List<String> list = csMapper.getCsFileNameList(id);
//        for(int i = 0; i < list.size(); i++) {
//            list.set(i, bucketUrl + "/csBoard/" + id + "/" + list.get(i));
//        }
        return Map.of("csBoard", csBoard, "files", list);
    }

    public boolean remove(Integer id) {
        List<String> removeFileName = csMapper.getCsFileNameList(id);
        if (removeFileName != null && !removeFileName.isEmpty()) {
            for (String fileName : removeFileName) {
                String objectKey = "TeamPlay/csBoard/" + id + "/" + fileName;

                DeleteObjectRequest dor = DeleteObjectRequest.builder()
                        .key(objectKey)
                        .bucket(bucketName)
                        .build();
                s3.deleteObject(dor);
            }
        }
        csMapper.removeFiles(id);
        int cnt = csMapper.remove(id);

        return cnt == 1;
    }

    public boolean modify(CsBoard csBoard, List<String> removeFileName, MultipartFile[] addFiles) throws Exception {
        if (removeFileName != null && !removeFileName.isEmpty()) {
            for (String fileName : removeFileName) {
                String objectKey = "TeamPlay/csBoard/" + csBoard.getId() + "/" + fileName;

                DeleteObjectRequest dor = DeleteObjectRequest.builder()
                        .key(objectKey)
                        .bucket(bucketName)
                        .build();
                s3.deleteObject(dor);
                csMapper.removeCsFile(fileName, csBoard.getId());
            }
        }

        for (MultipartFile file : addFiles) {
            if (file.getSize() > 0) {
                String objectKey = "TeamPlay/csBoard/" + csBoard.getId() + "/" + file.getOriginalFilename();
                PutObjectRequest por = PutObjectRequest.builder()
                        .acl(ObjectCannedACL.PUBLIC_READ)
                        .bucket(bucketName)
                        .key(objectKey)
                        .build();
                RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());

                s3.putObject(por, rb);
                csMapper.insertFileName(csBoard.getId(), file.getOriginalFilename());

            }
        }

        int cnt = csMapper.csModify(csBoard);

        return cnt == 1;
    }


    public void updateAnswer(String answer, Integer id) {
        csMapper.updateAnswer(answer, id);
    }
}