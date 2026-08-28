package com.pitstop.mechanic.repo;

import com.pitstop.mechanic.domain.Mechanic;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface MechanicRepo extends JpaRepository<Mechanic, UUID> {

    // Custom finder method (optional)
    List<Mechanic> findBySkill(String skill);
}
