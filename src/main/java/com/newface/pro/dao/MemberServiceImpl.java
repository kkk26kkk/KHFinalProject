package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.newface.pro.common.MailHandler;
import com.newface.pro.common.TempKey;
import com.newface.pro.model.AllimBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.WsBean;
import com.newface.pro.model.mfriendBean;

@Service
public class MemberServiceImpl implements MemberService {
  @Autowired
  private MemberDAOImpl memDAO;
  @Autowired
  private JavaMailSender mailSender;
  @Autowired
  BCryptPasswordEncoder passwordEncoder;

  // 회원 가입
  @Transactional
  @Override
  public void insertMember(MemberBean m) throws Exception {
    // int result = memDAO.insertMember(m);
    memDAO.insertMember(m);

    // 인증키 생성
    String key = new TempKey().getKey(15, false);
    memDAO.createAuthKey(m.getId(), key);

    // 메일 보내기
    MailHandler sendMail = new MailHandler(mailSender);
    sendMail.setSubject("[Newface] 이메일 인증입니다.");
    sendMail.setText(new StringBuffer().append("<h2>이메일 인증</h2>").append("<span>인증키 : <strong>")
        .append(key).append("<strong></span>").toString());
    sendMail.setFrom("kkk26kkk@naver.com", "박주형");
    sendMail.setTo(m.getId());
    sendMail.send();
  }

  // 인증키 대조를 위한 멤버용 인증키 얻어오기
  @Override
  public String getAuthKey(String id) {
    return memDAO.getAuthKey(id);
  }

  // 인증 후 로그인 가능한 상태로 변경
  @Override
  public void userAuth(String id) {
    try {
      memDAO.userAuth(id);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }


  // 로그인 - 가입된 회원인지 조회
  @Override
  public MemberBean userCheck(String id) throws Exception {
    return memDAO.userCheck(id);
  }

  // 회원 삭제
  @Override
  public void deleteMember(MemberBean delm) throws Exception {
    // TODO Auto-generated method stub

  }

  // 회원 정보 수정
  @Override
  public void updateMember(MemberBean member) {
    memDAO.updateMember(member);
  }

  // 아이디 찾기
  @Override
  public List<MemberBean> searchMember(String id) throws Exception {
    // TODO Auto-generated method stub
    return null;
  }

  // 멤버 검색
  @Override
  public List<MemberBean> member_search(Map<String, String> map) {
    return memDAO.member_search(map);
  }

  // 친구 요청 테이블에 값 저장
  @Override
  public void friend_request(FriendRequestBean frBean) {
    memDAO.friend_request(frBean);
  }

  // 알림 테이블에 알림 등록
  @Override
  public int friend_request_allim(AllimBean allim) {
    return memDAO.friend_request_allim(allim);
  }

  // 친구 요청 목록 가져오기
  @Override
  public List<MemberBean> getFriend_request(String id) {
    return memDAO.getFriend_request(id);
  }

  // 실제 친구 목록 가져오기
  @Override
  public List<MemberBean> getFriend_list(String id) {
    return memDAO.getFriend_list(id);
  }

  // 친구 요청 수락
  @Override
  public int friend_accept(FriendListBean flbean) {
    return memDAO.friend_accept(flbean);
  }

  // 친구 요청 거절
  @Override
  public void friend_reject(FriendRequestBean frBean) {
    memDAO.friend_reject(frBean);
  }

  // 친구 삭제
  @Override
  public void friend_delete(FriendListBean flBean) {
    memDAO.friend_delete(flBean);
  }

  // 특정 계정의 정보를 모두 가져옴
  @Override
  public MemberBean getMember(String id) {
    return memDAO.getMember(id);
  }

  // 매칭 친구 검색
  @Override
  public List<MemberBean> matching_search(Map<String, Object> m) {
    return memDAO.matching_search(m);
  }

  // 휴대폰번호로 조회
  @Override
  public MemberBean findCheck(String phone) throws Exception {
    return memDAO.findCheck(phone);
  }

  // 임시 비밀번호
  @Override
  public void updatePw(MemberBean m) throws Exception {

    // 인증키 생성
    String key = new TempKey().getKey(8, false);
    String encPassword = passwordEncoder.encode(key);
    memDAO.updatePw(m.getId(), encPassword);

    // 메일 보내기
    MailHandler sendMail = new MailHandler(mailSender);
    sendMail.setSubject("[Newface] 이메일 인증입니다.");
    sendMail.setText(new StringBuffer().append("<h2>임시 비밀번호 발급</h2>")
        .append("<span>비밀번호 : <strong>").append(key).append("<strong></span>").toString());
    sendMail.setFrom("kkk26kkk@naver.com", "박주형");
    sendMail.setTo(m.getId());
    sendMail.send();

  }

  // 비밀번호 변경
  @Override
  public void changePw(MemberBean m) throws Exception {
    memDAO.changePw(m);
  }


  // 채팅
  @Override
  public int checkMemberId(String id) throws Exception {
    int re = -1;
    MemberBean mb = memDAO.checkMemberId(id);
    if (mb != null)
      re = 1;
    return re;
  }

  public List<mfriendBean> mchat(String id1) throws Exception {
    return memDAO.mchat(id1);
  }

  public void save(WsBean wsbean) throws Exception {
    memDAO.save(wsbean);
  }

  public List<WsBean> out(WsBean wsbean) throws Exception {
    return memDAO.out(wsbean);
  }

  public MemberBean mfriend_detail(String id2) throws Exception {
    return memDAO.mfriend_detail(id2);
  }

  @Override
  public String member_hobby(String id) {
    return memDAO.member_hobby(id);
  }

  @Override
  public void On_Off(MemberBean mb) throws Exception {
    memDAO.On_Off(mb);
  }

  @Override
  public WsBean recent(String id1) throws Exception {
    return memDAO.recent(id1);
  }

  @Override
  public mfriendBean mfriend_detail2(Map ms) throws Exception {
    return memDAO.mfriend_detail2(ms);
  }

  public int mtof(FriendListBean flbean) {
    return memDAO.mtof(flbean);
  }

  public void tofriend(FriendListBean flbean) {
    memDAO.tofriend(flbean);
  }

  @Override
  public List<Integer> getbn_list(String id) {
    return memDAO.getbn_list(id);
  }

  @Override
  public void insert_likeid(Map<String, Object> m) {
    memDAO.insert_likeid(m);
  }
}
