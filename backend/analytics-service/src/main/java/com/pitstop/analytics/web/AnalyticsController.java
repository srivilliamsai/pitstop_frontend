package com.pitstop.analytics.web;

import com.pitstop.analytics.dto.OrderStatsDTO;
import com.pitstop.analytics.dto.RevenueStatsDTO;
import com.pitstop.analytics.service.AnalyticsService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/analytics")
public class AnalyticsController {

    private final AnalyticsService service;

    public AnalyticsController(AnalyticsService service) {
        this.service = service;
    }

    @GetMapping("/orders")
    public OrderStatsDTO getOrderStats() {
        return service.getOrderStats();
    }

    @GetMapping("/revenue")
    public RevenueStatsDTO getRevenueStats() {
        return service.getRevenueStats();
    }
}
