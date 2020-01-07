package com.bitware.service.impl;

import com.bitware.bean.DictionaryItem;
import com.bitware.bean.ResourceInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShareService {
    List<DictionaryItem> getDictionary(String dicCode, String dicItemCode);

    List<ResourceInfo> getMenuByRoleId(String roleId);

    List<ResourceInfo> getResourceByRoleId(String roleId, String category, String code);
}
