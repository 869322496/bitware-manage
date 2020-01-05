package com.bitware.service.impl;

import com.bitware.bean.DictionaryItem;

import java.util.List;

public interface ShareService {
    List<DictionaryItem> getDictionary(String dicCode, String dicItemCode);
}
