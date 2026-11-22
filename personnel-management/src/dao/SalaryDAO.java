package dao;

import bean.Salary;
import dbutil.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalaryDAO {

    public void add(Salary s) throws SQLException {
        String sql = "INSERT INTO salaries(employee_id, base_salary, bonus, tax, pay_date) VALUES(?,?,?,?,?)";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, s.getEmployeeId());
            ps.setDouble(2, s.getBaseSalary() == null ? 0.0 : s.getBaseSalary());
            ps.setDouble(3, s.getBonus() == null ? 0.0 : s.getBonus());
            ps.setDouble(4, s.getTax() == null ? 0.0 : s.getTax());
            ps.setDate(5, s.getPayDate());
            ps.executeUpdate();
        }
    }

    public void update(Salary s) throws SQLException {
        String sql = "UPDATE salaries SET employee_id=?, base_salary=?, bonus=?, tax=?, pay_date=? WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, s.getEmployeeId());
            ps.setDouble(2, s.getBaseSalary() == null ? 0.0 : s.getBaseSalary());
            ps.setDouble(3, s.getBonus() == null ? 0.0 : s.getBonus());
            ps.setDouble(4, s.getTax() == null ? 0.0 : s.getTax());
            ps.setDate(5, s.getPayDate());
            ps.setInt(6, s.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM salaries WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Salary findById(int id) throws SQLException {
        String sql = "SELECT * FROM salaries WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Salary s = new Salary();
                    s.setId(rs.getInt("id"));
                    s.setEmployeeId(rs.getInt("employee_id"));
                    s.setBaseSalary(rs.getDouble("base_salary"));
                    s.setBonus(rs.getDouble("bonus"));
                    s.setTax(rs.getDouble("tax"));
                    s.setPayDate(rs.getDate("pay_date"));
                    return s;
                }
            }
        }
        return null;
    }

    public List<Salary> findAll() throws SQLException {
        String sql = "SELECT * FROM salaries ORDER BY pay_date DESC";
        List<Salary> list = new ArrayList<>();
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Salary s = new Salary();
                s.setId(rs.getInt("id"));
                s.setEmployeeId(rs.getInt("employee_id"));
                s.setBaseSalary(rs.getDouble("base_salary"));
                s.setBonus(rs.getDouble("bonus"));
                s.setTax(rs.getDouble("tax"));
                s.setPayDate(rs.getDate("pay_date"));
                list.add(s);
            }
        }
        return list;
    }

    public List<Salary> findByEmployeeId(int employeeId) throws SQLException {
        String sql = "SELECT * FROM salaries WHERE employee_id=? ORDER BY pay_date DESC";
        List<Salary> list = new ArrayList<>();
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Salary s = new Salary();
                    s.setId(rs.getInt("id"));
                    s.setEmployeeId(rs.getInt("employee_id"));
                    s.setBaseSalary(rs.getDouble("base_salary"));
                    s.setBonus(rs.getDouble("bonus"));
                    s.setTax(rs.getDouble("tax"));
                    s.setPayDate(rs.getDate("pay_date"));
                    list.add(s);
                }
            }
        }
        return list;
    }
}
