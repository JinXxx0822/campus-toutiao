package com.campus.toutiao.controller;

import com.campus.toutiao.common.Result;
import com.campus.toutiao.dao.ChannelMapper;
import com.campus.toutiao.entity.Article;
import com.campus.toutiao.entity.Channel;
import com.campus.toutiao.entity.User;
import com.campus.toutiao.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private ChannelMapper channelMapper;

    @GetMapping("/")
    public String index(@RequestParam(required = false) Integer channelId,
                        @RequestParam(required = false) String keyword,
                        @RequestParam(required = false, defaultValue = "1") Integer page,
                        Model model) {
        // 页码边界限制：最小 1，最大 10000，避免非法/超大分页
        if (page == null || page < 1) {
            page = 1;
        } else if (page > 10000) {
            page = 10000;
        }
        List<Channel> channels = channelMapper.findAll();
        Map<String, Object> pageData = articleService.getArticleList(channelId, keyword, page, 10);

        model.addAttribute("channels", channels);
        model.addAttribute("channelId", channelId);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pageData", pageData);
        return "index";
    }

    @GetMapping("/article/{id}")
    public String detail(@PathVariable Integer id, Model model, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        Article article = articleService.getArticleById(id, loginUser != null ? loginUser.getId() : null);
        if (article == null) {
            return "redirect:/";
        }
        model.addAttribute("article", article);
        return "article_detail";
    }

    @GetMapping("/article/publish")
    public String publishPage(Model model, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/user/login";
        }
        List<Channel> channels = channelMapper.findAll();
        model.addAttribute("channels", channels);
        return "publish";
    }

    @PostMapping("/article/publish")
    @ResponseBody
    public Result publish(Article article, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        // 后端参数校验：标题、内容、频道
        String title = article.getTitle() == null ? "" : article.getTitle().trim();
        String content = article.getContent() == null ? "" : article.getContent().trim();
        if (title.isEmpty()) {
            return Result.error("标题不能为空");
        }
        if (title.length() > 200) {
            return Result.error("标题长度不能超过 200 字");
        }
        if (content.isEmpty()) {
            return Result.error("正文内容不能为空");
        }
        if (article.getChannelId() == null) {
            return Result.error("请选择频道");
        }
        article.setTitle(title);
        article.setContent(content);
        article.setUserId(loginUser.getId());
        articleService.publishArticle(article);
        return Result.success("发布成功", article.getId());
    }

    @PostMapping("/article/{id}/like")
    @ResponseBody
    public Result like(@PathVariable Integer id, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        articleService.likeArticle(id, loginUser.getId());
        return Result.success("点赞成功", null);
    }

    @PostMapping("/article/{id}/unlike")
    @ResponseBody
    public Result unlike(@PathVariable Integer id, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        articleService.unlikeArticle(id, loginUser.getId());
        return Result.success("取消点赞", null);
    }

    @GetMapping("/my/articles")
    public String myArticles(Model model, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/user/login";
        }
        List<Article> articles = articleService.getMyArticles(loginUser.getId());
        model.addAttribute("articles", articles);
        return "my_articles";
    }
}
