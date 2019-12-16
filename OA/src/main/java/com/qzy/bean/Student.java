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
public class Student {

  private long id;
  private String no;
  private String name;
  private String sex;
  private String birthday;
  private String cardno;
  private String school;
  private String education;
  private long class_id;
  private long flag;
  private String email;
  private String qq;
  private String phone;
  private String createdate;
  private String photo;
  private long del;

  private Classes classes;

}
