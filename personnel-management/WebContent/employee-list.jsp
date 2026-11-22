<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>员工列表</title>
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
            background-color: #216b56;
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
    </style>
</head>

<body>
    <div class="container">
        <h2>员工列表</h2>
        
        <a href="${pageContext.request.contextPath}/employee/add" class="btn">新增员工</a>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>工号</th>
                    <th>姓名</th>
                    <th>部门</th>
                    <th>职位</th>
                    <th>电话</th>
                    <th>邮箱</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="e" items="${employees}">
                    <tr>
                        <td>${e.id}</td>
                        <td>${e.empNo}</td>
                        <td>${e.name}</td>
                        <td>${e.dept}</td>
                        <td>${e.position}</td>
                        <td>${e.phone}</td>
                        <td>${e.email}</td>
                        <td class="action-links">
                            <a href="${pageContext.request.contextPath}/employee/edit?id=${e.id}" class="btn btn-secondary">编辑</a>
                            <a href="${pageContext.request.contextPath}/employee/delete?id=${e.id}" onclick="return confirm('确认删除?')" class="btn btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <a href="${pageContext.request.contextPath}/default.jsp" class="back-link btn btn-secondary">返回首页</a>
    </div>
</body>
</html>