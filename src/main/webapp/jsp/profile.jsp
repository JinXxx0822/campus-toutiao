<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - 校园头条</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f6fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .profile-card { background: #fff; border-radius: 8px; padding: 40px; margin-top: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); text-align: center; }
        .profile-avatar { width: 100px; height: 100px; border-radius: 50%; background: linear-gradient(135deg, #667eea, #764ba2); color: #fff; display: inline-flex; align-items: center; justify-content: center; font-size: 36px; font-weight: 700; margin-bottom: 20px; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">校园头条</a>
        <div class="ms-auto">
            <a href="/" class="nav-link d-inline text-white">返回首页</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="profile-card">
                <div class="profile-avatar"><c:out value="${fn:substring(sessionScope.loginUser.nickname, 0, 1)}"/></div>
                <h4><c:out value="${sessionScope.loginUser.nickname}"/></h4>
                <p class="text-muted">@<c:out value="${sessionScope.loginUser.username}"/></p>

                <div class="row mt-4">
                    <div class="col-4">
                        <div class="border-end">
                            <h5>12</h5>
                            <small class="text-muted">文章</small>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="border-end">
                            <h5>56</h5>
                            <small class="text-muted">关注</small>
                        </div>
                    </div>
                    <div class="col-4">
                        <h5>128</h5>
                        <small class="text-muted">粉丝</small>
                    </div>
                </div>

                <hr class="my-4">

                <div class="text-start">
                    <p><strong>学校：</strong><c:out value="${sessionScope.loginUser.school != null ? sessionScope.loginUser.school : '未填写'}"/></p>
                    <p><strong>学院：</strong><c:out value="${sessionScope.loginUser.college != null ? sessionScope.loginUser.college : '未填写'}"/></p>
                    <p><strong>个性签名：</strong><c:out value="${sessionScope.loginUser.signature}"/></p>
                    <p><strong>注册时间：</strong><c:out value="${sessionScope.loginUser.createTime}"/></p>
                </div>

                <div class="mt-4">
                    <a href="/my/articles" class="btn btn-primary">我的文章</a>
                    <a href="/article/publish" class="btn btn-outline-primary ms-2">发布文章</a>
                    <a href="/user/logout" class="btn btn-outline-danger ms-2">退出登录</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
