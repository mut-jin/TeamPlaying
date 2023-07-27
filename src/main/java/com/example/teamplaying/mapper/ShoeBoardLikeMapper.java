package com.example.teamplaying.mapper;

import com.example.teamplaying.domain.Member;
import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.domain.ShoeFileName;
import com.example.teamplaying.domain.ShoeLike;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ShoeBoardLikeMapper {

    @Select("""
			select *
			from shoeLike
			where boardId = #{boardId}
			and memberId = #{memberId}
			""")
    ShoeLike select(Integer id, String memberId);

	@Delete("""
			DELETE FROM shoeLike
			WHERE boardId = #{boardId} AND memberId = #{memberId}
			""")
    Integer delete(ShoeLike like);

	@Insert("""
   			INSERT INTO shoeLike(boardId, memberId)
   			VALUES(#{boardId}, #{memberId})
			""")
	Integer insert(ShoeLike like);

	@Select("""
			SELECT COUNT(*) FROM shoeLike
			WHERE boardId = #{boardId}
			""")
	Integer countByBoardId(Integer boardId);
}