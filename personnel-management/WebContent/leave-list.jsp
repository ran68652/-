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
    <title>请假列表</title>
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
        
        .btn-approve {
            background-color: #1ea767;
            padding: 6px 12px;
            font-size: 14px;
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-approve:hover {
            background-color: #216b56;
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
        
        select {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 5px;
        }
        
        .action-links {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 15px;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>请假列表</h2>

        <% if (!isAdmin) { %>
            <a href="${pageContext.request.contextPath}/leave/add" class="btn">提交请假</a>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>员工ID</th>
                    <th>类型</th>
                    <th>开始</th>
                    <th>结束</th>
                    <th>天数</th>
                    <th>理由</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="l" items="${leaves}">
                    <tr>
                        <td>${l.id}</td>
                        <td>${l.employeeId}</td>
                        <td>${l.leaveType}</td>
                        <td>${l.startDate}</td>
                        <td>${l.endDate}</td>
                        <td>${l.days}</td>
                        <td>${l.reason}</td>
                        <td>${l.status}</td>
                        <td class="action-links">
                            <c:if test="${sessionScope.user.role != 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/leave/edit?id=${l.id}" class="btn btn-secondary">编辑</a>
                                <a href="${pageContext.request.contextPath}/leave/delete?id=${l.id}" onclick="return confirm('确认删除?')" class="btn btn-danger">删除</a>
                            </c:if>
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                              <form action="${pageContext.request.contextPath}/leave/approve" method="post" style="display:inline">
                                <input type="hidden" name="id" value="${l.id}"/>
                                <select name="status">
                                  <option value="APPROVED">批准</option>
                                  <option value="REJECTED">拒绝</option>
                                </select>
                                <button type="submit" class="btn-approve">提交审批</button>
                              </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <a href="${pageContext.request.contextPath}/default.jsp" class="back-link btn btn-secondary">返回首页</a>
    </div>
</body>
</html>  