package com.pitstop.paymentservice.repo;
import com.pitstop.paymentservice.domain.Payment; 
import org.springframework.data.jpa.repository.JpaRepository; 
import java.util.UUID;

public interface PaymentRepo extends JpaRepository<Payment, UUID>{}
