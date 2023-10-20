package com.example.distribution_test.controller;

import com.example.distribution_test.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class HelloController {

    private final UserService userService;


    @GetMapping("/hello")
    public String hello() {
        return "hello2";
    }

    @PostMapping("user")
    public ResponseEntity<String> userSave() {
        userService.saveUser();
        return ResponseEntity.status(HttpStatus.OK).body("성공");
    }

    @PostMapping("image")
    public ResponseEntity<String> saveImg(@RequestPart("images") List<MultipartFile> multipartFileList) {
        userService.saveImg(multipartFileList);
        return ResponseEntity.status(HttpStatus.OK).body("성공");
    }

}
