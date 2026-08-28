package com.pitstop.userservice.domain;
import javax.persistence.*; import java.util.UUID;
@Entity @Table(name="users")
public class User {
  @Id @Column(columnDefinition="BINARY(16)") private UUID id = UUID.randomUUID();
  private String name; @Column(unique=true) private String email; private String phone; private String passwordHash;
  @Enumerated(EnumType.STRING) private Role role = Role.CUSTOMER; private boolean verified=false;
  public enum Role{ CUSTOMER, DRIVER, MECHANIC, ADMIN }
  public UUID getId(){return id;} public String getName(){return name;} public void setName(String v){name=v;}
  public String getEmail(){return email;} public void setEmail(String v){email=v;}
  public String getPhone(){return phone;} public void setPhone(String v){phone=v;}
  public String getPasswordHash(){return passwordHash;} public void setPasswordHash(String v){passwordHash=v;}
  public Role getRole(){return role;} public void setRole(Role v){role=v;}
  public boolean isVerified(){return verified;} public void setVerified(boolean v){verified=v;}
}
