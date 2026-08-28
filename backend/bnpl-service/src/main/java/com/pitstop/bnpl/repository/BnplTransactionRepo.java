package com.pitstop.bnpl.repository;

import com.pitstop.bnpl.domain.BnplTransaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface BnplTransactionRepo extends JpaRepository<BnplTransaction, UUID> {
    List<BnplTransaction> findByUserId(UUID userId);
}
