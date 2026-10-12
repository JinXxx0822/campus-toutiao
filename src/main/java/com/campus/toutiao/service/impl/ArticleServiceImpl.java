package com.campus.toutiao.service.impl;

import com.campus.toutiao.dao.ArticleMapper;
import com.campus.toutiao.dao.LikeMapper;
import com.campus.toutiao.entity.Article;
import com.campus.toutiao.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private LikeMapper likeMapper;

    @Override
    public Map<String, Object> getArticleList(Integer channelId, String keyword, Integer page, Integer size) {
        if (page == null || page < 1) page = 1;
        if (size == null || size < 1) size = 10;
        int offset = (page - 1) * size;

        List<Article> list = articleMapper.findList(channelId, keyword, offset, size);
        int total = articleMapper.countList(channelId, keyword);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("total", total);
        result.put("page", page);
        result.put("size", size);
        result.put("totalPages", (int) Math.ceil((double) total / size));
        return result;
    }

    @Override
    public Article getArticleById(Integer id, Integer userId) {
        Article article = articleMapper.findById(id);
        if (article != null) {
            articleMapper.updateViewCount(id);
            article.setViewCount(article.getViewCount() + 1);
            if (userId != null) {
                article.setLiked(likeMapper.exists(userId, id));
            }
        }
        return article;
    }

    @Override
    @Transactional
    public void publishArticle(Article article) {
        article.setStatus(1);
        articleMapper.insert(article);
    }

    @Override
    public List<Article> getMyArticles(Integer userId) {
        return articleMapper.findByUserId(userId);
    }

    @Override
    @Transactional
    public void likeArticle(Integer articleId, Integer userId) {
        if (!likeMapper.exists(userId, articleId)) {
            likeMapper.insert(userId, articleId);
            articleMapper.updateLikeCount(articleId, 1);
        }
    }

    @Override
    @Transactional
    public void unlikeArticle(Integer articleId, Integer userId) {
        if (likeMapper.exists(userId, articleId)) {
            likeMapper.delete(userId, articleId);
            articleMapper.updateLikeCount(articleId, -1);
        }
    }
}
