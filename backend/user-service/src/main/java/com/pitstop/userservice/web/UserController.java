package com.pitstop.userservice.web;
import com.pitstop.userservice.repo.UserRepo; import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication; import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/users")
public class UserController {
  private final UserRepo repo; public UserController(UserRepo r){repo=r;}
  @GetMapping("/me")
  public ResponseEntity<?> me(Authentication auth){
    if(auth==null) return ResponseEntity.status(401).build();
    return repo.findByEmail(auth.getName()).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
  }
}
