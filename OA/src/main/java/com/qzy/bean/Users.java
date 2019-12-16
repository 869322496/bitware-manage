package com.qzy.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author qingzeyu
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Users {
    private int id;
    private String name;
    private String pass;
    private String photo;
    private String loginDate;
    private int flag;
}
