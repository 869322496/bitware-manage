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
public class Classes {

  private long id;
  private long major_id;
  private String className;
  private java.sql.Date class_date;
  private String class_time;
  private String class_address;
  private long class_delete;

  private Major major;
}
