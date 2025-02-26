package com.springboot.hobbyverse.dto;

import lombok.Data;

@Data
public class AddCommentRequest {
	private Integer comment_id; //댓글  pk
	private Integer board_seq; // 댓글을 작성하는 게시글의 번호
	private Integer parent_comment_id; //부모 댓글
	private String user_email; //유저 이메일
	private String user_name; /// 유저 이름
	private String content; // 글 내용
	private String create_at; //댓글 작성일
	private String update_at; //댓글 수정일
}
