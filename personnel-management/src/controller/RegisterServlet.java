package controller;

import bean.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO dao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String role = req.getParameter("role");
            if (role == null) role = "EMP";
            User u = new User();
            u.setUsername(username);
            u.setPassword(password);
            u.setRole(role);
            dao.add(u);
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
