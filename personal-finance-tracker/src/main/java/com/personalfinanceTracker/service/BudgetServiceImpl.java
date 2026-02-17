package com.personalfinanceTracker.service;

import java.math.BigDecimal;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.personalfinanceTracker.entity.Budget;
import com.personalfinanceTracker.entity.User;
import com.personalfinanceTracker.repository.BudgetRepository;

@Service
public class BudgetServiceImpl implements BudgetService {

    @Autowired
    private BudgetRepository budgetRepo;

    @Override
    public Budget setOrUpdateMonthlyBudget(User user, Integer month, Integer year, BigDecimal amount) {

        Optional<Budget> existing = budgetRepo.findByUserAndMonthAndYear(user, month, year);

        if (existing.isPresent()) {
            Budget b = existing.get();
            b.setAmount(amount);
            return budgetRepo.save(b);
        }

        Budget newBudget = new Budget();
        newBudget.setUser(user);
        newBudget.setMonth(month);
        newBudget.setYear(year);
        newBudget.setAmount(amount);

        return budgetRepo.save(newBudget);
    }

    @Override
    public Optional<Budget> getMonthlyBudget(User user, Integer month, Integer year) {
        return budgetRepo.findByUserAndMonthAndYear(user, month, year);
    }
}
