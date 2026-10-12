package com.campus.toutiao.service;

import com.campus.toutiao.entity.Article;
import java.util.List;
import java.util.Map;

public interface ArticleService {

    Map<String, Object> getArticleList(Integer channelId, String keyword, Integer page, Integer size);

    Article getArticleById(Integer id, Integer userId);

    void publishArticle(Article article);

    List<Article> getMyArticles(Integer userId);

    void likeArticle(Integer articleId, Integer userId);

    void unlikeArticle(Integer articleId, Integer userId);
}
