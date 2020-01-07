package com.bitware.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.DictionaryItem;
import com.bitware.bean.ResourceInfo;
import com.bitware.service.impl.ShareService;
import com.bitware.utils.TreeUtil;
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

    /**
     * 根据角色获取目录
     * @param roleId
     * @return
     */
    @RequestMapping("/getMenu/{roleId}")
    @ResponseBody
    public BitResult  getMenu(@PathVariable String roleId){
        List<JSONObject> menuArray;
        try {
            JSONArray menu = new JSONArray();
            JSONObject rootNode; //map太多泛型强转容易出错
            List<ResourceInfo>  resourceInfoList = shareService.getMenuByRoleId(roleId);
            JSONArray resourceArray = JSONArray.parseArray(JSON.toJSONString(resourceInfoList));
            menuArray = JSONArray.parseObject(resourceArray.toString(), List.class);
            rootNode = menuArray.stream()
                    .filter(o -> o.getString("parentId").equals(TreeUtil.MENUROOT))
                    .findAny()
                    .orElse(null);
            if (rootNode == null) {
                return BitResult.failure("没有根目录结构！");
            }
            TreeUtil.addTreeNode(rootNode, null, menuArray, menu);
            return BitResult.success(menu);
        }catch (Exception e){
            e.printStackTrace();
            return BitResult.failure("获取目录失败");
        }

    }
}
