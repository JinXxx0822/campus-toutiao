package com.campus.toutiao.controller;

import com.campus.toutiao.common.Result;
import com.campus.toutiao.entity.Comment;
import com.campus.toutiao.entity.User;
import com.campus.toutiao.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @GetMapping("/article/{articleId}")
    public Result getComments(@PathVariable Integer articleId) {
        List<Comment> comments = commentService.getCommentsByArticleId(articleId);
        return Result.success(comments);
    }

    @PostMapping("/add")
    public Result addComment(@RequestParam Integer articleId,
                             @RequestParam String content,
                             HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        Comment comment = new Comment();
        comment.setArticleId(articleId);
        comment.setContent(content);
        comment.setUserId(loginUser.getId());
        commentService.addComment(comment);
        return Result.success("评论成功", null);
    }
}
