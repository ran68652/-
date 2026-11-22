<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="suggestion" value="${requestScope.suggestion}" />
<c:set var="edit" value="${suggestion != null}" />

<html>
<head>
    <meta charset="UTF-8">
    <title><c:choose>
        <c:when test="${edit}">编辑反馈</c:when>
        <c:otherwise>新增反馈</c:otherwise>
    </c:choose></title>
    
    <style> 
    /* 全局重置 & 基础样式 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Microsoft Yahei", Arial, sans-serif;
        }

        /* 页面主体样式 */
        body {
            background-color: #f5f7fa;
            padding: 20px;
        }

        /* 表单容器 */
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #f0f7f3;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            padding: 30px;
        }

        /* 标题样式 */
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #216b56;
        }

        /* 按钮通用样式 */
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

        /* 次要按钮样式 */
        .btn-secondary {
            background-color: #95a5a6;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        /* 表单组样式 */
        .form-group {
            margin-bottom: 20px;
        }

        /* 表单标签 */
        label {
            display: inline-block;
            width: 100px;
            font-weight: 500;
            color: #34495e;
            margin-bottom: 5px;
        }

        /* 输入框/文本域样式 */
        input[type="text"],
        input[type="hidden"],
        textarea {
            width: 600px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            font-family: "Microsoft Yahei", Arial, sans-serif;
        }

        textarea {
            min-height: 200px;
            resize: vertical;
        }

        /* 输入框聚焦状态 */
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #216b56;
            box-shadow: 0 0 0 2px rgba(33, 107, 86, 0.1);
        }

        /* 表单操作区（按钮组） */
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }

        /* 返回链接 */
        .back-link {
            display: inline-block;
            margin-top: 15px;
        }
    </style>
</head>

<body>
<div class="container">

    <h2><c:choose>
        <c:when test="${edit}">编辑反馈</c:when>
        <c:otherwise>新增反馈</c:otherwise>
    </c:choose></h2>

    <form action="${pageContext.request.contextPath}/suggestion/save" method="post">

        <c:if test="${edit}">
            <input type="hidden" name="suggestionID" value="${suggestion.suggestionID}" />
        </c:if>

        <div class="form-group">
            <label>建议标题：</label>
            <input type="text" name="suggestionTitle" value="${edit ? suggestion.suggestionTitle : ''}" required />
        </div>

        <div class="form-group">
            <label>反馈内容:</label>
            <textarea name="suggestionContent" required>${edit ? suggestion.suggestionContent : ''}</textarea>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn">保存</button>
            <a href="${pageContext.request.contextPath}/suggestion/list" class="btn btn-secondary">返回</a>
        </div>
    </form>

</div>
</body>
</html>