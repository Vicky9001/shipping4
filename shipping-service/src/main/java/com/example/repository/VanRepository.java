package com.example.repository;

import com.example.entity.User.Van;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VanRepository extends JpaRepository<Van, Long> {
	List<Van> findByLicenseContainingAndStateContaining(String license, int state);

	List<Van> findByLicenseContainingAndState(String license, int state);

	Van findByLicense(String license);

	List<Van> findByLicenseContaining(String license);

	boolean existsByLicense(String license);

	Van save(Van van);

}
