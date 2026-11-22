package bean;

import java.sql.Date;

public class LeaveRequest {
    private Integer id;
    private Integer employeeId;
    private String leaveType;
    private Date startDate;
    private Date endDate;
    private Integer days;
    private String reason;
    private String status;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getEmployeeId() { return employeeId; }
    public void setEmployeeId(Integer employeeId) { this.employeeId = employeeId; }
   
    public String getLeaveType() { return leaveType; }
    public void setLeaveType(String leaveType) { this.leaveType = leaveType; }
    
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    
    public Integer getDays() { return days; }
    public void setDays(Integer days) { this.days = days; }
   
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
