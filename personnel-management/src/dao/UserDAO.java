package dao;

import bean.User;
import dbutil.JDBCUtil;

import java.sql.*;

public class UserDAO {

    /**
     * 用于登录的推荐方法：按用户名 + 密码查询
     * 确保 employee_id 一并加载
     */
    public User login(String username, String password) throws SQLException {
        String sql = "SELECT id, username, password, role, employee_id FROM users WHERE username=? AND password=?";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));

                    // 关键修复：必须正确处理 employee_id
                    Object empObj = rs.getObject("employee_id");
                    if (empObj == null) {
                        user.setEmployeeId(null);
                    } else {
                        user.setEmployeeId(rs.getInt("employee_id"));
                    }

                    return user;
                }
            }
        }
        return null;
    }


    /**
     * 如果你的系统还会单独按用户名查用户（例如用于注册重复校验），可保留 findByUsername
     */
    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT id, username, password, role, employee_id FROM users WHERE username = ?";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));

                    // 同样必须正确处理 employee_id
                    Object empObj = rs.getObject("employee_id");
                    if (empObj == null) {
                        user.setEmployeeId(null);
                    } else {
                        user.setEmployeeId(rs.getInt("employee_id"));
                    }

                    return user;
                }
            }
        }
        return null;
    }


    /**
     * 添加用户（管理员注册、员工注册都适用）
     */
    public void add(User u) throws SQLException {
        String sql = "INSERT INTO users(username, password, role, employee_id) VALUES(?,?,?,?)";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getRole());

            // 处理 employee_id（管理员为 NULL）
            if (u.getEmployeeId() == null) {
                ps.setNull(4, Types.INTEGER);
            } else {
                ps.setInt(4, u.getEmployeeId());
            }

            ps.executeUpdate();
        }
    }
}
