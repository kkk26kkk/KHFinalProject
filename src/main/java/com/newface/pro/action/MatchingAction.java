package com.newface.pro.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.newface.pro.common.GetAge;
import com.newface.pro.dao.MatchingService;
import com.newface.pro.dao.MemberService;
import com.newface.pro.model.AllimBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;

@Controller
public class MatchingAction {
  @Autowired
  private MatchingService matchingService;
  @Autowired
  private MemberService memberService;

  // 매칭 페이지 이동 - 특정 멤버의 정보를 넘겨줌
  @RequestMapping(value = "matching.nf")
  public String matching_friend_list(HttpServletRequest request, HttpServletResponse response,
      Model m) {
    response.setContentType("text/html; charset=utf-8");

    String id = (String) request.getSession().getAttribute("id");

    MemberBean member = memberService.getMember(id);

    // 추가 정보 없으면 back
    if (member.getM_flag() == null) {
      PrintWriter out;
      try {
        out = response.getWriter();
        out.println("<script>");
        out.println("alert('추가 정보를 먼저 등록해주세요.');");
        out.println("history.back()");
        out.println("</script>");
        out.close();
        return null;
      } catch (IOException e) {
        e.printStackTrace();
      }
    } /** 매칭 허용 여부 '2'면 back - "허용을 선택해주세요" **/

    // 매칭 페이지 처음 들어갔을 때 멤버의 관심사와 일치하는 타 멤버들 조회
    String[] m_hobby = member.getM_hobby().split(",");
    for (int i = 0; i < m_hobby.length; i++) {
      m_hobby[i] = "'%" + m_hobby[i] + "%'";
    }

    Map<String, Object> search_map = new HashMap<>();
    search_map.put("id", id);
    search_map.put("m_hobby", m_hobby);

    List<MemberBean> m_list = matchingService.matching_search(search_map);

    for (MemberBean list_mem : m_list) {
      list_mem.setBirth(GetAge.getAge(list_mem.getBirth().substring(0, 4)));
    }

    m.addAttribute("m", member); // 현재 로그인 회원의 정보(관심사 등)
    m.addAttribute("m_list", m_list); // 매칭 페이지 로딩 시 관심사 일치하는 멤버 리스트

    return "matching/matching";
  }

  @RequestMapping("/matchinglist")
  public String matching_list(HttpServletRequest request, HttpServletResponse response, Model m) {
    response.setContentType("text/html; charset=utf-8");

    String id = (String) request.getSession().getAttribute("id");

    MemberBean member = memberService.getMember(id);

    // 추가 정보 없으면 back
    if (member.getM_flag() == null) {
      PrintWriter out;
      try {
        out = response.getWriter();
        out.println("<script>");
        out.println("alert('추가 정보를 먼저 등록해주세요.');");
        out.println("history.back()");
        out.println("</script>");
        out.close();
        return null;
      } catch (IOException e) {
        e.printStackTrace();
      }
    } /** 매칭 허용 여부 '2'면 back - "허용을 선택해주세요" **/

    // 매칭 요청, 친구 목록 가져오기
    List<MemberBean> m_req_list = matchingService.getMfriend_request(id);
    for (MemberBean list_reqmem : m_req_list) {
      list_reqmem.setBirth(GetAge.getAge(list_reqmem.getBirth().substring(0, 4)));
    }
    List<MemberBean> m_f_list = matchingService.getMfriend_list(id);
    for (MemberBean list_fmem : m_f_list) {
      list_fmem.setBirth(GetAge.getAge(list_fmem.getBirth().substring(0, 4)));
    }

    m.addAttribute("m_req_list", m_req_list);
    m.addAttribute("m_f_list", m_f_list);

    return "matching/matching_list";
  }

  // 매칭 친구 검색
  @RequestMapping(value = "matching_search.nf", method = RequestMethod.POST)
  @ResponseBody
  public Object matching_search(HttpServletRequest request, HttpServletResponse response) {
    String sido = request.getParameter("sido");
    String sigungu = request.getParameter("sigungu");
    String[] m_hobby = request.getParameterValues("m_hobby");
    String m_age = request.getParameter("m_age");
    String m_gender = request.getParameter("m_gender");


    if (sigungu == " " || !sigungu.equals("전체") || sigungu != null) {
      for (int i = 0; i < m_hobby.length; i++) {
        m_hobby[i] = "'%" + m_hobby[i] + "%'";
      }
    }

    Map<String, Object> m = new HashMap<String, Object>();
    m.put("id", (String) request.getSession().getAttribute("id"));

    if (!sido.equals("전국")) {
      m.put("sido", sido);
      m.put("sigungu", sigungu);
    }
    if (sigungu.equals("전체")) {
      m.remove("sigungu");
    }
    if (!m_age.equals("전 연령")) {
      m.put("m_age", m_age);
    }
    if (!m_gender.equals("모두")) {
      m.put("m_gender", m_gender);
    }
    m.put("m_hobby", m_hobby);

    List<MemberBean> m_list = matchingService.matching_search(m);
    for (MemberBean list_mem : m_list) {
      list_mem.setBirth(GetAge.getAge(list_mem.getBirth().substring(0, 4)));
    }

    return m_list;
  }

  // 매칭 친구 요청
  @RequestMapping(value = "matching_request.nf")
  public void matching_request(@RequestParam("a_flag") String a_flag,
      @RequestParam("m_friend") String m_friend, @RequestParam("request_id") String request_id,
      @RequestParam("accept_id") String accept_id) {

    // 친구 요청 테이블에 값 저장
    FriendRequestBean frBean = new FriendRequestBean();
    frBean.setRequest_id(request_id);
    frBean.setAccept_id(accept_id);
    frBean.setM_friend(Integer.parseInt(m_friend));
    memberService.friend_request(frBean);

    // 알림 테이블에 알림 등록
    AllimBean allim = new AllimBean();
    allim.setA_flag(Integer.parseInt(a_flag));
    allim.setId(request_id);
    allim.setAccept_id(accept_id); // 수락자 아이디

    memberService.friend_request_allim(allim);
  }

  // 매칭 요청 수락
  @RequestMapping(value = "/matching_accept")
  @ResponseBody
  public Object matching_accept(FriendListBean flBean) {
    int result = matchingService.matching_accept(flBean);

    return result;
  }

  // 매칭 요청 거절
  @RequestMapping(value = "/matching_reject")
  public void matching_reject(FriendRequestBean frBean) {
    matchingService.matching_reject(frBean);
  }

  // 매칭 친구 삭제
  @RequestMapping(value = "/matching_delete")
  public void matching_delete(FriendListBean flBean) {
    matchingService.matching_delete(flBean);
  }
}
