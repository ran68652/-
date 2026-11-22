<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="bean.User" %>
<%
    User user = (User) session.getAttribute("user");
    // 判断是否为管理员(ADMIN)
    boolean isAdmin = user != null && "ADMIN".equals(user.getRole());
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft Yahei", Arial, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            min-height: 100vh;
            padding: 50px 20px;
            background-image: url("images/bj2.jpg");
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
            padding: 40px;
        }
        
        h2 {
            color: #216b56;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 3px solid #91b7a2;
            font-size: 26px;
        }
        
        .user-info {
            background-color: #f8fbf9;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            font-size: 16px;
            color: #333;
            border-left: 4px solid #216b56;
        }
        
        ul {
            list-style: none;
            margin-bottom: 35px;
            
        }
        
        li {
            margin: 12px 0;
           
        }
        
        li a {
            display: block;
            padding: 12px 20px;
            background-color: #f0f7f3;
            color: #216b56;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }
        
        li a:hover {
            background-color: #e6f0ea;
            border-left-color: #216b56;
            transform: translateX(5px);
        }
        
        .logout-btn {
            display: inline-block;
            padding: 12px 25px;
            background-color: #7f8c8d;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        
        .logout-btn:hover {
            background-color:  #6a7879;
            color: white;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>欢迎使用 人事管理系统</h2>
        
        <div class="user-info">
            当前用户：<%= user != null ? user.getUsername() : "未登录" %> （角色：<%= user != null ? user.getRole() : "" %>)
        </div>
        
        <ul>
            <%-- 仅管理员显示员工管理入口 --%>
            <% if (isAdmin) { %>
                <li><a href="${pageContext.request.contextPath}/employee/list">员工管理</a></li>
            <% } %>
            <li><a href="${pageContext.request.contextPath}/salary/list">工资管理</a></li>
            <li><a href="${pageContext.request.contextPath}/leave/list">请假管理</a></li>
            <li><a href="${pageContext.request.contextPath}/suggestion/list">员工反馈</a></li>
        </ul>
        
        <a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn">退出</a>
    </div>
</body>
</html>