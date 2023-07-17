package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.domain.ShoeFileName;
import org.apache.ibatis.annotations.*;

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
            """)
    List<Integer> getBoardIdList(Integer memberId);

    @Select("""
            SELECT fileName FROM shoeFileName
            WHERE boardId = #{boardId}
            LIMIT 1
            """)
    String getMyShoeFileName(Integer boardId);

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
            	view,
            	price,
            	(SELECT COUNT(*) FROM shoeLike WHERE boardId = s.id) likeCount,
            	(SELECT COUNT(*) FROM shoeComment WHERE boardId = s.id) commentCount
            FROM shoeBoard s
            WHERE shoeName LIKE #{pattern}
            ORDER BY id DESC
            LIMIT #{startIndex}, #{rowPerPage}
            </script>
            """)
    List<ShoeBoard> selectAllPaging(Integer startIndex, Integer rowPerPage, String search, String type);

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



    @Select("SELECT * FROM shoeBoard WHERE brand = #{brand}")
    List<ShoeBoard> getAllShoesByBrand(@Param("brand") String brand);



    //    @Select("""
//            SELECT shoeName FROM shoeBoard
//            WHERE brand = #{shoeBrand}
//            """)
//    List<String> getShoeNameList(String shoeBrand);
}
