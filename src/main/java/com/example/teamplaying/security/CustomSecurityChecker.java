package com.example.teamplaying.security;

import com.example.teamplaying.domain.ShoeBoard;
import com.example.teamplaying.domain.ShoeComment;
import com.example.teamplaying.mapper.ShoeBoardMapper;
import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import org.springframework.security.core.*;
import org.springframework.stereotype.*;

import com.example.teamplaying.domain.*;
import com.example.teamplaying.mapper.*;

@Component
public class CustomSecurityChecker {

    @Autowired
    private ShoeBoardMapper mapper;

    public boolean checkShoeBoardCommentWriter(Authentication authentication,
                                      Integer commentId) {
        ShoeComment comment = mapper.commentSelectById(commentId);

        return comment.getMemberId().equals(authentication.getName());
    }

    public boolean checkBoardWriter(Authentication authentication, Integer boardId) {
        ShoeBoard board = mapper.getShoeBoardById(boardId);

        return authentication.getName().equals(board.getMemberId());
    }
}