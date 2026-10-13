<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 校园头条</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; }
        .login-card { background: #fff; border-radius: 12px; padding: 40px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); }
        .login-title { text-align: center; margin-bottom: 30px; color: #333; }
        .btn-login { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; width: 100%; padding: 12px; }
        .btn-login:hover { opacity: 0.9; }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="login-card">
                <h3 class="login-title">校园头条 - 登录</h3>
                <form id="loginForm">
                    <div class="mb-3">
                        <label class="form-label">用户名</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">密码</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div id="errorMsg" class="text-danger mb-3" style="display:none;"></div>
                    <button type="button" class="btn btn-primary btn-login" onclick="doLogin()">登 录</button>
                </form>
                <div class="text-center mt-3">
                    还没有账号？<a href="/user/register" style="color:#667eea;">立即注册</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
function doLogin() {
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;
    var errorMsg = document.getElementById('errorMsg');

    fetch('/user/login', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(password)
    })
    .then(res => res.json())
    .then(data => {
        if (data.code === 200) {
            window.location.href = '/';
        } else {
            errorMsg.style.display = 'block';
            errorMsg.textContent = data.message;
        }
    });
}
</script>
</body>
</html>
