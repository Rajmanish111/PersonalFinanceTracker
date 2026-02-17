package com.personalfinanceTracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.personalfinanceTracker.entity.User;
import com.personalfinanceTracker.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService __userService__;

    // Display registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";  // returns register.jsp
    }

    // Handle registration form submission
    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, 
                             RedirectAttributes redirectAttributes,
                             Model model) {
        
        // Call service to register user
        String result = __userService__.registerUser(user);
        
        // Check if registration was successful
        if ("SUCCESS".equals(result)) {
            redirectAttributes.addFlashAttribute("message", "Registration successful! You can now login.");
            return "redirect:/users/register";  // Redirect to avoid form resubmission
        } else {
            // Registration failed - show error message
            model.addAttribute("error", result);
            model.addAttribute("user", user);  // Keep form data
            return "register";  // Stay on the same page
        }
    }
    // login added 

    @GetMapping("/login")
    public String showLoginForm() {
        return "login"; // login.jsp
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            Model model,
                            HttpSession session) {

        User user = __userService__.loginUser(email, password);

        if (user != null) {
            session.setAttribute("loggedInUser", user);
            return "redirect:/user/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "login";
        }
    }

    // ================= LOGOUT (ADDED) =================

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/users/login";
    }
    
    
}