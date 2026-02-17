package com.personalfinanceTracker.entity;

import java.math.BigDecimal;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(
    name = "BUDGETS",
    uniqueConstraints = {
        @UniqueConstraint(columnNames = {"USER_ID", "BUDGET_MONTH", "BUDGET_YEAR"})
    }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Budget {

    @Id
    @SequenceGenerator(name = "budget_seq", sequenceName = "BUDGET_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "budget_seq")
    private Long id;

    @Column(nullable = false)
    private BigDecimal amount;

    @Column(name = "BUDGET_MONTH", nullable = false)
    private Integer month;   // 1-12

    @Column(name = "BUDGET_YEAR", nullable = false)
    private Integer year;    // 2026 etc.

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;
}
