<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${article.title}"/> - 校园头条</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f6fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .article-container { background: #fff; border-radius: 8px; padding: 40px; margin-top: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .article-title { font-size: 28px; font-weight: 700; color: #222; margin-bottom: 20px; }
        .article-info { color: #999; font-size: 14px; padding-bottom: 20px; border-bottom: 1px solid #eee; margin-bottom: 30px; }
        .article-content { font-size: 16px; line-height: 1.8; color: #333; white-space: pre-wrap; }
        .action-bar { padding: 20px 0; border-top: 1px solid #eee; margin-top: 30px; }
        .btn-action { margin-right: 15px; }
        .comment-item { padding: 15px 0; border-bottom: 1px solid #f0f0f0; }
        .comment-avatar { width: 36px; height: 36px; border-radius: 50%; background: #667eea; color: #fff; display: inline-flex; align-items: center; justify-content: center; font-weight: 600; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">校园头条</a>
        <div class="ms-auto">
            <c:choose>
                <c:when test="${sessionScope.loginUser != null}">
                    <a href="/article/publish" class="btn btn-outline-light btn-sm">发布文章</a>
                    <a href="/user/profile" class="nav-link d-inline">${sessionScope.loginUser.nickname}</a>
                </c:when>
                <c:otherwise>
                    <a href="/user/login" class="btn btn-outline-light btn-sm">登录</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="article-container">
                <h1 class="article-title"><c:out value="${article.title}"/></h1>
                <div class="article-info">
                    <span><c:out value="${article.authorName}"/></span> ·
                    <span><c:out value="${article.channelName}"/></span> ·
                    <span><c:out value="${article.createTime}"/></span> ·
                    <span>阅读 ${article.viewCount}</span>
                </div>
                <div class="article-content"><c:out value="${article.content}"/></div>

                <div class="action-bar">
                    <button class="btn btn-outline-danger btn-action" id="likeBtn" onclick="toggleLike()">
                        ❤️ 点赞 (<span id="likeCount">${article.likeCount}</span>)
                    </button>
                    <span class="text-muted">💬 ${article.commentCount} 评论</span>
                </div>
            </div>

            <!-- 评论区 -->
            <div class="article-container mt-4">
                <h5>评论（${article.commentCount}）</h5>

                <c:if test="${sessionScope.loginUser != null}">
                    <div class="mb-4">
                        <textarea class="form-control" id="commentContent" rows="3" placeholder="写下你的评论..." maxlength="500"></textarea>
                        <button class="btn btn-primary mt-2" id="commentBtn" onclick="addComment()">发表评论</button>
                    </div>
                </c:if>
                <c:if test="${sessionScope.loginUser == null}">
                    <div class="text-center py-3 text-muted">
                        <a href="/user/login">登录</a>后参与评论
                    </div>
                </c:if>

                <c:if test="${empty comments}">
                    <div class="text-center text-muted py-3">暂无评论，快来抢沙发～</div>
                </c:if>

                <div id="commentList">
                    <c:forEach var="comment" items="${comments}">
                        <div class="comment-item">
                            <div class="d-flex">
                                <span class="comment-avatar"><c:out value="${fn:substring(comment.userName, 0, 1)}"/></span>
                                <div class="ms-3">
                                    <div class="fw-bold"><c:out value="${comment.userName}"/></div>
                                    <div class="text-muted" style="font-size:12px;"><c:out value="${comment.createTime}"/></div>
                                    <div class="mt-1"><c:out value="${comment.content}"/></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
var articleId = ${article.id};
var isLiked = ${article.liked != null && article.liked};

function toggleLike() {
    var url = isLiked ? '/article/' + articleId + '/unlike' : '/article/' + articleId + '/like';
    fetch(url, {method: 'POST'})
        .then(res => res.json())
        .then(data => {
            if (data.code === 200) {
                isLiked = !isLiked;
                var count = parseInt(document.getElementById('likeCount').textContent);
                document.getElementById('likeCount').textContent = isLiked ? count + 1 : count - 1;
            } else {
                alert(data.message);
            }
        });
}

function addComment() {
    var content = document.getElementById('commentContent').value;
    if (!content.trim()) {
        alert('请输入评论内容');
        return;
    }
    fetch('/comment/add', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'articleId=' + articleId + '&content=' + encodeURIComponent(content)
    })
    .then(res => res.json())
    .then(data => {
        if (data.code === 200) {
            location.reload();
        } else {
            alert(data.message);
        }
    });
}

// 加载评论
function loadComments() {
    fetch('/comment/article/' + articleId)
        .then(res => res.json())
        .then(data => {
            if (data.code === 200) {
                // 评论渲染逻辑，简化处理
            }
        });
}
</script>
</body>
</html>
