package com.campus.toutiao.service;

import com.campus.toutiao.entity.User;

public interface UserService {

    User login(String username, String password);

    User register(User user);

    User findById(Integer id);

    boolean isUsernameExists(String username);

    /** 更新个人资料（昵称/学校/学院/签名等），返回是否成功 */
    boolean updateProfile(User user);

    /** 修改密码：校验旧密码正确后，以加盐哈希更新新密码 */
    boolean changePassword(Integer id, String oldPassword, String newPassword);
}
