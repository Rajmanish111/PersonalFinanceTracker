package com.personalfinanceTracker.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.personalfinanceTracker.entity.Transaction;
import com.personalfinanceTracker.entity.User;
import com.personalfinanceTracker.repository.TransactionRepository;

@Service
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    private TransactionRepository transactionRepo;

    // -------------------------------
    
    @Override
    public List<String> getAllCategories(User user) {
        // Fetch all transactions for this user and collect distinct categories
        List<Transaction> transactions = transactionRepo.findByUser(user);
        return transactions.stream()
                           .map(Transaction::getCategory)
                           .distinct()
                           .collect(Collectors.toList());
    }
    
    // OLD CODE: addTransaction
    // -------------------------------
    @Override
    public String addTransaction(Transaction txn, User user) {
        if (txn == null) return "Transaction cannot be null";
        if (user == null) return "User not found. Please login again.";

        if (txn.getAmount() == null || txn.getAmount() <= 0)
            return "Amount must be greater than 0";

        if (txn.getType() == null || 
            !(txn.getType().equalsIgnoreCase("CREDITED") || txn.getType().equalsIgnoreCase("DEBITED")))
            return "Invalid transaction type. Only CREDITED or DEBITED allowed.";

        if (txn.getCategory() == null || txn.getCategory().trim().isEmpty())
            return "Category is required";

        txn.setUser(user);
        if (txn.getTransactionDateTime() == null)
            txn.setTransactionDateTime(LocalDateTime.now());

        txn.setType(txn.getType().toUpperCase());

        transactionRepo.save(txn);
        return "SUCCESS";
    }
// new one 
    
    
    // -------------------------------
    // OLD CODE: getAllTransactions
    // -------------------------------
    @Override
    public List<Transaction> getAllTransactions(User user) {
        if (user == null) return List.of();
        return transactionRepo.findByUserOrderByTransactionDateTimeDesc(user);
    }

    // -------------------------------
    // OLD CODE: getCurrentBalance
    // -------------------------------
    @Override
    public Double getCurrentBalance(User user) {
        if (user == null) return 0.0;

        Double credited = transactionRepo.getTotalCredited(user);
        Double debited = transactionRepo.getTotalDebited(user);

        credited = (credited == null) ? 0.0 : credited;
        debited = (debited == null) ? 0.0 : debited;

        return credited - debited;
    }

    // -------------------------------
    // NEW CODE: getTransactionsByUser
    // Fetch transactions for history page
    // -------------------------------
    @Override
    public List<Transaction> getTransactionsByUser(User user) {
        if (user == null) return List.of();
        return transactionRepo.findByUserOrderByTransactionDateTimeDesc(user);
    }

    // -------------------------------
    // NEW CODE: getTransactionById
    // Fetch single transaction for editing
    // -------------------------------
    @Override
    public Transaction getTransactionById(Long id) {
        Optional<Transaction> txnOpt = transactionRepo.findById(id);
        return txnOpt.orElse(null);
    }

    // -------------------------------
    // UPDATED CODE: updateTransaction
    // Only category and description can be changed
    // Amount, type, and transactionDateTime remain unchanged
    // -------------------------------
    @Override
    public void updateTransaction(Transaction txn, User user) {
        if (txn == null || user == null) return;

        Optional<Transaction> existingOpt = transactionRepo.findById(txn.getId());
        if (existingOpt.isPresent()) {
            Transaction existing = existingOpt.get();
            if (existing.getUser().getId().equals(user.getId())) {
                // -------------------------------
                // NEW CODE: only allow updating category and description
                // -------------------------------
                existing.setCategory(txn.getCategory());
                existing.setDescription(txn.getDescription());

                transactionRepo.save(existing);
            }
        }
    }

    // -------------------------------
    // NEW CODE: deleteTransaction
    // Delete transaction for a specific user
    // -------------------------------
    @Override
    public void deleteTransaction(Long id, User user) {
        if (id == null || user == null) return;

        Optional<Transaction> txnOpt = transactionRepo.findById(id);
        if (txnOpt.isPresent() && txnOpt.get().getUser().getId().equals(user.getId())) {
            transactionRepo.delete(txnOpt.get());
        }
    }
    // budget transaction impl 
    @Override
    public BigDecimal getMonthlyDebitedAmount(User user, LocalDateTime start, LocalDateTime end) {
        return transactionRepo.getMonthlyDebitedAmount(user, start, end);
    }

    
    

    // -------------------------------
    // NEW FEATURE: getFilteredSortedTransactions
    // Fetch transactions for a user with dynamic filters (type, category, date range)
    // and sorting (by field and direction)
    // -------------------------------
    @Override
    public List<Transaction> getFilteredSortedTransactions(User user, String type, String category,
                                                           LocalDate startDate, LocalDate endDate,
                                                           String sortField, String sortDir) {
        if (user == null) return List.of();

        // Build Sort object based on sortField and sortDir
        Sort sort = Sort.by(sortField);
        sort = sortDir.equalsIgnoreCase("asc") ? sort.ascending() : sort.descending();

        // Dynamic filtering using repository methods
        if ((type == null || type.isEmpty()) &&
            (category == null || category.isEmpty()) &&
            startDate == null && endDate == null) {
            // No filters applied → fetch all transactions sorted
            return transactionRepo.findByUser(user, sort);
        } else {
            // Filters applied → fetch transactions based on type, category, date range, and sort
            return transactionRepo.findByUserWithFilters(user, type, category, startDate, endDate, sort);
        }
    }
}
