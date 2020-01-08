package com.bitware.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoleInfo {
    private String id;
    private String name;
    private String remark;
    private Integer orderNo;
    private String code;
}
