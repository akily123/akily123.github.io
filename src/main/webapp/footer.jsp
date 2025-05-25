 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <!-- 页脚 -->
    <footer class="bg-dark-light py-12">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <h3 class="text-xl font-bold mb-4 flex items-center">
                        <i class="fa fa-gamepad mr-2"></i>
                        <span>Goming</span>
                    </h3>
                    <p class="text-text-muted mb-4">游戏爱好者的交流平台，分享游戏心得，讨论游戏话题，结交游戏好友。</p>
                    <div class="flex space-x-4">
                        <a href="#" class="text-text-muted hover:text-white transition-colors duration-200">
                            <i class="fa fa-facebook"></i>
                        </a>
                        <a href="#" class="text-text-muted hover:text-white transition-colors duration-200">
                            <i class="fa fa-twitter"></i>
                        </a>
                        <a href="#" class="text-text-muted hover:text-white transition-colors duration-200">
                            <i class="fa fa-instagram"></i>
                        </a>
                        <a href="#" class="text-text-muted hover:text-white transition-colors duration-200">
                            <i class="fa fa-discord"></i>
                        </a>
                    </div>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">快速链接</h4>
                    <ul class="space-y-2">
                        <li><a href="index.jsp" class="text-text-muted hover:text-white transition-colors duration-200">首页</a></li>
                        <li><a href="createPost.jsp" class="text-text-muted hover:text-white transition-colors duration-200">发布帖子</a></li>
                        <li><a href="search.jsp" class="text-text-muted hover:text-white transition-colors duration-200">搜索</a></li>
                        <li><a href="aboutUs.jsp" class="text-text-muted hover:text-white transition-colors duration-200">关于我们</a></li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">游戏分类</h4>
                    <ul class="space-y-2">
                        <li><a href="#" class="text-text-muted hover:text-white transition-colors duration-200">角色扮演</a></li>
                        <li><a href="#" class="text-text-muted hover:text-white transition-colors duration-200">多人在线</a></li>
                        <li><a href="#" class="text-text-muted hover:text-white transition-colors duration-200">竞速</a></li>
                        <li><a href="#" class="text-text-muted hover:text-white transition-colors duration-200">体育</a></li>
                        <li><a href="#" class="text-text-muted hover:text-white transition-colors duration-200">动作</a></li>
                        <li><a href="#" class="text-text-muted hover:text-white transition-colors duration-200">策略</a></li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">联系我们</h4>
                    <ul class="space-y-2">
                        <li class="flex items-start">
                            <i class="fa fa-envelope-o mr-2 mt-1"></i>
                            <span class="text-text-muted">1031374769@qq.com</span>
                        </li>
                        <li class="flex items-start">
                            <i class="fa fa-phone mr-2 mt-1"></i>
                            <span class="text-text-muted">16642232051</span>
                        </li>
                        <li class="flex items-start">
                            <i class="fa fa-map-marker mr-2 mt-1"></i>
                            <span class="text-text-muted">辽宁科技大学2舍</span>
                        </li>
                    </ul>
                    
                    <div class="mt-6">
                        <h5 class="text-sm font-medium mb-3">订阅我们的新闻通讯</h5>
                        <form class="flex">
                            <input type="email" placeholder="输入你的邮箱" class="bg-dark rounded-l-full py-2 px-4 w-full focus:outline-none focus:ring-2 focus:ring-primary/50">
                            <button class="bg-primary hover:bg-primary/90 text-white rounded-r-full py-2 px-4 transition-colors duration-200">
                                <i class="fa fa-paper-plane"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="border-t border-gray-700 mt-10 pt-6 flex flex-col md:flex-row justify-between items-center">
                <p class="text-text-muted text-sm mb-4 md:mb-0">© 2025 GameTalk. 保留所有权利。</p>
                <div class="flex space-x-6">
                    <a href="#" class="text-text-muted hover:text-white text-sm transition-colors duration-200">服务条款</a>
                    <a href="#" class="text-text-muted hover:text-white text-sm transition-colors duration-200">隐私政策</a>
                    <a href="#" class="text-text-muted hover:text-white text-sm transition-colors duration-200">Cookie政策</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script>
        // 导航栏滚动效果
        const navbar = document.getElementById('navbar');
        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) {
                navbar.classList.add('py-2', 'bg-dark-light/95', 'shadow-lg');
                navbar.classList.remove('py-3', 'bg-dark-light/80');
            } else {
                navbar.classList.add('py-3', 'bg-dark-light/80');
                navbar.classList.remove('py-2', 'bg-dark-light/95', 'shadow-lg');
            }
        });
        
        // 移动端菜单切换
        const menuToggle = document.getElementById('menu-toggle');
        const mobileMenu = document.getElementById('mobile-menu');
        
        menuToggle.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
        });
    </script>
</body>
</html>