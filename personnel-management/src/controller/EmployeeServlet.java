package controller;

import bean.Employee;
import dao.EmployeeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/employee/*")
public class EmployeeServlet extends HttpServlet {
    private EmployeeDAO dao = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo(); // /list /add /edit /delete
        try {
            if (path == null || "/list".equals(path)) {
                List<Employee> list = dao.findAll();
                req.setAttribute("employees", list);
                req.getRequestDispatcher("/employee-list.jsp").forward(req, resp);
            } else if ("/add".equals(path)) {
                req.getRequestDispatcher("/employee-form.jsp").forward(req, resp);
            } else if ("/edit".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Employee e = dao.findById(id);
                req.setAttribute("employee", e);
                req.getRequestDispatcher("/employee-form.jsp").forward(req, resp);
            } else if ("/delete".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.delete(id);
                resp.sendRedirect(req.getContextPath() + "/employee/list");
            } else {
                resp.sendError(404);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getPathInfo(); // /save
        try {
            if ("/save".equals(action)) {
                String idStr = req.getParameter("id");
                Employee e = new Employee();
                e.setEmpNo(req.getParameter("empNo"));
                e.setName(req.getParameter("name"));
                e.setDept(req.getParameter("dept"));
                e.setPosition(req.getParameter("position"));
                e.setPhone(req.getParameter("phone"));
                e.setEmail(req.getParameter("email"));
                if (idStr == null || idStr.isEmpty()) {
                    dao.add(e);
                } else {
                    e.setId(Integer.parseInt(idStr));
                    dao.update(e);
                }
                resp.sendRedirect(req.getContextPath() + "/employee/list");
            } else {
                resp.sendError(404);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
