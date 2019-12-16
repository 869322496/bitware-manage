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
public class LoginLog {
    private long id;
    private String ip;
    private String no;
    private String createtime;
    private String location;

    public LoginLog(String ip, String no, String location) {
        this.ip = ip;
        this.no = no;
        this.location = location;
    }
}
