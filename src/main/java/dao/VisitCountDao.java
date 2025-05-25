package dao;

import java.sql.*;
public class VisitCountDao {
    public void incrementCount(String page) {
        String sql = "INSERT INTO visit_count (page, count) VALUES (?, 1) " +
                     "ON DUPLICATE KEY UPDATE count = count + 1";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, page);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int getCount(String page) {
        String sql = "SELECT count FROM visit_count WHERE page = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, page);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
}