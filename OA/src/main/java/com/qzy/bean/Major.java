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
public class Major {

  private long id;
  private String major_name;
  private String major_time;
  private String  major_date;
  private long major_type;
  private long major_delete;

  private MajorType majorType;
}
