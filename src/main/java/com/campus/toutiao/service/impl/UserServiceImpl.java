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

    /**
     * 更新个人资料。UserMapper.update 仅更新非 null 字段，因此密码等无关字段不受影响。
     */
    @Override
    public boolean updateProfile(User user) {
        return userMapper.update(user) > 0;
    }

    /**
     * 修改密码：先用库中旧密码（加盐哈希）校验原密码，校验通过后再写入新密码的哈希。
     * @return true 修改成功；false 原密码错误或用户不存在
     */
    @Override
    public boolean changePassword(Integer id, String oldPassword, String newPassword) {
        User db = userMapper.findById(id);
        if (db == null) {
            return false;
        }
        if (!PasswordUtil.hash(oldPassword, db.getUsername()).equals(db.getPassword())) {
            return false;
        }
        User update = new User();
        update.setId(id);
        update.setPassword(PasswordUtil.hash(newPassword, db.getUsername()));
        return userMapper.update(update) > 0;
    }
}
