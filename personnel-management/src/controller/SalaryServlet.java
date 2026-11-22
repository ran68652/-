package controller;

import bean.Salary;
import bean.User;
import dao.SalaryDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/salary/*")
public class SalaryServlet extends HttpServlet {
    private SalaryDAO dao = new SalaryDAO();

    // 通用管理员判断（仅按role和username，无硬编码）
    private boolean isAdmin(User loginUser) {
        if (loginUser == null || loginUser.getRole() == null) {
            return false;
        }
        // 只根据 role 判断
        return "ADMIN".equals(loginUser.getRole());
    }
    

    // 权限校验：仅员工禁止操作
    private boolean checkSalaryPermission(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return false;
        }
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return false;
        }

        String path = req.getPathInfo();
        // 非管理员（员工）禁止新增/编辑/删除/保存
        if (!isAdmin(loginUser)) {
            if ("/add".equals(path) || "/edit".equals(path) || "/delete".equals(path) || "/save".equals(path)) {
                resp.setContentType("text/html;charset=UTF-8");
                resp.getWriter().write("""
                        <!DOCTYPE html>
                        <html>
                        <head>
                            <meta charset="UTF-8">
                            <title>无权限访问</title>
                            <style>
                                body { font-family: "Microsoft Yahei"; text-align: center; margin-top: 100px; }
                                h2 { color: #e74c3c; }
                                a { color: #216b56; text-decoration: none; }
                                a:hover { text-decoration: underline; }
                            </style>
                        </head>
                        <body>
                            <h2> 普通员工禁止操作工资数据！</h2>
                            <p>仅可查看本人工资信息</p>
                            <br>
                            <a href="%s/salary/list">返回工资列表</a>
                        </body>
                        </html>
                        """.formatted(req.getContextPath()));
                return false;
            }
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkSalaryPermission(req, resp)) {
            return;
        }

        String path = req.getPathInfo();
        try {
            if (path == null || "/list".equals(path)) {
                List<Salary> list;
                HttpSession session = req.getSession();
                User loginUser = (User) session.getAttribute("user");
                
                // ========== 通用过滤逻辑（无硬编码）==========
                if (isAdmin(loginUser)) {
                    // 管理员：查询所有工资
                    list = dao.findAll();
                    System.out.println("管理员" + loginUser.getUsername() + "查询到" + list.size() + "条工资数据");
                } else {
                    // 员工：从数据库取绑定的employee_id，过滤自身工资
                    Integer employeeId = loginUser.getEmployeeId();
                    list = new ArrayList<>();
                    // 仅当employee_id有效（>0）时，查询对应数据
                    if (employeeId != null && employeeId > 0) {
                        list = dao.findByEmployeeId(employeeId);
                        System.out.println("员工" + loginUser.getUsername() + "（employee_id=" + employeeId + "）查询到" + list.size() + "条工资数据");
                    } else {
                        System.out.println("员工" + loginUser.getUsername() + "无有效employee_id，返回空列表");
                    }
                }
                
                req.setAttribute("salaries", list);
                req.getRequestDispatcher("/salary-list.jsp").forward(req, resp);
            } else if ("/add".equals(path)) {
                req.getRequestDispatcher("/salary-form.jsp").forward(req, resp);
            } else if ("/edit".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Salary s = dao.findById(id);
                req.setAttribute("salary", s);
                req.getRequestDispatcher("/salary-form.jsp").forward(req, resp);
            } else if ("/delete".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.delete(id);
                resp.sendRedirect(req.getContextPath() + "/salary/list");
            } else {
                resp.sendError(404);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!checkSalaryPermission(req, resp)) {
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String action = req.getPathInfo();
        try {
            if ("/save".equals(action)) {
                String idStr = req.getParameter("id");
                Salary s = new Salary();
                s.setEmployeeId(Integer.parseInt(req.getParameter("employeeId")));
                s.setBaseSalary(Double.valueOf(req.getParameter("baseSalary")));
                s.setBonus(Double.valueOf(req.getParameter("bonus")));
                s.setTax(Double.valueOf(req.getParameter("tax")));
                s.setPayDate(Date.valueOf(req.getParameter("payDate")));
                if (idStr == null || idStr.isEmpty()) {
                    dao.add(s);
                } else {
                    s.setId(Integer.parseInt(idStr));
                    dao.update(s);
                }
                resp.sendRedirect(req.getContextPath() + "/salary/list");
            } else {
                resp.sendError(404);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}