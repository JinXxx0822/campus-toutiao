package com.campus.toutiao.service;

import com.campus.toutiao.entity.User;

public interface UserService {

    User login(String username, String password);

    User register(User user);

    User findById(Integer id);

    boolean isUsernameExists(String username);
}
