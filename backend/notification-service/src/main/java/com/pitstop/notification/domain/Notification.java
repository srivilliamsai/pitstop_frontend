package com.pitstop.notification.domain;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
public class Notification {
    @Id @GeneratedValue
    private UUID id;

    private UUID userId;
    private String message;
    private String channel; // PUSH, SMS, EMAIL
    private LocalDateTime sentAt = LocalDateTime.now();
    // getters/setters
}
