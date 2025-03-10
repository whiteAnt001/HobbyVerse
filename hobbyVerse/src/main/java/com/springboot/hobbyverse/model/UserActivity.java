package com.springboot.hobbyverse.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.time.LocalDate;

@Entity
@Table(name = "user_activity")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserActivity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // 기본 키

    @Column(name = "activity_date", nullable = false)
    private LocalDate activityDate; // 동향 날짜

    @Column(name = "new_users", nullable = false)
    private int newUsers; // 신규 가입자 수

    @Column(name = "unsubscribed_users", nullable = false)
    private int unsubscribedUsers; // 탈퇴한 사용자 수

    @Column(name = "joined_meetings", nullable = false)
    private int joinedMeetings; // 모임 가입 수

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt; // 생성 시간

    @Column(name = "updated_at")
    private LocalDateTime updatedAt; // 업데이트 시간

    // 엔티티가 저장되기 전에 자동으로 시간 설정
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // 엔티티가 업데이트될 때 자동으로 시간 설정
    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}
