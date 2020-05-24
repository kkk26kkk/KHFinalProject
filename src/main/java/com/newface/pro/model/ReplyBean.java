package com.newface.pro.model;

import java.sql.Date;

public class ReplyBean {
  private String id;
  private int board_no;
  private int reply_no;
  private String reply_id;
  private String name;
  private String content;
  private int re_ref;
  private int re_lev;
  private int re_seq;
  private Date ref_date;
  private String prof_img_file;


  public String getReply_id() {
    return reply_id;
  }

  public void setReply_id(String reply_id) {
    this.reply_id = reply_id;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
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

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public int getRe_ref() {
    return re_ref;
  }

  public void setRe_ref(int re_ref) {
    this.re_ref = re_ref;
  }

  public int getRe_lev() {
    return re_lev;
  }

  public void setRe_lev(int re_lev) {
    this.re_lev = re_lev;
  }

  public int getRe_seq() {
    return re_seq;
  }

  public void setRe_seq(int re_seq) {
    this.re_seq = re_seq;
  }

  public Date getRef_date() {
    return ref_date;
  }

  public void setRef_date(Date ref_date) {
    this.ref_date = ref_date;
  }

  public String getProf_img_file() {
    return prof_img_file;
  }

  public void setProf_img_file(String prof_img_file) {
    this.prof_img_file = prof_img_file;
  }


}
