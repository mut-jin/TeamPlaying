package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MemberMapper {

    @Select("""
            SELECT nickName FROM Member
            WHERE userId = #{userId}
            """)
    String getNickNameByUserId(String userId);

    @Select("""
            SELECT * FROM Member
            WHERE userId = #{userId}
            AND status = 1
            """)
    Member getMemberInfoByUserId(String userId);

    @Insert("""
            insert into Member
            (userId, password, name, nickName, birth, memberType, address, addressDetail, phone, email, introduce)
            values (#{userId}, #{password}, #{name} ,#{nickName}, #{birth}, #{memberType}, #{address}, #{addressDetail}, #{phone}, #{email}, #{introduce})
            """)
    Integer insertMember(Member member);

    ////////////////
    @Select("""
            SELECT *
            FROM Member
            ORDER BY inserted DESC
            """)
    List<Member> selectAll();

    @Select("""
            SELECT *
            FROM Member
            WHERE userId = #{userId}
            """)
    Member selectById(String userId);

    @Delete("""
            DELETE FROM Member
            WHERE userId=#{userId}
            """)
    Integer deleteById(String userId);

    @Update("""
            UPDATE Member
            SET
               <if test = "password neq null and password neq ''">
               password = #{password},
               </if>
               name     = #{name},
               nickName = #{nickName},
               birth    = #{birth},
               gender   = #{gender},
               address  = #{address},
               phone    = #{phone},
               email    = #{email},
               introduce= #{introduce}
            WHERE
               userId = #{userId};
            """)
    Integer update(Member member);

    @Select("""
            SELECT userId FROM Member
            WHERE nickName = #{invitedNickName}
            """)
    String getUserIdSelectByNickName(String invitedNickName);

    @Select("""
            SELECT userId FROM Member
            WHERE nickName LIKE CONCAT('%', #{search}, '%')
            """)
    List<String> UserIdSelectBySearch(String search);

    @Update("""
            UPDATE Member
            SET password = #{password},
               name     = #{name},
               nickName = #{nickName},
               birth     = #{birth},
               gender     = #{gender},
               address  = #{address},
               phone    = #{phone},
               email    = #{email},
               introduce= #{introduce}
            WHERE
               id = #{id};
            """)
    Integer updateMember(Member member);

    @Select("""
            SELECT id FROM Member
            WHERE userId = #{userId}
            """)
    Integer getId(String userId);

    @Select("""
            SELECT *
            FROM Member
            WHERE NickName = #{NickName}
            """)
    Member selectByNickName(String nickName);

    @Select("""
            SELECT *
            FROM Member
            WHERE email = #{email}
            """)
    Member selectByEmail(String email);

    @Delete("""
            DELETE FROM Member
            WHERE userId = #{userId}
            """)
    int deleteMember(String userId);

    @Delete("""
            DELETE FROM Chat
            WHERE senderId = #{userId} or recipientId = #{userId}
            """)
    void deleteChatByUserId(String userId);

    @Delete("""
            DELETE FROM ChatRoom
            WHERE creater = #{userId} or invited = #{userId}
            """)
    void deleteChatRoomByUserId(String userId);

    @Delete("""
            DELETE FROM GroupChatMessage
            WHERE senderId = #{userId}
            """)
    void deleteGroupChatRoomByUserId(String userId);

    @Select("""
            <script>
                <bind name="pattern" value="'%' + search + '%'"/>
                SELECT COUNT(*) FROM Member
                <where>
                    memberType = 'artist' AND
                    nickName LIKE #{pattern}
                </where>
            </script>
            """)
    int getArtistNum(String search);

    @Select("""
            <script>
            <bind name="pattern" value="'%' + search + '%'"/>
            SELECT
            	id,
            	nickName,
            	address,
            	profile,
            	(SELECT SUM(view) FROM shoeBoard WHERE memberId = m.id) totalView,
            	(SELECT COUNT(*) FROM shoeBoard WHERE memberId = m.id) totalWork,
            	(SELECT COUNT(*) FROM subscribe WHERE artistId = m.id) subscribe
            FROM Member m
            WHERE memberType = 'artist' AND
                  nickName LIKE #{pattern}
            ORDER BY ${order} DESC
            LIMIT #{startIndex}, #{rowPerPage}
            </script>
            """)
    List<Member> selectAllPaging(Integer startIndex, Integer rowPerPage, String search, String order);

    @Select("""
            SELECT
                 id,
                 userId,
                 profile,
                 nickName,
                 address,
                 introduce,
                 (SELECT SUM(view) FROM shoeBoard WHERE memberId = m.id) totalView,
                 (SELECT COUNT(*) FROM shoeBoard WHERE memberId = m.id) workCount,
                 (SELECT COUNT(*) FROM subscribe WHERE artistId = m.id) subCount
            FROM Member m
            WHERE id = #{id}
            ORDER BY id DESC
            LIMIT #{startIndex}, #{rowPerPage}
            """)
    Member getMemberById(Integer id);

    @Select("""
            SELECT COUNT(*) FROM shoeBoard
            WHERE memberId = #{id}
            """)
    Integer getmyShoeBoardNum(Integer id);

    @Select("""
            SELECT * FROM Member
            WHERE id = #{id}
            """)
    Member getArtistInfo(Integer id);

    @Select("""
            SELECT * FROM ShoeBoard
            WHERE memberId = #{memberId}
            """)
    List<ShoeBoard> getShoeBoardList(Integer memberId);
    @Select("""
            SELECT userId FROM Member
            WHERE id = #{id}
            """)
    String getUserIdSelectById(Integer id);
/*
    COUNT(f.id) fileCount,
            	(SELECT COUNT(*) FROM BoardLike WHERE boardId = b.id) likeCount,
            FROM Board b LEFT JOIN FileNames f ON b.id = f.boardId
            */

    @Select("""
            SELECT *
            FROM Member
            """)
    List<Member> selectAllMember();

//    @Delete("""
//            Delete
//            FROM Member
//            WHERE id = #{memberId}
//            """)
//    int deleteMemberById(int memberId);

        @Update("""
                UPDATE Member
                SET status = #{status} 
                WHERE id = #{id}
                """)
        int updateMemberStatus(@Param("id") int id, @Param("status") int status);

    @Select("""
        SELECT userId FROM Member
        WHERE name = #{name} AND email = #{email}
        """)
    Member selectByNameAndEmail(String name, String email);
}