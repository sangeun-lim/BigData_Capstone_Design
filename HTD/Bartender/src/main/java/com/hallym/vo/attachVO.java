package com.hallym.vo;

public class attachVO {
  private String attach_id;
  
  private String path;
  
  private String name;
  
  private int attach_no;
  
  public int getAttach_no() {
    return this.attach_no;
  }
  
  public void setAttach_no(int attach_no) {
    this.attach_no = attach_no;
  }
  
  public String getAttach_id() {
    return this.attach_id;
  }
  
  public String getPath() {
    return this.path;
  }
  
  public String getName() {
    return this.name;
  }
  
  public void setAttach_id(String attach_id) {
    this.attach_id = attach_id;
  }
  
  public void setPath(String path) {
    this.path = path;
  }
  
  public void setName(String name) {
    this.name = name;
  }
}
