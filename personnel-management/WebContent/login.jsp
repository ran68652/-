<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>人事管理系统登录</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        /* 全屏背景图 */
        body {
            height: 100vh;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-image: url("images/bj2.jpg");
            
        }

        /* 登录框 */
        .login-container {
            width: 380px;
            background: rgba(255,255,255,0.9);  /* 半透明白色 */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);

            position: absolute;
            right: 80px;            /* 右侧位置 */
            top: 50%;
            transform: translateY(-50%); /* 垂直居中 */
        }

        h1 {
            font-size: 26px;
            margin-bottom: 30px;
            text-align: center;
            color: #216b56;
        }

        .input-group input {
            width: 100%;
            padding: 12px 16px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
            outline: none;
        }

        /* 角色选择 */
        .role-select {
            margin-bottom: 25px;
            font-size: 15px;
        }
        .role-select label {
            margin-right: 20px;
            cursor: pointer;
        }

        /* 登录按钮 */
        .login-btn {
            width: 100%;
            padding: 12px 0;
            font-size: 18px;
            border: none;
            border-radius: 25px;
            background: #216b56;
            color: white;
            cursor: pointer;
        }
        .login-btn:hover {
            opacity: 0.9;
        }

        /* 错误提示 */
        .error-msg {
            margin-top: 15px;
            color: red;
            font-size: 14px;
            text-align: center;
        }

        /* 注册提示 */
        .register-text {
            margin-top: 20px;
            font-size: 14px;
            text-align: center;
        }
        .register-text a {
            color: #216b56;
            text-decoration: none;
        }
    </style>

</head>
<body>

<div class="login-container">
    <h1>人事管理系统登录</h1>

    <form action="${pageContext.request.contextPath}/auth/login" method="post">

        <!-- 用户名 -->
        <div class="input-group">
            <input type="text" name="username"
                   placeholder="请输入用户名"
                   value="${empty cookie.username.value ? '' : cookie.username.value}">
        </div>

        <!-- 密码 -->
        <div class="input-group">
            <input type="password" name="password" placeholder="请输入密码">
        </div>

        <!-- 角色选择 -->
        <div class="role-select">
            <label><input type="radio" name="role" value="admin"> 管理员</label>
            <label><input type="radio" name="role" value="employee"> 员工</label>
        </div>

        <button type="submit" class="login-btn">登录</button>

        <!-- 错误提示 -->
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

    </form>

    <p class="register-text">
        还没有账号？<a href="register.jsp">注册</a>
    </p>
</div>

</body>
</html>
