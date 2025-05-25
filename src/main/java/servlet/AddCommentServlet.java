package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Comment;
import bean.User;
import dao.CommentDao;

@WebServlet("/addCommentServlet")
public class AddCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int postId = Integer.parseInt(request.getParameter("postId"));
        String content = request.getParameter("content");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Comment comment = new Comment();
        comment.setPostId(postId);
        comment.setUserId(user.getId());
        comment.setContent(content);
        
        CommentDao commentDao = new CommentDao();
        boolean success = commentDao.addComment(comment);
        
        if (success) {
            response.sendRedirect("post.jsp?id=" + postId);
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('评论发表失败！');history.back();</script>");
        }
    }
}