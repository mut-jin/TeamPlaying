package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.CustomRequest;
import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.domain.ShoeComment;
import org.apache.ibatis.annotations.*;
import retrofit2.http.DELETE;

import java.util.List;

@Mapper
public interface ShoeBoardMapper {


    @Select("""
            SELECT
                s.id,
                s.shoeName,
                s.title,
                s.nickName,
                s.view,
                s.price,
                (SELECT COUNT(*) FROM shoeLike WHERE boardId = s.id) likeCount,
                (SELECT COUNT(*) FROM shoeComment WHERE boardId = s.id) commentCount
            FROM
                shoeBoard s
            LEFT JOIN
                shoeFileName f ON s.id = f.boardId
            LEFT JOIN
                shoeLike sl ON s.id = sl.boardId
            LEFT JOIN
                shoeComment st ON s.id = st.boardId
            ORDER BY
                s.id DESC
            		""")
//    @ResultMap("ShoeBoardResultMap")
    List<ShoeBoard> selectShoeBoardList();


    @Select("""
            SELECT id FROM shoeBoard
            WHERE memberId = #{memberId}
            ORDER BY id DESC
            """)
    List<Integer> getBoardIdList(Integer memberId, Integer startIndex, Integer rowPerPage);

    @Select("""
            SELECT fileName FROM shoeFileName
            WHERE boardId = #{boardId}
            LIMIT 1
            """)
    String getMyShoeFileName(Integer boardId);

    @Select("""
            SELECT fileName FROM shoeFileName
            WHERE boardId = #{boardId}
            """)
    List<String> getMyShoeFileNameAll(Integer boardId);

    @Select("""
            SELECT COUNT(*) FROM subscribe
            WHERE artistId = #{id}
            """)
    Integer getMySubscribe(Integer id);

    @Select("""
            <script>
            <bind name="pattern" value="'%' + search + '%'"/>
            SELECT COUNT(*) FROM shoeBoard
            <where>
                shoeName LIKE #{pattern}
            </where>
            </script>
            """)
    Integer getshoeBoardNum(String search);

    @Select("""
            <script>
            <bind name="pattern" value="'%' + search + '%'"/>
            SELECT
            	id,
            	shoeName,
            	memberId,
            	title,
            	nickName,
            	body,
            	makeTime,
            	inserted,
            	brand,
            	view,
            	price,
            	(SELECT COUNT(*) FROM shoeLike WHERE boardId = s.id) likeCount,
            	(SELECT COUNT(*) FROM shoeComment WHERE boardId = s.id) commentCount,
            	(SELECT userId FROM Member WHERE id = s.memberId) userId
            FROM shoeBoard s
            WHERE title LIKE #{pattern}
            <if test="brand != null">
                AND brand = #{brand}
            </if>
            ORDER BY ${order} ${direction}
            LIMIT #{startIndex}, #{rowPerPage}
            </script>
            """)
    List<ShoeBoard> selectAllPaging(String direction, Integer startIndex, Integer rowPerPage, String search, String type, String brand, String order);

    @Select("""
            SELECT fileName FROM shoeFileName
            WHERE boardId = #{boardId}
            """)
    List<String> getMyShoeFileNameList(Integer boardId);


    @Select("""
            SELECT shoeName FROM shoeBoard
            WHERE brand = #{brand}
            """)
    List<String> getShoeModelsByBrand(String brand);

    @Select("""
            SELECT * FROM Member
            WHERE userId = #{userId}
            """)
    Member selectMemberById(String userId);

    @Insert("""
            INSERT INTO shoeBoard (nickName, title, body, shoeName, memberId, makeTime, price, brand)
            VALUES (#{nickName}, #{title}, #{body}, #{shoeName}, #{memberId}, #{makeTime}, #{price}, #{brand})
            """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(ShoeBoard shoeBoard);

    @Insert("""
            INSERT INTO shoeFileName (boardId, fileName)
            VALUES (#{boardId}, #{fileName})
            """)
    void insertFileName(Integer boardId, String fileName);

    @Select("""
                     SELECT
                         s.id,
                         s.shoeName,
                         s.title,
                         s.nickName,
                         s.view,
                         s.price,
                         s.body,
                         s.makeTime,
                         f.fileName,
                         m.userId,
                         (SELECT COUNT(*) FROM shoeLike WHERE boardId = s.id) likeCount,
                     FROM
                         shoeBoard s
                         LEFT JOIN shoeFileName f ON s.id = f.boardId
            	LEFT JOIN Member m ON s.nickName = m.nickName
            	LEFT JOIN shoeLike sl on s.id = sl.boardId
            WHERE s.id = #{id}
                             """)
    @ResultMap("shoeBoardResultMap")
    List<ShoeBoard> selectById(Integer id);

    @Select("""
            select * from Member where userId = #{userId}
            """)
    Member getNickName(String name);

    @Select("SELECT * FROM shoeBoard WHERE brand = #{brand}")
    List<ShoeBoard> getShoesByBrand(@Param("brand") String brand);


    @Select("""
            SELECT
                s.id,
                s.shoeName,
                s.title,
                s.nickName,
                s.brand,
                s.memberId,
                s.view,
                s.price,
                s.body,
                s.makeTime,
                f.fileName,
                m.profile,
                m.address,
                m.userId,
                (SELECT COUNT(*) FROM shoeLike WHERE boardId = s.id) likeCount,
                (SELECT COUNT(*) FROM shoeComment WHERE boardId = s.id) commentCount
            FROM
                shoeBoard s
                LEFT JOIN shoeFileName f ON s.id = f.boardId
                LEFT JOIN shoeLike sl ON s.id = sl.boardId
                LEFT JOIN Member m ON m.id = s.memberId
            WHERE
                s.brand = #{brand}
            GROUP BY
                id
            ORDER BY
                s.id DESC
            LIMIT 6
            """)
    List<ShoeBoard> getAllShoesByBrand(String brand);

    @Update("""
            Update shoeBoard
            SET
                view = view + 1
            WHERE id = #{id}
            """)
    void updateView(Integer id);

    @Select("""
            SELECT view FROM shoeBoard
            WHERE id = #{id}
            """)
    Integer getView(Integer id);

    @Insert("""
                     INSERT INTO shoeComment (boardId, content, memberId)
            VALUES (#{boardId}, #{content} , #{memberId})
                     """)
    int insertComment(ShoeComment comment);

    @Select("""
                     SELECT *
            FROM shoeComment
            WHERE boardId = #{boardId}
            ORDER BY id DESC
                     """)
    List<ShoeComment> selectAllByBoardId(Integer boardId);

    @Select("""
            SELECT * FROM shoeComment
            WHERE id = #{id}
            """)
    ShoeComment commentSelectById(Integer id);

    @Select("""
            SELECT * FROM shoeBoard
            WHERE id = #{id}
            """)
    ShoeBoard getShoeBoardById(Integer id);

    @Update("""
            UPDATE shoeComment
            SET
            	content = #{content}
            WHERE
            	id = #{id}
            """)
    int commentUpdate(ShoeComment comment);

    @Delete("""
			DELETE FROM shoeComment
			WHERE id = #{id}
			""")
    int commentDeleteById(Integer id);

    @Insert("""
            INSERT INTO CustomRequest(shoeName, body, price, brand, makeTime, artistUserId, customerUserId, title)
            VALUES(#{shoeName}, #{body}, #{price}, #{brand}, #{makeTime}, #{artistUserId}, #{customerUserId}, #{title})
            """)
    void addCustomRequest(CustomRequest customRequest);

    @Select("""
            SELECT
            	id,
            	shoeName,
            	memberId,
            	title,
            	nickName,
            	body,
            	makeTime,
            	inserted,
            	brand,
            	view,
            	price,
            	(SELECT COUNT(*) FROM shoeLike WHERE boardId = s.id) likeCount,
            	(SELECT COUNT(*) FROM shoeComment WHERE boardId = s.id) commentCount
            FROM shoeBoard s
            WHERE memberId = #{memberId}
            ORDER BY id DESC
            LIMIT #{startIndex}, #{rowPerPage}
            """)
    List<ShoeBoard> getAllShoesByArtistId(Integer memberId, Integer startIndex, Integer rowPerPage);

    @Select("""
            SELECT
            	id,
            	shoeName,
            	memberId,
            	title,
            	nickName,
            	body,
            	makeTime,
            	inserted,
            	brand,
            	view,
            	price,
            	(SELECT COUNT(*) FROM shoeLike WHERE boardId = s.id) likeCount,
            	(SELECT COUNT(*) FROM shoeComment WHERE boardId = s.id) commentCount,
            	(SELECT userId FROM Member WHERE id = s.memberId) userId
            FROM shoeBoard s
            WHERE memberId = #{memberId}
            ORDER BY id DESC
            """)
    List<ShoeBoard> getAllShoes(Integer memberId);

    @Delete("""
            DELETE FROM shoeBoard
            WHERE id = #{id}
            """)
    Integer shoeDelete(Integer id);

    @Delete("""
            DELETE FROM shoeFileName
            WHERE boardId = #{boardId}
            """)
    void shoeFileDelete(Integer boardId);

    @Select("""
            SELECT fileName FROM shoeFileName
            WHERE boardId = #{boardId}
            """)
    List<String> selectFileNameList(Integer boardId);

    @Select("""
            SELECT * FROM shoeBoard
            WHERE id = #{id}
            """)
    ShoeBoard getShoeBoard(Integer id);

    @Select("""
            SELECT title FROM shoeBoard
            WHERE title = #{title}
            LIMIT 1
            """)
    String contains(String title);

    @Delete("""
            DELETE FROM shoeComment
            WHERE boardId = #{boardId}
            """)
    void commentDelete(Integer boardId);

    @Delete("""
            DELETE FROM shoeLike
            WHERE boardId = #{boarId}
            """)
    void likeDelete(Integer boardId);

    @Update("""
            UPDATE CustomRequest
            SET progress = #{progress}
            WHERE id = #{id}
            """)
    void progressUpdate(CustomRequest customRequest);


    //    @Select("""
//            SELECT shoeName FROM shoeBoard
//            WHERE brand = #{shoeBrand}
//            """)
//    List<String> getShoeNameList(String shoeBrand);
}
