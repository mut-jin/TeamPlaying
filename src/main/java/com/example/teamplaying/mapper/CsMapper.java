package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.CsBoard;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CsMapper {

    @Insert("""
            INSERT INTO CsBoard(title, category, body, writer)
            VALUES(#{title}, #{category}, #{body}, #{writer})
            """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(CsBoard csBoard);

    @Insert("""
            INSERT INTO CsFileName(boardId, fileName)
            VALUES(#{boardId}, #{fileName})
            """)
    void insertFileName(Integer boardId, String fileName);

    @Select("""
            SELECT * FROM CsBoard
            WHERE writer = #{writer}
            """)
    List<CsBoard> getCsBoardByWriter(String writer);
}
