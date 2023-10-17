package com.example.distribution_test;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@SpringBootApplication
@RestController
public class DistributionTestApplication {

    public static void main(String[] args) {
        SpringApplication.run(DistributionTestApplication.class, args);
    }

    @GetMapping("/")
    public String handleRequest() {
        return "ok";
    }
}
