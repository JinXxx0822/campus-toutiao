<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布文章 - 校园头条</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f6fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .publish-container { background: #fff; border-radius: 8px; padding: 40px; margin-top: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">校园头条</a>
        <div class="ms-auto">
            <span class="navbar-text text-white">${sessionScope.loginUser.nickname}</span>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="publish-container">
                <h4 class="mb-4">发布新文章</h4>
                <form id="publishForm">
                    <div class="mb-3">
                        <label class="form-label">标题</label>
                        <input type="text" class="form-control" id="title" name="title" required placeholder="请输入文章标题">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">选择频道</label>
                        <select class="form-select" id="channelId" name="channelId" required>
                            <option value="">请选择频道</option>
                            <c:forEach var="ch" items="${channels}">
                                <option value="${ch.id}">${ch.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">正文内容</label>
                        <textarea class="form-control" id="content" name="content" rows="10" required placeholder="请输入文章内容..."></textarea>
                    </div>
                    <div id="errorMsg" class="text-danger mb-3" style="display:none;"></div>
                    <button type="button" class="btn btn-primary" onclick="doPublish()" style="padding: 10px 40px;">发布文章</button>
                    <a href="/" class="btn btn-outline-secondary ms-2">取消</a>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function doPublish() {
    var title = document.getElementById('title').value;
    var channelId = document.getElementById('channelId').value;
    var content = document.getElementById('content').value;

    if (!title.trim()) { alert('请输入标题'); return; }
    if (!channelId) { alert('请选择频道'); return; }
    if (!content.trim()) { alert('请输入内容'); return; }

    var params = 'title=' + encodeURIComponent(title) +
                 '&channelId=' + channelId +
                 '&content=' + encodeURIComponent(content);

    fetch('/article/publish', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: params
    })
    .then(res => res.json())
    .then(data => {
        if (data.code === 200) {
            alert('发布成功！');
            window.location.href = '/article/' + data.data;
        } else {
            var errorMsg = document.getElementById('errorMsg');
            errorMsg.style.display = 'block';
            errorMsg.textContent = data.message;
        }
    });
}
</script>
</body>
</html>
