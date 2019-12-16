package com.qzy.utils;

import lombok.Data;

import java.util.List;

/**
 * @author qingzeyu
 */
@Data
public class PageUtils<T> {
    private long pageIndex;
    private long pageSize;
    private long totalCount;
    private long pageCount;

    private List<T> records;

    private long numberStart;
    private long numberEnd;

    public PageUtils(long pageIndex, long pageSize, long totalCount, List<T> records) {
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.records = records;

        //计算一下总页数
        this.pageCount=(totalCount%pageSize==0)?(totalCount/pageSize):(totalCount/pageSize+1);

        //数学算法
        // -----------偷偷的给页码序号赋值------------------
        // 一共显示10个页面 动态伸缩-
        if (this.pageCount <= 10) {
            this.numberStart = 1;
            this.numberEnd = pageCount;
        } else {
            this.numberStart = pageIndex - 4;
            this.numberEnd = pageIndex + 5;
            if (numberStart < 1) {
                this.numberStart = 1;
                this.numberEnd = 10;
            } else if (numberEnd > pageCount) {
                this.numberEnd = pageCount;
                this.numberStart = pageCount - 9;
            }
        }
        // -----------偷偷的给页码序号赋值------------------

    }
}
