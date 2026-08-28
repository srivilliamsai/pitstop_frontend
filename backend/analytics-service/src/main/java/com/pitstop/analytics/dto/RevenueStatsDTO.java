package com.pitstop.analytics.dto;

public class RevenueStatsDTO {
    private double totalRevenue;
    private double bnplOutstanding;

    // Getters and Setters
    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public double getBnplOutstanding() {
        return bnplOutstanding;
    }

    public void setBnplOutstanding(double bnplOutstanding) {
        this.bnplOutstanding = bnplOutstanding;
    }
}
