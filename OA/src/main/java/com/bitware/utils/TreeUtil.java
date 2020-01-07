package com.bitware.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.ResourceInfo;
import com.bitware.service.impl.ShareService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


/**
 * @Author ludaxian
 */
@Component
public class TreeUtil {
    private static ShareService shareService;

    @Autowired(required = false)
    public void setShareService(
            ShareService shareService
    ) {
        TreeUtil.shareService = shareService;
    }
    public static final String MENUROOT = "menu_root";

    /**
     * 新增节点
     *
     * @param childNode    此次递归需要封装的树节点数据
     * @param parentId     父节点key
     * @param allTreeNodes 递归需要的所有源数据
     * @param childrenTree 每一级的树节点集合
     */
    public static void addTreeNode(JSONObject childNode, String parentId, List<JSONObject> allTreeNodes, JSONArray childrenTree) {
        JSONObject orgTreeNode = new JSONObject();
        orgTreeNode.put("text", childNode.getString("name"));
        orgTreeNode.put("link", childNode.getString("url"));
        orgTreeNode.put("parentId", parentId);
        orgTreeNode.put("icon", childNode.getString("menuIcon"));
        List<JSONObject> allChildNodes = allTreeNodes.stream()
                .filter(node -> StringUtils.equals(node.getString("parentId"), childNode.getString("id")))
                .collect(Collectors.toList());
        if (allChildNodes.size() == 0) {//没有根节点
            orgTreeNode.put("children", new JSONArray());
        } else {
            allChildNodes.sort((o1, o2) -> o1.getInteger("orderNo").compareTo(o2.getInteger("orderNo")));
            // allChildNodes = allChildNodes.stream().sorted(Comparator.comparing(o->o.get("orderNo"))).collect(Collectors.toList());
            orgTreeNode.put("children", editTreeNode(allChildNodes, allTreeNodes, childNode.getString("id")));
        }
        childrenTree.add(orgTreeNode);
    }

    /**
     * 生成zorroTree格式children
     *
     * @param allChildNodes 所有归属于parentIdD的组织结构
     * @param allTreeNodes  所有组织结构
     * @param parentId      父级组织结构orgId
     * @return
     */
    public static JSONArray editTreeNode(List<JSONObject> allChildNodes, List<JSONObject> allTreeNodes, String parentId) {
        JSONArray childrenTree = new JSONArray();
        allChildNodes.forEach(childNode ->
                addTreeNode(childNode, parentId, allTreeNodes, childrenTree)
        );
        return childrenTree;
    }

}
