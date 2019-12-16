package com.qzy.service;

import com.qzy.bean.LoginLog;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author qingzeyu
 */

public interface LoginLogService {
    int addLoginLog(LoginLog loginLog);
    List<LoginLog> getLastLog(String str);
}
