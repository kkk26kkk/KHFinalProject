package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newface.pro.model.BoardBean;
import com.newface.pro.model.MemberBean;

@Service
public class TimeLineServiceImpl implements TimeLineService {
  @Autowired
  private TimeLineDAOImpl timelineDAO;

  // 친구 구하기
  @Override
  public List<MemberBean> getmemberinfo(String id) throws Exception {
    return timelineDAO.getmemberinfo(id);
  }

  // 스크롤 내리면 게시물 플러스
  @Override
  public List<BoardBean> timeListPlus(Map m) throws Exception {
    return timelineDAO.timeListPlus(m);
  }

  // 알림 '읽음'으로 변경
  @Override
  public void setReadCheck(int a_no) {
    timelineDAO.setReadCheck(a_no);
  }

  // 알림 타고온 게시글 하나 상세 보기
  @Override
  public List<BoardBean> get_oneboard(Map m) throws Exception {
    return timelineDAO.get_oneboard(m);
  }

  // 정보하기 클릭시 정보 보기
  @Override
  public MemberBean tm_info(Map m) throws Exception {
    return timelineDAO.tm_info(m);
  }

  // 정보 더보기
  @Override
  public MemberBean infoshowplus(Map m) throws Exception {
    return timelineDAO.infoshowplus(m);
  }
}
