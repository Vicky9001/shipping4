package com.example.client;

import com.example.entity.User.ERole;
import com.example.entity.User.User;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;


@Component   //注意，需要将其注册为Bean，Feign才能自动注入
public class UserFallBackClient implements UserClient{
    @Override
    public User findById(Long id) {
        System.out.println("服务降级");
        User user = new User();
        user.setUsername("我是替代方案");
        return user;
    }

    @Override
    public Object findByRoleName(ERole roleName) {
        System.out.println("服务降级");
        User user = new User();
        user.setUsername("我是替代方案");
        return user;
    }

    @Override
    public List<User> findByUsernameContaining(String username) {
        System.out.println("服务降级");
        List<User> l = new ArrayList<>();
        User user = new User();
        user.setUsername("我是替代方案");
        l.add(user);
        return l;
    }

//    @Override
//    public User registerDriver(User signUp){
//        System.out.println("服务降级");
//        User user = new User();
//        user.setUserName("我是替代方案");
//        return user;
//    }
//
}
