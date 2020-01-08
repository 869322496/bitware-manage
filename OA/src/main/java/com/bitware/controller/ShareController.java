package com.bitware.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.DictionaryItem;
import com.bitware.bean.ResourceInfo;
import com.bitware.service.impl.ShareService;
import com.bitware.utils.TreeUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/share")
public class ShareController {
    @Autowired
    ShareService shareService;

    @RequestMapping("/getDictionary/{dicCode}/{dicItemCode}")
    @ResponseBody
    public BitResult getDictionary(@PathVariable String dicCode,@PathVariable String dicItemCode) {
      List<DictionaryItem> dictionaryItemList =   shareService.getDictionary(dicCode,dicItemCode);
      return BitResult.success(dictionaryItemList);
    }




}
