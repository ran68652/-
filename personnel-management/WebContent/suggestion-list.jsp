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
    <title>员工反馈列表</title>
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
        
        td.title {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        td.content {
            max-width: 400px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        tr:hover {
            background-color: #f8f9fa;
        }
        
        a {
            color: #3498db;
            text-decoration: none;
        }
        
        a:hover {
            text-decoration: underline;
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
        <h2>员工反馈列表</h2>

        <% if (!isAdmin) { %>
            <a href="${pageContext.request.contextPath}/suggestion/add" class="btn">新增反馈</a>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>反馈标题</th>
                    <th>反馈内容</th>
                    <th>提交时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty suggestions}">
                        <tr>
                            <td colspan="5" class="empty-tip">暂无数据</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="s" items="${suggestions}">
                            <tr>
                                <td>${s.suggestionID}</td>
                                <td class="title" title="${s.suggestionTitle}">${s.suggestionTitle}</td>
                                <td class="content" title="${s.suggestionContent}">${s.suggestionContent}</td>
                                <td>${s.submitTime}</td>
                                <td class="action-links">
                                    <c:if test="${sessionScope.user.role != 'ADMIN'}">
                                        <a href="${pageContext.request.contextPath}/suggestion/edit?id=${s.suggestionID}" class="btn btn-secondary">编辑</a>
                                        <a href="${pageContext.request.contextPath}/suggestion/delete?id=${s.suggestionID}" onclick="return confirm('确认删除该建议?')" class="btn btn-danger">删除</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        
        <a href="${pageContext.request.contextPath}/default.jsp" class="back-link btn btn-secondary">返回首页</a>
    </div>
</body>
</html>