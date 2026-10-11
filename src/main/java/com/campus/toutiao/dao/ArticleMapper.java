package com.campus.toutiao.dao;

import com.campus.toutiao.entity.Article;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface ArticleMapper {

    List<Article> findList(@Param("channelId") Integer channelId,
                           @Param("keyword") String keyword,
                           @Param("offset") Integer offset,
                           @Param("limit") Integer limit);

    int countList(@Param("channelId") Integer channelId,
                  @Param("keyword") String keyword);

    Article findById(Integer id);

    int insert(Article article);

    int update(Article article);

    int delete(Integer id);

    int updateViewCount(Integer id);

    int updateLikeCount(@Param("id") Integer id, @Param("count") int count);

    List<Article> findByUserId(Integer userId);
}
