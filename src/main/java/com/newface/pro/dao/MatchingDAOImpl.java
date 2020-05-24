package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;


@Repository
public class MatchingDAOImpl {
  @Autowired
  private SqlSessionTemplate sqlSession;

  // 매칭 친구 검색
  public List<MemberBean> matching_serach(Map<String, Object> m) {
    return sqlSession.selectList("matching_search", m);
  }

  // 매칭 요청 목록 가져오기
  public List<MemberBean> getMfriend_request(String id) {
    return sqlSession.selectList("Matching.getMfriend_request", id);
  }

  // 매칭 친구 목록 가져오기
  public List<MemberBean> getMfriend_list(String id) {
    return sqlSession.selectList("getMfriend_list", id);
  }

  // 매칭 요청 수락
  public int matching_accept(FriendListBean frBean) {
    return sqlSession.insert("matching_accept", frBean);
  }

  // 매칭 요청 거절
  public void matching_reject(FriendRequestBean frBean) {
    sqlSession.delete("matching_reject", frBean);
  }

  // 매칭 친구 삭제
  public void matching_delete(FriendListBean flBean) {
    sqlSession.delete("matching_delete", flBean);
  }

}
