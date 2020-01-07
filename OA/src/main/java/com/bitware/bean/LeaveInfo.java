package com.bitware.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LeaveInfo {
    private String id;
    private String userId;
    private String leaveType;
    private String title;
    private Date beginTime;
    private Date endTime;
    private String reason;
    private String orderNo;
    private String leaveTypeName;
    private String userName;
    private Date createTime;
    private Integer status;
    private String auditorName;
    private String reviewerName;
    private List<LeaveAudit> leaveProcess;
    private String img;
    private String dateType;
    private String  statusName;
}
