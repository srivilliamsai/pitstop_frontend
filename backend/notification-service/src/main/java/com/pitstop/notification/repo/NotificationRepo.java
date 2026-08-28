package com.pitstop.notification.repo;

import com.pitstop.notification.domain.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface NotificationRepo extends JpaRepository<Notification, UUID> {
}
