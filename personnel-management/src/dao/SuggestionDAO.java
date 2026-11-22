package dao;

import bean.Suggestion;
import dbutil.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SuggestionDAO {
    // 新增建议
    public void add(Suggestion s) throws SQLException {
        String sql = "INSERT INTO suggestion(suggestionTitle, suggestionContent) VALUES(?,?)";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getSuggestionTitle());
            ps.setString(2, s.getSuggestionContent());
            ps.executeUpdate();
        }
    }

    // 更新建议
    public void update(Suggestion s) throws SQLException {
        String sql = "UPDATE suggestion SET suggestionTitle=?, suggestionContent=? WHERE suggestionID=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getSuggestionTitle());
            ps.setString(2, s.getSuggestionContent());
            ps.setInt(3, s.getSuggestionID());
            ps.executeUpdate();
        }
    }

    // 删除建议
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM suggestion WHERE suggestionID=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // 根据ID查询建议
    public Suggestion findById(int id) throws SQLException {
        String sql = "SELECT * FROM suggestion WHERE suggestionID=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Suggestion s = new Suggestion();
                    s.setSuggestionID(rs.getInt("suggestionID"));
                    s.setSuggestionTitle(rs.getString("suggestionTitle"));
                    s.setSuggestionContent(rs.getString("suggestionContent"));
                    s.setSubmitTime(rs.getString("submitTime"));
                    return s;
                }
            }
        }
        return null;
    }

    // 查询所有建议
    public List<Suggestion> findAll() throws SQLException {
        String sql = "SELECT * FROM suggestion ORDER BY suggestionID DESC";
        List<Suggestion> list = new ArrayList<>();
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Suggestion s = new Suggestion();
                s.setSuggestionID(rs.getInt("suggestionID"));
                s.setSuggestionTitle(rs.getString("suggestionTitle"));
                s.setSuggestionContent(rs.getString("suggestionContent"));
                s.setSubmitTime(rs.getString("submitTime"));
                list.add(s);
            }
        }
        return list;
    }
}