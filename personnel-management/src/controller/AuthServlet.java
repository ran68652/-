package controller;

import bean.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/logout".equals(path)) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            resp.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String path = req.getPathInfo();

            // 支持 POST /auth/login 和 POST /auth/
            if (path == null || "/".equals(path) || "/login".equals(path)) {

                String username = req.getParameter("username");
                String password = req.getParameter("password");

                // ❗❗ 核心修复：必须使用登录方法
                User u = userDAO.login(username, password);

                if (u != null) {
                    // 登录成功
                    HttpSession session = req.getSession();
                    session.setAttribute("user", u);
                    session.setAttribute("role", u.getRole());
                    session.setAttribute("employeeId", u.getEmployeeId()); // 关键：确保员工ID可用

                    // 记住用户名
                    Cookie cookie = new Cookie("username", username);
                    cookie.setMaxAge(7 * 24 * 3600);
                    resp.addCookie(cookie);

                    resp.sendRedirect(req.getContextPath() + "/default.jsp");
                } else {
                    // 登录失败
                    req.setAttribute("error", "用户名或密码错误");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                }

            } else {
                resp.sendError(404);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
