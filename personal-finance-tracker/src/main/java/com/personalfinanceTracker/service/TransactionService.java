//
//
//package com.personalfinanceTracker.service;
//
//import java.util.List;
//
//import com.personalfinanceTracker.entity.Transaction;
//import com.personalfinanceTracker.entity.User;
//
//public interface TransactionService {
//
//    // -------------------------------
//    // OLD CODE
//    // -------------------------------
//    String addTransaction(Transaction txn, User user);
//
//    List<Transaction> getAllTransactions(User user);
//
//    Double getCurrentBalance(User user);
//
//    // -------------------------------
//    // NEW CODE: transaction history, edit, delete
//    // -------------------------------
//    List<Transaction> getTransactionsByUser(User user); // fetch transactions for history page
//
//    Transaction getTransactionById(Long id); // fetch single transaction for edit
//
//    void updateTransaction(Transaction txn, User user); // update existing transaction
//
//    void deleteTransaction(Long id, User user); // delete transaction
//}
// old code avobe 

package com.personalfinanceTracker.service;

import java.time.LocalDate;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import com.personalfinanceTracker.entity.Transaction;
import com.personalfinanceTracker.entity.User;

public interface TransactionService {
	
	
	
	

BigDecimal getMonthlyDebitedAmount(User user, LocalDateTime start, LocalDateTime end);

    // -------------------------------
    // OLD CODE
    // -------------------------------
    String addTransaction(Transaction txn, User user);

    List<Transaction> getAllTransactions(User user);

    Double getCurrentBalance(User user);

    // -------------------------------
    // NEW CODE: transaction history, edit, delete
    // -------------------------------
    List<Transaction> getTransactionsByUser(User user); // fetch transactions for history page

    Transaction getTransactionById(Long id); // fetch single transaction for edit

    void updateTransaction(Transaction txn, User user); // update existing transaction

    void deleteTransaction(Long id, User user); // delete transaction

    // -------------------------------
    
    List<String> getAllCategories(User user);
    // NEW FEATURE: Filtering & Sorting
    // -------------------------------
    // Fetch transactions for a user with dynamic filters (type, category, date range)
    // and sorting (by date or amount, ascending/descending)
    List<Transaction> getFilteredSortedTransactions(
            User user,
            String type,
            String category,
            LocalDate startDate,
            LocalDate endDate,
            String sortField,
            String sortDir);
}
