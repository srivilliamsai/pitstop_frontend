package com.pitstop.mechanic.web;

import com.pitstop.mechanic.domain.Mechanic;
import com.pitstop.mechanic.repo.MechanicRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/mechanics")
public class MechanicController {

    @Autowired
    private MechanicRepo mechanicRepo;

    // GET all mechanics
    @GetMapping
    public List<Mechanic> getAllMechanics() {
        return mechanicRepo.findAll();
    }

    // GET mechanic by ID
    @GetMapping("/{id}")
    public Optional<Mechanic> getMechanicById(@PathVariable UUID id) {
        return mechanicRepo.findById(id);
    }

    // GET mechanics by skill
    @GetMapping("/skill/{skill}")
    public List<Mechanic> getBySkill(@PathVariable String skill) {
        return mechanicRepo.findBySkill(skill.toUpperCase());
    }

    // POST create mechanic
    @PostMapping
    public Mechanic createMechanic(@RequestBody Mechanic mechanic) {
        return mechanicRepo.save(mechanic);
    }

    // PUT update mechanic
    @PutMapping("/{id}")
    public Mechanic updateMechanic(@PathVariable UUID id, @RequestBody Mechanic updated) {
        return mechanicRepo.findById(id).map(m -> {
            m.setName(updated.getName());
            m.setSkill(updated.getSkill());
            m.setLat(updated.getLat());
            m.setLng(updated.getLng());
            return mechanicRepo.save(m);
        }).orElseThrow(() -> new RuntimeException("Mechanic not found with id " + id));
    }

    // DELETE mechanic
    @DeleteMapping("/{id}")
    public void deleteMechanic(@PathVariable UUID id) {
        mechanicRepo.deleteById(id);
    }
}
