package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import com.newface.pro.model.AllimBean;
import com.newface.pro.model.BoardBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.ReplyBean;

public interface MainService {
  public List<BoardBean> BoardlistAll(String id) throws Exception;


  public List<BoardBean> BoardListPlus(Map m) throws Exception;


  public List<ReplyBean> ReplyShow(Map m) throws Exception;


  public void insertBoard(BoardBean b) throws Exception;


  public List<ReplyBean> ReplyShowPlus(Map m) throws Exception;


  public MemberBean userInfo(String id) throws Exception;


  public List<BoardBean> get_board(Map m) throws Exception;


  public int count_bn(String id) throws Exception;


  public int count_rn(Map m) throws Exception;


  public void insertreply(ReplyBean rb) throws Exception;


  public List<ReplyBean> get_reply(Map m) throws Exception;


  public void updatelike_date(Map m) throws Exception;


  public void refEdit(ReplyBean rb) throws Exception;


  public void re_replyInsert(ReplyBean rb) throws Exception;


  public List<ReplyBean> re_replyshow(Map m) throws Exception;


  public void updatelike_count(Map m) throws Exception;


  public void updateboard_like(Map m) throws Exception;


  public int checkboard_like(Map m) throws Exception;


  public void like_status_on(Map m) throws Exception;


  public void like_status_off(Map m) throws Exception;


  public void insertBoard_like(BoardBean b) throws Exception;


  public List<FriendListBean> getFriends(String id) throws Exception;


  public List<MemberBean> getmemberinfo(String id) throws Exception;

  // 좋아요 알림
  public void like_allim(AllimBean allim);

  // 댓글 등록 알림
  public void reply_allim(AllimBean allim);


  public void insertshare(Map m2) throws Exception;


  public BoardBean one_board(Map m) throws Exception;


  public void deleteshareboard(Map m) throws Exception;


  public void deleteboard(Map m) throws Exception;


  public void updatelike_count_down(Map m) throws Exception;

  // 메인용 친구요청 가져오기
  public List<MemberBean> getFriend_request(String id);

  // 메인용 매칭요청 가져오기
  public List<MemberBean> getMfriend_request(String id);

}
