package com.pitstop.userservice.web;
import com.pitstop.common.security.JwtUtil; import com.pitstop.userservice.domain.User; import com.pitstop.userservice.repo.UserRepo;
import org.springframework.http.ResponseEntity; import org.springframework.security.crypto.password.PasswordEncoder; import org.springframework.web.bind.annotation.*;
import java.util.*;
@RestController @RequestMapping("/auth")
public class AuthController {
  private final UserRepo repo; private final PasswordEncoder encoder; private final JwtUtil jwt;
  public AuthController(UserRepo r, PasswordEncoder e, JwtUtil j){ repo=r; encoder=e; jwt=j; }
  @PostMapping("/register")
  public ResponseEntity<?> register(@RequestBody Map<String,Object> b){
    String email=(String)b.get("email"); if(repo.findByEmail(email).isPresent()) return ResponseEntity.badRequest().body("Email exists");
    User u=new User(); u.setName((String)b.get("name")); u.setEmail(email); u.setPhone((String)b.get("phone"));
    u.setPasswordHash(encoder.encode((String)b.get("password"))); repo.save(u);
    return ResponseEntity.ok(Collections.singletonMap("id",u.getId().toString()));
  }
  @PostMapping("/login")
  public ResponseEntity<?> login(@RequestBody Map<String,String> b){
    return repo.findByEmail(b.get("email")).map(u->{
      if(!encoder.matches(b.get("password"),u.getPasswordHash())) return ResponseEntity.status(401).body("Invalid");
      Map<String,Object> claims=new HashMap<>(); claims.put("role", u.getRole().name());
      return ResponseEntity.ok(Collections.singletonMap("token", jwt.generate(u.getEmail(), claims)));
    }).orElse(ResponseEntity.status(404).body("User not found"));
  }
}
