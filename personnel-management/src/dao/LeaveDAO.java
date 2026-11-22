package dao;

import bean.LeaveRequest;
import dbutil.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveDAO {

    public void add(LeaveRequest l) throws SQLException {
        String sql = "INSERT INTO leave_requests(employee_id, leave_type, start_date, end_date, days, reason, status) VALUES(?,?,?,?,?,?,?)";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, l.getEmployeeId());
            ps.setString(2, l.getLeaveType());
            ps.setDate(3, l.getStartDate());
            ps.setDate(4, l.getEndDate());
            ps.setInt(5, l.getDays());
            ps.setString(6, l.getReason());
            ps.setString(7, l.getStatus() == null ? "PENDING" : l.getStatus());
            ps.executeUpdate();
        }
    }

    public void update(LeaveRequest l) throws SQLException {
        String sql = "UPDATE leave_requests SET employee_id=?, leave_type=?, start_date=?, end_date=?, days=?, reason=?, status=? WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, l.getEmployeeId());
            ps.setString(2, l.getLeaveType());
            ps.setDate(3, l.getStartDate());
            ps.setDate(4, l.getEndDate());
            ps.setInt(5, l.getDays());
            ps.setString(6, l.getReason());
            ps.setString(7, l.getStatus());
            ps.setInt(8, l.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM leave_requests WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public LeaveRequest findById(int id) throws SQLException {
        String sql = "SELECT * FROM leave_requests WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LeaveRequest l = map(rs);
                    return l;
                }
            }
        }
        return null;
    }

    public List<LeaveRequest> findAll() throws SQLException {
        String sql = "SELECT * FROM leave_requests ORDER BY apply_date DESC";
        List<LeaveRequest> list = new ArrayList<>();
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public List<LeaveRequest> findByEmployeeId(int employeeId) throws SQLException {
        String sql = "SELECT * FROM leave_requests WHERE employee_id=? ORDER BY apply_date DESC";
        List<LeaveRequest> list = new ArrayList<>();
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }

    private LeaveRequest map(ResultSet rs) throws SQLException {
        LeaveRequest l = new LeaveRequest();
        l.setId(rs.getInt("id"));
        l.setEmployeeId(rs.getInt("employee_id"));
        l.setLeaveType(rs.getString("leave_type"));
        l.setStartDate(rs.getDate("start_date"));
        l.setEndDate(rs.getDate("end_date"));
        l.setDays(rs.getInt("days"));
        l.setReason(rs.getString("reason"));
        l.setStatus(rs.getString("status"));
        return l;
    }
}
