package com.personalfinanceTracker.entity;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "TRANSACTIONS")
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TXN_SEQ_GEN")
    @SequenceGenerator(name = "TXN_SEQ_GEN", sequenceName = "TXN_SEQ", allocationSize = 1)
    private Long id;

    @Column(nullable = false)
    private Double amount;

    @Column(nullable = false, length = 20)
    private String type;   // CREDITED / DEBITED

    @Column(nullable = false, length = 50)
    private String category;

    @Column(length = 255)
    private String description;

    @Column(nullable = false)
    private LocalDateTime transactionDateTime;

    // Many transactions belong to one user
    @ManyToOne
    @JoinColumn(name = "USER_ID", nullable = false)
    private User user;
}
