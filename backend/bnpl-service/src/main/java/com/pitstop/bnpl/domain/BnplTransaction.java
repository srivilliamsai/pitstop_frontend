package com.pitstop.bnpl.domain;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.UUID;

@Entity
public class BnplTransaction {
    @Id
    @GeneratedValue
    private UUID id;

    private LocalDate dueDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private BnplUser user;

    private double amount;

    private String status; // DUE, PAID, OVERDUE

    public BnplTransaction() {}

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public BnplUser getUser() {
        return user;
    }

    public void setUser(BnplUser user) {
        this.user = user;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
