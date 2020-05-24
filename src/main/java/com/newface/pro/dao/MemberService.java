package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import com.newface.pro.model.AllimBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.WsBean;
import com.newface.pro.model.mfriendBean;

public interface MemberService {
  /* 회원등록 */
  // public int insertMember(MemberBean m) throws Exception;
  public void insertMember(MemberBean m) throws Exception;

  // 인증키 대조를 위한 멤버용 인증키 얻어오기
  public String getAuthKey(String id);

  // 인증 후 로그인 가능한 상태로 변경
  public void userAuth(String id);

  // 가입된 회원인지 조회
  public MemberBean userCheck(String id) throws Exception;

  /* 회원삭제 */
  public void deleteMember(MemberBean delm) throws Exception;

  /* 회원수정 */
  public void updateMember(MemberBean member);

  /* 아이디 찾기 */
  public List<MemberBean> searchMember(String id) throws Exception;

  // 멤버 검색
  public List<MemberBean> member_search(Map<String, String> map);

  // 친구 요청 - 친구 요청 테이블에 값 저장
  public void friend_request(FriendRequestBean frBean);

  // 친구 요청 - 알림 테이블에 값 저장
  public int friend_request_allim(AllimBean allim);

  // 친구 요청 목록 가져오기
  public List<MemberBean> getFriend_request(String id);

  // 실제 친구 목록 가져오기
  public List<MemberBean> getFriend_list(String id);

  // 친구 요청 수락
  public int friend_accept(FriendListBean flbean);

  // 친구 요청 거절
  public void friend_reject(FriendRequestBean frBean);

  // 친구 삭제
  public void friend_delete(FriendListBean flBean);

  // 특정 계정의 정보를 모두 가져옴
  public MemberBean getMember(String id);

  // 매칭 친구 검색
  public List<MemberBean> matching_search(Map<String, Object> m);


  /* 번호로 계정 체크 */
  public MemberBean findCheck(String phone) throws Exception;

  // 임시 비밀번호
  public void updatePw(MemberBean m) throws Exception;

  public void changePw(MemberBean m) throws Exception;

  // 채팅
  public int checkMemberId(String id) throws Exception; // 필요없을수도

  public List<mfriendBean> mchat(String id1) throws Exception;

  public void save(WsBean wsbean) throws Exception;

  public List<WsBean> out(WsBean wsbean) throws Exception;

  public MemberBean mfriend_detail(String id2) throws Exception;

  // 공통 관심사 가져오기
  public String member_hobby(String id);

  public WsBean recent(String id1) throws Exception;

  public mfriendBean mfriend_detail2(Map ms) throws Exception;

  // 로그인 상태 표시
  public void On_Off(MemberBean mb) throws Exception;

  public int mtof(FriendListBean flbean);

  public void tofriend(FriendListBean flbean);

  public List<Integer> getbn_list(String id);

  public void insert_likeid(Map<String, Object> m);

}
