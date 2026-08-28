package com.pitstop.notification.web;

import com.pitstop.notification.domain.Notification;
import com.pitstop.notification.repo.NotificationRepo;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/notifications")
public class NotificationController {
    private final NotificationRepo repo;

    public NotificationController(NotificationRepo repo) {
        this.repo = repo;
    }

    @GetMapping
    public List<Notification> all() {
        return repo.findAll();
    }

    @PostMapping
    public Notification send(@RequestBody Notification n) {
        return repo.save(n);
    }
}
