package com.pitstop.analytics.service;

import com.pitstop.analytics.dto.OrderStatsDTO;
import com.pitstop.analytics.dto.RevenueStatsDTO;

public interface AnalyticsService {
    OrderStatsDTO getOrderStats();
    RevenueStatsDTO getRevenueStats();
}
