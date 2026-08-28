package com.pitstop.bnpl.client;

import com.pitstop.bnpl.dto.PaymentInfoDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "payment-service")
public interface PaymentClient {

    @GetMapping("/api/payment/info")
    PaymentInfoDTO getPaymentInfo();
}
