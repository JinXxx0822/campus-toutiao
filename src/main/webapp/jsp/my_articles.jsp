<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的文章 - 校园头条</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f6fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .article-card { background: #fff; border-radius: 8px; padding: 20px; margin-bottom: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .article-title { font-size: 18px; font-weight: 600; color: #333; margin-bottom: 8px; }
        .article-title a { color: #333; text-decoration: none; }
        .article-meta { font-size: 13px; color: #999; }
        .article-meta span { margin-right: 15px; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">校园头条</a>
        <div class="ms-auto">
            <a href="/article/publish" class="btn btn-outline-light btn-sm me-2">发布文章</a>
            <a href="/user/profile" class="nav-link d-inline text-white">个人中心</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h4 class="mb-4">我的文章</h4>

    <c:forEach var="article" items="${articles}">
        <div class="article-card">
            <div class="article-title">
                <a href="/article/${article.id}">${article.title}</a>
            </div>
            <div class="article-meta">
                <span>${article.channelName}</span>
                <span>👁 ${article.viewCount}</span>
                <span>❤️ ${article.likeCount}</span>
                <span>💬 ${article.commentCount}</span>
                <span>${article.createTime}</span>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty articles}">
        <div class="text-center py-5 text-muted">
            <p>你还没有发布过文章</p>
            <a href="/article/publish" class="btn btn-primary mt-3">去发布第一篇</a>
        </div>
    </c:if>
</div>

</body>
</html>
