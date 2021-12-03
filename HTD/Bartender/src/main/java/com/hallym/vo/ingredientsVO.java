package com.hallym.vo;

public class ingredientsVO {
  private int ig;
  
  private int ig_type;
  
  private String ig_name;
  
  private String ig_pic;
  
  private int spirits_type;
	
  public int getSpirits_type() {
	return spirits_type;
}

public void setSpirits_type(int spirits_type) {
	this.spirits_type = spirits_type;
}

public String getIg_pic() {
    return this.ig_pic;
  }
  
  public void setIg_pic(String ig_pic) {
    this.ig_pic = ig_pic;
  }
  
  public int getIg() {
    return this.ig;
  }
  
  public void setIg(int ig) {
    this.ig = ig;
  }
  
  public int getIg_type() {
    return this.ig_type;
  }
  
  public void setIg_type(int ig_type) {
    this.ig_type = ig_type;
  }
  
  public String getIg_name() {
    return this.ig_name;
  }
  
  public void setIg_name(String ig_name) {
    this.ig_name = ig_name;
  }
}
