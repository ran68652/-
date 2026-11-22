package controller;

import bean.Suggestion;
import dao.SuggestionDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/suggestion/*")
public class SuggestionServlet extends HttpServlet {
    private SuggestionDAO dao = new SuggestionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        try {
            // 查看所有建议
            if (path == null || "/list".equals(path)) {
                List<Suggestion> list = dao.findAll();
                req.setAttribute("suggestions", list);
                req.getRequestDispatcher("/suggestion-list.jsp").forward(req, resp);
            }
            // 跳转到新增建议表单
            else if ("/add".equals(path)) {
                req.getRequestDispatcher("/suggestion-form.jsp").forward(req, resp);
            }
            // 跳转到编辑建议表单
            else if ("/edit".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Suggestion s = dao.findById(id);
                req.setAttribute("suggestion", s);
                req.getRequestDispatcher("/suggestion-form.jsp").forward(req, resp);
            }
            // 删除建议
            else if ("/delete".equals(path)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.delete(id);
                resp.sendRedirect(req.getContextPath() + "/suggestion/list");
            }
            // 无效路径
            else {
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
            // 保存（新增/编辑）建议
            if ("/save".equals(action)) {
                String idStr = req.getParameter("suggestionID");
                Suggestion s = new Suggestion();
                s.setSuggestionTitle(req.getParameter("suggestionTitle"));
                s.setSuggestionContent(req.getParameter("suggestionContent"));

                if (idStr == null || idStr.isEmpty()) {
                    dao.add(s);
                } else {
                    s.setSuggestionID(Integer.parseInt(idStr));
                    dao.update(s);
                }
                resp.sendRedirect(req.getContextPath() + "/suggestion/list");
            } else {
                resp.sendError(404);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}