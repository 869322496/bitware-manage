package com.qzy.service.impl;

import com.qzy.bean.LoginLog;
import com.qzy.mapper.LoginLogMapper;
import com.qzy.service.LoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author qingzeyu
 */
@Service
public class LoginLogServiceImpl implements LoginLogService {
    @Autowired
    LoginLogMapper mapper;
    @Override
    public int addLoginLog(LoginLog loginLog) {
        return mapper.addLoginLog(loginLog);
    }

    @Override
    public List<LoginLog> getLastLog(String str) {
        return mapper.getLastLog(str);
    }
}
