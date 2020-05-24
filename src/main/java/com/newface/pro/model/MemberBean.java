package com.newface.pro.model;

import org.springframework.web.multipart.MultipartFile;

public class MemberBean {
  private String id; // 아이디
  private String pw; // 비밀번호
  private String name; // 이름
  private String phone; // 휴대폰번호
  private String birth; // 생년월일
  private String gender; // 성별
  private MultipartFile bg_img; // 배경사진
  private MultipartFile prof_img; // 프로필사진
  private String sido; // 시/도
  private String sigungu; // 시/군/구
  private String m_hobby; // 취미or관심사(매칭)
  private String m_gender; // 성별(매칭)
  private String m_age; // 연령(매칭)
  private String m_region; // 지역(매칭)
  private String m_flag; // 매칭허용여부(매칭)
  private String m_pr; // 자기소개(매칭)
  private int my_no; // 고유번호
  // 로그인 가능 상태는 안넣어도 될려나???필요없을듯한데

  private String bg_img_original; // 배경사진 파일명
  private String bg_img_file; // 변경된 배경사진 파일명(난수화)
  private String prof_img_original; // 프로필사진 파일명
  private String prof_img_file; // 변경된 프로필사진 파일명(난수화)

  // 나와 친구 상태인지, 요청 목록에 들어가 있는지 확인용
  private String id2;
  private String accept_id;

  private int on_off; // 1 : 온라인 2: 오프라인

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getPw() {
    return pw;
  }

  public void setPw(String pw) {
    this.pw = pw;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    /** **/
    // - 등 문자는 다르게 처리?
    this.phone = phone.replaceAll("-", "");
  }

  public String getBirth() {
    return birth;
  }

  public void setBirth(String birth) {
    this.birth = birth;
  }

  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }

  public MultipartFile getBg_img() {
    return bg_img;
  }

  public void setBg_img(MultipartFile bg_img) {
    this.bg_img = bg_img;
  }

  public MultipartFile getProf_img() {
    return prof_img;
  }

  public void setProf_img(MultipartFile prof_img) {
    this.prof_img = prof_img;
  }

  public String getSido() {
    return sido;
  }

  public void setSido(String sido) {
    this.sido = sido;
  }

  public String getSigungu() {
    return sigungu;
  }

  public void setSigungu(String sigungu) {
    this.sigungu = sigungu;
  }

  public String getM_hobby() {
    return m_hobby;
  }

  public void setM_hobby(String m_hobby) {
    this.m_hobby = m_hobby;
  }

  public String getM_gender() {
    return m_gender;
  }

  public void setM_gender(String m_gender) {
    this.m_gender = m_gender;
  }

  public String getM_age() {
    return m_age;
  }

  public void setM_age(String m_age) {
    this.m_age = m_age;
  }

  public String getM_region() {
    return m_region;
  }

  public void setM_region(String m_region) {
    this.m_region = m_region;
  }

  public String getM_flag() {
    return m_flag;
  }

  public void setM_flag(String m_flag) {
    this.m_flag = m_flag;
  }

  public String getM_pr() {
    return m_pr;
  }

  public void setM_pr(String m_pr) {
    this.m_pr = m_pr;
  }

  public int getMy_no() {
    return my_no;
  }

  public void setMy_no(int my_no) {
    this.my_no = my_no;
  }

  public String getBg_img_original() {
    return bg_img_original;
  }

  public void setBg_img_original(String bg_img_original) {
    this.bg_img_original = bg_img_original;
  }

  public String getBg_img_file() {
    return bg_img_file;
  }

  public void setBg_img_file(String bg_img_file) {
    this.bg_img_file = bg_img_file;
  }

  public String getProf_img_original() {
    return prof_img_original;
  }

  public void setProf_img_original(String prof_img_original) {
    this.prof_img_original = prof_img_original;
  }

  public String getProf_img_file() {
    return prof_img_file;
  }

  public void setProf_img_file(String prof_img_file) {
    this.prof_img_file = prof_img_file;
  }

  public String getId2() {
    return id2;
  }

  public void setId2(String id2) {
    this.id2 = id2;
  }

  public String getAccept_id() {
    return accept_id;
  }

  public void setAccept_id(String accept_id) {
    this.accept_id = accept_id;
  }

  public int getOn_off() {
    return on_off;
  }

  public void setOn_off(int on_off) {
    this.on_off = on_off;
  }


}
