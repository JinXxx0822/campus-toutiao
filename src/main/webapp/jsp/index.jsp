<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>校园头条 - 发现校园新鲜事</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f6fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .channel-bar { background: #fff; padding: 10px 0; border-bottom: 1px solid #eee; margin-bottom: 20px; }
        .channel-item { display: inline-block; padding: 6px 16px; margin: 0 4px; border-radius: 20px; color: #666; text-decoration: none; }
        .channel-item.active { background: #667eea; color: #fff; }
        .channel-item:hover { background: #f0f0f0; color: #333; text-decoration: none; }
        .channel-item.active:hover { background: #667eea; color: #fff; }
        .article-card { background: #fff; border-radius: 8px; padding: 20px; margin-bottom: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .article-title { font-size: 18px; font-weight: 600; color: #333; margin-bottom: 8px; }
        .article-title a { color: #333; text-decoration: none; }
        .article-title a:hover { color: #667eea; }
        .article-meta { font-size: 13px; color: #999; }
        .article-meta span { margin-right: 15px; }
        .sidebar-card { background: #fff; border-radius: 8px; padding: 20px; margin-bottom: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .sidebar-title { font-size: 16px; font-weight: 600; margin-bottom: 15px; color: #333; }
        .avatar { width: 40px; height: 40px; border-radius: 50%; background: #ddd; display: inline-flex; align-items: center; justify-content: center; color: #fff; font-weight: 600; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">校园头条</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <form class="d-flex mx-auto" action="/" method="get" style="width: 400px;">
                <input class="form-control me-2" type="search" name="keyword" placeholder="搜索文章..." value="${fn:escapeXml(keyword)}">
                <button class="btn btn-outline-light" type="submit">搜索</button>
            </form>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${sessionScope.loginUser != null}">
                        <li class="nav-item"><a class="nav-link" href="/article/publish">发布</a></li>
                        <li class="nav-item"><a class="nav-link" href="/my/articles">我的文章</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">${sessionScope.loginUser.nickname}</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/user/profile">个人中心</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/user/logout">退出登录</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="/user/login">登录</a></li>
                        <li class="nav-item"><a class="nav-link" href="/user/register">注册</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="channel-bar">
    <div class="container">
        <a href="/" class="channel-item ${empty channelId ? 'active' : ''}">全部</a>
        <c:forEach var="ch" items="${channels}">
            <a href="/?channelId=${ch.id}" class="channel-item ${channelId == ch.id ? 'active' : ''}">${ch.name}</a>
        </c:forEach>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-8">
            <c:forEach var="article" items="${pageData.list}">
                <div class="article-card">
                    <div class="article-title">
                        <a href="/article/${article.id}"><c:out value="${article.title}"/></a>
                    </div>
                    <div class="article-meta">
                        <span class="d-inline-flex align-items-center">
                            <span class="avatar me-2" style="width:24px;height:24px;font-size:12px;"><c:out value="${fn:substring(article.authorName, 0, 1)}"/></span>
                            <c:out value="${article.authorName}"/>
                        </span>
                        <span>${article.channelName}</span>
                        <span>👁 ${article.viewCount}</span>
                        <span>❤️ ${article.likeCount}</span>
                        <span>💬 ${article.commentCount}</span>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty pageData.list}">
                <div class="text-center py-5 text-muted">暂无文章，快来发布第一篇吧！</div>
            </c:if>

            <!-- 分页 -->
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${pageData.page > 1}">
                        <li class="page-item">
                            <a class="page-link" href="/?channelId=${channelId}&keyword=${keyword}&page=${pageData.page - 1}">上一页</a>
                        </li>
                    </c:if>
                    <li class="page-item active"><a class="page-link">第 ${pageData.page} / ${pageData.totalPages} 页</a></li>
                    <c:if test="${pageData.page < pageData.totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="/?channelId=${channelId}&keyword=${keyword}&page=${pageData.page + 1}">下一页</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <div class="col-md-4">
            <div class="sidebar-card">
                <div class="sidebar-title">关于校园头条</div>
                <p class="text-muted" style="font-size:14px;">校园头条是一个面向高校学生的内容分享平台，你可以在这里发布校园资讯、学习交流、社团活动等内容，与同学们分享校园生活的点点滴滴。</p>
            </div>
            <div class="sidebar-card">
                <div class="sidebar-title">热门频道</div>
                <c:forEach var="ch" items="${channels}" varStatus="vs">
                    <div style="padding: 8px 0; border-bottom: 1px solid #f5f5f5;">
                        <span class="text-muted">${vs.index + 1}. </span>
                        <a href="/?channelId=${ch.id}" style="color:#333;text-decoration:none;">${ch.name}</a>
                        <span class="text-muted float-end" style="font-size:12px;">${ch.description}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
