package com.bitware.service.impl;

import com.bitware.bean.DictionaryItem;
import com.bitware.bean.ResourceInfo;
import com.bitware.mapper.ShareMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShareServiceImpl implements  ShareService {
    @Autowired
    ShareMapper shareMapper;
    @Override
    public List<DictionaryItem> getDictionary(String dicCode, String dicItemCode) {
        return shareMapper.getDictionary(dicCode,dicItemCode);
    }

    @Override
    public List<ResourceInfo> getMenuByRoleId(String roleId) {
        return shareMapper.getResourceByRoleId(roleId,null,null);
    }

    @Override
    public List<ResourceInfo> getResourceByRoleId(String roleId,String category,String code) {
        return shareMapper.getResourceByRoleId(roleId,category,code);
    }
}
