package com.example.client;

import com.example.entity.User.ERole;
import com.example.entity.User.User;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(value = "user-service", fallback = UserFallBackClient.class)
public interface UserClient {
    @GetMapping("/findUserById")
    User findById(@RequestParam(required = true,name = "id") Long id);

    @GetMapping("/findByRoleName")
    Object findByRoleName(@RequestParam(required = true,name = "roleName") ERole roleName);

    @GetMapping("/findByUsernameContaining")
    public List<User> findByUsernameContaining(@RequestParam(required = true,name = "username") String username);
}
