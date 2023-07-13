package com.example.teamplaying.service;

import com.example.teamplaying.domain.CsBoard;
import com.example.teamplaying.domain.Member;
import com.example.teamplaying.mapper.CsMapper;
import com.example.teamplaying.mapper.ShoeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.util.List;

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

    public List<CsBoard> getCsBoardByWriter(String writer) {
        List<CsBoard> list = csMapper.getCsBoardByWriter(writer);
        for(CsBoard csBoard : list) {
            csBoard.setInsert(csBoard.getInserted().toLocalDate());
        }
        return list;
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

}