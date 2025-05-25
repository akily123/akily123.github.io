<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.Post, dao.PostDao" %>
<%@ include file="header.jsp" %>
<main class="flex-grow pt-20 pb-10">
    <div class="container mx-auto px-4">
        <div class="mb-8">
            <h1 class="text-3xl font-bold mb-4">搜索结果</h1>
            <p class="text-text-muted">关键词: <%= request.getParameter("keyword") %></p>
        </div>

        <%
            String keyword = request.getParameter("keyword");
            PostDao postDao = new PostDao();
            List<Post> posts = postDao.searchPosts(keyword);
            if (posts.isEmpty()) {
        %>
            <div class="bg-dark-light rounded-xl p-8 text-center">
                <i class="fa fa-search text-5xl text-text-muted mb-4"></i>
                <h2 class="text-2xl font-bold mb-2">未找到相关帖子</h2>
                <p class="text-text-muted mb-6">尝试使用不同的关键词搜索</p>
                <a href="search.jsp" 
                    class="inline-block bg-primary hover:bg-primary/90 text-white py-2 px-6 rounded-full transition-all duration-200 font-medium">
                    重新搜索
                </a>
            </div>
        <%
            } else {
        %>
            <div class="space-y-6">
                <%
                    for (Post post : posts) {
                %>
                    <div class="bg-dark-light rounded-xl p-6 hover:bg-dark-light/80 transition-colors duration-200 card-hover">
                        <div class="flex flex-col md:flex-row gap-6">
                            <div class="md:w-1/4">
                                <div class="bg-dark rounded-lg h-full flex items-center justify-center">
                                    <i class="fa fa-file-text-o text-4xl text-text-muted"></i>
                                </div>
                            </div>
                            <div class="md:w-3/4">
                                <div class="flex justify-between items-start mb-2">
                                    <span class="text-xs px-3 py-1 bg-primary/10 text-primary rounded-full"><%= post.getCategory() %></span>
                                    <span class="text-xs text-text-muted"><%= post.getCreateTime() %></span>
                                </div>
                                <h3 class="text-xl font-bold mb-2 hover:text-secondary transition-colors duration-200">
                                    <a href="post.jsp?id=<%= post.getId() %>"><%= post.getTitle() %></a>
                                </h3>
                                <p class="text-text-muted mb-4 line-clamp-2"><%= post.getContent().substring(0, Math.min(post.getContent().length(), 200)) %>...</p>
                                <div class="flex justify-between items-center">
                                    <div class="flex items-center">
                                        <div class="w-8 h-8 rounded-full bg-dark flex items-center justify-center mr-2">
                                            <i class="fa fa-user text-xs text-text-muted"></i>
                                        </div>
                                        <span class="text-sm"><%= post.getUsername() %></span>
                                    </div>
                                    <div class="flex items-center space-x-4 text-text-muted">
                                        <!-- 暂时移除 viewCount 显示 -->
                                        <span><i class="fa fa-comment mr-1"></i> <%= postDao.getCommentCount(post.getId()) %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        <%
            }
        %>
    </div>
</main>
<%@ include file="footer.jsp" %>