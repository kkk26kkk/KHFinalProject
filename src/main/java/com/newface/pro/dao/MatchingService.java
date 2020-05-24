package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;


public interface MatchingService {
  // 매칭 친구 검색
  public List<MemberBean> matching_search(Map<String, Object> m);

  // 매칭 요청 목록 가져오기
  public List<MemberBean> getMfriend_request(String id);

  // 매칭 친구 목록 가져오기
  public List<MemberBean> getMfriend_list(String id);

  // 매칭 요청 수락
  public int matching_accept(FriendListBean flBean);

  // 매칭 요청 거절
  public void matching_reject(FriendRequestBean frBean);

  // 매칭 친구 삭제
  public void matching_delete(FriendListBean flBean);

}
