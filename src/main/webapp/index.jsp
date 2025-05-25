<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.Post, dao.PostDao,dao.VisitCountDao" %>
<%@ include file="header.jsp" %>
<%@ page import="dao.VisitCountDao" %>
<%
new VisitCountDao().incrementCount("total_visits");
%>

<main class="flex-grow pt-20 pb-10">
    <!-- 英雄区域 -->
    <section class="relative h-[50vh] min-h-[400px] flex items-center overflow-hidden bg-gradient-to-b from-primary/10 to-secondary/10">
        <div class="container mx-auto px-4 relative z-10 text-center">
            <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold mb-6 text-white drop-shadow-lg">
                探索游戏世界
            </h1>
            <p class="text-xl text-gray-300 mb-8 max-w-2xl mx-auto">
                加入百万玩家的讨论社区，分享你的游戏体验
            </p>
            <div class="flex flex-wrap gap-4 justify-center">
                <a href="#hot-posts" 
                   class="bg-primary hover:bg-primary/90 text-white py-3 px-8 rounded-full transition-all duration-200 font-medium flex items-center">
                    <i class="fa fa-comments mr-2"></i>浏览热门帖子
                </a>
                <% if (session.getAttribute("user") == null) { %>
                    <a href="register.jsp" 
                       class="bg-white hover:bg-gray-100 text-primary py-3 px-8 rounded-full transition-all duration-200 font-medium flex items-center">
                        <i class="fa fa-user-plus mr-2"></i>立即注册
                    </a>
                <% } %>
            </div>
            <div class="stat-item">
    <span class="text-2xl font-bold">
        <%= new VisitCountDao().getCount("total_visits") %>
    </span>
    <span>总访问量</span>
</div>
        </div>
    </section>

    <!-- 热门帖子 -->
    <section id="hot-posts" class="py-16 bg-gray-900">
        <div class="container mx-auto px-4">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold mb-4 text-white">热门讨论</h2>
                <p class="text-gray-400 max-w-2xl mx-auto">社区最受欢迎的游戏话题</p>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <%
                    PostDao postDao = new PostDao();
                    List<Post> hotPosts = postDao.getHotPosts(3);
                    
                    if (hotPosts.isEmpty()) {
                %>
                <div class="col-span-3 text-center py-10">
                    <i class="fa fa-gamepad text-4xl text-gray-500 mb-4"></i>
                    <p class="text-gray-400">暂无热门帖子，快去发帖吧！</p>
                </div>
                <%
                    } else {
                        for (Post post : hotPosts) {
                            String excerpt = post.getContent().length() > 100 ? 
                                post.getContent().substring(0, 100) + "..." : post.getContent();
                %>
                <div class="bg-gray-800 rounded-lg overflow-hidden hover:shadow-lg transition-all duration-300">
                    <div class="p-6">
                        <div class="flex justify-between items-center mb-3">
                            <span class="text-xs px-3 py-1 bg-primary/20 text-primary rounded-full">
                                <%= post.getCategory() %>
                            </span>
                            <span class="text-xs text-gray-500">
                                <%= post.getCreateTime() %>
                            </span>
                        </div>
                        <h3 class="text-xl font-bold mb-2 text-white hover:text-secondary transition-colors">
                            <a href="post.jsp?id=<%= post.getId() %>"><%= post.getTitle() %></a>
                        </h3>
                        <p class="text-gray-400 mb-4"><%= excerpt %></p>
                        <div class="flex items-center justify-between">
                            <div class="flex items-center">
                                <div class="w-8 h-8 rounded-full bg-gray-700 flex items-center justify-center mr-2">
                                    <i class="fa fa-user text-gray-400"></i>
                                </div>
                                <span class="text-sm text-gray-300"><%= post.getUsername() %></span>
                            </div>
                            <span class="text-sm text-gray-500">
                                <i class="fa fa-comment mr-1"></i>
                                <%= postDao.getCommentCount(post.getId()) %>
                            </span>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </section>

    <!-- 最新帖子 -->
    <section class="py-16 bg-gray-950">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h2 class="text-3xl font-bold text-white">最新帖子</h2>
                    <p class="text-gray-500">社区最新讨论话题</p>
                </div>
                <a href="search.jsp?sort=newest" class="text-primary hover:text-primary/80 flex items-center">
                    查看更多 <i class="fa fa-arrow-right ml-2"></i>
                </a>
            </div>
            
            <div class="space-y-6">
                <%
                    List<Post> latestPosts = postDao.getLatestPosts(5);
                    
                    if (latestPosts.isEmpty()) {
                %>
                <div class="bg-gray-800 rounded-lg p-8 text-center">
                    <i class="fa fa-newspaper-o text-4xl text-gray-500 mb-4"></i>
                    <p class="text-gray-400">暂无最新帖子</p>
                </div>
                <%
                    } else {
                        for (Post post : latestPosts) {
                            String excerpt = post.getContent().length() > 150 ? 
                                post.getContent().substring(0, 150) + "..." : post.getContent();
                %>
                <div class="bg-gray-800 rounded-lg p-6 hover:bg-gray-700 transition-colors duration-300">
                    <div class="flex flex-col md:flex-row gap-6">
                        <div class="md:w-1/4">
                            <div class="bg-gradient-to-br from-primary/10 to-secondary/10 h-full rounded-lg flex items-center justify-center aspect-video">
                                <i class="fa fa-file-text-o text-4xl text-gray-500"></i>
                            </div>
                        </div>
                        <div class="md:w-3/4">
                            <div class="flex justify-between items-start mb-2">
                                <span class="text-xs px-3 py-1 bg-primary/20 text-primary rounded-full">
                                    <%= post.getCategory() %>
                                </span>
                                <span class="text-xs text-gray-500">
                                    <%= post.getCreateTime() %>
                                </span>
                            </div>
                            <h3 class="text-xl font-bold mb-2 text-white hover:text-secondary transition-colors">
                                <a href="post.jsp?id=<%= post.getId() %>"><%= post.getTitle() %></a>
                            </h3>
                            <p class="text-gray-400 mb-4"><%= excerpt %></p>
                            <div class="flex justify-between items-center">
                                <div class="flex items-center">
                                    <div class="w-8 h-8 rounded-full bg-gray-700 flex items-center justify-center mr-2">
                                        <i class="fa fa-user text-xs text-gray-400"></i>
                                    </div>
                                    <span class="text-sm text-gray-300"><%= post.getUsername() %></span>
                                </div>
                                <div class="flex items-center space-x-4 text-gray-500 text-sm">
                                    <span>
                                        <i class="fa fa-comment mr-1"></i>
                                        <%= postDao.getCommentCount(post.getId()) %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </section>

    <!-- 分类导航 -->
    <section class="py-16 bg-gray-900">
        <div class="container mx-auto px-4">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold mb-4 text-white">游戏分类</h2>
                <p class="text-gray-400 max-w-2xl mx-auto">按游戏类型浏览内容</p>
            </div>
            
            <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-4">
                <a href="search.jsp?category=RPG" class="bg-gray-800 hover:bg-gray-700 rounded-lg p-4 text-center transition-colors">
                    <i class="fa fa-gamepad text-2xl text-primary mb-2"></i>
                    <p class="text-white">角色扮演</p>
                </a>
                <a href="search.jsp?category=FPS" class="bg-gray-800 hover:bg-gray-700 rounded-lg p-4 text-center transition-colors">
                    <i class="fa fa-crosshairs text-2xl text-red-400 mb-2"></i>
                    <p class="text-white">射击游戏</p>
                </a>
                <a href="search.jsp?category=MOBA" class="bg-gray-800 hover:bg-gray-700 rounded-lg p-4 text-center transition-colors">
                    <i class="fa fa-users text-2xl text-blue-400 mb-2"></i>
                    <p class="text-white">MOBA</p>
                </a>
                <a href="search.jsp?category=Racing" class="bg-gray-800 hover:bg-gray-700 rounded-lg p-4 text-center transition-colors">
                    <i class="fa fa-car text-2xl text-yellow-400 mb-2"></i>
                    <p class="text-white">竞速游戏</p>
                </a>
                <a href="search.jsp?category=Sports" class="bg-gray-800 hover:bg-gray-700 rounded-lg p-4 text-center transition-colors">
                    <i class="fa fa-futbol-o text-2xl text-green-400 mb-2"></i>
                    <p class="text-white">体育游戏</p>
                </a>
                <a href="search.jsp?category=Strategy" class="bg-gray-800 hover:bg-gray-700 rounded-lg p-4 text-center transition-colors">
                    <i class="fa fa-chess text-2xl text-purple-400 mb-2"></i>
                    <p class="text-white">策略游戏</p>
                </a>
            </div>
        </div>
    </section>

</main>

<%@ include file="footer.jsp" %>

<script>
    // 数字动画
    function animateValue(id, start, end, duration) {
        const obj = document.getElementById(id);
        let startTimestamp = null;
        const step = (timestamp) => {
            if (!startTimestamp) startTimestamp = timestamp;
            const progress = Math.min((timestamp - startTimestamp) / duration, 1);
            obj.innerHTML = Math.floor(progress * (end - start) + start + "+";
            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        };
        window.requestAnimationFrame(step);
    }
    
, { threshold: 0.5 });
    
    observer.observe(document.getElementById("postCount").parentElement.parentElement);
</script>