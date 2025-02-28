package com.springboot.hobbyverse.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.springboot.hobbyverse.model.Meetup;
import org.springframework.data.repository.query.Param;

@Repository
public interface MeetupRepository extends JpaRepository<Meetup, Integer> {

    @Modifying
    @Transactional
    @Query("UPDATE Meetup m SET m.views = m.views + 1 WHERE m.m_id = :id")
    int incrementViewsById(@Param("id") Integer id);  // ✅ 직접 SQL 실행
}
