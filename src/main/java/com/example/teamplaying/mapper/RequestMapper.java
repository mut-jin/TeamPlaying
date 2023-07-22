package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.CustomRequest;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RequestMapper {

    @Insert("""
            INSERT INTO CustomRequestFileName(boardId, fileName)
            VALUES(#{boardId}, #{fileName})
            """)
    void insertFileCustomRequest(String fileName, Integer boardId);

    @Insert("""
            INSERT INTO CustomRequest(shoeName, body, price, brand, makeTime, artistUserId, customerUserId)
            VALUES(#{shoeName}, #{body}, #{price}, #{brand}, #{makeTime}, #{artistUserId}, #{customerUserId})
            """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertCustomRequest(CustomRequest customRequest);

    @Select("""
            SELECT COUNT(*) FROM CustomRequest
            WHERE artistUserId = #{artistUserId}
            """)
    Integer getMyRequestCnt(String artistUserId);

    @Select("""
            SELECT * FROM CustomRequest
            WHERE artistUserId = #{artistUserId}
            ORDER BY id DESC
            LIMIT #{startIndex}, #{rowPerPage}
            """)
    List<CustomRequest> getMyRequest(String artistUserId, Integer startIndex, Integer rowPerPage);

    @Select("""
            SELECT fileName FROM CustomRequestFileName
            WHERE boardId = #{boardId}
            """)
    List<String> getFiles(Integer boardId);

    @Delete("""
            DELETE FROM CustomRequestFileName
            WHERE boardId = #{boardId}
            """)
    void removeRequestFile(Integer boardId);

    @Delete("""
            DELETE FROM CustomRequest
            WHERE id = #{id}
            """)
    int removeRequest(Integer id);

    @Update("""
            UPDATE CustomRequest
            SET
                progress = #{progress}
            WHERE
                id = #{id}
            """)
    boolean acceptRequest(Integer id, String progress);
}
