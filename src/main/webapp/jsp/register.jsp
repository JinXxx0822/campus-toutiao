<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 校园头条</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; }
        .register-card { background: #fff; border-radius: 12px; padding: 40px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); }
        .register-title { text-align: center; margin-bottom: 30px; color: #333; }
        .btn-register { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; width: 100%; padding: 12px; }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="register-card">
                <h3 class="register-title">校园头条 - 注册</h3>
                <form id="registerForm">
                    <div class="mb-3">
                        <label class="form-label">用户名</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">密码</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">昵称</label>
                        <input type="text" class="form-control" id="nickname" name="nickname" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">学校</label>
                        <input type="text" class="form-control" id="school" name="school" placeholder="如：XX大学">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">学院</label>
                        <input type="text" class="form-control" id="college" name="college" placeholder="如：计算机学院">
                    </div>
                    <div id="errorMsg" class="text-danger mb-3" style="display:none;"></div>
                    <button type="button" class="btn btn-primary btn-register" onclick="doRegister()">注 册</button>
                </form>
                <div class="text-center mt-3">
                    已有账号？<a href="/user/login" style="color:#667eea;">去登录</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
function doRegister() {
    var formData = new FormData(document.getElementById('registerForm'));
    var params = new URLSearchParams(formData).toString();

    fetch('/user/register', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: params
    })
    .then(res => res.json())
    .then(data => {
        if (data.code === 200) {
            alert('注册成功，请登录');
            window.location.href = '/user/login';
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
