package com.qzy.mapper;

import com.qzy.bean.LoginLog;

import java.util.List;

/**
 * @author qingzeyu
 */
public interface LoginLogMapper {
    int addLoginLog(LoginLog loginLog);
    List<LoginLog> getLastLog(String no);
}
