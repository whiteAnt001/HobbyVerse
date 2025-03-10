package com.springboot.hobbyverse.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.hobbyverse.model.Meetup;

@Repository
public interface MeetupRepository extends JpaRepository<Meetup, Integer> {

    @Modifying
    @Transactional
    @Query("UPDATE Meetup m SET m.views = m.views + 1 WHERE m.m_id = :id")
    int incrementViewsById(@Param("id") Integer id);  // ✅ 직접 SQL 실행
    

    @Query(value = "SELECT m.c_key, c.name AS category_name, COUNT(a.apply_id) AS meeting_count " +
            "FROM meetup m " +
            "JOIN meeting_apply a ON m.m_id = a.m_id " +
            "JOIN category c ON m.c_key = c.c_key " +
            "WHERE a.apply_date >= :startDate " +
            "GROUP BY m.c_key, c.name " +
            "ORDER BY meeting_count DESC " +
            "LIMIT 3", nativeQuery = true)
List<Object[]> findTopMeetingCategories(@Param("startDate") LocalDateTime startDate);

}
