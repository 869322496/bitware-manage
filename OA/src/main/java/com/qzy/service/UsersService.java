package com.qzy.service;

import com.qzy.bean.Emp;
import com.qzy.bean.Users;

/**
 * @author qingzeyu
 */
public interface UsersService {
    Users selectUserInfoById(int id);
    int updateUserPhotoById(Emp emp);
}
