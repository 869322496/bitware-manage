package com.bitware.service.impl;

import com.bitware.bean.UserInfo;

public interface SecurityService {

    UserInfo getUserInfoByUserAccount(String userAccount);
}
