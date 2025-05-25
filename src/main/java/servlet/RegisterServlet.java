package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDao;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        UserDao userDao = new UserDao();
        
        // 检查用户名是否已存在
        if (userDao.checkUsernameExists(username)) { // 检查这一行
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('用户名已存在！');history.back();</script>");
            return;
        }
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        
        boolean success = userDao.register(user);
        
        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('注册失败，请重试！');history.back();</script>");
        }
    }
}