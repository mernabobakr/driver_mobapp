package com.kidzona.driverservice.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kidzona.driverservice.entity.Driver;


public interface DriverRepository extends JpaRepository<Driver,Integer> {
	List<Driver> findByUserId(int userId);
	 List<Driver> findByEmail(String email);
	    

}