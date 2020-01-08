package com.bitware.bean;

import lombok.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserInfo {
    private String userAccount;
    private String name;
    private String password;
    private String id;
    private Date createDate;
    private Date lastLoginDate;
    private String email;
    private String remark;
    private int isDelete;
    private int isEnable;
    private String orgId;
    private String tel;
    private String avatar;
    private String roleId;
    private String roleName;
    private String role;
    private List<ResourceInfo> roleResource;
}
