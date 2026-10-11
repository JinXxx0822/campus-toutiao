package com.campus.toutiao.dao;

import org.apache.ibatis.annotations.Param;

public interface FollowMapper {

    int insert(@Param("userId") Integer userId, @Param("followedId") Integer followedId);

    int delete(@Param("userId") Integer userId, @Param("followedId") Integer followedId);

    int countByUserId(Integer userId);

    int countByFollowedId(Integer followedId);

    boolean exists(@Param("userId") Integer userId, @Param("followedId") Integer followedId);
}
