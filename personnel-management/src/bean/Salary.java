package bean;

import java.sql.Date;

public class Salary {
    private Integer id;
    private Integer employeeId;
    private Double baseSalary;
    private Double bonus;
    private Double tax;
    private Date payDate;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getEmployeeId() { return employeeId; }
    public void setEmployeeId(Integer employeeId) { this.employeeId = employeeId; }
    public Double getBaseSalary() { return baseSalary; }
    public void setBaseSalary(Double baseSalary) { this.baseSalary = baseSalary; }
    public Double getBonus() { return bonus; }
    public void setBonus(Double bonus) { this.bonus = bonus; }
    public Double getTax() { return tax; }
    public void setTax(Double tax) { this.tax = tax; }
    public Date getPayDate() { return payDate; }
    public void setPayDate(Date payDate) { this.payDate = payDate; }
}
