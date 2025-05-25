<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<main class="flex-grow pt-20 pb-10">
    <div class="container mx-auto px-4 max-w-3xl">
        <div class="bg-dark-light rounded-xl p-8 shadow-lg">
            <h1 class="text-3xl font-bold mb-8 text-center text-primary">搜索帖子</h1>
            <form action="searchResult.jsp" method="get" class="flex">
                <input type="text" name="keyword" placeholder="输入关键词..." required
                    class="flex-grow bg-dark border border-gray-700 rounded-l-full px-6 py-3 focus:outline-none focus:ring-2 focus:ring-primary/50">
                <button type="submit" 
                    class="bg-primary hover:bg-primary/90 text-white px-6 rounded-r-full transition-all duration-200 font-medium">
                    <i class="fa fa-search"></i>
                </button>
            </form>
        </div>
    </div>
</main>
<%@ include file="footer.jsp" %>