package com.bitware.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResourceInfo {
    private String id;
    private String name;
    private String description;
    private String menuIcon;
    private String url;
    private String category;
    private String parentId;
    private Integer orderNo;
    private Integer enabled;
    private Date updateDate;
    private String code;
}
