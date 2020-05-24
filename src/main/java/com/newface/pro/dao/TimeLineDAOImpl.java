package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newface.pro.model.BoardBean;
import com.newface.pro.model.MemberBean;

@Repository
public class TimeLineDAOImpl {
  @Autowired
  private SqlSessionTemplate sqlSession;

  public void getTimeLine(String id) {
    // sqlSession.
  }

  // 알림 '읽음'으로 바꿈
  public void setReadCheck(int a_no) {
    sqlSession.update("Allim.setReadCheck", a_no);
  }

  public List<MemberBean> getmemberinfo(String id) {
    return sqlSession.selectList("Timeline.getmemberinfo", id);
  }

  public List<BoardBean> timeListPlus(Map m) {
    return sqlSession.selectList("Timeline.listPlus", m);
  }

  // 알림 타고온 게시글 하나 상세 보기
  public List<BoardBean> get_oneboard(Map m) {
    return sqlSession.selectList("Timeline.get_oneboard", m);
  }

  public MemberBean tm_info(Map m) {
    return sqlSession.selectOne("Timeline.tm_info", m);
  }

  public MemberBean infoshowplus(Map m) {
    return sqlSession.selectOne("Timeline.infoshowplus", m);
  }
}
