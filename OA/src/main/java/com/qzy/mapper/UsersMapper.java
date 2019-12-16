package com.qzy.mapper;

import com.qzy.bean.Emp;
import com.qzy.bean.Users;

/**
 * @author qingzeyu
 */
public interface UsersMapper {
    Users selectUserInfoById(int id);
    int updateUserPhotoById(Emp emp);
    int updateUserPassword(Emp emp);
}
