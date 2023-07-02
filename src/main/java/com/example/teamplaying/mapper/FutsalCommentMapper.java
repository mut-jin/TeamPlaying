package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface FutsalCommentMapper {

	@Select("""
			SELECT *
			FROM FutsalComment
			WHERE id = #{id}
			""")
	FutsalComment selectById(Integer id);

	@Insert("""
			INSERT INTO FutsalComment (boardId, content, memberId)
			VALUES (#{boardId}, #{content}, #{memberId})
			""")
	Integer insert(FutsalComment comment);

	@Select("""
			SELECT * 
			FROM FutsalComment
			WHERE boardId = #{boardId}
			ORDER BY id
			""")
	List<FutsalComment> selectAllByBoardId(Integer boardId);

	@Update("""
			UPDATE FutsalComment
			SET
				content = #{content}
			WHERE
				id = #{id}
			""")
	Integer update(FutsalComment comment);

	@Delete("""
			DELETE FROM FutsalComment
			WHERE id = #{id}
			""")
	Integer deleteById(Integer id);

}
