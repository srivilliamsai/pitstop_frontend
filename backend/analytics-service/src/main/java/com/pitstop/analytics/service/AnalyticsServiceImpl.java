package com.pitstop.analytics.service;

import com.pitstop.analytics.dto.OrderStatsDTO;
import com.pitstop.analytics.dto.RevenueStatsDTO;
import org.springframework.stereotype.Service;

@Service
public class AnalyticsServiceImpl implements AnalyticsService {

    @Override
    public OrderStatsDTO getOrderStats() {
        OrderStatsDTO dto = new OrderStatsDTO();
        dto.setTotalOrders(100);
        dto.setFuelOrders(40);
        dto.setMechanicOrders(30);
        dto.setEmergencyOrders(30);
        return dto;
    }

    @Override
    public RevenueStatsDTO getRevenueStats() {
        RevenueStatsDTO dto = new RevenueStatsDTO();
        dto.setTotalRevenue(200000.0);
        dto.setBnplOutstanding(55000.0);
        return dto;
    }
}
