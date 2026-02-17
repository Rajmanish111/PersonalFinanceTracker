package com.personalfinanceTracker.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.personalfinanceTracker.entity.Budget;
import com.personalfinanceTracker.entity.User;

public interface BudgetRepository extends JpaRepository<Budget, Long> {

    Optional<Budget> findByUserAndMonthAndYear(User user, Integer month, Integer year);

    boolean existsByUserAndMonthAndYear(User user, Integer month, Integer year);
}
