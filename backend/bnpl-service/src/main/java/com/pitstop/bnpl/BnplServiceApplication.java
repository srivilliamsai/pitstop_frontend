package com.pitstop.bnpl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@EnableFeignClients(basePackages = "com.pitstop.bnpl.client")
@SpringBootApplication
public class BnplServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(BnplServiceApplication.class, args);
    }
}
