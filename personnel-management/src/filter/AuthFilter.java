package filter;
import bean.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse resp = (HttpServletResponse)response;
        String uri = req.getRequestURI();
        String ctx = req.getContextPath();

        // 静态资源、登录、注册、webapp 根允许访问
        if (uri.startsWith(ctx + "/resources/") ||
            uri.startsWith(ctx + "/images/") ||
            uri.endsWith("login.jsp") ||
            uri.endsWith("register.jsp") ||
            uri.endsWith("mynote7.xml") ||
            uri.startsWith(ctx + "/auth") ||
            uri.startsWith(ctx + "/register")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(ctx + "/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}