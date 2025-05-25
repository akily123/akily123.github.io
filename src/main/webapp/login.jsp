<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<main class="flex-grow pt-20 pb-10">
    <div class="container mx-auto px-4 max-w-md">
        <div class="bg-dark-light rounded-xl p-8 shadow-lg">
            <h1 class="text-3xl font-bold mb-8 text-center text-primary">登录 GameTalk</h1>
            <form action="LoginServlet" method="post" class="space-y-6">
                <div>
                    <label for="username" class="block text-text-muted mb-2">用户名</label>
                    <input type="text" id="username" name="username" required 
                        class="w-full bg-dark border border-gray-700 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-primary/50">
                </div>
                <div>
                    <label for="password" class="block text-text-muted mb-2">密码</label>
                    <input type="password" id="password" name="password" required 
                        class="w-full bg-dark border border-gray-700 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-primary/50">
                </div>
                <div class="flex justify-between items-center">
                    <a href="register.jsp" class="text-secondary hover:text-secondary/80 text-sm">还没有账号？立即注册</a>
                    <button type="submit" 
                        class="bg-primary hover:bg-primary/90 text-white py-3 px-8 rounded-full transition-all duration-200 font-medium">
                        登录
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>
<%@ include file="footer.jsp" %>