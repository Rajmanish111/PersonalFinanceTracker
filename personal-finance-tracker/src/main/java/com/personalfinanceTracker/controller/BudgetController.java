package com.personalfinanceTracker.controller;

import java.math.BigDecimal;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.personalfinanceTracker.entity.Budget;
import com.personalfinanceTracker.entity.User;
import com.personalfinanceTracker.service.BudgetService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/budget")
public class BudgetController {

    @Autowired
    private BudgetService budgetService;

    // -------------------------------
    // OPEN SET/UPDATE BUDGET PAGE
    // -------------------------------
    @GetMapping("/set")
    public String showSetBudgetPage(
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) Integer year,
            HttpSession session,
            Model model) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        LocalDate now = LocalDate.now();
        if (month == null) month = now.getMonthValue();
        if (year == null) year = now.getYear();

        // if budget exists, show it in form
        Budget budget = budgetService.getMonthlyBudget(loggedInUser, month, year).orElse(null);

        model.addAttribute("month", month);
        model.addAttribute("year", year);
        model.addAttribute("budget", budget);

        return "setBudget"; // setBudget.jsp
    }

    // -------------------------------
    // SAVE / UPDATE BUDGET
    // -------------------------------
    @PostMapping("/set")
    public String saveOrUpdateBudget(
            @RequestParam Integer month,
            @RequestParam Integer year,
            @RequestParam BigDecimal amount,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0) {
            redirectAttributes.addFlashAttribute("error", "Budget must be greater than 0!");
            return "redirect:/budget/set?month=" + month + "&year=" + year;
        }

        budgetService.setOrUpdateMonthlyBudget(loggedInUser, month, year, amount);

        redirectAttributes.addFlashAttribute("message", "Budget saved successfully!");
        return "redirect:/user/dashboard";
    }
}
