<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="bean.Salary" %>
<%
    Salary s = (Salary) request.getAttribute("salary");
    boolean edit = (s != null);
%>
<html>
<head>
    <meta charset="UTF-8">

    <!--【修改点1：修复标题判断 leave → salary】-->
    <title><%= edit ? "编辑工资" : "提交工资" %></title>

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
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            padding: 30px;
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: inline-block;
            width: 140px;
            font-weight: 500;
            color: #34495e;
            margin-bottom: 5px;
        }
        
        input[type="text"], input[type="hidden"] {
            width: 300px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        input[type="text"]:focus {
            outline: none;
            border-color: #216b56;
            box-shadow: 0 0 0 2px rgba(33, 107, 86, 0.1);
        }
        
        .form-actions {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }
        
        .hint {
            color: #7f8c8d;
            font-size: 12px;
            margin-left: 145px;
            margin-top: 3px;
        }
    </style>
</head>

<body>
    <div class="container">

        <!--【修改点2：修复标题 leave → salary】-->
        <h2><%= edit ? "编辑工资" : "提交工资" %></h2>
        
        <form action="${pageContext.request.contextPath}/salary/save" method="post">
            <input type="hidden" name="id" value="<%= s != null ? s.getId() : "" %>"/>
            
            <div class="form-group">
                <label>员工ID:</label>
                <input type="text" name="employeeId" value="<%= s != null ? s.getEmployeeId() : "" %>"/>
            </div>
            
            <div class="form-group">
                <label>基本工资：</label>
                <input type="text" name="baseSalary" value="<%= s != null ? s.getBaseSalary() : "" %>"/>
            </div>
            
            <div class="form-group">
                <label>奖金：</label>
                <input type="text" name="bonus" value="<%= s != null ? s.getBonus() : "" %>"/>
            </div>
            
            <div class="form-group">
                <label>税：</label>
                <input type="text" name="tax" value="<%= s != null ? s.getTax() : "" %>"/>
            </div>
            
            <div class="form-group">
                <label>发放日期：</label>
                <input type="text" name="payDate" value="<%= s != null ? s.getPayDate() : "" %>"/>
                <div class="hint">(格式:yyyy-MM-dd)</div>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn">保存</button>
                <a href="${pageContext.request.contextPath}/salary/list" class="btn btn-secondary">返回</a>
            </div>
        </form>
    </div>
</body>
</html>
