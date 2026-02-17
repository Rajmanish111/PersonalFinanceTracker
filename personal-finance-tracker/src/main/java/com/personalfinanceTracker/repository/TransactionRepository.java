package com.personalfinanceTracker.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.personalfinanceTracker.entity.Transaction;
import com.personalfinanceTracker.entity.User;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {

    // -------------------------------
    // OLD CODE: fetch transactions for user and totals
    // -------------------------------
    List<Transaction> findByUserOrderByTransactionDateTimeDesc(User user);

    @Query("SELECT COALESCE(SUM(t.amount), 0) FROM Transaction t WHERE t.user = :user AND t.type = 'CREDITED'")
    Double getTotalCredited(User user);

    @Query("SELECT COALESCE(SUM(t.amount), 0) FROM Transaction t WHERE t.user = :user AND t.type = 'DEBITED'")
    Double getTotalDebited(User user);

    // -------------------------------
    // OLD CODE: fetch single transaction by id and user
    // -------------------------------
    @Query("SELECT t FROM Transaction t WHERE t.id = :id AND t.user = :user")
    Transaction findByIdAndUser(Long id, User user);

    // -------------------------------
    // NEW CODE: required for getFilteredSortedTransactions
    // -------------------------------

    // Fetch all transactions for a user with sorting (no filters applied)
    List<Transaction> findByUser(User user, Sort sort);

    // Dynamic filtering with optional type, category, startDate, endDate
    @Query("SELECT t FROM Transaction t WHERE t.user = :user "
            + "AND (:type IS NULL OR t.type = :type) "
            + "AND (:category IS NULL OR t.category = :category) "
            + "AND (:startDate IS NULL OR t.transactionDateTime >= :startDate) "
            + "AND (:endDate IS NULL OR t.transactionDateTime <= :endDate)")
    List<Transaction> findByUserWithFilters(
            @Param("user") User user,
            @Param("type") String type,
            @Param("category") String category,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate,
            Sort sort);
    List<Transaction> findByUser(User user);
    
    
    // adding budget queries
    
    @Query("""
    	       SELECT COALESCE(SUM(t.amount), 0)
    	       FROM Transaction t
    	       WHERE t.user = :user
    	         AND t.type = 'DEBITED'
    	         AND t.transactionDateTime BETWEEN :start AND :end
    	       """)
    	java.math.BigDecimal getMonthlyDebitedAmount(
    	        @Param("user") com.personalfinanceTracker.entity.User user,
    	        @Param("start") java.time.LocalDateTime start,
    	        @Param("end") java.time.LocalDateTime end
    	);

}
