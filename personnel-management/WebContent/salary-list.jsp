<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 新增：导入必要的类（核心修复） --%>
<%@ page import="bean.Salary" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.User" %>
<%
    User loginUser = (User) session.getAttribute("user");
    // 强制判断管理员(和Servlet保持一致)
    boolean isAdmin = false;
    if (loginUser != null) {
        if ("ADMIN".equals(loginUser.getRole()) || "11".equals(loginUser.getUsername())) {
            isAdmin = true;
        }
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>工资列表</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft Yahei", Arial, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: #f0f7f3;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            padding: 20px;
        }
        
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid  #216b56;
        }
        
        .btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: #216b56;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 15px;
            transition: background-color 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .btn:hover {
            background-color: #1a5645;
        }
        
        .btn-secondary {
            background-color: #95a5a6;
        }
        
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
        
        .btn-danger {
            background-color: #e74c3c;
        }
        
        .btn-danger:hover {
            background-color: #c0392b;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: white;
        }
        
        th {
            background-color: #216b56;
            color:white;
            padding: 12px;
            text-align: left;
            font-weight: normal;
        }
        
        td {
            padding: 12px;
            border-bottom: 1px solid #ecf0f1;
            color: #34495e;
        }
        
        tr:hover {
            background-color: #f8f9fa;
        }
        
        .action-links a {
            margin-right: 10px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 15px;
        }
        
        .empty-tip {
            text-align: center;
            padding: 30px;
            color: #7f8c8d;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>工资列表</h2>
        
        <%-- 管理员强制显示新增按钮 --%>
        <% if (isAdmin) { %>
            <a href="${pageContext.request.contextPath}/salary/add" class="btn">新增工资条</a>
        <% } %>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>员工ID</th>
                    <th>基本工资</th>
                    <th>奖金</th>
                    <th>税</th>
                    <th>发放日期</th>
                    <%-- 管理员显示操作列 --%>
                    <% if (isAdmin) { %>
                        <th>操作</th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <%
                    // 现在能正确识别List和Salary类型
                    List<Salary> salaries = (List<Salary>) request.getAttribute("salaries");
                    if (salaries == null || salaries.isEmpty()) {
                %>
                    <tr>
                        <td colspan="<%= isAdmin ? 7 : 6 %>" class="empty-tip">暂无工资数据</td>
                    </tr>
                <% } else { %>
                    <% for (Salary s : salaries) { %>
                        <tr>
                            <td><%= s.getId() %></td>
                            <td><%= s.getEmployeeId() %></td>
                            <td><%= s.getBaseSalary() %></td>
                            <td><%= s.getBonus() %></td>
                            <td><%= s.getTax() %></td>
                            <td><%= s.getPayDate() %></td>
                            <%-- 管理员显示编辑/删除按钮 --%>
                            <% if (isAdmin) { %>
                                <td class="action-links">
                                    <a href="${pageContext.request.contextPath}/salary/edit?id=<%= s.getId() %>" class="btn btn-secondary">编辑</a>
                                    <a href="${pageContext.request.contextPath}/salary/delete?id=<%= s.getId() %>" onclick="return confirm('确认删除?')" class="btn btn-danger">删除</a>
                                </td>
                            <% } %>
                        </tr>
                    <% } %>
                <% } %>
            </tbody>
        </table>
        
        <a href="${pageContext.request.contextPath}/default.jsp" class="back-link btn btn-secondary">返回首页</a>
    </div>
</body>
</html>