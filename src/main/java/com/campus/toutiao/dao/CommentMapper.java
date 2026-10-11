package com.campus.toutiao.dao;

import com.campus.toutiao.entity.Comment;
import java.util.List;

public interface CommentMapper {

    List<Comment> findByArticleId(Integer articleId);

    int insert(Comment comment);

    int delete(Integer id);

    int countByArticleId(Integer articleId);
}
