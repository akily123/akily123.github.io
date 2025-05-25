package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import bean.User;
import dao.DBUtil;

public class UserDao {
    // 用户登录验证
    public User login(String username, String password) {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        
        return user;
    }
    
    // 用户注册
    public boolean register(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean result = false;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO user (username, password, email, role) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, "user"); // 默认角色为普通用户
            
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn);
        }
        
        return result;
    }
    
    public void recordUserVisit(int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            // 检查用户访问记录是否存在
            String checkSql = "SELECT * FROM visit_count WHERE user_id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            
            if (rs.next()) {
                // 如果记录存在，更新访问次数和最后访问时间
                String updateSql = "UPDATE visit_count SET count = count + 1, last_visit_time = ? WHERE user_id = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setTimestamp(1, currentTime);
                pstmt.setInt(2, userId);
                pstmt.executeUpdate();
            } else {
                // 如果记录不存在，插入新记录
                String insertSql = "INSERT INTO visit_count (user_id, count, last_visit_time) VALUES (?, 1, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setInt(1, userId);
                pstmt.setTimestamp(2, currentTime);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBUtil.close(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // 获取用户访问次数
    public int getUserVisitCount(int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT count FROM visit_count WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBUtil.close(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }
    // 检查用户名是否存在
    public boolean checkUsernameExists(String username) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("数据库连接失败！");
                return false;
            }
            
            String sql = "SELECT * FROM user WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                exists = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 确保资源关闭
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) DBUtil.close(conn); // 检查这一行
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return exists;
    }
}