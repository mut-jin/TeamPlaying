package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.RunningComment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RunningCommentMapper {

	@Select("""
			SELECT *
			FROM RunningComment
			WHERE id = #{id}
			""")
	RunningComment selectById(Integer id);

	@Insert("""
			INSERT INTO RunningComment (boardId, content, memberId)
			VALUES (#{boardId}, #{content}, #{memberId})
			""")
	Integer insert(RunningComment comment);

	@Select("""
			SELECT *
			FROM RunningComment
			WHERE boardId = #{boardId}
			ORDER BY id
			""")
	List<RunningComment> selectAllByBoardId(Integer boardId);

	@Update("""
			UPDATE RunningComment
				SET
				content = #{content}
			WHERE
				id = #{id}
			""")
	Integer update(RunningComment comment);

	@Delete("""
			DELETE FROM RunningComment
			WHERE id = #{id}
			""")
	Integer deleteById(Integer id);

}
