package com.campus.toutiao.service.impl;

import com.campus.toutiao.dao.ArticleMapper;
import com.campus.toutiao.dao.CommentMapper;
import com.campus.toutiao.entity.Comment;
import com.campus.toutiao.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public List<Comment> getCommentsByArticleId(Integer articleId) {
        return commentMapper.findByArticleId(articleId);
    }

    @Override
    @Transactional
    public void addComment(Comment comment) {
        commentMapper.insert(comment);
        // 更新文章评论数
        int count = commentMapper.countByArticleId(comment.getArticleId());
        // 这里简化处理，实际应该更新article表的comment_count
    }
}
