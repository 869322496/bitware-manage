package com.qzy.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author QZY
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Depart {

  private long id;
  private String name;
  private String createtime;
  private long del;
  private Integer count;



}
