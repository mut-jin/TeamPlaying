package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.CsBoard;
import org.apache.ibatis.annotations.*;

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
            <script>
            <bind name="pattern" value="'%' + search + '%'"/>
            SELECT * FROM CsBoard
            WHERE writer = #{writer}
                AND title LIKE #{pattern}
            ORDER BY id DESC
            LIMIT #{startIndex}, #{rowPerPage}
            </script>
            """)
    List<CsBoard> getCsBoardByWriter(String writer, Integer startIndex, Integer rowPerPage, String search);

    @Select("""
            <script>
            <bind name="pattern" value="'%' + search + '%'"/>
            SELECT COUNT(*) FROM CsBoard
            WHERE writer = #{writer}
                AND title = #{pattern}
            </script>
            """)
    Integer getCsCount(String search, String writer);

    @Select("""
            SELECT * FROM CsBoard
            WHERE id = #{id}
            """)
    CsBoard getCsBoardById(Integer id);

    @Select("""
            SELECT fileName FROM CsFileName
            WHERE boardId = #{boardId}
            """)
    List<String> getCsFileNameList(Integer boardId);

    @Delete("""
            DELETE FROM CsFileName
            WHERE boardId = #{boardId}
            """)
    void removeFiles(Integer boardId);

    @Delete("""
            DELETE FROM CsBoard
            WHERE id = #{id}  
            """)
    int remove(Integer id);

    @Delete("""
            DELETE FROM CsFileName
            WHERE boardId = #{boardId} AND fileName = #{file}
            """)
    void removeCsFile(String file, Integer boardId);

    @Update("""
            UPDATE CsBoard
            SET 
                title = #{title},
                category = #{category},
                body = #{body}
            WHERE 
                id = #{id}
            """)
    int csModify(CsBoard csBoard);

    @Update("""
            UPDATE CsBoard
            SET
                answer = #{answer}
            WHERE
                id = #{id}
            """)
    void updateAnswer(String answer, Integer id);

    @Select("""
            SELECT writer FROM CsBoard
            WHERE id = #{id}
            """)
    String getWriter(Integer id);
}
