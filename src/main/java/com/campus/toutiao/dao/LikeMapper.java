package com.campus.toutiao.dao;

import org.apache.ibatis.annotations.Param;

public interface LikeMapper {

    int insert(@Param("userId") Integer userId, @Param("articleId") Integer articleId);

    int delete(@Param("userId") Integer userId, @Param("articleId") Integer articleId);

    int countByArticleId(Integer articleId);

    boolean exists(@Param("userId") Integer userId, @Param("articleId") Integer articleId);
}
