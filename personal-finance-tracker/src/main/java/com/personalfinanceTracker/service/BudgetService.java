package com.personalfinanceTracker.service;

import java.math.BigDecimal;
import java.util.Optional;

import com.personalfinanceTracker.entity.Budget;
import com.personalfinanceTracker.entity.User;

public interface BudgetService {

    // Create OR Update budget for month/year
    Budget setOrUpdateMonthlyBudget(User user, Integer month, Integer year, BigDecimal amount);

    // Get budget for month/year
    Optional<Budget> getMonthlyBudget(User user, Integer month, Integer year);
}
