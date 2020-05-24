package com.newface.pro.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.newface.pro.common.GetAge;
import com.newface.pro.dao.MemberService;
import com.newface.pro.model.AllimBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.FriendRequestBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.WsBean;
import com.newface.pro.model.mfriendBean;

@Controller
public class MemberAction {
  @Autowired
  private MemberService memberService;

  // 비밀번호 암호화 위한 의존성 주입
  @Autowired
  private BCryptPasswordEncoder passwordEncoder;

  // 배경 사진 폴더 경로
  private String profileImageFolder =
      "C:\\Users\\user1\\git\\FinalProject\\FinalProject\\src\\main\\webapp\\resources\\upload\\profileimg";
  // private String profileImageFolder = "/var/lib/tomcat8/webapps/pro/resources/upload/profileimg";

  // 프로필 사진 폴더 경로
  private String backgroundImageFolder =
      "C:\\Users\\user1\\git\\FinalProject\\FinalProject\\src\\main\\webapp\\resources\\upload\\backgroundimg";
  // private String backgroundImageFolder =
  // "/var/lib/tomcat8/webapps/pro/resources/upload/backgroundimg";

  // 로그인 회원가입 페이지로 이동
  @RequestMapping(value = "member_login.nf")
  public ModelAndView join(ModelAndView mv, MemberBean m, HttpServletRequest request,
      @CookieValue(value = "saveid", required = false) Cookie readCookie) throws Exception {

    if (readCookie != null) {
      mv.addObject("saveid", readCookie.getValue());
      mv.setViewName("member/member_login");

      m = memberService.userCheck(readCookie.getValue());

      // System.out.println("saveid = " + readCookie.getValue());
      // System.out.println("Name = " + m.getName());
      // System.out.println("img = " + m.getProf_img());

      mv.addObject("m", m);
    } else {
      mv.setViewName("member/member_login");
    }
    return mv;
  }

  // 회원 가입 처리
  @RequestMapping(value = "/member_join_ok.nf", method = RequestMethod.POST)
  public void join_ok(MemberBean m, HttpServletResponse response) throws Exception {
    PrintWriter out = response.getWriter();
    response.setContentType("text/html; charset=utf-8");

    // 비밀번호 암호화
    String encPassword = passwordEncoder.encode(m.getPw());
    m.setPw(encPassword);

    // 프로필, 배경 사진 기본 이미지로 자동 저장
    m.setProf_img_file("/human.jpg");
    m.setBg_img_file("/blackbg.jpg");

    memberService.insertMember(m); /** 회원 가입 후 생성된 인증키 지워야함. 방법 생각 **/

    out.println("<script>");
    out.println("alert('이메일로 인증키가 전송되었습니다. 확인해주세요.');");
    out.println("location.href='email_confirm.nf?id=" + m.getId() + "';");
    out.println("</script>");
  }

  // 이메일 인증 페이지 이동
  @RequestMapping(value = "email_confirm.nf", method = RequestMethod.GET)
  public ModelAndView email_confirm(@RequestParam("id") String id) {

    ModelAndView mv = new ModelAndView("member/email_confirm");
    mv.addObject("id", id);

    return mv;
  }

  // 이메일 인증 처리
  @RequestMapping(value = "email_confirm_ok.nf", method = RequestMethod.POST)
  public void email_confirm_ok(@RequestParam("id") String id,
      @RequestParam("authkey") String authkey, HttpServletResponse response) {

    response.setContentType("text/html; charset=utf-8");

    String m_authkey = memberService.getAuthKey(id);

    if (m_authkey.equals(authkey)) {
      try {
        memberService.userAuth(id); // 인증 가능 상태로 변경
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('인증에 성공하였습니다. 환영합니다.');");
        out.println("location.href='member_login.nf';");
        out.println("</script>");
      } catch (IOException e) {
        e.printStackTrace();
      }
    } else {
      try {
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('인증에 실패하였습니다. 인증키를 확인해주세요.');");
        out.println("history.back();");
        out.println("</script>");
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  // 로그인
  @RequestMapping(value = "member_login_ok.nf", method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView login_ok(HttpServletRequest request, HttpServletResponse response)
      throws Exception {

    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();

    HttpSession session = request.getSession();

    String id = request.getParameter("id").trim();
    String pw = request.getParameter("pw").trim();

    MemberBean m = this.memberService.userCheck(id); // 가입된 회원인지 조회

    if (m == null) {
      out.println("<script>");
      out.println("alert('등록되지 않은 회원입니다!')");
      out.println("history.back()");
      out.println("</script>");
    } else {
      // if (m.getPw().equals(pw)) {
      if (passwordEncoder.matches(pw, m.getPw())) {
        session.setAttribute("id", id);
        session.setAttribute("s_m", m);

        Cookie savecookie = new Cookie("saveid", id);
        if (request.getParameter("id") != null) {
          savecookie.setMaxAge(60 * 60 * 24 * 2); // 7일정도 유지시간 설정
          System.out.println("쿠키저장 : 60*60*24*2");
        } else {
          System.out.println("쿠키저장 : 0");
          savecookie.setMaxAge(0);
        }
        response.addCookie(savecookie);
        // addCookie해야 쿠키에 저장이된다.

        // 추가
        MemberBean mb = new MemberBean();
        mb.setId(id);
        mb.setOn_off(2);
        memberService.On_Off(mb);

        out.println("<script>");
        out.println("alert('로그인 되었습니다');");
        out.println("location.href='main.nf';");
        out.println("</script>");
        return null;
      } else {
        out.println("<script>");
        out.println("alert('비번이 다릅니다!')");
        out.println("history.go(-1)");
        out.println("</script>");
      }
    }

    return null;
  }

  // 쿠키 삭제 처리
  @RequestMapping(value = "cookieDel.nf")
  public void cookieDel(@CookieValue(value = "saveid", required = false) Cookie readCookie,
      HttpServletResponse response) {
    readCookie.setMaxAge(0);
    response.addCookie(readCookie);
  }

  // 멤버 검색
  @RequestMapping(value = "member_search.nf", method = RequestMethod.POST)
  public ModelAndView friend_search(HttpServletRequest request,
      @RequestParam("name_phone") String name_phone) {

    Map<String, String> map = new HashMap<>();
    map.put("id", (String) request.getSession().getAttribute("id")); // 접속자 id
    map.put("name_phone", name_phone.replaceAll("-", "")); // 검색하는 이름 또는 번호

    // List<MemberBean> mem_search_list = memberService.member_search(name_phone.replaceAll("-",
    // ""));
    List<MemberBean> mem_search_list = memberService.member_search(map);
    for (MemberBean list_mem : mem_search_list) {
      list_mem.setBirth(list_mem.getBirth().substring(0, 4));
    }

    ModelAndView mv = new ModelAndView("member/member_search");
    mv.addObject("mem_search_list", mem_search_list);
    mv.addObject("name_phone", name_phone);

    return mv;
  }

  // // 친구 요청 (알림 + 요청 테이블에 값 저장)
  // @RequestMapping(value = "friend_request.nf")
  // public void friend_request(@RequestParam("a_flag") String a_flag,
  // @RequestParam("m_friend") String m_friend, @RequestParam("request_id") String request_id,
  // @RequestParam("accept_id") String accept_id) { // 커멘드
  //
  // // 친구 요청 테이블에 값 저장
  // FriendRequestBean frBean = new FriendRequestBean();
  // frBean.setRequest_id(request_id);
  // frBean.setAccept_id(accept_id);
  // frBean.setM_friend(Integer.parseInt(m_friend));
  // memberService.friend_request(frBean);
  //
  // // 알림 테이블에 알림 등록
  // AllimBean allim = new AllimBean();
  // allim.setA_flag(Integer.parseInt(a_flag));
  // allim.setId(request_id);
  // allim.setAccept_id(accept_id); // 수락자 아이디
  //
  // memberService.friend_request_allim(allim);
  // }

  // 친구 요청 (알림 + 요청 테이블에 값 저장)
  @RequestMapping(value = "friend_request.nf")
  public void friend_request(@RequestParam("a_flag") String a_flag,
      @RequestParam("m_friend") String m_friend, @RequestParam("request_id") String request_id,
      @RequestParam("accept_id") String accept_id) { // 커멘드

    // 친구 요청 테이블에 값 저장
    FriendRequestBean frBean = new FriendRequestBean();
    frBean.setRequest_id(request_id);
    frBean.setAccept_id(accept_id);
    frBean.setM_friend(Integer.parseInt(m_friend));
    memberService.friend_request(frBean);

    System.out.println("friendrequest= " + a_flag);
    System.out.println("friendrequest= " + m_friend);
    System.out.println("friendrequest= " + request_id);
    System.out.println("friendrequest= " + accept_id);
    // 알림 테이블에 알림 등록
    AllimBean allim = new AllimBean();
    allim.setA_flag(Integer.parseInt(a_flag));
    allim.setId(request_id);
    allim.setAccept_id(accept_id); // 수락자 아이디

    memberService.friend_request_allim(allim);
    System.out.println("requestallim= " + a_flag);
    System.out.println("friendrequestallim= " + m_friend);
    System.out.println("friendrequestallim= " + request_id);
    System.out.println("friendrequestallim= " + accept_id);
  }

  // 친구 요청 수락
  @RequestMapping(value = "friend_accept.nf")
  @ResponseBody
  public Object friend_accept(FriendListBean flbean) {
    int result = 0;
    int result1;
    result1 = memberService.mtof(flbean);

    List<Integer> getbn_list1 = memberService.getbn_list(flbean.getId1());
    List<Integer> getbn_list2 = memberService.getbn_list(flbean.getId2());
    Map<String, Object> m = new HashMap<>();


    if (result1 > 0) {
      memberService.tofriend(flbean);

      for (int bn : getbn_list1) {
        m.put("id1", flbean.getId1());
        m.put("board_no", bn);
        m.put("id2", flbean.getId2());
        memberService.insert_likeid(m);
      }
      for (int bn : getbn_list2) {
        m.put("id1", flbean.getId2());
        m.put("board_no", bn);
        m.put("id2", flbean.getId1());
        memberService.insert_likeid(m);
      }
    } else {
      result = memberService.friend_accept(flbean);
      if (flbean.getM_friend() == 1) {
        for (int bn : getbn_list1) {
          m.put("id1", flbean.getId1());
          m.put("board_no", bn);
          m.put("id2", flbean.getId2());
          memberService.insert_likeid(m);
        }
        for (int bn : getbn_list2) {
          m.put("id1", flbean.getId2());
          m.put("board_no", bn);
          m.put("id2", flbean.getId1());
          memberService.insert_likeid(m);
        }
      }
    }

    /* 트리거가 실행되어 친구 수락 후 친구 요청 목록에서 아이디 삭제 */

    return result;
  }

  /** 친구 요청 거절 **/
  @RequestMapping(value = "/friend_reject", method = RequestMethod.POST)
  public void friend_reject(FriendRequestBean frBean) {
    memberService.friend_reject(frBean);
  }

  /** 친구 삭제 **/
  @RequestMapping(value = "/friend_delete", method = RequestMethod.POST)
  public void friend_delete(FriendListBean flBean) {
    memberService.friend_delete(flBean);
  }

  // 친구(요청 목록 + 실제 친구 목록) 페이지로 이동
  @RequestMapping(value = "friend.nf")
  public ModelAndView friend(HttpServletRequest request) {
    String id = (String) request.getSession().getAttribute("id");

    // 친구 요청 목록 가져오기
    List<MemberBean> frBean = new ArrayList<MemberBean>();
    frBean = memberService.getFriend_request(id);

    // 실제 친구 목록 가져오기
    List<MemberBean> flBean = new ArrayList<MemberBean>();
    flBean = memberService.getFriend_list(id);

    ModelAndView mv = new ModelAndView("member/friend");
    mv.addObject("frBean", frBean);
    mv.addObject("flBean", flBean);

    return mv;
  }

  // 정보 관리 페이지로 이동
  @RequestMapping(value = "member_info.nf")
  public ModelAndView addInfo(HttpServletRequest request) {
    String id = (String) request.getSession().getAttribute("id");

    MemberBean member = memberService.getMember(id);

    ModelAndView mv = new ModelAndView("member/member_info");
    mv.addObject("m", member);

    return mv;
  }

  // 정보 관리(추가 정보 등록 또는 수정) 처리
  @RequestMapping(value = "member_info_ok.nf", method = RequestMethod.POST)
  public String member_info_ok(MemberBean member, HttpServletRequest request) {
    /** prof, bg img_original 컬럼 없애는거 생각해보자 필요 없어보임 **/
    String id = (String) request.getSession().getAttribute("id");
    member.setId(id);

    // 프로필 사진 파일명 난수화해서 저장
    MultipartFile uploadProfile = member.getProf_img();
    if (!uploadProfile.isEmpty()) {
      // 원래 파일명 구해오기
      String profileFileName = uploadProfile.getOriginalFilename();

      // 원래 파일명 저장
      member.setProf_img_original(profileFileName);

      // DB에 저장할 파일명 구해옴
      String profileDBName = getFileDBName(profileFileName, 1); // 프로필 사진 - flag : 1

      // 업로드한 파일 저장
      try {
        uploadProfile.transferTo(new File(profileImageFolder + profileDBName));
      } catch (IllegalStateException | IOException e) {
        e.printStackTrace();
      }

      member.setProf_img_file(profileDBName);
    } else { // 프로필 사진 선택 안한 경우 기본 사진으로
      member.setProf_img_file("/human.jpg");
    }

    // 배경 사진 파일명 난수화해서 저장
    MultipartFile uploadBackground = member.getBg_img();
    if (!uploadBackground.isEmpty()) {
      // 원래 파일명 구해오기
      String backgroundFileName = uploadBackground.getOriginalFilename();

      // 원래 파일명 저장
      member.setBg_img_original(backgroundFileName);

      // DB에 저장할 파일명 구해옴
      String backgroundDBName = getFileDBName(backgroundFileName, 2); // 배경사진 - flag : 2

      // 업로드한 파일 저장
      try {
        uploadBackground.transferTo(new File(backgroundImageFolder + backgroundDBName));
      } catch (IllegalStateException | IOException e) {
        e.printStackTrace();
      }

      member.setBg_img_file(backgroundDBName);
    } else { // 배경 사진 선택 안한 경우 기본 사진으로
      member.setBg_img_file("/blackbg.jpg");
    }

    // m_age 구하기
    String m_age = GetAge.getM_age(member.getBirth());
    member.setM_age(m_age);

    // 값 수정 처리
    try {
      memberService.updateMember(member);
    } catch (Exception e) {
      e.printStackTrace();
    }

    return "redirect:main.nf";
  }

  // 업로드 파일명 난수화 처리 Spring7
  /** 이 메소드를 따로 모듈화 시키는거 생각해보자 **/
  public String getFileDBName(String fileName, int flag) {
    Calendar c = Calendar.getInstance();
    int year = c.get(Calendar.YEAR);
    int month = c.get(Calendar.MONTH) + 1;
    int date = c.get(Calendar.DATE);

    String imgDir = "";
    if (flag == 1) // 프로필 사진인 경우
      imgDir = profileImageFolder + "/" + year + "-" + month + "-" + date;
    else if (flag == 2) { // 배경 사진인 경우
      imgDir = backgroundImageFolder + "/" + year + "-" + month + "-" + date;
    }

    // 해당 폴더에 file 객체 생성
    File path1 = new File(imgDir);

    if (!path1.isFile())
      System.out.println("파일이 존재하지 않아요.");
    if (!path1.exists()) {
      System.out.println("폴더 만들어요");
      path1.mkdir();
    }

    // 난수 구하기
    Random r = new Random();
    int random = r.nextInt(100000000);

    /* 확장자 구하기 */
    int index = fileName.lastIndexOf(".");

    String fileExtension = fileName.substring(index + 1);
    /* 확장자 구하기 끝 */

    // 새로운 파일명 생성
    String refileName = "";
    if (flag == 1) // 프로필 사진인 경우
      refileName = "profile" + year + month + random + "." + fileExtension;
    else if (flag == 2) // 배경사진인 경우
      refileName = "background" + year + month + random + "." + fileExtension;

    // 오라클 db에 저장될 파일명
    String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;

    return fileDBName;
  }

  // 계정 설정(비밀번호 변경 등) 페이지로 이동
  @RequestMapping(value = "change_pw.nf")
  public ModelAndView updateMember(HttpServletRequest request) {
    String id = (String) request.getSession().getAttribute("id");

    MemberBean member = memberService.getMember(id);

    ModelAndView mv = new ModelAndView("member/member_changepw");
    mv.addObject("m", member);

    return mv;
  }

  // 로그아웃
  @RequestMapping(value = "logout", method = RequestMethod.GET)
  public String logout(HttpServletRequest request) throws Exception {
    HttpSession session = request.getSession(); // 세션 객체 생성
    String id = (String) session.getAttribute("id");

    session.getId();

    MemberBean mb = new MemberBean();
    mb.setId(id);
    mb.setOn_off(1);
    memberService.On_Off(mb);

    request.getSession().invalidate();

    return "redirect:member_login.nf";
  }

  // 임시 비밀번호로 변경
  @RequestMapping(value = "member_find_pw.nf", method = {RequestMethod.POST, RequestMethod.GET})
  public void member_find_pw(MemberBean m, HttpServletResponse response) throws Exception {
    PrintWriter out = response.getWriter();
    response.setContentType("text/html; charset=utf-8");

    System.out.println("ID = " + m.getId());

    memberService.updatePw(m);
    System.out.println("PW = " + m.getPw());

    out.println("<script>");
    out.println("alert('이메일로 인증키가 전송되었습니다. 확인해주세요.');");
    out.println("location.href='member_find_pw_ok.nf?id=" + m.getId() + "';");
    out.println("</script>");
  }

  // 이메일 임시 비밀번호 페이지 이동
  @RequestMapping(value = "member_find_pw_ok.nf", method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView member_find_pw_ok(@RequestParam("id") String id) {

    ModelAndView mv = new ModelAndView("member/member_find_pw");
    mv.addObject("id", id);

    return mv;
  }

  // 이메일 인증 처리
  @RequestMapping(value = "member_find_pw_ok_ok.nf",
      method = {RequestMethod.POST, RequestMethod.GET})
  public void member_find_pw_ok_ok(MemberBean m, @RequestParam("authkey") String authkey,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    response.setContentType("text/html; charset=utf-8");

    m = memberService.userCheck(m.getId());
    System.out.println("id = " + m.getId());
    System.out.println("pw = " + m.getPw());

    if (passwordEncoder.matches(authkey, m.getPw())) {
      try {
        HttpSession session = request.getSession();
        String id = request.getParameter("id").trim();
        session.setAttribute("id", id);

        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('임시 비밀번호로 로그인하였습니다. 환영합니다.');");
        out.println("location.href='member_find_pw_form.nf';");
        out.println("</script>");
      } catch (IOException e) {
        e.printStackTrace();
      }
    } else {
      try {
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("alert('로그인에 실패하였습니다. 임시 비밀번호를 확인해주세요.');");
        out.println("history.back();");
        out.println("</script>");
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  // 계정 찾기
  @RequestMapping(value = "member_find_ok.nf", method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView member_find_ok(HttpServletRequest request, HttpServletResponse response)
      throws Exception {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();

    HttpSession session = request.getSession();

    String id = request.getParameter("id").trim();

    // 이메일로 찾기/
    MemberBean m = this.memberService.userCheck(id);
    // 이메일이 없을 경우
    if (m == null) {
      // 휴대전화
      MemberBean a = this.memberService.findCheck(id);

      if (a == null) {
        out.println("<script>");
        out.println("alert('등록된 계정이 없습니다!')");
        out.println("history.go(-1)");
        out.println("</script>");
      } else {// 휴대전화 있을경우
        session.setAttribute("id", id);
        ModelAndView findM = new ModelAndView("member/member_find_ok");
        findM.addObject("fid", a.getId());
        findM.addObject("fphone", a.getPhone());
        findM.addObject("fname", a.getName());
        findM.addObject("fprof_img", a.getProf_img_file());
        return findM;
      }
    } else {// 등록된 이메일이 있을 경우.
      session.setAttribute("id", id);
      ModelAndView findM = new ModelAndView("member/member_find_ok");
      findM.addObject("fid", m.getId());
      findM.addObject("fphone", m.getPhone());
      findM.addObject("fname", m.getName());
      findM.addObject("fprof_img", m.getProf_img_file());
      return findM;
    }
    return null;
  }

  // 비밀번호 변경 페이지
  @RequestMapping(value = "member_find_pw_form_ok.nf",
      method = {RequestMethod.POST, RequestMethod.GET})
  public String member_find_pw_form(MemberBean m) throws Exception {

    m = memberService.userCheck(m.getId());

    return "member/member_find_pw_form";
  }

  // 비밀번호 변경 처리
  @RequestMapping(value = "member_find_pw_form_ok_ok.nf",
      method = {RequestMethod.POST, RequestMethod.GET})
  public void member_find_pw_form_ok(MemberBean m, HttpServletRequest request,
      HttpServletResponse response) throws Exception {
    response.setContentType("text/html; charset=utf-8");
    HttpSession session = request.getSession();
    String id = (String) session.getAttribute("id");

    String pw = request.getParameter("pw");

    m = memberService.userCheck(id);
    m.setPw(pw);

    String encPassword = passwordEncoder.encode(m.getPw());
    m.setPw(encPassword);
    memberService.changePw(m);

    PrintWriter out = response.getWriter();

    if (pw != null) {
      out.println("<script>");
      out.println("alert('비밀번호가 변경되었습니다.');");
      out.println("location.href='member_login.nf';");
      out.println("</script>");
    } else {
      out.println("<script>");
      out.println("alert('비밀번호를 입력해주세요');");
      out.println("history.back();");
      out.println("</script>");
    }
  }

  // 채팅
  @RequestMapping(value = "/one")
  public ModelAndView one(HttpServletRequest request) throws Exception {
    WsBean wsbean = new WsBean();
    String id1;
    String id2;
    if (request.getParameter("id1") == null) {
      System.out.println("getParameter(\"id1\")= " + request.getParameter("id1"));
      HttpSession session = request.getSession();
      id1 = (String) session.getAttribute("id");
      System.out.println("1.id1= " + id1);
      if (this.memberService.recent(id1) == null) {
        id2 = id1;
      } else {
        wsbean = this.memberService.recent(id1);
        String s_id = wsbean.getS_id();
        System.out.println("2.s_id= " + s_id);
        String r_id = wsbean.getR_id();
        System.out.println("3.r_id= " + r_id);
        if (s_id.equals(id1)) {
          id2 = r_id;
        } else {
          id2 = s_id;
        }
        System.out.println("4.id2= " + id2);
      }
    } else {
      id1 = request.getParameter("id1");
      id2 = request.getParameter("id2");
      System.out.println("id1= " + id1);
      System.out.println("id2= " + id2);
    }
    List<mfriendBean> m_friend_list = this.memberService.mchat(id1);

    Map ms = new HashMap();
    ms.put("id1", id1);
    ms.put("id2", id2);

    mfriendBean mfriend_detail = memberService.mfriend_detail2(ms);
    ModelAndView dm = new ModelAndView("member/chat");
    dm.addObject("id1", id1);
    dm.addObject("id2", id2);
    dm.addObject("mfriend_detail", mfriend_detail);
    dm.addObject("m_friend_list", m_friend_list);

    if (memberService.member_hobby(id1) != null && memberService.member_hobby(id2) != null) {
      String[] my_hobby = memberService.member_hobby(id1).split(",");
      String[] mfriend_hobby = memberService.member_hobby(id2).split(",");
      List<String> s_l = new ArrayList<>();
      for (int i = 0; i < my_hobby.length; i++) {
        for (int j = 0; j < mfriend_hobby.length; j++) {
          if (my_hobby[i].equals(mfriend_hobby[j])) {
            s_l.add(my_hobby[i]);
          }
        }
      }
      String common_hobby = StringUtils.collectionToDelimitedString(s_l, ", ");
      System.out.println(common_hobby);
      dm.addObject("common_hobby", common_hobby);
    }
    return dm;
  }

  @RequestMapping(value = "/save", method = RequestMethod.POST)
  @ResponseBody
  public Object save(String s_id, String r_id, String m) throws Exception {
    WsBean wsbean = new WsBean();
    wsbean.setS_id(s_id);
    wsbean.setR_id(r_id);
    wsbean.setM(m);
    memberService.save(wsbean);
    List<WsBean> message = memberService.out(wsbean);
    return message;
  }

  @RequestMapping(value = "/call", method = RequestMethod.POST)
  @ResponseBody
  public Object call(String s_id, String r_id) throws Exception {
    WsBean wsbean = new WsBean();
    wsbean.setS_id(s_id);
    wsbean.setR_id(r_id);
    List<WsBean> message = memberService.out(wsbean);
    System.out.println(message.get(0).getInputdate());
    return message;
  }
}
