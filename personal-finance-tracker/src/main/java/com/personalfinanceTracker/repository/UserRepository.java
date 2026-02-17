package com.personalfinanceTracker.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.personalfinanceTracker.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    /**
     * Find a user by email
     * @param email - the email to search for
     * @return Optional containing User if found, empty Optional otherwise
     */
    Optional<User> findByEmail(String email);
}