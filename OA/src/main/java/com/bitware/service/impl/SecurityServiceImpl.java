package com.bitware.service.impl;

import com.bitware.bean.UserInfo;
import com.bitware.mapper.SecurityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SecurityServiceImpl implements SecurityService {
    @Autowired
    SecurityMapper securityMapper;
    @Override
    public UserInfo getUserInfoByUserAccount(String userAccount) {
        return securityMapper.getUserInfoByUserAccount(userAccount);
    }
}
