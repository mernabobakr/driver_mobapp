package com.kidzona.driverservice.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import com.kidzona.driverservice.entity.Driver;
import com.kidzona.driverservice.entity.Kid;
import com.kidzona.driverservice.error.NotFoundException;
import com.kidzona.driverservice.repository.DriverRepository;
import com.kidzona.driverservice.helper.TokenUtil;

import java.util.HashMap;
import java.util.List;

import java.util.Set;


@Service

public class DriverService {

	@Autowired
	private DriverRepository driverRepository;
	 @Autowired
	    TokenUtil tokenUtil;

	public List<Driver> findAll() {
		return driverRepository.findAll();
	}

	public Driver findById(Integer id) {
		this.checkDriverWithIdExists(id);
		return driverRepository.findById(id).get();
	}

	public Driver save(Driver driver) {

		return driverRepository.save(driver);
	}
	
	public  HashMap<String, String>  save(Driver driver,String token) {
		int userId = tokenUtil.getUserIdFromJWT(token);
        driver.setUserId(userId);

		 driverRepository.save(driver);
		String parentIdString = String.valueOf(this.driverRepository.findByUserId(userId).get(0).getId());
        HashMap<String, String> result = new HashMap<>();
        result.put("driverId", parentIdString);
        System.out.println("5rrraaaaaaaaaaaaaa"); 
        return result;
	}


	public void delete(Integer id) {
		driverRepository.deleteById(id);
	}
	
	
    public Set<Kid> getAllKidsByDriverId(int id) {
    	
        return driverRepository.getOne(id).getKids();
        
    }
    private void checkDriverWithIdExists(int id) {
        if (!this.driverRepository.existsById(id))
            throw new NotFoundException("can't find parent with this id");
    }
	
}