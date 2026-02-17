package com.personalfinanceTracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.personalfinanceTracker.entity.User;
import com.personalfinanceTracker.repository.UserRepository;

import java.util.Optional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository __userRepo__;

	@Override
	public String registerUser(User user) {
		try {
			// Validate user object
			if (user == null) {
				return "User data is required";
			}
			
			// Validate name
			if (user.getName() == null || user.getName().trim().isEmpty()) {
				return "Name is required";
			}
			if (user.getName().trim().length() < 3) {
				return "Name must be at least 3 characters long";
			}
			if (user.getName().length() > 50) {
				return "Name cannot exceed 50 characters";
			}
			
			// Validate email
			if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
				return "Email is required";
			}
			if (!isValidEmail(user.getEmail())) {
				return "Please enter a valid email address";
			}
			if (user.getEmail().length() > 100) {
				return "Email cannot exceed 100 characters";
			}
			
			// Validate password
			if (user.getPassword() == null || user.getPassword().isEmpty()) {
				return "Password is required";
			}
			if (user.getPassword().length() < 6) {
				return "Password must be at least 6 characters long";
			}
			if (user.getPassword().length() > 255) {
				return "Password cannot exceed 255 characters";
			}
			
			// Check if email already exists in database
			Optional<User> existingUser = __userRepo__.findByEmail(user.getEmail());
			if (existingUser.isPresent()) {
				return "Email already exists. Please use a different email.";
			}
			
			// Trim name and email before saving
			user.setName(user.getName().trim());
			user.setEmail(user.getEmail().trim());
			
			// TODO: Hash password before saving (Recommended for production)
			// If you have PasswordEncoder configured:
			// user.setPassword(passwordEncoder.encode(user.getPassword()));
			
			// Save user to database
			User savedUser = __userRepo__.save(user);
			
			// Check if save was successful
			if (savedUser != null && savedUser.getId() != null) {
				return "SUCCESS";
			} else {
				return "Registration failed. Please try again.";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "Registration failed: " + e.getMessage();
		}
	}
	
	// Login feature is added here 
	   // ✅ Added Login Method (ONLY ADDING)
    @Override
    public User loginUser(String email, String password) {

        if (email == null || email.trim().isEmpty()) return null;
        if (password == null || password.trim().isEmpty()) return null;

        Optional<User> optionalUser = __userRepo__.findByEmail(email.trim());

        // Email not found
        if (!optionalUser.isPresent()) {
            return null;
        }

        User dbUser = optionalUser.get();

        // Password match check
        if (dbUser.getPassword().equals(password)) {
            return dbUser; // success
        }

        return null; // password mismatch
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * Helper method to validate email format
	 * @param email - email to validate
	 * @return true if valid, false otherwise
	 */
	private boolean isValidEmail(String email) {
		if (email == null || email.trim().isEmpty()) {
			return false;
		}
		// Simple email validation regex
		String emailRegex = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
		return email.matches(emailRegex);
	}
	
	
}