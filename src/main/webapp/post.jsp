<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bean.Post, bean.Comment, bean.User, dao.PostDao, dao.CommentDao, dao.VisitCountDao, java.util.List" %>
<%
// 设置无缓存
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

// 获取帖子ID
int postId = Integer.parseInt(request.getParameter("id"));

// 访问计数
new VisitCountDao().incrementCount("post_" + postId);

// 获取帖子详情
PostDao postDao = new PostDao();
Post post = postDao.getPostById(postId);

// 获取评论列表
CommentDao commentDao = new CommentDao();
List<Comment> comments = commentDao.getCommentsByPostId(postId);

// 获取当前用户
User user = (User) session.getAttribute("user");
%>

<%@ include file="header.jsp" %>
<main class="flex-grow pt-20 pb-10">
    <div class="container mx-auto px-4">
        <div class="bg-dark-light rounded-xl p-8 mb-8">
            <div class="flex justify-between items-center mb-4">
                <span class="text-sm px-3 py-1 bg-primary/10 text-primary rounded-full"><%= post.getCategory() %></span>
                <span class="text-sm text-text-muted"><%= post.getCreateTime() %></span>
            </div>
            <h1 class="text-3xl font-bold mb-4"><%= post.getTitle() %></h1>
            <div class="flex items-center mb-6">
                <div class="w-10 h-10 rounded-full bg-dark flex items-center justify-center mr-3">
                    <i class="fa fa-user text-text-muted"></i>
                </div>
                <span class="text-text-muted">作者: <%= post.getUsername() %></span>
            </div>
            <div class="prose max-w-none text-text-light">
                <p class="whitespace-pre-line"><%= post.getContent() %></p>
            </div>
        </div>

        <div class="bg-dark-light rounded-xl p-8 mb-8">
            <h2 class="text-2xl font-bold mb-6">
                评论 (<%= postDao.getCommentCount(postId) %>)
            </h2>
            <%
                if (comments.isEmpty()) {
            %>
                <p class="text-text-muted text-center py-8">暂无评论</p>
            <%
                } else {
                    for (Comment comment : comments) {
            %>
                <div class="border-b border-gray-700 py-6 last:border-0">
                    <div class="flex items-center mb-2">
                        <div class="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center mr-3">
                            <%= comment.getUsername().charAt(0) %>
                        </div>
                        <div>
                            <span class="font-medium"><%= comment.getUsername() %></span>
                            <span class="text-xs text-text-muted ml-2">
                                <%= comment.getCreateTime() %>
                            </span>
                        </div>
                    </div>
                    <div class="pl-11 text-text-light">
                        <%= comment.getContent().replace("\n", "<br>") %>
                    </div>
                </div>
            <% 
                    }
                }
            %>
        </div>

        <%
            if (user != null) {
        %>
            <div class="bg-dark-light rounded-xl p-8">
                <h2 class="text-xl font-bold mb-6">发表评论</h2>
                <form action="<%= request.getContextPath() %>/addCommentServlet" method="post">
                    <input type="hidden" name="postId" value="<%= postId %>">
                    <textarea name="content" rows="4" required placeholder="写下你的评论..."
                        class="w-full bg-dark border border-gray-700 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-primary/50 mb-4"></textarea>
                    <div class="flex justify-end">
                        <button type="submit" 
                            class="bg-primary hover:bg-primary/90 text-white py-2 px-6 rounded-full transition-all duration-200 font-medium">
                            发表评论
                        </button>
                    </div>
                </form>
            </div>
        <% } else { %>
            <div class="bg-dark-light rounded-xl p-8 text-center">
                <p class="text-text-muted mb-4">请 <a href="login.jsp?redirect=post.jsp?id=<%= postId %>" class="text-secondary hover:text-secondary/80">登录</a> 后发表评论</p>
                <a href="login.jsp?redirect=post.jsp?id=<%= postId %>" 
                    class="inline-block bg-primary hover:bg-primary/90 text-white py-2 px-6 rounded-full transition-all duration-200 font-medium">
                    立即登录
                </a>
            </div>
        <% } %>
    </div>
</main>
<%@ include file="footer.jsp" %>

<script>
    // 自动调整文本域高度
    document.querySelector('textarea')?.addEventListener('input', function() {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });

    // 表单验证
    document.querySelector('form')?.addEventListener('submit', function(e) {
        if (this.content.value.trim().length < 5) {
            e.preventDefault();
            alert('评论内容至少需要5个字符');
        }
    });
</script>