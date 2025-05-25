<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<main class="flex-grow pt-20 pb-10">
    <div class="container mx-auto px-4">
        <div class="bg-dark-light rounded-xl p-8">
            <h1 class="text-3xl font-bold mb-6 text-primary">发布新帖子</h1>
            <form action="createPostServlet" method="post" class="space-y-6">
                <div>
                    <label for="title" class="block text-text-muted mb-2">标题</label>
                    <input type="text" id="title" name="title" required 
                        class="w-full bg-dark border border-gray-700 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-primary/50">
                </div>
                <div>
                    <label for="content" class="block text-text-muted mb-2">内容</label>
                    <textarea id="content" name="content" rows="10" required
                        class="w-full bg-dark border border-gray-700 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-primary/50"></textarea>
                </div>
                <div>
                    <label for="category" class="block text-text-muted mb-2">分类</label>
                    <select id="category" name="category" required
                        class="w-full bg-dark border border-gray-700 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-primary/50">
                        <option value="">选择分类</option>
                        <option value="角色扮演">角色扮演</option>
                        <option value="多人在线">多人在线</option>
                        <option value="竞速">竞速</option>
                        <option value="体育">体育</option>
                        <option value="动作">动作</option>
                        <option value="策略">策略</option>
                    </select>
                </div>
                <div class="flex justify-end">
                    <button type="submit" 
                        class="bg-primary hover:bg-primary/90 text-white py-3 px-8 rounded-full transition-all duration-200 font-medium">
                        发布帖子
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>
<%@ include file="footer.jsp" %>