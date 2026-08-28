package com.pitstop.analytics.dto;

public class OrderStatsDTO {
    private int totalOrders;
    private int fuelOrders;
    private int mechanicOrders;
    private int emergencyOrders;

    // Getters and Setters
    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getFuelOrders() {
        return fuelOrders;
    }

    public void setFuelOrders(int fuelOrders) {
        this.fuelOrders = fuelOrders;
    }

    public int getMechanicOrders() {
        return mechanicOrders;
    }

    public void setMechanicOrders(int mechanicOrders) {
        this.mechanicOrders = mechanicOrders;
    }

    public int getEmergencyOrders() {
        return emergencyOrders;
    }

    public void setEmergencyOrders(int emergencyOrders) {
        this.emergencyOrders = emergencyOrders;
    }
}
