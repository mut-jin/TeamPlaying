package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface MemberMapper {

    @Select("""
            SELECT nickName FROM Member
            WHERE userId = #{userId}
            """)
    String getNickNameByUserId(String userId);

    // ** 서재권 추가내용
    @Select("""
            SELECT * FROM Member
            WHERE userId = #{userId}
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
    Member selectById(String integer);

    @Delete("""
            DELETE FROM Member
            WHERE userId=#{userId}
            """)
    Integer deleteById(String userId);

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

    // 멤버 삭제 =====
    // 러닝 ***********
    // 러닝 메이트 신청 인원 삭제
    @Delete("""
            DELETE FROM RunningParty
            WHERE host = #{userId} or guest = #{userId}
            """)
    void deleteRunningPartyById(String userId);

    // 러닝 올린 게시물 삭제
    @Delete("""
            DELETE FROM RunningBoard
            WHERE writer = #{nickName}
            """)
    void deleteRunningBoardById(String nickName);

    // 러닝 today like 삭제
    @Delete("""
            DELETE FROM RunningLike
            WHERE memberId = #{userId}
            """)
    void deleteRunningTodayLikeById(String userId);

    // 러닝 today like 삭제
    @Delete("""
            DELETE FROM RunningComment
            WHERE memberId = #{userId}
            """)
    void deleteRunningTodayCommentById(String userId);

    // 러닝 today 삭제
    @Delete("""
            DELETE FROM RunningToday
            WHERE writer = #{nickName}
            """)
    void deleteRunningTodayById(String nickName);

    // 등산 ***********
    // 등산 메이트 신청 인원 삭제 1
    @Delete("""
            DELETE FROM ClimbingParty
            WHERE host = #{userId} or guest = #{userId}
            """)
    void deleteClimbingPartyById(String userId);

    // 등산 올린 게시물 삭제 2
    @Delete("""
            DELETE FROM ClimbingMate
            WHERE writer = #{nickName}
            """)
    void deleteClimbingMateById(String nickName);

    // 등산 today like 삭제 1
    @Delete("""
            DELETE FROM ClimbingTodayLike
            WHERE memberId = #{userId}
            """)
    void deleteClimbingTodayLikeById(String userId);

    // 등산 today comment 삭제 2
    @Delete("""
            DELETE FROM ClimbingTodayComment
            WHERE memberId = #{userId}
            """)
    void deleteClimbingTodayCommentById(String userId);

    // 등산 today 삭제 3
    @Delete("""
            DELETE FROM ClimbingToday
            WHERE writer = #{nickName}
            """)
    void deleteClimbingTodayById(String nickName);

    // 등산 Course like 삭제 1
    @Delete("""
            DELETE FROM ClimbingCourseLike
            WHERE memberId = #{userId}
            """)
    void deleteClimbingCourseLikeById(String userId);

    // 등산 Course comment 삭제 2
    @Delete("""
            DELETE FROM ClimbingCourseComment
            WHERE memberId = #{userId}
            """)
    void deleteClimbingCourseCommentById(String userId);

    // 등산 Course 삭제 3
    @Delete("""
            DELETE FROM ClimbingCourse
            WHERE writer = #{nickName}
            """)
    void deleteClimbingCourseById(String nickName);

    @Select("""
            SELECT id
            FROM RunningToday
            WHERE writer = #{nickName}
            """)
    List<Integer> selectIdByWriter(String nickName);

    @Delete("""
            DELETE FROM RunningFileName
            WHERE boardId = #{boardId}
            """)
    void deleteRunningFileNameById(Integer boardId);

    @Delete("""
            DELETE FROM ClimbingToday
            WHERE todayId = #{todayId}
            """)
    List<Integer> selectClimbIdByWriter(Integer todayId);

    @Select("""
            SELECT id
            FROM ClimbingToday
            WHERE writer = #{nickName}
            """)
    List<Integer> selectClimbingTodayByWriter(String nickName);

    @Delete("""
            DELETE FROM ClimbingTodayFileName
            WHERE todayId = #{todayId}
            """)
    void deleteClimbingTodayFileNameById(Integer todayId);

    @Select("""
            SELECT id
            FROM ClimbingCourse
            WHERE writer = #{nickName}
            """)
    List<Integer> selectClimbCourseIdByWriter(String nickName);

    @Delete("""
            DELETE FROM ClimbingCourseFileName
            WHERE courseId = #{courseId}
            """)
    void deleteClimbingCourseFileNameById(Integer courseId);

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
            	(SELECT SUM(view) FROM shoeBoard WHERE memberId = m.id) totalView
            FROM Member m
            WHERE memberType = 'artist' AND
                  nickName LIKE #{pattern}
            ORDER BY id DESC
            LIMIT #{startIndex}, #{rowPerPage}
            </script>
            """)
    List<Member> selectAllPaging(Integer startIndex, Integer rowPerPage, String search, String type);

    @Select("""
            SELECT
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
    List<Member> getMemberById(Integer startIndex, Integer rowPerPage, Integer id);

    @Select("""
            SELECT COUNT(*) FROM shoeBoard
            WHERE memberId = #{id}
            """)
    Integer getmyShoeBoardNum(Integer id);
/*
    COUNT(f.id) fileCount,
            	(SELECT COUNT(*) FROM BoardLike WHERE boardId = b.id) likeCount,
            FROM Board b LEFT JOIN FileNames f ON b.id = f.boardId
            */
}