package com.campus.toutiao.dao;

import com.campus.toutiao.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    User findByUsername(String username);

    User findById(Integer id);

    int insert(User user);

    int update(User user);
}
