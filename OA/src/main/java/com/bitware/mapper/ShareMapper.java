package com.bitware.mapper;

import com.bitware.bean.DictionaryItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShareMapper {
    List<DictionaryItem> getDictionary(@Param("dicCode") String dicCode, @Param("dicItemCode") String dicItemCode);
}
