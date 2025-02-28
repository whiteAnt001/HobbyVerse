package com.springboot.hobbyverse.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentRequest {
    private Long boardId;
    private Long parentId;
    private String userEmail;
    private String userName;
    private String content;
}

