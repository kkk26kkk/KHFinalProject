package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;

@Service
public class MatchingServiceImpl implements MatchingService {
  @Autowired
  private MatchingDAOImpl matchingDAO;

  // 매칭 친구 검색
  @Override
  public List<MemberBean> matching_search(Map<String, Object> m) {
    return matchingDAO.matching_serach(m);
  }

  // 매칭 요청 목록 가져오기
  @Override
  public List<MemberBean> getMfriend_request(String id) {
    return matchingDAO.getMfriend_request(id);
  }

  // 매칭 친구 목록 가져오기
  @Override
  public List<MemberBean> getMfriend_list(String id) {
    return matchingDAO.getMfriend_list(id);
  }

  // 매칭 요청 수락
  @Override
  public int matching_accept(FriendListBean flBean) {
    return matchingDAO.matching_accept(flBean);
  }

  // 매칭 요청 거절
  @Override
  public void matching_reject(FriendRequestBean frBean) {
    matchingDAO.matching_reject(frBean);
  }

  // 매칭 친구 삭제
  @Override
  public void matching_delete(FriendListBean flBean) {
    matchingDAO.matching_delete(flBean);
  }

}
