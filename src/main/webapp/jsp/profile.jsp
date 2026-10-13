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
        .card-box { background: #fff; border-radius: 8px; padding: 24px; margin-top: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        .profile-avatar { width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #667eea, #764ba2); color: #fff; display: inline-flex; align-items: center; justify-content: center; font-size: 30px; font-weight: 700; }
        .section-title { font-size: 16px; font-weight: 700; color: #333; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 1px solid #eee; }
        .toast-msg { position: fixed; top: 70px; left: 50%; transform: translateX(-50%); z-index: 9999; display: none; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">校园头条</a>
        <div class="ms-auto">
            <a href="/" class="nav-link d-inline text-white">返回首页</a>
            <a href="/my/articles" class="btn btn-outline-light btn-sm ms-2">我的文章</a>
            <a href="/article/publish" class="btn btn-outline-light btn-sm ms-2">发布文章</a>
            <a href="/user/logout" class="btn btn-outline-light btn-sm ms-2">退出登录</a>
        </div>
    </div>
</nav>

<div class="toast-msg" id="toast">
    <div class="alert alert-success py-2 px-3 mb-0" id="toastBody">保存成功</div>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-7">

            <!-- 基本信息 -->
            <div class="card-box text-center">
                <div class="profile-avatar"><c:out value="${fn:substring(sessionScope.loginUser.nickname, 0, 1)}"/></div>
                <h4 class="mt-2 mb-0"><c:out value="${sessionScope.loginUser.nickname}"/></h4>
                <p class="text-muted">@<c:out value="${sessionScope.loginUser.username}"/></p>
                <p class="text-muted small mb-0">注册时间：<c:out value="${sessionScope.loginUser.createTime}"/></p>
            </div>

            <!-- 编辑资料 -->
            <div class="card-box">
                <div class="section-title">编辑资料</div>
                <form id="profileForm">
                    <div class="mb-3">
                        <label class="form-label">昵称 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="nickname"
                               value="<c:out value='${sessionScope.loginUser.nickname}'/>" maxlength="30" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">学校</label>
                            <input type="text" class="form-control" id="school"
                                   value="<c:out value='${sessionScope.loginUser.school}'/>" maxlength="50">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">学院</label>
                            <input type="text" class="form-control" id="college"
                                   value="<c:out value='${sessionScope.loginUser.college}'/>" maxlength="50">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">个性签名</label>
                        <textarea class="form-control" id="signature" rows="2" maxlength="100"><c:out value="${sessionScope.loginUser.signature}"/></textarea>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="saveProfile()">保存资料</button>
                </form>
            </div>

            <!-- 修改密码 -->
            <div class="card-box">
                <div class="section-title">修改密码</div>
                <form id="pwdForm">
                    <div class="mb-3">
                        <label class="form-label">原密码</label>
                        <input type="password" class="form-control" id="oldPassword" maxlength="30" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">新密码（6-30 位）</label>
                            <input type="password" class="form-control" id="newPassword" maxlength="30" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">确认新密码</label>
                            <input type="password" class="form-control" id="confirmPassword" maxlength="30" required>
                        </div>
                    </div>
                    <button type="button" class="btn btn-outline-primary" onclick="changePassword()">修改密码</button>
                </form>
            </div>

        </div>
    </div>
</div>

<script>
function showToast(text, ok) {
    var t = document.getElementById('toast');
    var body = document.getElementById('toastBody');
    body.className = 'alert alert-' + (ok ? 'success' : 'danger') + ' py-2 px-3 mb-0';
    body.textContent = text;
    t.style.display = 'block';
    setTimeout(function () { t.style.display = 'none'; }, 2500);
}

function saveProfile() {
    var nickname = document.getElementById('nickname').value.trim();
    if (!nickname) { showToast('昵称不能为空', false); return; }
    var body = new URLSearchParams({
        nickname: nickname,
        school: document.getElementById('school').value.trim(),
        college: document.getElementById('college').value.trim(),
        signature: document.getElementById('signature').value.trim()
    });
    fetch('/user/profile/update', { method: 'POST', body: body })
        .then(res => res.json())
        .then(data => {
            if (data.code === 200) { showToast('资料已更新', true); location.reload(); }
            else { showToast(data.message || '更新失败', false); }
        });
}

function changePassword() {
    var oldPwd = document.getElementById('oldPassword').value;
    var newPwd = document.getElementById('newPassword').value;
    var confirmPwd = document.getElementById('confirmPassword').value;
    if (!oldPwd || !newPwd || !confirmPwd) { showToast('请填写完整', false); return; }
    if (newPwd !== confirmPwd) { showToast('两次输入的新密码不一致', false); return; }
    var body = new URLSearchParams({ oldPassword: oldPwd, newPassword: newPwd });
    fetch('/user/password', { method: 'POST', body: body })
        .then(res => res.json())
        .then(data => {
            if (data.code === 200) { showToast('密码已修改，即将重新登录', true); setTimeout(function(){ location.href = '/user/logout'; }, 1200); }
            else { showToast(data.message || '修改失败', false); }
        });
}
</script>
</body>
</html>
