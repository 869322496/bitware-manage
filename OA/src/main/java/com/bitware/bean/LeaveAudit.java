package com.bitware.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LeaveAudit {
    private String auditor;
    private String type;
    private Integer status;
    private String reason;
    private String leaveId;
    private String auditorName;
    private String typeName;
    private Date time;
}
