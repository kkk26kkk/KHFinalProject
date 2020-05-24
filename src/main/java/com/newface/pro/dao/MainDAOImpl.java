package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newface.pro.model.AllimBean;
import com.newface.pro.model.BoardBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.ReplyBean;

@Repository
public class MainDAOImpl {
  @Autowired
  private SqlSessionTemplate sqlsession;

  public List<BoardBean> BoardlistAll(String id) {
    return sqlsession.selectList("Main.listAll", id);
  }

  public List<BoardBean> BoardListPlus(Map m) {
    return sqlsession.selectList("Main.listPlus", m);
  }

  public List<ReplyBean> ReplyShow(Map m) {
    return sqlsession.selectList("Main.ReplyShow", m);
  }

  public void insertBoard(BoardBean b) {
    sqlsession.insert("Main.insertBoard", b);
  }

  public List<ReplyBean> ReplyShowPlus(Map m) {
    return sqlsession.selectList("Main.ReplyShowPlus", m);
  }

  public MemberBean userInfo(String id) {
    return sqlsession.selectOne("Main.userInfo", id);
  }

  public List<BoardBean> get_board(Map m) {
    return sqlsession.selectList("Main.get_board", m);
  }

  public int count_bn(String id) {
    return sqlsession.selectOne("Main.count_bn", id);
  }

  public int count_rn(Map m) {
    return sqlsession.selectOne("Main.count_rn", m);
  }

  public void insertreply(ReplyBean rb) {
    sqlsession.selectOne("Main.insertReply", rb);
  }

  public List<ReplyBean> get_reply(Map m) {
    return sqlsession.selectList("Main.get_reply", m);
  }

  public void updatelike_date(Map m) {
    sqlsession.update("Main.updatelike_date", m);
  }

  public void getrefEdit(ReplyBean rb) {
    sqlsession.update("Main.reply_level", rb);
  }

  public void re_replyInsert(ReplyBean rb) {
    sqlsession.insert("Main.re_replyInsert", rb);
  }

  public List<ReplyBean> re_replyshow(Map m) {
    return sqlsession.selectList("Main.re_replyshow", m);
  }

  public void updatelike_count(Map m) {
    sqlsession.update("Main.updatelike_count", m);
  }

  public void updateboard_like(Map m) {
    sqlsession.insert("Main.updateboard_like", m);
  }

  public int checkboard_like(Map m) {
    return sqlsession.selectOne("Main.checkboard_like", m);
  }

  public void status_on(Map m) {
    sqlsession.update("Main.status_on", m);
  }

  public void status_off(Map m) {
    sqlsession.update("Main.status_off", m);
  }

  public void insertboard_like(BoardBean b) {
    sqlsession.insert("Main.insertboard_like_init", b);
  }

  public List<FriendListBean> getFriends(String id) {
    return sqlsession.selectList("Main.getFriends", id);
  }

  public List<MemberBean> getmemberinfo(String id) {
    return sqlsession.selectList("Main.getmemberinfo", id);
  }

  public void updatelike_count_down(Map m) {
    sqlsession.update("Main.updatelike_count_down", m);
  }

  public void deleteboard(Map m) {
    sqlsession.delete("Main.deleteboard", m);
  }

  public BoardBean one_board(Map m) {
    return sqlsession.selectOne("Main.one_board", m);
  }

  public void insertshare(Map m) {
    sqlsession.insert("Main.insertshare", m);
  }

  public void deleteshareboard(Map m) {
    sqlsession.delete("Main.deleteshareboard", m);
  }



  // 좋아요 알림
  public void like_allim(AllimBean allim) {
    sqlsession.insert("like_allim", allim);
  }

  // 댓글 등록 알림
  public void reply_allim(AllimBean allim) {
    sqlsession.insert("reply_allim", allim);
  }

  // 메인용 친구요청 가져오기
  public List<MemberBean> getFriend_request(String id) {
    return sqlsession.selectList("Main.getFriend_request", id);
  }

  // 메인용 매칭요청 가져오기
  public List<MemberBean> getMfriend_request(String id) {
    return sqlsession.selectList("Main.getMfriend_request", id);
  }

}
