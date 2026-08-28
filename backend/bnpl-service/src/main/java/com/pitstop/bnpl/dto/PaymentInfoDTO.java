package com.pitstop.bnpl.dto;

import java.math.BigDecimal;
import java.util.UUID;

public class PaymentInfoDTO {
    private UUID userId;
    private BigDecimal amount;
    private String paymentStatus;

    // Getters and setters

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
}