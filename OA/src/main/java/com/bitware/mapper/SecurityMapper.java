package com.bitware.mapper;

import com.bitware.bean.UserInfo;
import org.apache.ibatis.annotations.Param;

public interface  SecurityMapper {

    UserInfo getUserInfoByUserAccount(@Param("userAccount") String userAccount);
}
