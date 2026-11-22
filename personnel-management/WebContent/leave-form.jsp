<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${not empty leave}">编辑请假</c:when>
            <c:otherwise>提交请假</c:otherwise>
        </c:choose>
    </title>

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
            max-width: 800px;
            margin: 0 auto;
            background: #f0f7f3;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            padding: 30px;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #216b56;
        }
        .btn {
            padding: 8px 16px;
            background-color: #216b56;
            color: white;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
        .btn:hover { background-color: #1a5645; }
        .btn-secondary { background-color: #95a5a6; }
        .btn-secondary:hover { background-color: #7f8c8d; }

        .form-group { margin-bottom: 20px; }
        label {
            display: inline-block;
            width: 140px;
            font-weight: 500;
            color: #34495e;
            margin-bottom: 5px;
        }
        input[type="text"], textarea {
            width: 300px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        textarea { height: 120px; resize: vertical; }
        input:focus, textarea:focus {
            outline: none;
            border-color: #216b56;
            box-shadow: 0 0 0 2px rgba(33,107,86,0.1);
        }
        .hint {
            color: #7f8c8d;
            font-size: 12px;
            margin-left: 145px;
            margin-top: 3px;
        }
        .form-actions { margin-top: 30px; display: flex; gap: 10px; }
    </style>
</head>

<body>
<div class="container">

    <h2>
        <c:choose>
            <c:when test="${not empty leave}">编辑请假</c:when>
            <c:otherwise>提交请假</c:otherwise>
        </c:choose>
    </h2>

    <form action="${pageContext.request.contextPath}/leave/save" method="post">

        <!-- 编辑时才有 id -->
        <c:if test="${not empty leave}">
            <input type="hidden" name="id" value="${leave.id}">
        </c:if>

        <div class="form-group">
            <label>员工ID:</label>
            <input type="text" name="employeeId" value="${leave.employeeId}">
        </div>

        <div class="form-group">
            <label>请假类型：</label>
            <input type="text" name="leaveType" value="${leave.leaveType}">
        </div>

        <div class="form-group">
            <label>开始日期：</label>
            <input type="text" name="startDate" value="${leave.startDate}">
            <div class="hint">(格式: yyyy-MM-dd)</div>
        </div>

        <div class="form-group">
            <label>结束日期：</label>
            <input type="text" name="endDate" value="${leave.endDate}">
            <div class="hint">(格式: yyyy-MM-dd)</div>
        </div>

        <div class="form-group">
            <label>天数：</label>
            <input type="text" name="days" value="${leave.days}">
        </div>

        <div class="form-group">
            <label>理由：</label>
            <textarea name="reason">${leave.reason}</textarea>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn">保存</button>
            <a href="${pageContext.request.contextPath}/leave/list" class="btn btn-secondary">返回</a>
        </div>

    </form>
</div>
</body>
</html>