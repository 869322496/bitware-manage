package com.bitware.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DictionaryItem {
    private String id;
    private String name;
    private String code;
    private String dictionaryId;
    private String parentId;
    private String orderNo;
}
