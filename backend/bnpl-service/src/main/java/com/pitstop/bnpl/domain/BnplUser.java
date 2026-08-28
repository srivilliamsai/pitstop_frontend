// BnplUser.java
package com.pitstop.bnpl.domain;

import javax.persistence.*;
import java.util.UUID;

@Entity
public class BnplUser {
    @Id
    @GeneratedValue
    private UUID id;

    private String name;
    private String email;
    private double creditLimit;
    private double availableLimit;

    public BnplUser() {}

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public double getCreditLimit() { return creditLimit; }
    public void setCreditLimit(double creditLimit) { this.creditLimit = creditLimit; }

    public double getAvailableLimit() { return availableLimit; }
    public void setAvailableLimit(double availableLimit) { this.availableLimit = availableLimit; }
}
