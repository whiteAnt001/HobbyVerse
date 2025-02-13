package com.springboot.hobbyverse.model;

import java.time.LocalDate;
import jakarta.persistence.*;

@Entity
public class LikedBoard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user; // 🔥 추천한 사용자

    @ManyToOne
    @JoinColumn(name = "board_id", nullable = false)
    private Board board; // 🔥 추천한 게시글

    private LocalDate likedDate; // 🔥 추천한 날짜 (하루 1회 제한)

    public LikedBoard() {
        this.likedDate = LocalDate.now(); // 추천 날짜 설정
    }

    public LikedBoard(User user, Board board) {
        this.user = user;
        this.board = board;
        this.likedDate = LocalDate.now();
    }

    public Long getId() { return id; }
    public User getUser() { return user; }
    public Board getBoard() { return board; }
    public LocalDate getLikedDate() { return likedDate; }
}
