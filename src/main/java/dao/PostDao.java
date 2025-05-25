package dao;

import bean.Post;
import dao.DBUtil;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    // 获取热门帖子（按评论数降序）
    public List<Post> getHotPosts(int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.username, COUNT(c.id) as comment_count " +
                     "FROM post p " +
                     "JOIN user u ON p.user_id = u.id " +
                     "LEFT JOIN comment c ON p.id = c.post_id " +
                     "GROUP BY p.id " +
                     "ORDER BY comment_count DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // 获取最新帖子
    public List<Post> getLatestPosts(int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.username FROM post p " +
                     "JOIN user u ON p.user_id = u.id " +
                     "ORDER BY p.create_time DESC LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setId(rs.getInt("id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setCategory(rs.getString("category"));
        post.setUserId(rs.getInt("user_id")); // 设置user_id
        
        // 处理用户名
        try {
            post.setUsername(rs.getString("username"));
        } catch (SQLException e) {
            post.setUsername("未知用户");
        }
        
        // 处理时间字段 - 安全版本
        try {
            Timestamp timestamp = rs.getTimestamp("create_time");
            if (timestamp != null) {
                post.setCreateTime(dateFormat.format(timestamp));
            } else {
                post.setCreateTime("未知时间");
            }
        } catch (SQLException e) {
            post.setCreateTime("时间解析错误");
        }
        
        return post;
    }

    // 获取帖子评论数
    public int getCommentCount(int postId) {
        String sql = "SELECT COUNT(*) FROM comment WHERE post_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // 搜索帖子
    public List<Post> searchPosts(String keyword) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.username FROM post p " +
                     "JOIN user u ON p.user_id = u.id " +
                     "WHERE p.title LIKE ? OR p.content LIKE ? " +
                     "ORDER BY p.create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSetToPost(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // 根据ID获取帖子
    public Post getPostById(int postId) {
        String sql = "SELECT p.*, u.username FROM post p " +
                     "JOIN user u ON p.user_id = u.id " +
                     "WHERE p.id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, postId);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next() ? mapResultSetToPost(rs) : null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    // 创建新帖子
    public boolean createPost(Post post) {
        String sql = "INSERT INTO post(title, content, user_id, category) VALUES(?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setInt(3, post.getUserId()); // 需要Post类中添加userId字段
            pstmt.setString(4, post.getCategory());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}