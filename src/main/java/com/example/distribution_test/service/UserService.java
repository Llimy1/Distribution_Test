package com.example.distribution_test.service;

import com.example.distribution_test.config.S3UploadService;
import com.example.distribution_test.domain.UserRepository;
import com.example.distribution_test.domain.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RequiredArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;
    private final S3UploadService s3UploadService;

    public void saveUser() {

        User user = User.builder()
                .email("abcd@naver.com")
                .build();

        userRepository.save(user);
    }

    public void saveImg(List<MultipartFile> multipartFileList) {
        s3UploadService.communityUpload(multipartFileList);
    }
}
