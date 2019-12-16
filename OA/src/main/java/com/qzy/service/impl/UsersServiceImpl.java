package com.qzy.service.impl;

import com.qzy.bean.Emp;
import com.qzy.bean.Users;
import com.qzy.mapper.UsersMapper;
import com.qzy.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author qingzeyu
 */
@Service
public class UsersServiceImpl implements UsersService {
    @Autowired
    UsersMapper mapper;

    @Override
    public Users selectUserInfoById(int id) {
        return mapper.selectUserInfoById(id);
    }

    @Override
    public int updateUserPhotoById(Emp emp) {
        return mapper.updateUserPhotoById(emp);
    }
}
