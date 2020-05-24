package com.newface.pro.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newface.pro.model.AllimBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.WsBean;
import com.newface.pro.model.mfriendBean;

@Repository
public class MemberDAOImpl {
  @Autowired
  private SqlSessionTemplate sqlSession;

  /* 회원저장 */
  public int insertMember(MemberBean m) {
    return sqlSession.insert("insertMember", m);
  }

  // 가입된 회원인지 조회
  public MemberBean userCheck(String id) {
    MemberBean m = (MemberBean) sqlSession.selectOne("login_check", id);
    return m;
  }

  /* 회원삭제 */
  public void deleteMember(MemberBean delm) throws Exception {}

  /* 회원수정 */
  public void updateMember(MemberBean m) {
    sqlSession.update("member_update", m);
  }

  /* 아이디 찾기 */
  public List<MemberBean> searchMember(String id) throws Exception {
    return null;
  }

  // 멤버 검색
  public List<MemberBean> member_search(Map<String, String> map) {
    return sqlSession.selectList("member_search", map);
  }

  // 인증키 생성
  public void createAuthKey(String id, String authKey) throws Exception { // 인증키 DB에 넣기
    Map<String, Object> map = new HashMap<String, Object>();

    map.put("id", id);
    map.put("authKey", authKey);

    sqlSession.insert("createAuthKey", map);
  }

  // 인증키 대조를 위한 멤버용 인증키 얻어오기
  public String getAuthKey(String id) {
    return sqlSession.selectOne("getAuthKey", id);
  }

  // 인증 후 로그인 가능한 상태로 변경
  public void userAuth(String id) {
    sqlSession.update("userAuth", id);
  }

  // 친구 요청 테이블에 값 저장
  public void friend_request(FriendRequestBean frBean) {
    sqlSession.insert("friend_request", frBean);
  }

  // 알림 테이블에 알림 등록
  public int friend_request_allim(AllimBean allim) {
    return sqlSession.insert("friend_request_allim", allim);
  }

  // 친구 요청 목록 가져오기
  public List<MemberBean> getFriend_request(String id) {
    return sqlSession.selectList("Member.getFriend_request", id);
  }

  // 실제 친구 목록 가져오기
  public List<MemberBean> getFriend_list(String id) {
    return sqlSession.selectList("getFriend_list", id);
  }

  // 친구 요청 수락
  public int friend_accept(FriendListBean flbean) {
    return sqlSession.insert("friend_accept", flbean);
  }

  // 친구 요청 거절
  public void friend_reject(FriendRequestBean frBean) {
    sqlSession.delete("friend_reject", frBean);
  }

  // 친구 삭제
  public void friend_delete(FriendListBean flBean) {
    sqlSession.delete("friend_delete", flBean);
  }

  // 특정 계정의 정보를 모두 가져옴
  public MemberBean getMember(String id) {
    return sqlSession.selectOne("getMember", id);
  }

  // 매칭 친구 검색
  public List<MemberBean> matching_search(Map<String, Object> m) {
    return sqlSession.selectList("matching_search", m);
  }

  public MemberBean findCheck(String phone) {
    MemberBean m = (MemberBean) sqlSession.selectOne("find_check", phone);
    return m;
  }

  public void updatePw(String id, String key) {
    Map<String, Object> map = new HashMap<String, Object>();

    map.put("id", id);
    map.put("key", key);

    sqlSession.update("updatePw", map);
  }

  public void changePw(MemberBean m) {
    sqlSession.update("changePw", m);
  }

  // 채팅
  public MemberBean checkMemberId(String id) throws Exception {
    return (MemberBean) sqlSession.selectOne("login_check", id);
  }

  public List<mfriendBean> mchat(String id1) throws Exception {
    List<mfriendBean> list = sqlSession.selectList("mchat", id1);
    return list;
  }

  public void save(WsBean wsbean) throws Exception {
    sqlSession.insert("insertWsbean", wsbean);
  }

  public List<WsBean> out(WsBean wsbean) {
    List<WsBean> list = sqlSession.selectList("out", wsbean);
    return list;
  }

  public MemberBean mfriend_detail(String id2) {
    MemberBean m = (MemberBean) sqlSession.selectOne("mfriend_detail", id2);
    return m;
  }

  // 공통 관심사 가져오기
  public String member_hobby(String id) {
    return sqlSession.selectOne("member_hobby", id);
  }

  // 로그인 상태
  public void On_Off(MemberBean mb) {
    sqlSession.update("On_Off", mb);
  }

  public WsBean recent(String id1) {
    WsBean m = (WsBean) sqlSession.selectOne("recent", id1);
    return m;
  }

  public mfriendBean mfriend_detail2(Map ms) {
    return sqlSession.selectOne("mfriend_detail2", ms);
  }

  public int mtof(FriendListBean flbean) {
    return sqlSession.selectOne("mtof", flbean);
  }

  public void tofriend(FriendListBean flbean) {
    sqlSession.update("tofriend", flbean);
  }

  public List<Integer> getbn_list(String id) {
    return sqlSession.selectList("getbn_list", id);
  }

  public void insert_likeid(Map<String, Object> m) {
    sqlSession.insert("insert_likeid", m);
  }
}
