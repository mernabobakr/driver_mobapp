package com.kidzona.driverservice.entity;


import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sun.istack.NotNull;



@Table(name = "drivers")
@Entity
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" }, ignoreUnknown = true)
public class Driver {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@NotNull
	@Column(name = "iddrivers")
	private Integer iddrivers;

	@Column(name = "first_name")

	@NotEmpty(message = "first name can not be empty")
	private String first_name;
	@Column(name = "last_name")
	private String last_name;
	@Column(name = "phone_number")
	private String phone_number;
	@Column(name = "email")
	private String email;
	
	@Column(name = "user_id")
    private int userId;

    public int getId() {
        return iddrivers;
    }

    public void setId(int id) {
        this.iddrivers = id;
    }
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
	 @OneToMany(mappedBy = "driver",cascade= {CascadeType.PERSIST,CascadeType.MERGE })
	    private Set<Kid> kids;


	public Integer getIddrivers() {
		return iddrivers;
	}

	public void setIddrivers(Integer iddrivers) {
		this.iddrivers = iddrivers;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
    @JsonIgnore
    public Set<Kid> getKids() {
        return kids;
    }


}