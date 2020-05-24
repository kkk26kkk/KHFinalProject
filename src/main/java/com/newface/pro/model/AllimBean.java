package com.newface.pro.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.newface.pro.common.TIME_MAXIMUM;

public class AllimBean {
  private int a_flag;
  private int a_no;
  private int read_check;
  private String name;
  private String id;
  private String accept_id;
  private int board_no;
  private int reply_no;
  private int my_no;
  private String reg_date; // 알림 등록 날짜
  private String prof_img_file; // 보내는 멤버의 프로필 사진

  public int getA_flag() {
    return a_flag;
  }

  public void setA_flag(int a_flag) {
    this.a_flag = a_flag;
  }

  public int getA_no() {
    return a_no;
  }

  public void setA_no(int a_no) {
    this.a_no = a_no;
  }

  public int getRead_check() {
    return read_check;
  }

  public void setRead_check(int read_check) {
    this.read_check = read_check;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getAccept_id() {
    return accept_id;
  }

  public void setAccept_id(String accept_id) {
    this.accept_id = accept_id;
  }

  public int getBoard_no() {
    return board_no;
  }

  public void setBoard_no(int board_no) {
    this.board_no = board_no;
  }

  public int getReply_no() {
    return reply_no;
  }

  public void setReply_no(int reply_no) {
    this.reply_no = reply_no;
  }

  public int getMy_no() {
    return my_no;
  }

  public void setMy_no(int my_no) {
    this.my_no = my_no;
  }

  // 알림 등록일을 기준으로 현재 시간과 계산해서 얼마 전에 온 알림인지 계산
  public String getReg_date() {
    // return reg_date;

    long currentDate = System.currentTimeMillis();

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    long regDate = 0;
    try {
      Date date = sdf.parse(reg_date);
      regDate = date.getTime();
    } catch (ParseException e) {
      e.printStackTrace();
    }

    String msg = TIME_MAXIMUM.formatTimeString(regDate, currentDate);

    return msg;
  }

  public void setReg_date(String reg_date) {
    this.reg_date = reg_date;
  }

  // 보내는 멤버의 프로필 사진 getter, setter
  public String getProf_img_file() {
    return prof_img_file;
  }

  public void setProf_img_file(String prof_img_file) {
    this.prof_img_file = prof_img_file;
  }

}
