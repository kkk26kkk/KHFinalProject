package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import com.newface.pro.model.BoardBean;
import com.newface.pro.model.MemberBean;

public interface TimeLineService {
  public List<MemberBean> getmemberinfo(String id) throws Exception;

  public List<BoardBean> timeListPlus(Map m) throws Exception;

  public void setReadCheck(int a_no);

  // 알림 타고온 게시글 하나 상세 보기
  public List<BoardBean> get_oneboard(Map m) throws Exception;

  public MemberBean tm_info(Map m) throws Exception;

  public MemberBean infoshowplus(Map m) throws Exception;
}
