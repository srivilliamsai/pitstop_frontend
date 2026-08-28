package com.pitstop.emergency.repo;

import com.pitstop.emergency.domain.EmergencyRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface EmergencyRepo extends JpaRepository<EmergencyRequest, UUID> {
    List<EmergencyRequest> findBySeverity(String severity);
    List<EmergencyRequest> findByIssueType(String issueType);
}
