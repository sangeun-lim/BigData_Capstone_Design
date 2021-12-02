package com.hallym.vo;

public class replyVO {
  private int reply_no;
  
  private int no;
  
  private int nreply_no;
  
  private String time;
  
  private String content;
  
  private int user_no;
  
  private String user_id;
  
  public int getReply_no() {
    return this.reply_no;
  }
  
  public int getNo() {
    return this.no;
  }
  
  public int getNreply_no() {
    return this.nreply_no;
  }
  
  public String getTime() {
    return this.time;
  }
  
  public String getContent() {
    return this.content;
  }
  
  public int getUser_no() {
    return this.user_no;
  }
  
  public String getUser_id() {
    return this.user_id;
  }
  
  public void setReply_no(int reply_no) {
    this.reply_no = reply_no;
  }
  
  public void setNo(int no) {
    this.no = no;
  }
  
  public void setNreply_no(int nreply_no) {
    this.nreply_no = nreply_no;
  }
  
  public void setTime(String time) {
    this.time = time;
  }
  
  public void setContent(String content) {
    this.content = content;
  }
  
  public void setUser_no(int user_no) {
    this.user_no = user_no;
  }
  
  public void setUser_id(String user_id) {
    this.user_id = user_id;
  }
}
