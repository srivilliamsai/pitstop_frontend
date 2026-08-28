package com.pitstop.analytics.client;

import com.pitstop.analytics.dto.OrderStatsDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "order-service") // must match the spring.application.name of order-service
public interface OrderClient {

    @GetMapping("/api/orders/stats")
    OrderStatsDTO getOrderStats();
}
