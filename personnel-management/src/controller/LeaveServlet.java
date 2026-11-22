package controller;

import bean.LeaveRequest;
import dao.LeaveDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/leave/*")
public class LeaveServlet extends HttpServlet {
    private LeaveDAO dao = new LeaveDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo(); // /list /add /edit /delete /approve
        try {
            if (path == null || "/list".equals(path)) {
                List<LeaveRequest> list = dao.findAll();
                req.setAttribute("leaves", list);
                req.getRequestDispatcher("/leave-list.jsp").forward(req, resp);
            } else if ("/add".equals(path)) {
                req.getRequestDispatcher("/leave-form.jsp").forward(req, resp);
            } else if ("/edit".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                LeaveRequest l = dao.findById(id);
                req.setAttribute("leave", l);
                req.getRequestDispatcher("/leave-form.jsp").forward(req, resp);
            } else if ("/delete".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.delete(id);
                resp.sendRedirect(req.getContextPath() + "/leave/list");
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
        String action = req.getPathInfo();
        try {
            if ("/save".equals(action)) {
                String idStr = req.getParameter("id");
                LeaveRequest l = new LeaveRequest();
                if (idStr != null && !idStr.isEmpty()) l.setId(Integer.parseInt(idStr));
                l.setEmployeeId(Integer.parseInt(req.getParameter("employeeId")));
                l.setLeaveType(req.getParameter("leaveType"));
                l.setStartDate(Date.valueOf(req.getParameter("startDate")));
                l.setEndDate(Date.valueOf(req.getParameter("endDate")));
                l.setDays(Integer.parseInt(req.getParameter("days")));
                l.setReason(req.getParameter("reason"));
                l.setStatus(req.getParameter("status") == null ? "PENDING" : req.getParameter("status"));
                if (idStr == null || idStr.isEmpty()) dao.add(l);
                else dao.update(l);
                resp.sendRedirect(req.getContextPath() + "/leave/list");
            } else if ("/approve".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String status = req.getParameter("status");
                LeaveRequest l = dao.findById(id);
                l.setStatus(status);
                dao.update(l);
                resp.sendRedirect(req.getContextPath() + "/leave/list");
            } else {
                resp.sendError(404);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}