package com.pitstop.bnpl.web;

import com.pitstop.bnpl.domain.BnplTransaction;
import com.pitstop.bnpl.repository.BnplTransactionRepo;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/bnpl")
public class BnplController {

    private final BnplTransactionRepo transactionRepo;

    public BnplController(BnplTransactionRepo transactionRepo) {
        this.transactionRepo = transactionRepo;
    }

    @GetMapping("/transactions/{userId}")
    public List<BnplTransaction> getUserTransactions(@PathVariable UUID userId) {
        return transactionRepo.findByUserId(userId);
    }

    @PostMapping("/transaction")
    public BnplTransaction createTransaction(@RequestBody BnplTransaction txn) {
        return transactionRepo.save(txn);
    }
}
