package dao;

import bean.Employee;
import dbutil.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {
    public void add(Employee e) throws SQLException {
        String sql = "INSERT INTO employees(emp_no,name,dept,position,phone,email) VALUES(?,?,?,?,?,?)";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getEmpNo());
            ps.setString(2, e.getName());
            ps.setString(3, e.getDept());
            ps.setString(4, e.getPosition());
            ps.setString(5, e.getPhone());
            ps.setString(6, e.getEmail());
            ps.executeUpdate();
        }
    }

    public void update(Employee e) throws SQLException {
        String sql = "UPDATE employees SET emp_no=?,name=?,dept=?,position=?,phone=?,email=? WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getEmpNo());
            ps.setString(2, e.getName());
            ps.setString(3, e.getDept());
            ps.setString(4, e.getPosition());
            ps.setString(5, e.getPhone());
            ps.setString(6, e.getEmail());
            ps.setInt(7, e.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM employees WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Employee findById(int id) throws SQLException {
        String sql = "SELECT * FROM employees WHERE id=?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Employee e = new Employee();
                    e.setId(rs.getInt("id"));
                    e.setEmpNo(rs.getString("emp_no"));
                    e.setName(rs.getString("name"));
                    e.setDept(rs.getString("dept"));
                    e.setPosition(rs.getString("position"));
                    e.setPhone(rs.getString("phone"));
                    e.setEmail(rs.getString("email"));
                    return e;
                }
            }
        }
        return null;
    }

    public List<Employee> findAll() throws SQLException {
        String sql = "SELECT * FROM employees ORDER BY id";
        List<Employee> list = new ArrayList<>();
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("id"));
                e.setEmpNo(rs.getString("emp_no"));
                e.setName(rs.getString("name"));
                e.setDept(rs.getString("dept"));
                e.setPosition(rs.getString("position"));
                e.setPhone(rs.getString("phone"));
                e.setEmail(rs.getString("email"));
                list.add(e);
            }
        }
        return list;
    }
}
