package com.personalfinanceTracker.controller;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.personalfinanceTracker.entity.Budget;
import com.personalfinanceTracker.entity.Transaction;
import com.personalfinanceTracker.entity.User;
import com.personalfinanceTracker.service.BudgetService;
import com.personalfinanceTracker.service.TransactionService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class DashboardController {

    @Autowired
    private TransactionService transactionService;

    @Autowired
    private BudgetService budgetService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            return "redirect:/users/login";
        }

        // -------------------------------
        // BALANCE (Already)
        // -------------------------------
        Double balance = transactionService.getCurrentBalance(loggedInUser);
        model.addAttribute("balance", balance);

        // optional: show transaction list on dashboard
        List<Transaction> txns = transactionService.getAllTransactions(loggedInUser);
        model.addAttribute("txns", txns);

        // -------------------------------
        // BUDGET LOGIC (NEW)
        // -------------------------------
        LocalDate now = LocalDate.now();
        int month = now.getMonthValue();
        int year = now.getYear();

        // get budget
        Optional<Budget> budgetOpt = budgetService.getMonthlyBudget(loggedInUser, month, year);

        BigDecimal budgetAmount = budgetOpt.map(Budget::getAmount).orElse(BigDecimal.ZERO);

        // get monthly spent (DEBITED sum)
        LocalDateTime start = LocalDate.of(year, month, 1).atStartOfDay();
        LocalDateTime end = LocalDate.of(year, month, 1)
                .withDayOfMonth(LocalDate.of(year, month, 1).lengthOfMonth())
                .atTime(23, 59, 59);

        BigDecimal spentAmount = transactionService.getMonthlyDebitedAmount(loggedInUser, start, end);

        BigDecimal remainingAmount = budgetAmount.subtract(spentAmount);

        boolean budgetExceeded = budgetOpt.isPresent() && remainingAmount.compareTo(BigDecimal.ZERO) < 0;

        // send to dashboard.jsp
        model.addAttribute("budgetAmount", budgetAmount);
        model.addAttribute("spentAmount", spentAmount);
        model.addAttribute("remainingAmount", remainingAmount);
        model.addAttribute("budgetExceeded", budgetExceeded);

        model.addAttribute("budgetMonth", month);
        model.addAttribute("budgetYear", year);
        model.addAttribute("budgetSet", budgetOpt.isPresent());

        return "dashboard";
    }
}


//package com.personalfinanceTracker.controller;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.personalfinanceTracker.entity.Transaction;
//import com.personalfinanceTracker.entity.User;
//import com.personalfinanceTracker.service.TransactionService;
//
//import jakarta.servlet.http.HttpSession;
//
//@Controller
//@RequestMapping("/user")
//public class DashboardController {
//
//    @Autowired
//    private TransactionService transactionService;
//
//    @GetMapping("/dashboard")
//    public String dashboard(HttpSession session, Model model) {
//
//        User loggedInUser = (User) session.getAttribute("loggedInUser");
//
//        if (loggedInUser == null) {
//            return "redirect:/users/login";
//        }
//
//        Double balance = transactionService.getCurrentBalance(loggedInUser);
//        model.addAttribute("balance", balance);
//
//        // optional: show transaction list on dashboard
//        List<Transaction> txns = transactionService.getAllTransactions(loggedInUser);
//        model.addAttribute("txns", txns);
//
//        return "dashboard";
//    }
//}
