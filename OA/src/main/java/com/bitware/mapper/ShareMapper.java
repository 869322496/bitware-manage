package com.bitware.mapper;

import com.bitware.bean.DictionaryItem;
import com.bitware.bean.ResourceInfo;
import org.apache.ibatis.annotations.Param;


import java.util.List;

public interface ShareMapper {
    List<DictionaryItem> getDictionary(@Param("dicCode") String dicCode, @Param("dicItemCode") String dicItemCode);

    List<ResourceInfo> getResourceByRoleId(@Param("roleId") String roleId,@Param("category") String category,@Param("code") String code);

}
