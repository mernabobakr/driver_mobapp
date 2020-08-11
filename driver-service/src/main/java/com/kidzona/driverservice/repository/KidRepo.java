package com.kidzona.driverservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kidzona.driverservice.entity.Kid;




@Repository
public interface KidRepo extends JpaRepository<Kid, Integer> {
}
