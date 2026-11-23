# Java Web 人事管理系统

一个基于 Java Web 技术开发的人事管理系统，采用 Servlet、JSP、JDBC 和 MySQL 实现，主要用于管理企业员工信息、薪资信息、请假申请及相关业务数据。

本项目通过 MVC 分层思想组织代码，将页面展示、业务请求处理和数据库操作进行分离，帮助理解 Java Web 应用程序的基本开发流程。

## 一、项目简介

随着企业日常管理工作的增加，传统人工管理方式在员工信息维护、薪资记录管理和请假审批等方面容易出现效率较低、数据分散等问题。

因此，本项目设计并实现了一个基于 Java Web 的人事管理系统，通过 Web 页面提供统一的操作入口，实现用户登录、员工信息管理、薪资管理、请假管理等功能。

本项目主要用于学习和实践 Java Web 开发技术，重点涉及 Servlet 请求处理、JSP 页面展示、JDBC 数据库访问、Filter 请求拦截以及 MVC 分层架构。

## 二、开发技术

| 技术类别 | 使用技术 |
|---|---|
| 开发语言 | Java |
| 后端技术 | Servlet、JSP |
| 前端技术 | HTML、CSS、JavaScript |
| 数据库 | MySQL |
| 数据库连接 | JDBC |
| Web 服务器 | Apache Tomcat 9.0.22 |
| JDK 版本 | JDK 21 |
| 开发工具 | Visual Studio Code |

## 三、系统功能模块

### 1. 用户登录与权限管理

- 用户登录验证。
- 用户注册。
- 根据用户角色进行身份识别。
- 使用 HttpSession 保存登录状态。
- 通过 Filter 对访问请求进行拦截和权限控制。

### 2. 员工信息管理

- 员工信息的维护。
- 员工信息的查询。
- 员工相关数据的数据库操作。

### 3. 薪资管理

- 薪资信息管理。
- 薪资记录的数据库操作。
- 通过员工相关信息关联薪资数据。

### 4. 请假管理

- 请假申请相关操作。
- 请假记录管理。
- 请假审批相关业务处理。

### 5. 意见管理

- 意见信息相关操作。
- 意见数据的管理。

## 四、项目目录结构

```text
PERSONNEL-MANAGEMENT/
├── .vscode/
│   └── settings.json
├── classes_backup_20261122_214215/
├── src/
│   ├── bean/
│   │   ├── Employee.java
│   │   ├── LeaveRequest.java
│   │   ├── Salary.java
│   │   ├── Suggestion.java
│   │   └── User.java
│   ├── controller/
│   │   ├── AuthServlet.java
│   │   ├── EmployeeServlet.java
│   │   ├── LeaveServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── SalaryServlet.java
│   │   └── SuggestionServlet.java
│   ├── dao/
│   │   ├── EmployeeDAO.java
│   │   ├── LeaveDAO.java
│   │   ├── SalaryDAO.java
│   │   ├── SuggestionDAO.java
│   │   └── UserDAO.java
│   ├── dbutil/
│   │   ├── JDBCUtil.java
│   │   └── personnel.sql
│   └── filter/
│       └── AuthFilter.java
└── WebContent/
    ├── images/
    ├── WEB-INF/
    │   ├── classes/
    │   │   ├── bean/
    │   │   ├── controller/
    │   │   ├── dao/
    │   │   ├── dbutil/
    │   │   └── filter/
    │   ├── lib/
    │   └── web.xml
    ├── default.jsp
    ├── employee-form.jsp
    ├── employee-list.jsp
    ├── leave-form.jsp
    ├── leave-list.jsp
    ├── login.jsp
    ├── per.xml
    ├── register.jsp
    ├── salary-form.jsp
    ├── salary-list.jsp
    ├── suggestion-form.jsp
    └── suggestion-list.jsp
```

## 五、系统架构设计

本项目采用 MVC 分层设计思想，将系统划分为不同的功能层次，以提高代码的可维护性和可读性。

| 分层 | 对应目录 | 主要职责 |
|---|---|---|
| Model | bean、dao、dbutil | 实体数据封装、数据库访问及连接管理 |
| Controller | controller | 接收请求、处理业务逻辑、调用 DAO |
| View | WebContent 中的 JSP 页面 | 展示系统页面和处理用户交互 |
| Filter | filter | 拦截请求、检查用户登录状态 |

系统基本运行流程：

```text
用户访问 JSP 页面
       ↓
提交 HTTP 请求
       ↓
AuthFilter 请求过滤
       ↓
对应 Servlet 处理请求
       ↓
调用 DAO 访问数据库
       ↓
JDBC 连接 MySQL
       ↓
返回处理结果
       ↓
Servlet 转发至 JSP 页面
       ↓
展示处理结果
```

## 六、数据库设计

项目使用 MySQL 作为关系型数据库，数据库名称为：

```sql
personnel
```

已记录的核心数据表包括：

| 数据表 | 主要用途 |
|---|---|
| users | 保存系统用户信息 |
| employees | 保存员工基本信息 |
| salaries | 保存员工薪资信息 |
| leave_requests | 保存员工请假申请信息 |

项目通过 JDBC 实现 Java 程序与 MySQL 数据库之间的数据交互，并使用 DAO 类对数据库操作进行封装。

## 七、项目运行环境与部署

### 1. 环境要求

- JDK 21
- Apache Tomcat 9
- MySQL
- Java Web 开发环境

### 2. 获取项目

```bash
git clone https://github.com/你的GitHub用户名/Java-Web-HR-Management-System.git
```

### 3. 配置数据库

1. 启动 MySQL 服务。
2. 创建数据库 `personnel`。
3. 执行项目提供的 `database/personnel.sql` 数据库脚本。
4. 检查 `JDBCUtil.java` 中的数据库连接地址、用户名和密码。
5. 根据本地 MySQL 环境修改数据库连接配置。

### 4. 配置 Tomcat

1. 配置 JDK 21。
2. 配置 Apache Tomcat 9。
3. 将项目的 `WebContent` 目录部署到 Tomcat。
4. 确认项目 Context Path 配置正确。

### 5. 启动项目

启动 Tomcat 服务，在浏览器中访问：

```text
http://localhost:8080/per/login.jsp
```

## 八、项目开发收获

通过本项目的开发，我对 Java Web 应用程序的开发流程有了更加深入的理解，并积累了以下实践经验：

1. 掌握 Servlet 接收和处理 HTTP 请求的基本方法。
2. 理解 JSP 页面与后端 Servlet 之间的数据交互。
3. 使用 JDBC 实现 Java 程序与 MySQL 数据库的连接。
4. 通过 DAO 模式封装数据库操作。
5. 使用 JavaBean 封装业务实体数据。
6. 理解 MVC 分层架构在 Web 项目中的应用。
7. 使用 Filter 和 HttpSession 实现登录状态检查及访问控制。
8. 学习 Java Web 项目的部署、运行和调试。

## 九、后续改进方向

- 优化系统页面布局与用户交互体验。
- 完善表单数据验证和异常处理。
- 加强用户权限管理。
- 优化数据库操作和系统安全性。
- 增加系统测试和项目文档。

## 十、项目说明

本项目为个人 Java Web 学习与实践项目，主要用于展示 Java Web 基础开发、数据库操作及 Web 系统设计能力。

**项目名称：** Java Web 人事管理系统

**开发语言：** Java

**核心技术：** Servlet、JSP、JDBC、MySQL

**服务器：** Apache Tomcat 9
:::
