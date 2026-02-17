package com.personalfinanceTracker.service;

import com.personalfinanceTracker.entity.User;

public interface UserService {

    /**
     * Register a new user
     * @param user - User entity with name, email, and password
     * @return String message indicating success or failure
     */
    String registerUser(User user);
    
    // log in feature 
    User loginUser(String email, String password);
}