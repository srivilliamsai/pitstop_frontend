package com.pitstop.emergency.web;

import com.pitstop.emergency.domain.EmergencyRequest;
import com.pitstop.emergency.repo.EmergencyRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/emergency")
public class EmergencyController {

    @Autowired
    private EmergencyRepo emergencyRepo;

    // Create emergency request
    @PostMapping
    public EmergencyRequest create(@RequestBody EmergencyRequest request) {
        request.setRequestTime(LocalDateTime.now());
        return emergencyRepo.save(request);
    }

    // Get all emergency requests
    @GetMapping
    public List<EmergencyRequest> getAll() {
        return emergencyRepo.findAll();
    }

    // Get by ID
    @GetMapping("/{id}")
    public EmergencyRequest getById(@PathVariable UUID id) {
        return emergencyRepo.findById(id).orElse(null);
    }

    // Filter by severity (e.g., HIGH, MEDIUM, LOW)
    @GetMapping("/severity/{level}")
    public List<EmergencyRequest> getBySeverity(@PathVariable String level) {
        return emergencyRepo.findBySeverity(level.toUpperCase());
    }

    // Filter by issue type (e.g., BATTERY, ENGINE)
    @GetMapping("/issue/{type}")
    public List<EmergencyRequest> getByIssueType(@PathVariable String type) {
        return emergencyRepo.findByIssueType(type.toUpperCase());
    }
}
