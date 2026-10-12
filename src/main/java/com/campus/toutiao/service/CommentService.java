package com.campus.toutiao.service;

import com.campus.toutiao.entity.Comment;
import java.util.List;

public interface CommentService {

    List<Comment> getCommentsByArticleId(Integer articleId);

    void addComment(Comment comment);
}
