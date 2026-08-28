package com.pitstop.userservice.repo;
import com.pitstop.userservice.domain.User; import org.springframework.data.jpa.repository.JpaRepository;
import java.util.*; import java.util.UUID;
public interface UserRepo extends JpaRepository<User, UUID>{ Optional<User> findByEmail(String email); }
