package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newface.pro.model.AllimBean;
import com.newface.pro.model.BoardBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.ReplyBean;

@Service
public class MainServiceImpl implements MainService {
  @Autowired
  private MainDAOImpl mainDAO;

  // 처음 페이지 게시글 리스트
  @Override
  public List<BoardBean> BoardlistAll(String id) throws Exception {
    return mainDAO.BoardlistAll(id);
  }

  // 스크롤시 게시글 보이기
  @Override
  public List<BoardBean> BoardListPlus(Map m) throws Exception {
    return mainDAO.BoardListPlus(m);
  }

  // 버튼 클릭시 리플 보기
  @Override
  public List<ReplyBean> ReplyShow(Map m) throws Exception {
    return mainDAO.ReplyShow(m);
  }

  // 게시글 추가
  @Override
  public void insertBoard(BoardBean b) throws Exception {
    mainDAO.insertBoard(b);
  }

  // 댓글 플러스
  @Override
  public List<ReplyBean> ReplyShowPlus(Map m) throws Exception {
    return mainDAO.ReplyShowPlus(m);
  }

  // 세션 정보 가져오기
  @Override
  public MemberBean userInfo(String id) throws Exception {
    return mainDAO.userInfo(id);
  }

  // 게시글 하나보기
  @Override
  public List<BoardBean> get_board(Map m) throws Exception {
    return mainDAO.get_board(m);
  }

  // board_no 최대값 구하기
  @Override
  public int count_bn(String id) throws Exception {
    return mainDAO.count_bn(id);
  }

  // reply_no 최대값 구하기
  @Override
  public int count_rn(Map m) throws Exception {
    return mainDAO.count_rn(m);
  }

  // 댓글 추가
  @Override
  public void insertreply(ReplyBean rb) throws Exception {
    mainDAO.insertreply(rb);
  }

  // 리플 하나보기
  @Override
  public List<ReplyBean> get_reply(Map m) throws Exception {
    return mainDAO.get_reply(m);
  }

  // like_date 수정
  @Override
  public void updatelike_date(Map m) throws Exception {
    mainDAO.updatelike_date(m);
  }

  // ref 레벨증가
  @Override
  public void refEdit(ReplyBean rb) throws Exception {
    mainDAO.getrefEdit(rb);
  }

  // 답글 등록
  @Override
  public void re_replyInsert(ReplyBean rb) throws Exception {
    mainDAO.re_replyInsert(rb);
  }

  // 댓글의 댓글보기
  @Override
  public List<ReplyBean> re_replyshow(Map m) throws Exception {
    return mainDAO.re_replyshow(m);
  }

  // like_count 증가
  @Override
  public void updatelike_count(Map m) throws Exception {
    mainDAO.updatelike_count(m);

  }

  // board_like 추가
  @Override
  public void updateboard_like(Map m) throws Exception {
    mainDAO.updateboard_like(m);
  }

  // 좋아요 확인
  @Override
  public int checkboard_like(Map m) throws Exception {
    return mainDAO.checkboard_like(m);
  }

  // 좋아요 ON
  @Override
  public void like_status_on(Map m) throws Exception {
    mainDAO.status_on(m);
  }

  // 좋아요 OFF
  @Override
  public void like_status_off(Map m) throws Exception {
    mainDAO.status_off(m);
  }

  // 게시물 등록시 board_like insert
  @Override
  public void insertBoard_like(BoardBean b) throws Exception {
    mainDAO.insertboard_like(b);
  }

  // 친구 구해오기
  @Override
  public List<FriendListBean> getFriends(String id) throws Exception {
    return mainDAO.getFriends(id);
  }

  // 친구 정보 가져오기
  @Override
  public List<MemberBean> getmemberinfo(String id) throws Exception {
    return mainDAO.getmemberinfo(id);
  }

  // 좋아요 다운
  @Override
  public void updatelike_count_down(Map m) throws Exception {
    mainDAO.updatelike_count_down(m);

  }

  // 게시글 삭제
  @Override
  public void deleteboard(Map m) throws Exception {
    mainDAO.deleteboard(m);
  }

  // 게시글 삭제하기위한 하나 가져오기
  @Override
  public BoardBean one_board(Map m) throws Exception {
    return mainDAO.one_board(m);
  }

  // 공유하기 shareinsert
  @Override
  public void insertshare(Map m) throws Exception {
    mainDAO.insertshare(m);
  }

  // 원본글 삭제시 공유한 글 삭제
  @Override
  public void deleteshareboard(Map m) throws Exception {
    mainDAO.deleteshareboard(m);
  }

  // 좋아요 알림
  @Override
  public void like_allim(AllimBean allim) {
    mainDAO.like_allim(allim);
  }

  // 댓글 등록 알림
  @Override
  public void reply_allim(AllimBean allim) {
    mainDAO.reply_allim(allim);
  }

  // 메인용 친구요청 가져오기
  @Override
  public List<MemberBean> getFriend_request(String id) {
    return mainDAO.getFriend_request(id);
  }

  // 메인용 매칭요청 가져오기
  @Override
  public List<MemberBean> getMfriend_request(String id) {
    return mainDAO.getMfriend_request(id);
  }

}
