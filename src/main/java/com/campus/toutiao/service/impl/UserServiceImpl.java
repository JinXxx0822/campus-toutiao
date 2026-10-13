package com.campus.toutiao.service.impl;

import com.campus.toutiao.common.PasswordUtil;
import com.campus.toutiao.dao.UserMapper;
import com.campus.toutiao.entity.User;
import com.campus.toutiao.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 登录校验：对输入密码做与注册时一致的加盐 SHA-256 哈希，再与库中密文比对。
     */
    @Override
    public User login(String username, String password) {
        User user = userMapper.findByUsername(username);
        if (user != null && PasswordUtil.hash(password, username).equals(user.getPassword())) {
            user.setPassword(null); // 不回传密码
            return user;
        }
        return null;
    }

    /**
     * 注册：先对密码加盐哈希，再写入数据库，避免明文存储。
     */
    @Override
    public User register(User user) {
        user.setPassword(PasswordUtil.hash(user.getPassword(), user.getUsername()));
        userMapper.insert(user);
        return user;
    }

    @Override
    public User findById(Integer id) {
        User user = userMapper.findById(id);
        if (user != null) {
            user.setPassword(null);
        }
        return user;
    }

    @Override
    public boolean isUsernameExists(String username) {
        return userMapper.findByUsername(username) != null;
    }
}
