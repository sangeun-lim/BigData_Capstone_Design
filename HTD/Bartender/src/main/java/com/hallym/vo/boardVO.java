package com.hallym.vo;

public class boardVO {
  private int no;
  
  private String user_id;
  
  private String title;
  
  private String date;
  
  private String time;
  
  private String content;
  
  private String attach_id;
  
  private int start;
  
  private int end;
  
  private int view;
  
  private String word;
  
  public String getWord() {
	return word;
  }
	
	public void setWord(String word) {
			this.word = word;
	}
	
	public int getView() {
	    return this.view;
	  }
  
  public void setView(int view) {
    this.view = view;
  }
  
  public int getStart() {
    return this.start;
  }
  
  public int getEnd() {
    return this.end;
  }
  
  public void setStart(int start) {
    this.start = start;
  }
  
  public void setEnd(int end) {
    this.end = end;
  }
  
  public int getNo() {
    return this.no;
  }
  
  public String getUser_id() {
    return this.user_id;
  }
  
  public String getTitle() {
    return this.title;
  }
  
  public String getDate() {
    return this.date;
  }
  
  public String getTime() {
    return this.time;
  }
  
  public String getContent() {
    return this.content;
  }
  
  public String getAttach_id() {
    return this.attach_id;
  }
  
  public void setNo(int no) {
    this.no = no;
  }
  
  public void setUser_id(String user_id) {
    this.user_id = user_id;
  }
  
  public void setTitle(String title) {
    this.title = title;
  }
  
  public void setDate(String date) {
    this.date = date;
  }
  
  public void setTime(String time) {
    this.time = time;
  }
  
  public void setContent(String content) {
    this.content = content;
  }
  
  public void setAttach_id(String attach_id) {
    this.attach_id = attach_id;
  }
}
