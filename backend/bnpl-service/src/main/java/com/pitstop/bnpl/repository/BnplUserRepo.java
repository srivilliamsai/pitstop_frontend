package com.pitstop.bnpl.repository;

import com.pitstop.bnpl.domain.BnplUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface BnplUserRepo extends JpaRepository<BnplUser, UUID> {
}
