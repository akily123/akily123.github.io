<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GoMing - 游戏论坛</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link rel="icon" href="images/favicon.ico" type="image/x-icon">
	<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
	<link rel="manifest" href="/site.webmanifest">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#6C5CE7',
                        secondary: '#00CEFF',
                        accent: '#FF2E63',
                        dark: '#191A1E',
                        'dark-light': '#2D3038',
                        'text-light': '#F5F5F5',
                        'text-muted': '#8E8E8E',
                    },
                    fontFamily: {
                        sans: ['Inter', 'system-ui', 'sans-serif'],
                    },
                },
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .bg-gradient-game {
                background: linear-gradient(135deg, #191A1E 0%, #2D3038 100%);
            }
            .card-hover {
                transition: all 0.3s ease;
            }
            .card-hover:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px -5px rgba(108, 92, 231, 0.2);
            }
        }
    </style>
</head>
<body class="bg-dark text-text-light min-h-screen flex flex-col">
    <!-- 导航栏 -->
    <header class="bg-dark-light/80 backdrop-blur-md fixed w-full z-50 transition-all duration-300" id="navbar">
        <div class="container mx-auto px-4 py-3 flex items-center justify-between">
            <div class="flex items-center">
                <a href="index.jsp" class="text-2xl font-bold text-primary flex items-center">
                    <!-- 【需要替换】自定义Logo图片 -->
                    <img src="images/logo.png" alt="GoMing Logo" class="h-8 w-8 mr-2">
                    <span>GoMing</span>
                </a>
            </div>
            
            <!-- 桌面导航 -->
            <nav class="hidden md:flex space-x-8">
                <a href="index.jsp" class="text-white hover:text-secondary transition-colors duration-200 font-medium">首页</a>
                <a href="createPost.jsp" class="text-text-muted hover:text-secondary transition-colors duration-200 font-medium">发布帖子</a>
                <a href="search.jsp" class="text-text-muted hover:text-secondary transition-colors duration-200 font-medium">搜索</a>
                <a href="aboutUs.jsp" class="text-text-muted hover:text-secondary transition-colors duration-200 font-medium">关于我们</a>
            </nav>
            
            <div class="flex items-center space-x-4">
                <div class="relative hidden md:block">
                    <form action="searchResult.jsp" method="get">
                        <input type="text" name="keyword" placeholder="搜索帖子..." class="bg-dark rounded-full py-2 pl-10 pr-4 w-64 focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all">
                        <i class="fa fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-text-muted"></i>
                    </form>
                </div>
                
                <% if (session.getAttribute("user") != null) { %>
                    <a href="createPost.jsp" class="bg-primary hover:bg-primary/90 text-white py-2 px-4 rounded-full transition-all duration-200 flex items-center">
                        <i class="fa fa-pencil mr-2"></i>
                        <span>发布帖子</span>
                    </a>
                    <a href="logout.jsp" class="text-text-muted hover:text-white transition-colors duration-200">
                        <i class="fa fa-sign-out"></i>
                    </a>
                <% } else { %>
                    <a href="login.jsp" class="bg-primary hover:bg-primary/90 text-white py-2 px-4 rounded-full transition-all duration-200 flex items-center">
                        <i class="fa fa-user mr-2"></i>
                        <span>登录</span>
                    </a>
                <% } %>
                
                <!-- 移动端菜单按钮 -->
                <button class="md:hidden text-white" id="menu-toggle">
                    <i class="fa fa-bars text-xl"></i>
                </button>
            </div>
        </div>
        
        <!-- 移动端导航菜单 -->
        <div class="md:hidden hidden bg-dark-light/95 backdrop-blur-md absolute w-full" id="mobile-menu">
            <div class="container mx-auto px-4 py-3 flex flex-col space-y-4">
                <div class="relative">
                    <form action="searchResult.jsp" method="get">
                        <input type="text" name="keyword" placeholder="搜索帖子..." class="bg-dark rounded-full py-2 pl-10 pr-4 w-full focus:outline-none focus:ring-2 focus:ring-primary/50">
                        <i class="fa fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-text-muted"></i>
                    </form>
                </div>
                <a href="index.jsp" class="text-white py-2 border-b border-gray-700">首页</a>
                <a href="createPost.jsp" class="text-text-muted hover:text-white py-2 border-b border-gray-700">发布帖子</a>
                <a href="search.jsp" class="text-text-muted hover:text-white py-2 border-b border-gray-700">搜索</a>
                <a href="aboutUs.jsp" class="text-text-muted hover:text-white py-2">关于我们</a>
            </div>
        </div>
    </header>