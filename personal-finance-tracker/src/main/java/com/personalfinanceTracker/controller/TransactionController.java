package com.personalfinanceTracker.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.personalfinanceTracker.entity.Transaction;
import com.personalfinanceTracker.entity.User;
import com.personalfinanceTracker.service.TransactionService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/transactions")
public class TransactionController {

    @Autowired
    private TransactionService transactionService;

    // -------------------------------
    // OPEN ADD TRANSACTION PAGE
    // -------------------------------
    @GetMapping("/add")
    public String showAddTransactionPage(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        model.addAttribute("transaction", new Transaction());
        return "addTransaction"; // addTransaction.jsp
    }

    // -------------------------------
    // SAVE TRANSACTION
    // -------------------------------
    @PostMapping("/add")
    public String addTransaction(@ModelAttribute("transaction") Transaction txn,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes,
                                 Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        String result = transactionService.addTransaction(txn, loggedInUser);

        if ("SUCCESS".equals(result)) {
            redirectAttributes.addFlashAttribute("message", "Transaction added successfully!");
            return "redirect:/user/dashboard";
        } else {
            model.addAttribute("error", result);
            model.addAttribute("transaction", txn);
            return "addTransaction";
        }
    }

    // -------------------------------
    // VIEW ALL TRANSACTIONS (WITH FILTER & SORT)
    // -------------------------------
    @GetMapping({"/history"})
    public String viewTransactions(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(defaultValue = "transactionDateTime") String sortField,
            @RequestParam(defaultValue = "desc") String sortDir,
            Model model,
            HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        // Fetch filtered & sorted transactions
        List<Transaction> transactions = transactionService.getFilteredSortedTransactions(
                loggedInUser, type, category, startDate, endDate, sortField, sortDir);

        model.addAttribute("transactions", transactions);

        // Add categories for dropdown in filter
        model.addAttribute("categories", transactionService.getAllCategories(loggedInUser));

        // Preserve filter/sort selections in JSP
        model.addAttribute("selectedType", type);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDir", sortDir);

        return "transactionHistory"; // JSP page
    }

    // -------------------------------
    // EDIT TRANSACTION FORM
    // -------------------------------
    @GetMapping("/edit/{id}")
    public String editTransactionForm(@PathVariable("id") Long id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        Transaction txn = transactionService.getTransactionById(id);
        if (!txn.getUser().getId().equals(loggedInUser.getId())) {
            return "redirect:/transactions"; // Security check
        }

        model.addAttribute("transaction", txn);
        return "editTransaction";
    }

    // -------------------------------
    // UPDATE TRANSACTION
    // -------------------------------
//    @PostMapping("/update")
//    public String updateTransaction(@ModelAttribute Transaction transaction, HttpSession session) {
//        User loggedInUser = (User) session.getAttribute("loggedInUser");
//        if (loggedInUser == null) return "redirect:/users/login";
//
//        transactionService.updateTransaction(transaction, loggedInUser);
//        return "redirect:/transactions";
//    }
    @PostMapping("/update")
    public String updateTransaction(@ModelAttribute Transaction transaction, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        transactionService.updateTransaction(transaction, loggedInUser);
        // Redirect to the correct history page to avoid white-label
        return "redirect:/transactions/history";
    }

//    // -------------------------------
//    // DELETE TRANSACTION
//    // -------------------------------
//    @GetMapping("/delete/{id}")
//    public String deleteTransaction(@PathVariable("id") Long id, HttpSession session) {
//        User loggedInUser = (User) session.getAttribute("loggedInUser");
//        if (loggedInUser == null) return "redirect:/users/login";
//
//        transactionService.deleteTransaction(id, loggedInUser);
//        return "redirect:/transactions";
//    }
    
    @GetMapping("/delete/{id}")
    public String deleteTransaction(@PathVariable("id") Long id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/users/login";

        transactionService.deleteTransaction(id, loggedInUser);
        // Redirect to the correct history page to avoid white-label
        return "redirect:/transactions/history";
    }
}
